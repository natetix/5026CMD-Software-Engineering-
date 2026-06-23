using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace StudentManagementSystem
{
    public partial class LecturerDashboard : System.Web.UI.Page
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
                if (Session["LecturerName"] != null)
                    lblLecturerName.Text = Session["LecturerName"].ToString();

                LoadCourses();
                LoadAttendance();
                LoadChartData();
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM LecturerCourseAssignment WHERE LecturerID=@LecturerID", con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                con.Open();
                lblCourses.Text = cmd.ExecuteScalar().ToString();
            }
        }

        private void LoadAttendance()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) FROM Attendance A
                    INNER JOIN LecturerCourseAssignment LCA ON A.CourseID = LCA.CourseID
                    WHERE LCA.LecturerID=@LecturerID", con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                con.Open();
                lblAttendance.Text = cmd.ExecuteScalar().ToString();
            }
        }

        private void LoadChartData()
        {
            int gradeA = 0, gradeB = 0, gradeC = 0, gradeD = 0, gradeF = 0;
            var attLabels = new StringBuilder("[");
            var attData   = new StringBuilder("[");

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string gradeQuery = @"
                    SELECT
                        SUM(CASE WHEN CM.TotalMarks >= 80 THEN 1 ELSE 0 END) AS GradeA,
                        SUM(CASE WHEN CM.TotalMarks >= 70 AND CM.TotalMarks < 80 THEN 1 ELSE 0 END) AS GradeB,
                        SUM(CASE WHEN CM.TotalMarks >= 60 AND CM.TotalMarks < 70 THEN 1 ELSE 0 END) AS GradeC,
                        SUM(CASE WHEN CM.TotalMarks >= 50 AND CM.TotalMarks < 60 THEN 1 ELSE 0 END) AS GradeD,
                        SUM(CASE WHEN CM.TotalMarks < 50 THEN 1 ELSE 0 END) AS GradeF
                    FROM CourseMarks CM
                    INNER JOIN LecturerCourseAssignment LCA ON CM.CourseID = LCA.CourseID
                    WHERE LCA.LecturerID = @LecturerID";

                using (SqlCommand cmd = new SqlCommand(gradeQuery, con))
                {
                    cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            gradeA = r["GradeA"] == DBNull.Value ? 0 : Convert.ToInt32(r["GradeA"]);
                            gradeB = r["GradeB"] == DBNull.Value ? 0 : Convert.ToInt32(r["GradeB"]);
                            gradeC = r["GradeC"] == DBNull.Value ? 0 : Convert.ToInt32(r["GradeC"]);
                            gradeD = r["GradeD"] == DBNull.Value ? 0 : Convert.ToInt32(r["GradeD"]);
                            gradeF = r["GradeF"] == DBNull.Value ? 0 : Convert.ToInt32(r["GradeF"]);
                        }
                    }
                }

                string attQuery = @"
                    SELECT C.CourseName,
                        CAST(100.0 * SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END)
                            / NULLIF(COUNT(*), 0) AS DECIMAL(5,2)) AS AttRate
                    FROM Attendance A
                    INNER JOIN LecturerCourseAssignment LCA ON A.CourseID = LCA.CourseID
                    INNER JOIN Courses C ON A.CourseID = C.CourseID
                    WHERE LCA.LecturerID = @LecturerID2
                    GROUP BY C.CourseName
                    ORDER BY C.CourseName";

                using (SqlCommand cmd2 = new SqlCommand(attQuery, con))
                {
                    cmd2.Parameters.AddWithValue("@LecturerID2", Session["LecturerID"]);
                    using (SqlDataReader r2 = cmd2.ExecuteReader())
                    {
                        bool first = true;
                        while (r2.Read())
                        {
                            if (!first) { attLabels.Append(","); attData.Append(","); }
                            attLabels.Append("\"")
                                     .Append(r2["CourseName"].ToString().Replace("\"", "\\\""))
                                     .Append("\"");
                            attData.Append(r2["AttRate"]);
                            first = false;
                        }
                    }
                }
            }

            attLabels.Append("]");
            attData.Append("]");

            string script = string.Format(
                "initGradeChart({0},{1},{2},{3},{4});" +
                "initAttCourseChart({5},{6});",
                gradeA, gradeB, gradeC, gradeD, gradeF,
                attLabels, attData);

            Page.ClientScript.RegisterStartupScript(GetType(), "lecturerCharts", script, true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LecturerLogin.aspx");
        }
    }
}
