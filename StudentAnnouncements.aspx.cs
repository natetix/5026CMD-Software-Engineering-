using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentAnnouncements : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["StudentEmail"] == null)
            {
                Response.Redirect("StudentLogin.aspx");
                return;
            }

            if (!IsPostBack)
                LoadAnnouncements();
        }

        private void LoadAnnouncements()
        {
            string query = @"
                SELECT DISTINCT
                    A.AnnouncementID,
                    A.Title,
                    A.Content,
                    A.PostedDate,
                    C.CourseName,
                    L.LecturerName
                FROM Announcements A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                INNER JOIN Lecturers L ON A.LecturerID = L.LecturerID
                INNER JOIN EnrollmentDetails ED ON A.CourseID = ED.CourseID
                INNER JOIN EnrollmentMaster EM ON ED.EnrolmentID = EM.EnrolmentID
                WHERE EM.StudentEmail = @Email
                ORDER BY A.PostedDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    lblEmpty.Visible = true;
                    rptAnnouncements.Visible = false;
                }
                else
                {
                    rptAnnouncements.DataSource = dt;
                    rptAnnouncements.DataBind();
                }
            }
        }
    }
}
