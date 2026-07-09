using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentViewMarks : System.Web.UI.Page
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
                LoadMarks();
                LoadGPA();
            }
        }

        private void LoadMarks()
        {
            string query = @"
                SELECT
                    C.CourseName,
                    C.CourseCode,
                    CM.AssignmentMarks,
                    CM.QuizMarks,
                    CM.MidTestMarks,
                    CM.FinalExamMarks,
                    CM.TotalMarks,
                    CASE
                        WHEN CM.TotalMarks >= 80 THEN 'A'
                        WHEN CM.TotalMarks >= 70 THEN 'B'
                        WHEN CM.TotalMarks >= 60 THEN 'C'
                        WHEN CM.TotalMarks >= 50 THEN 'D'
                        ELSE 'F'
                    END AS Grade
                FROM CourseMarks CM
                INNER JOIN EnrollmentMaster EM
                    ON CM.EnrolmentID = EM.EnrolmentID
                INNER JOIN Courses C
                    ON CM.CourseID = C.CourseID
                WHERE EM.StudentEmail = @StudentEmail";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StudentEmail", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    gvMarks.Visible = false;
                    lblNoData.Visible = true;
                }
                else
                {
                    gvMarks.DataSource = dt;
                    gvMarks.DataBind();
                }
            }
        }
        private void LoadGPA()
        {
            string query = @"
                SELECT CAST(AVG(CAST(
                    CASE
                        WHEN CM.TotalMarks >= 80 THEN 4.0
                        WHEN CM.TotalMarks >= 70 THEN 3.0
                        WHEN CM.TotalMarks >= 60 THEN 2.0
                        WHEN CM.TotalMarks >= 50 THEN 1.0
                        ELSE 0.0
                    END AS DECIMAL(3,2))) AS DECIMAL(3,2)) AS GPA
                FROM CourseMarks CM
                INNER JOIN EnrollmentMaster EM
                    ON CM.EnrolmentID = EM.EnrolmentID
                WHERE EM.StudentEmail = @StudentEmail";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StudentEmail", Session["StudentEmail"]);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                    lblGPA.Text = Convert.ToDecimal(result).ToString("0.00") + " / 4.00";
                else
                    lblGPA.Text = "N/A";
            }
        }
    }
}
