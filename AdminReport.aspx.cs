using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace StudentManagementSystem
{
    public partial class AdminReport : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadEnrollmentSummary();
                LoadMarksSummary();
                LoadAttendanceSummary();
            }
        }

        private void LoadEnrollmentSummary()
        {
            string query = @"
                SELECT
                    COUNT(*) AS Total,
                    SUM(CASE WHEN Status='Approved' THEN 1 ELSE 0 END) AS Approved,
                    SUM(CASE WHEN Status='Pending'  THEN 1 ELSE 0 END) AS Pending,
                    SUM(CASE WHEN Status='Rejected' THEN 1 ELSE 0 END) AS Rejected
                FROM EnrollmentMaster";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTotal.Text    = dr["Total"].ToString();
                    lblApproved.Text = dr["Approved"].ToString();
                    lblPending.Text  = dr["Pending"].ToString();
                    lblRejected.Text = dr["Rejected"].ToString();
                }
            }
        }

        private void LoadMarksSummary()
        {
            string query = @"
                SELECT
                    C.CourseCode,
                    C.CourseName,
                    COUNT(CM.EnrolmentID)                        AS TotalStudents,
                    CAST(AVG(CM.TotalMarks) AS DECIMAL(5,2))     AS AvgMarks,
                    SUM(CASE WHEN CM.TotalMarks >= 50 THEN 1 ELSE 0 END) AS PassCount,
                    SUM(CASE WHEN CM.TotalMarks <  50 THEN 1 ELSE 0 END) AS FailCount
                FROM CourseMarks CM
                INNER JOIN Courses C ON CM.CourseID = C.CourseID
                GROUP BY C.CourseCode, C.CourseName
                ORDER BY C.CourseCode";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMarks.DataSource = dt;
                gvMarks.DataBind();
            }
        }

        private void LoadAttendanceSummary()
        {
            string query = @"
                SELECT
                    C.CourseCode,
                    C.CourseName,
                    COUNT(*)                                                AS TotalRecords,
                    SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END)    AS PresentCount,
                    CAST(
                        100.0 * SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END)
                        / NULLIF(COUNT(*),0)
                    AS DECIMAL(5,2))                                        AS AttendanceRate
                FROM Attendance A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                GROUP BY C.CourseCode, C.CourseName
                ORDER BY C.CourseCode";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();
            }
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("ENROLLMENT SUMMARY");
            sb.AppendLine("Total,Approved,Pending,Rejected");
            sb.AppendLine(string.Format("{0},{1},{2},{3}",
                lblTotal.Text, lblApproved.Text, lblPending.Text, lblRejected.Text));
            sb.AppendLine();

            sb.AppendLine("MARKS SUMMARY BY COURSE");
            sb.AppendLine("Course Code,Course Name,Students Assessed,Average Marks,Pass,Fail");

            string marksQuery = @"
                SELECT C.CourseCode, C.CourseName,
                    COUNT(CM.EnrolmentID) AS TotalStudents,
                    CAST(AVG(CM.TotalMarks) AS DECIMAL(5,2)) AS AvgMarks,
                    SUM(CASE WHEN CM.TotalMarks >= 50 THEN 1 ELSE 0 END) AS PassCount,
                    SUM(CASE WHEN CM.TotalMarks <  50 THEN 1 ELSE 0 END) AS FailCount
                FROM CourseMarks CM
                INNER JOIN Courses C ON CM.CourseID = C.CourseID
                GROUP BY C.CourseCode, C.CourseName ORDER BY C.CourseCode";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(marksQuery, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow row in dt.Rows)
                    sb.AppendLine(string.Format("{0},{1},{2},{3},{4},{5}",
                        CsvEscape(row["CourseCode"].ToString()),
                        CsvEscape(row["CourseName"].ToString()),
                        row["TotalStudents"], row["AvgMarks"],
                        row["PassCount"], row["FailCount"]));
            }
            sb.AppendLine();

            sb.AppendLine("ATTENDANCE SUMMARY BY COURSE");
            sb.AppendLine("Course Code,Course Name,Total Records,Present,Attendance Rate (%)");

            string attQuery = @"
                SELECT C.CourseCode, C.CourseName,
                    COUNT(*) AS TotalRecords,
                    SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END) AS PresentCount,
                    CAST(100.0 * SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END)
                        / NULLIF(COUNT(*),0) AS DECIMAL(5,2)) AS AttendanceRate
                FROM Attendance A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                GROUP BY C.CourseCode, C.CourseName ORDER BY C.CourseCode";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(attQuery, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow row in dt.Rows)
                    sb.AppendLine(string.Format("{0},{1},{2},{3},{4}",
                        CsvEscape(row["CourseCode"].ToString()),
                        CsvEscape(row["CourseName"].ToString()),
                        row["TotalRecords"], row["PresentCount"], row["AttendanceRate"]));
            }

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition",
                "attachment; filename=InstitutionalReport_" +
                DateTime.Now.ToString("yyyyMMdd") + ".csv");
            Response.Write(sb.ToString());
            Response.End();
        }

        private static string CsvEscape(string value)
        {
            if (value == null) return "\"\"";
            value = value.Replace("\"", "\"\"");
            if (value.IndexOfAny(new[] { ',', '"', '\n', '\r', '=', '+', '-', '@' }) >= 0)
                value = "\"" + value + "\"";
            return value;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
