using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class ManageAttendance : System.Web.UI.Page
    {
        string cs =
        ConfigurationManager.ConnectionStrings["CollegeDB"]
        .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LecturerID"] == null)
            {
                Response.Redirect("LecturerLogin.aspx");
                return;  // FIX 1: added missing return after redirect
            }

            if (!IsPostBack)
            {
                LoadSessions();
            }
        }

        private int LecturerID
        {
            get
            {
                return Convert.ToInt32(Session["LecturerID"]);
            }
        }

        private void LoadSessions()
        {
            // FIX 2a: SqlConnection now in using block (was a bare new SqlConnection)
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT DISTINCT SessionName
                FROM LecturerCourseAssignment
                WHERE LecturerID=@LecturerID";

                SqlCommand cmd =
                new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                "@LecturerID",
                LecturerID);

                con.Open();

                ddlSession.DataSource =
                cmd.ExecuteReader();

                ddlSession.DataTextField =
                "SessionName";

                ddlSession.DataValueField =
                "SessionName";

                ddlSession.DataBind();

                ddlSession.Items.Insert(
                0,
                new ListItem("-- Select Session --", ""));
            }
        }

        protected void ddlSession_SelectedIndexChanged(
        object sender,
        EventArgs e)
        {
            LoadCourses();
        }

        private void LoadCourses()
        {
            // FIX 2b: SqlConnection now in using block
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT
                C.CourseID,
                C.CourseName

                FROM LecturerCourseAssignment LCA

                INNER JOIN Courses C
                ON LCA.CourseID=C.CourseID

                WHERE LCA.LecturerID=@LecturerID
                AND LCA.SessionName=@Session";

                SqlCommand cmd =
                new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                "@LecturerID",
                LecturerID);

                cmd.Parameters.AddWithValue(
                "@Session",
                ddlSession.SelectedValue);

                con.Open();

                ddlCourse.DataSource =
                cmd.ExecuteReader();

                ddlCourse.DataTextField =
                "CourseName";

                ddlCourse.DataValueField =
                "CourseID";

                ddlCourse.DataBind();

                ddlCourse.Items.Insert(
                0,
                new ListItem("-- Select Course --", ""));
            }
        }

        protected void ddlCourse_SelectedIndexChanged(
        object sender,
        EventArgs e)
        {
            LoadStudents();
        }

        private void LoadStudents()
        {
            // FIX 2c: SqlConnection now in using block
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT
                EM.StudentName,
                EM.StudentEmail

                FROM EnrollmentMaster EM

                INNER JOIN EnrollmentDetails ED
                ON EM.EnrolmentID = ED.EnrolmentID

                WHERE ED.CourseID=@CourseID";

                SqlCommand cmd =
                new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                "@CourseID",
                ddlCourse.SelectedValue);

                SqlDataAdapter da =
                new SqlDataAdapter(cmd);

                DataTable dt =
                new DataTable();

                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        protected void btnSave_Click(
        object sender,
        EventArgs e)
        {
            // FIX 2d: SqlConnection now in using block (was bare new SqlConnection opened before loop)
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                foreach (GridViewRow row in gvStudents.Rows)
                {
                    string email =
                    row.Cells[1].Text;

                    DropDownList ddl =
                    (DropDownList)row.FindControl(
                    "ddlStatus");

                    string status =
                    ddl.SelectedValue;

                    string query = @"
                    INSERT INTO Attendance
                    (
                        CourseID,
                        StudentEmail,
                        AttendanceDate,
                        Status
                    )

                    VALUES
                    (
                        @CourseID,
                        @Email,
                        @Date,
                        @Status
                    )";

                    SqlCommand cmd =
                    new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue(
                    "@CourseID",
                    ddlCourse.SelectedValue);

                    cmd.Parameters.AddWithValue(
                    "@Email",
                    email);

                    cmd.Parameters.AddWithValue(
                    "@Date",
                    txtDate.Text);

                    cmd.Parameters.AddWithValue(
                    "@Status",
                    status);

                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text =
            "Attendance saved successfully.";
        }
    }
}
