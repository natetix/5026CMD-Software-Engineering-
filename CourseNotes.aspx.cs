using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace StudentManagementSystem
{
    public partial class CourseNotes : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"]
            .ConnectionString;

        static readonly string[] AllowedExtensions =
            { ".pdf", ".doc", ".docx", ".ppt", ".pptx", ".xls", ".xlsx", ".txt", ".zip" };

        int courseID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LecturerID"] == null)
            {
                Response.Redirect("LecturerLogin.aspx");
                return;
            }

            // Guard: reject missing or non-numeric CourseID instead of crashing
            if (!int.TryParse(Request.QueryString["CourseID"], out courseID))
            {
                Response.Redirect("ViewAssignedCourses.aspx");
                return;
            }

            // FIX 4: IDOR guard -- verify the logged-in lecturer is assigned to this course
            if (!IsLecturerAssignedToCourse(courseID))
            {
                Response.Redirect("ViewAssignedCourses.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCourseName();
                LoadNotes();
            }
        }

        void LoadCourseName()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CourseName FROM Courses WHERE CourseID=@CourseID", con);
                cmd.Parameters.AddWithValue("@CourseID", courseID);
                con.Open();
                object result = cmd.ExecuteScalar();
                lblCourseName.Text = result != null ? result.ToString() : string.Empty;
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!FileUpload1.HasFile)
            {
                lblMessage.Text = "Please select a file to upload.";
                return;
            }

            string fileName = Path.GetFileName(FileUpload1.FileName);
            string ext = Path.GetExtension(fileName).ToLowerInvariant();

            bool allowed = false;
            foreach (string allowedExt in AllowedExtensions)
            {
                if (ext == allowedExt) { allowed = true; break; }
            }

            if (!allowed)
            {
                lblMessage.Text = "File type not allowed. Permitted types: PDF, Word, PowerPoint, Excel, TXT, ZIP.";
                return;
            }

            string folderPath = Server.MapPath("~/Notes/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string savePath = folderPath + fileName;
            FileUpload1.SaveAs(savePath);

            string dbPath = "~/Notes/" + fileName;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Notes (LecturerID, CourseID, WeekNo, FileName, FilePath, UploadDate) VALUES (@LecturerID, @CourseID, @WeekNo, @FileName, @FilePath, @UploadDate)", con);

                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                cmd.Parameters.AddWithValue("@CourseID", courseID);
                cmd.Parameters.AddWithValue("@WeekNo", ddlWeek.SelectedValue);
                cmd.Parameters.AddWithValue("@FileName", fileName);
                cmd.Parameters.AddWithValue("@FilePath", dbPath);
                cmd.Parameters.AddWithValue("@UploadDate", DateTime.Now);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Notes Uploaded Successfully";
            LoadNotes();
        }

        void LoadNotes()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT WeekNo, FileName, FilePath, UploadDate FROM Notes WHERE CourseID=@CourseID", con);
                cmd.Parameters.AddWithValue("@CourseID", courseID);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvNotes.DataSource = dt;
                gvNotes.DataBind();
            }
        }

        // FIX 4: helper -- confirms the current lecturer is assigned to the given course
        private bool IsLecturerAssignedToCourse(int cID)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(1) FROM LecturerCourseAssignment WHERE LecturerID=@LecturerID AND CourseID=@CourseID", con);
                cmd.Parameters.AddWithValue("@LecturerID", Session["LecturerID"]);
                cmd.Parameters.AddWithValue("@CourseID", cID);
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }
    }
}