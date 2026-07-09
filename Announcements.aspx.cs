using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class Announcements : System.Web.UI.Page
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
                LoadCourses();
                LoadAnnouncements();
            }
        }

        private void LoadCourses()
        {
            string query = @"
                SELECT C.CourseID, C.CourseName
                FROM Courses C
                INNER JOIN LecturerCourseAssignment LCA ON C.CourseID = LCA.CourseID
                WHERE LCA.LecturerID = @LecturerID
                ORDER BY C.CourseName";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCourse.DataSource = dt;
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
                ddlCourse.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Course --", "0"));
            }
        }

        private void LoadAnnouncements()
        {
            string query = @"
                SELECT A.AnnouncementID, C.CourseName, A.Title, A.Content, A.PostedDate
                FROM Announcements A
                INNER JOIN Courses C ON A.CourseID = C.CourseID
                WHERE A.LecturerID = @LecturerID
                ORDER BY A.PostedDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAnnouncements.DataSource = dt;
                gvAnnouncements.DataBind();
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            if (ddlCourse.SelectedValue == "0")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please select a course.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Title is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtContent.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Content is required.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Announcements (LecturerID, CourseID, Title, Content, PostedDate)
                          VALUES (@LecturerID, @CourseID, @Title, @Content, GETDATE())", con);

                    cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                    cmd.Parameters.AddWithValue("@CourseID", Convert.ToInt32(ddlCourse.SelectedValue));
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Content", txtContent.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Announcement posted successfully.";
                txtTitle.Text = txtContent.Text = string.Empty;
                LoadAnnouncements();
            }
            catch (SqlException)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Failed to post announcement. Please try again.";
            }
        }

        protected void gvAnnouncements_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteAnn")
            {
                int annID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Announcements WHERE AnnouncementID=@ID AND LecturerID=@LecturerID", con);
                    cmd.Parameters.AddWithValue("@ID", annID);
                    cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Announcement deleted.";
                LoadAnnouncements();
            }
        }
    }
}
