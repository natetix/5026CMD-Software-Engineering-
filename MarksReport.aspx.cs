using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace StudentManagementSystem
{
    public partial class MarksReport : System.Web.UI.Page
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
                LoadSessions();
                LoadCourses();
                LoadMarks();
            }
        }

        private void LoadSessions()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT DISTINCT SessionName FROM Courses", con);
                con.Open();
                ddlSession.DataSource = cmd.ExecuteReader();
                ddlSession.DataTextField = "SessionName";
                ddlSession.DataValueField = "SessionName";
                ddlSession.DataBind();
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CourseID, CourseName FROM Courses WHERE SessionName=@Session", con);
                cmd.Parameters.AddWithValue("@Session", ddlSession.SelectedValue);
                con.Open();
                ddlCourse.DataSource = cmd.ExecuteReader();
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
            }
        }

        private void LoadMarks()
        {
            string query = @"
                SELECT
                    CM.EnrolmentID,
                    EM.StudentName,
                    C.CourseName,
                    CM.AssignmentMarks,
                    CM.QuizMarks,
                    CM.MidTestMarks,
                    CM.FinalExamMarks,
                    CM.TotalMarks
                FROM CourseMarks CM
                INNER JOIN EnrollmentMaster EM ON CM.EnrolmentID = EM.EnrolmentID
                INNER JOIN Courses C ON CM.CourseID = C.CourseID
                WHERE CM.CourseID=@CourseID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CourseID", ddlCourse.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMarks.DataSource = dt;
                gvMarks.DataBind();
            }
        }

        protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
            LoadMarks();
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMarks();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=MarksReport.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            StringWriter sw = new StringWriter();
            sw.WriteLine("Student ID,Student Name,Course,Assignment,Quiz,Mid Test,Final Exam,Total");

            foreach (System.Web.UI.WebControls.GridViewRow row in gvMarks.Rows)
            {
                sw.WriteLine(
                    CsvEscape(row.Cells[0].Text) + "," +
                    CsvEscape(row.Cells[1].Text) + "," +
                    CsvEscape(row.Cells[2].Text) + "," +
                    row.Cells[3].Text + "," +
                    row.Cells[4].Text + "," +
                    row.Cells[5].Text + "," +
                    row.Cells[6].Text + "," +
                    row.Cells[7].Text);
            }

            Response.Output.Write(sw.ToString());
            Response.Flush();
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
    }
}
