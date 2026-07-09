using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class EnterMarks : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LecturerID"] == null)
            {
                Response.Redirect("LecturerLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSessions();

                if (ddlSession.Items.Count > 0)
                {
                    LoadCourses();

                    if (ddlCourse.Items.Count > 0)
                        LoadStudents();
                }
            }
        }

        private void LoadSessions()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT DISTINCT SessionName FROM Courses", con);

                con.Open();
                ddlSession.DataSource = cmd.ExecuteReader();
                ddlSession.DataTextField = "SessionName";
                ddlSession.DataValueField = "SessionName";
                ddlSession.DataBind();
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CourseID, CourseName FROM Courses WHERE SessionName=@Session", con);
                cmd.Parameters.AddWithValue("@Session", ddlSession.SelectedValue);

                con.Open();
                ddlCourse.DataSource = cmd.ExecuteReader();
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
            }
        }

        private void LoadStudents()
        {
            if (ddlCourse.Items.Count == 0) return;

            string query = @"
                SELECT EM.EnrolmentID, EM.StudentName
                FROM EnrollmentMaster EM
                INNER JOIN EnrollmentDetails ED ON EM.EnrolmentID = ED.EnrolmentID
                WHERE ED.CourseID=@CourseID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CourseID", ddlCourse.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
            LoadStudents();
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadStudents();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string upsert = @"
                IF EXISTS (SELECT 1 FROM CourseMarks WHERE EnrolmentID=@EnrolmentID AND CourseID=@CourseID)
                    UPDATE CourseMarks
                    SET AssignmentMarks=@Assignment, QuizMarks=@Quiz,
                        MidTestMarks=@Mid, FinalExamMarks=@Final, TotalMarks=@Total
                    WHERE EnrolmentID=@EnrolmentID AND CourseID=@CourseID
                ELSE
                    INSERT INTO CourseMarks
                    (EnrolmentID, CourseID, AssignmentMarks, QuizMarks, MidTestMarks, FinalExamMarks, TotalMarks)
                    VALUES (@EnrolmentID, @CourseID, @Assignment, @Quiz, @Mid, @Final, @Total)";

            string courseName = ddlCourse.SelectedItem != null
                ? ddlCourse.SelectedItem.Text : "your course";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                foreach (GridViewRow row in gvStudents.Rows)
                {
                    int enrolmentID = Convert.ToInt32(row.Cells[0].Text);

                    decimal assignment, quiz, mid, finalExam;
                    decimal.TryParse(((TextBox)row.FindControl("txtAssignment")).Text, out assignment);
                    decimal.TryParse(((TextBox)row.FindControl("txtQuiz")).Text, out quiz);
                    decimal.TryParse(((TextBox)row.FindControl("txtMidTest")).Text, out mid);
                    decimal.TryParse(((TextBox)row.FindControl("txtFinalExam")).Text, out finalExam);

                    assignment = Math.Min(Math.Max(assignment, 0), 100);
                    quiz       = Math.Min(Math.Max(quiz,       0), 100);
                    mid        = Math.Min(Math.Max(mid,        0), 100);
                    finalExam  = Math.Min(Math.Max(finalExam,  0), 100);

                    decimal total = assignment + quiz + mid + finalExam;

                    SqlCommand cmd = new SqlCommand(upsert, con);
                    cmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                    cmd.Parameters.AddWithValue("@CourseID",    ddlCourse.SelectedValue);
                    cmd.Parameters.AddWithValue("@Assignment",  assignment);
                    cmd.Parameters.AddWithValue("@Quiz",        quiz);
                    cmd.Parameters.AddWithValue("@Mid",         mid);
                    cmd.Parameters.AddWithValue("@Final",       finalExam);
                    cmd.Parameters.AddWithValue("@Total",       total);
                    cmd.ExecuteNonQuery();

                    // Notify student their marks have been updated
                    SqlCommand emailCmd = new SqlCommand(
                        "SELECT StudentEmail, StudentName FROM EnrollmentMaster WHERE EnrolmentID=@ID", con);
                    emailCmd.Parameters.AddWithValue("@ID", enrolmentID);
                    using (SqlDataReader r = emailCmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string email    = r["StudentEmail"].ToString();
                            string studName = r["StudentName"].ToString();
                            r.Close();
                            InsertNotification(con, email,
                                "Dear " + studName + ", your marks for " + courseName +
                                " have been updated. Total: " + total.ToString("0.##"),
                                "Marks");
                        }
                    }
                }
            }

            lblMessage.Text = "Student marks saved successfully.";
        }

        private void InsertNotification(SqlConnection con, string recipientEmail, string message, string category)
        {
            SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Notifications (RecipientEmail, Message, Category)
                VALUES (@Email, @Message, @Category)", con);
            cmd.Parameters.AddWithValue("@Email",    recipientEmail);
            cmd.Parameters.AddWithValue("@Message",  message);
            cmd.Parameters.AddWithValue("@Category", category);
            cmd.ExecuteNonQuery();
        }
    }
}
