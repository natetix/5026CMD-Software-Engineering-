using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentViewAttendance : System.Web.UI.Page
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
            {
                lblName.Text = Session["StudentName"] != null
                    ? Session["StudentName"].ToString()
                    : Session["StudentEmail"].ToString();
                LoadSummary();
                LoadDetail();
            }
        }

        private void LoadSummary()
        {
            string query = @"
                SELECT
                    C.CourseName,
                    C.CourseCode,
                    COUNT(*) AS TotalClasses,
                    SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END) AS Present,
                    SUM(CASE WHEN A.Status='Absent'  THEN 1 ELSE 0 END) AS Absent,
                    CAST(
                        ROUND(
                            100.0 * SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END) / COUNT(*),
                        2) AS DECIMAL(5,2)
                    ) AS AttendancePct
                FROM Attendance A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                WHERE A.StudentEmail = @Email
                GROUP BY C.CourseName, C.CourseCode";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSummary.DataSource = dt;
                gvSummary.DataBind();
            }
        }

        private void LoadDetail()
        {
            string query = @"
                SELECT
                    C.CourseName,
                    A.AttendanceDate,
                    A.Status
                FROM Attendance A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                WHERE A.StudentEmail = @Email
                ORDER BY A.AttendanceDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    gvAttendance.Visible = false;
                    gvSummary.Visible = false;
                    lblNoData.Visible = true;
                }
                else
                {
                    gvAttendance.DataSource = dt;
                    gvAttendance.DataBind();
                }
            }
        }
    }
}
