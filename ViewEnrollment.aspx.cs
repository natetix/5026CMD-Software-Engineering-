using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class ViewEnrollment : System.Web.UI.Page
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
                LoadEnrollment();
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

        void LoadEnrollment()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT EnrolmentID, StudentName, StudentEmail,
                           SessionName, Semester, Status
                    FROM EnrollmentMaster
                    WHERE SessionName=@SessionName";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SessionName", ddlSession.SelectedValue);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvEnrollment.DataSource = dt;
                gvEnrollment.DataBind();
            }
        }

        protected void gvEnrollment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int enrolmentID = Convert.ToInt32(
                    gvEnrollment.DataKeys[e.Row.RowIndex].Value);

                GridView gvCourses = (GridView)e.Row.FindControl("gvCourses");

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                        SELECT C.CourseCode, C.CourseName, C.CreditHours
                        FROM EnrollmentDetails ED
                        INNER JOIN Courses C ON ED.CourseID = C.CourseID
                        WHERE ED.EnrolmentID=@EnrolmentID";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvCourses.DataSource = dt;
                    gvCourses.DataBind();
                }
            }
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadEnrollment();
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int enrolmentID = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE EnrollmentMaster SET Status='Approved' WHERE EnrolmentID=@EnrolmentID", con);
                cmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                cmd.ExecuteNonQuery();

                SqlCommand emailCmd = new SqlCommand(
                    "SELECT StudentEmail, StudentName FROM EnrollmentMaster WHERE EnrolmentID=@ID", con);
                emailCmd.Parameters.AddWithValue("@ID", enrolmentID);
                using (SqlDataReader r = emailCmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        string email = r["StudentEmail"].ToString();
                        string name  = r["StudentName"].ToString();
                        r.Close();
                        InsertNotification(con, email,
                            "Dear " + name + ", your course enrollment has been approved.",
                            "Enrollment");
                    }
                }
            }

            LoadEnrollment();
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int enrolmentID = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE EnrollmentMaster SET Status='Rejected' WHERE EnrolmentID=@EnrolmentID", con);
                cmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                cmd.ExecuteNonQuery();

                SqlCommand emailCmd = new SqlCommand(
                    "SELECT StudentEmail, StudentName FROM EnrollmentMaster WHERE EnrolmentID=@ID", con);
                emailCmd.Parameters.AddWithValue("@ID", enrolmentID);
                using (SqlDataReader r = emailCmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        string email = r["StudentEmail"].ToString();
                        string name  = r["StudentName"].ToString();
                        r.Close();
                        InsertNotification(con, email,
                            "Dear " + name + ", your course enrollment has been rejected. Please contact the admin.",
                            "Enrollment");
                    }
                }
            }

            LoadEnrollment();
        }

        private void InsertNotification(SqlConnection con, string recipientEmail, string message, string category)
        {
            SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Notifications (RecipientEmail, Message, Category)
                VALUES (@Email, @Message, @Category)", con);
            cmd.Parameters.AddWithValue("@Email",    recipientEmail);
            cmd.Parameters.AddWithValue("@Message",  message);
            cmd.Parameters.AddWithValue("@Category", category);
            cmd.ExecuteNonQuery();
        }
    }
}
