using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class CourseEnrollment : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentEmail"] == null)
            {
                Response.Redirect("StudentLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSession();
                LoadCourses();
                LoadEnrollment();
            }
        }

        void LoadSession()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter sda = new SqlDataAdapter(
                    "SELECT DISTINCT SessionName FROM Courses", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlSession.DataSource     = dt;
                ddlSession.DataTextField  = "SessionName";
                ddlSession.DataValueField = "SessionName";
                ddlSession.DataBind();
            }
        }

        void LoadCourses()
        {
            string query = @"SELECT CourseID, CourseCode, CourseName, CreditHours
                             FROM Courses
                             WHERE SessionName=@SessionName AND Semester=@Semester";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SessionName", ddlSession.SelectedValue);
                cmd.Parameters.AddWithValue("@Semester",    ddlSemester.SelectedValue);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        void LoadEnrollment()
        {
            string query = @"
                SELECT EM.EnrolmentID, EM.StudentName, C.CourseCode,
                       C.CourseName, C.CreditHours, EM.Status
                FROM EnrollmentMaster EM
                INNER JOIN EnrollmentDetails ED ON EM.EnrolmentID = ED.EnrolmentID
                INNER JOIN Courses C ON ED.CourseID = C.CourseID
                WHERE EM.StudentEmail=@StudentEmail";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StudentEmail",
                    Session["StudentEmail"].ToString());

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvEnrollment.DataSource = dt;
                gvEnrollment.DataBind();
            }
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
        }

        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string studentName  = Session["StudentName"]  != null
                ? Session["StudentName"].ToString()
                : Session["StudentEmail"].ToString();
            string studentEmail = Session["StudentEmail"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // DUPLICATE CHECK
                SqlCommand dupCmd = new SqlCommand(@"
                    SELECT COUNT(1) FROM EnrollmentMaster
                    WHERE StudentEmail=@StudentEmail
                    AND SessionName=@SessionName
                    AND Semester=@Semester", con);
                dupCmd.Parameters.AddWithValue("@StudentEmail", studentEmail);
                dupCmd.Parameters.AddWithValue("@SessionName",  ddlSession.SelectedValue);
                dupCmd.Parameters.AddWithValue("@Semester",     ddlSemester.SelectedValue);

                int existing = Convert.ToInt32(dupCmd.ExecuteScalar());
                if (existing > 0)
                {
                    lblMessage.Text      = "You have already enrolled for this session and semester.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                using (SqlTransaction tx = con.BeginTransaction())
                {
                    try
                    {
                        // INSERT MASTER RECORD
                        SqlCommand masterCmd = new SqlCommand(@"
                            INSERT INTO EnrollmentMaster
                            (StudentName, StudentEmail, SessionName, Semester, Status)
                            OUTPUT INSERTED.EnrolmentID
                            VALUES (@StudentName, @StudentEmail, @SessionName, @Semester, 'Pending')", con, tx);

                        masterCmd.Parameters.AddWithValue("@StudentName",  studentName);
                        masterCmd.Parameters.AddWithValue("@StudentEmail", studentEmail);
                        masterCmd.Parameters.AddWithValue("@SessionName",  ddlSession.SelectedValue);
                        masterCmd.Parameters.AddWithValue("@Semester",     ddlSemester.SelectedValue);

                        int enrolmentID = Convert.ToInt32(masterCmd.ExecuteScalar());

                        // INSERT COURSE DETAILS
                        foreach (GridViewRow row in gvCourses.Rows)
                        {
                            CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                            if (chk != null && chk.Checked)
                            {
                                int courseID = Convert.ToInt32(row.Cells[1].Text);

                                SqlCommand detailCmd = new SqlCommand(@"
                                    INSERT INTO EnrollmentDetails (EnrolmentID, CourseID)
                                    VALUES (@EnrolmentID, @CourseID)", con, tx);
                                detailCmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                                detailCmd.Parameters.AddWithValue("@CourseID",    courseID);
                                detailCmd.ExecuteNonQuery();
                            }
                        }

                        tx.Commit();
                        lblMessage.Text      = "Enrollment Submitted Successfully";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    catch
                    {
                        tx.Rollback();
                        lblMessage.Text      = "Enrollment failed. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }

            LoadEnrollment();
        }
    }
}
