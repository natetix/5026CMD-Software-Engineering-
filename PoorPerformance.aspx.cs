using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class PoorPerformance : System.Web.UI.Page
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
                LoadLowMarks();
                LoadLowAttendance();
            }
        }

        private void LoadLowMarks()
        {
            string query = @"
                SELECT
                    S.StudentName,
                    EM.StudentEmail,
                    C.CourseName,
                    CM.TotalMarks,
                    CASE
                        WHEN CM.TotalMarks >= 80 THEN 'A'
                        WHEN CM.TotalMarks >= 70 THEN 'B'
                        WHEN CM.TotalMarks >= 60 THEN 'C'
                        WHEN CM.TotalMarks >= 50 THEN 'D'
                        ELSE 'F'
                    END AS Grade
                FROM CourseMarks CM
                INNER JOIN EnrollmentMaster EM ON CM.EnrolmentID = EM.EnrolmentID
                INNER JOIN Students S ON EM.StudentEmail = S.Email
                INNER JOIN Courses C ON CM.CourseID = C.CourseID
                INNER JOIN LecturerCourseAssignment LCA ON CM.CourseID = LCA.CourseID
                WHERE LCA.LecturerID = @LecturerID
                AND CM.TotalMarks < 50
                ORDER BY CM.TotalMarks ASC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMarks.DataSource = dt;
                gvMarks.DataBind();
            }
        }

        private void LoadLowAttendance()
        {
            string query = @"
                SELECT
                    S.StudentName,
                    A.StudentEmail,
                    C.CourseName,
                    CAST(
                        ROUND(100.0 * SUM(CASE WHEN A.Status = 'Present' THEN 1 ELSE 0 END) / COUNT(*), 1)
                    AS DECIMAL(5,1)) AS AttendancePct
                FROM Attendance A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                INNER JOIN LecturerCourseAssignment LCA ON A.CourseID = LCA.CourseID
                INNER JOIN Students S ON A.StudentEmail = S.Email
                WHERE LCA.LecturerID = @LecturerID
                GROUP BY S.StudentName, A.StudentEmail, C.CourseName
                HAVING ROUND(100.0 * SUM(CASE WHEN A.Status = 'Present' THEN 1 ELSE 0 END) / COUNT(*), 1) < 75
                ORDER BY AttendancePct ASC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();
            }
        }
    }
}
