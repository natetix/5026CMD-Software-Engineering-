using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class ViewAssignedCourses : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LecturerID"] == null)
            {
                Response.Redirect("LecturerLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSession();
                LoadCourses();
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

        void LoadCourses()
        {
            string query = @"
                SELECT
                    A.AssignmentID,
                    A.CourseID,
                    C.CourseCode,
                    C.CourseName,
                    A.SessionName,
                    A.Semester
                FROM LecturerCourseAssignment A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                WHERE A.LecturerID=@LecturerID
                AND A.SessionName=@SessionName";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                cmd.Parameters.AddWithValue("@SessionName", ddlSession.SelectedValue);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
        }

        protected void btnManage_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string courseID = btn.CommandArgument;
            Response.Redirect("CourseNotes.aspx?CourseID=" + courseID);
        }
    }
}
