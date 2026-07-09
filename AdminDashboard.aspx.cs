using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace StudentManagementSystem
{
    public partial class AdminDashboard : System.Web.UI.Page
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

            lblWelcome.Text = Session["AdminName"]?.ToString() ?? "Admin";

            if (!IsPostBack)
            {
                LoadDashboard();
                LoadChartData();
            }
        }

        void LoadDashboard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand totalCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM EnrollmentMaster", con);
                lblTotalEnrollment.Text = Convert.ToInt32(totalCmd.ExecuteScalar()).ToString();

                SqlCommand approvedCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM EnrollmentMaster WHERE Status='Approved'", con);
                lblApproved.Text = Convert.ToInt32(approvedCmd.ExecuteScalar()).ToString();

                SqlCommand pendingCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM EnrollmentMaster WHERE Status='Pending'", con);
                lblPending.Text = Convert.ToInt32(pendingCmd.ExecuteScalar()).ToString();

                SqlCommand rejectedCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM EnrollmentMaster WHERE Status='Rejected'", con);
                lblRejected.Text = Convert.ToInt32(rejectedCmd.ExecuteScalar()).ToString();

                SqlCommand assignmentCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM LecturerCourseAssignment", con);
                lblAssignment.Text = Convert.ToInt32(assignmentCmd.ExecuteScalar()).ToString();
            }
        }

        void LoadChartData()
        {
            int approved = int.Parse(lblApproved.Text);
            int pending  = int.Parse(lblPending.Text);
            int rejected = int.Parse(lblRejected.Text);

            var marksLabels = new StringBuilder("[");
            var marksData   = new StringBuilder("[");
            var attLabels   = new StringBuilder("[");
            var attData     = new StringBuilder("[");

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string marksQuery = @"
                    SELECT TOP 8 C.CourseName,
                        CAST(AVG(CM.TotalMarks) AS DECIMAL(5,2)) AS AvgMarks
                    FROM CourseMarks CM
                    INNER JOIN Courses C ON CM.CourseID = C.CourseID
                    GROUP BY C.CourseName
                    ORDER BY AVG(CM.TotalMarks) DESC";

                using (SqlCommand cmd = new SqlCommand(marksQuery, con))
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    bool first = true;
                    while (r.Read())
                    {
                        if (!first) { marksLabels.Append(","); marksData.Append(","); }
                        marksLabels.Append("\"").Append(r["CourseName"].ToString().Replace("\"", "\\\"")).Append("\"");
                        marksData.Append(r["AvgMarks"]);
                        first = false;
                    }
                }

                marksLabels.Append("]");
                marksData.Append("]");

                string attQuery = @"
                    SELECT TOP 8 C.CourseName,
                        CAST(100.0 * SUM(CASE WHEN A.Status='Present' THEN 1 ELSE 0 END)
                            / NULLIF(COUNT(*), 0) AS DECIMAL(5,2)) AS AttRate
                    FROM Attendance A
                    INNER JOIN Courses C ON A.CourseID = C.CourseID
                    GROUP BY C.CourseName
                    ORDER BY C.CourseName";

                using (SqlCommand cmd2 = new SqlCommand(attQuery, con))
                using (SqlDataReader r2 = cmd2.ExecuteReader())
                {
                    bool first = true;
                    while (r2.Read())
                    {
                        if (!first) { attLabels.Append(","); attData.Append(","); }
                        attLabels.Append("\"").Append(r2["CourseName"].ToString().Replace("\"", "\\\"")).Append("\"");
                        attData.Append(r2["AttRate"]);
                        first = false;
                    }
                }

                attLabels.Append("]");
                attData.Append("]");
            }

            string script = string.Format(
                "initEnrollmentChart({0},{1},{2});" +
                "initMarksChart({3},{4});" +
                "initAttendanceChart({5},{6});",
                approved, pending, rejected,
                marksLabels, marksData,
                attLabels, attData);

            Page.ClientScript.RegisterStartupScript(GetType(), "charts", script, true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
