using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentNotifications : System.Web.UI.Page
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
                LoadNotifications();
            }
        }

        void LoadNotifications()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT NotificationID, Message, IsRead, CreatedDate, Category
                    FROM Notifications
                    WHERE RecipientEmail = @Email
                    ORDER BY CreatedDate DESC", con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    lblEmpty.Visible = true;
                    btnMarkAllRead.Visible = false;
                }
                else
                {
                    rptNotifications.DataSource = dt;
                    rptNotifications.DataBind();
                }
            }
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Notifications SET IsRead=1 WHERE RecipientEmail=@Email AND IsRead=0", con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "All notifications marked as read.";
            LoadNotifications();
        }
    }
}
