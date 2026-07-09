using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentDashboard : System.Web.UI.Page
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
                lblStudentName.Text = Session["StudentName"] != null
                    ? Session["StudentName"].ToString()
                    : Session["StudentEmail"].ToString();

                LoadDashboard();
                LoadNotificationBadge();
            }
        }

        void LoadDashboard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string totalQuery = @"
                    SELECT COUNT(*)
                    FROM EnrollmentDetails ED
                    INNER JOIN EnrollmentMaster EM ON ED.EnrolmentID = EM.EnrolmentID
                    WHERE EM.StudentEmail=@StudentEmail";

                SqlCommand totalCmd = new SqlCommand(totalQuery, con);
                totalCmd.Parameters.AddWithValue("@StudentEmail", Session["StudentEmail"]);
                lblTotalCourses.Text = totalCmd.ExecuteScalar().ToString();

                string approvedQuery = @"
                    SELECT COUNT(*)
                    FROM EnrollmentDetails ED
                    INNER JOIN EnrollmentMaster EM ON ED.EnrolmentID = EM.EnrolmentID
                    WHERE EM.StudentEmail=@StudentEmail AND EM.Status='Approved'";

                SqlCommand approvedCmd = new SqlCommand(approvedQuery, con);
                approvedCmd.Parameters.AddWithValue("@StudentEmail", Session["StudentEmail"]);
                lblApproved.Text = approvedCmd.ExecuteScalar().ToString();

                string pendingQuery = @"
                    SELECT COUNT(*)
                    FROM EnrollmentDetails ED
                    INNER JOIN EnrollmentMaster EM ON ED.EnrolmentID = EM.EnrolmentID
                    WHERE EM.StudentEmail=@StudentEmail AND EM.Status='Pending'";

                SqlCommand pendingCmd = new SqlCommand(pendingQuery, con);
                pendingCmd.Parameters.AddWithValue("@StudentEmail", Session["StudentEmail"]);
                lblPending.Text = pendingCmd.ExecuteScalar().ToString();
            }
        }

        void LoadNotificationBadge()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Notifications WHERE RecipientEmail=@Email AND IsRead=0", con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                if (count > 0)
                {
                    lblNotifCount.Text = count.ToString();
                    lblNotifCount.Visible = true;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("StudentLogin.aspx");
        }
    }
}
