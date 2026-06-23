using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class AssignCourse : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSession();
                LoadLecturer();
                LoadCourse();
                LoadAssignment();
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
                ddlSession.DataSource = dt;
                ddlSession.DataTextField = "SessionName";
                ddlSession.DataValueField = "SessionName";
                ddlSession.DataBind();
            }
        }

        void LoadLecturer()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter sda = new SqlDataAdapter(
                    "SELECT LecturerID, LecturerName FROM Lecturers", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlLecturer.DataSource = dt;
                ddlLecturer.DataTextField = "LecturerName";
                ddlLecturer.DataValueField = "LecturerID";
                ddlLecturer.DataBind();
            }
        }

        void LoadCourse()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter sda = new SqlDataAdapter(
                    "SELECT CourseID, CourseName FROM Courses", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlCourse.DataSource = dt;
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO LecturerCourseAssignment
                      (LecturerID, CourseID, SessionName, Semester)
                      VALUES (@LecturerID, @CourseID, @SessionName, @Semester)", con);

                cmd.Parameters.AddWithValue("@LecturerID", ddlLecturer.SelectedValue);
                cmd.Parameters.AddWithValue("@CourseID", ddlCourse.SelectedValue);
                cmd.Parameters.AddWithValue("@SessionName", ddlSession.SelectedValue);
                cmd.Parameters.AddWithValue("@Semester", ddlSemester.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Course Assigned Successfully";
            LoadAssignment();
        }

        void LoadAssignment()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        A.AssignmentID,
                        L.LecturerName,
                        C.CourseCode,
                        C.CourseName,
                        A.SessionName,
                        A.Semester
                    FROM LecturerCourseAssignment A
                    INNER JOIN Lecturers L ON A.LecturerID = L.LecturerID
                    INNER JOIN Courses C ON A.CourseID = C.CourseID";

                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvAssignment.DataSource = dt;
                gvAssignment.DataBind();
            }
        }
    }
}
