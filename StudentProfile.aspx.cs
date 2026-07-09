using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentProfile : System.Web.UI.Page
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
                LoadProfile();
                LoadAcademicSummary();
                LoadGPA();
            }
        }

        private void LoadProfile()
        {
            string query = @"
                SELECT StudentID, StudentName, Email, Phone
                FROM Students
                WHERE Email = @Email";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblStudentID.Text = dr["StudentID"].ToString();
                    lblName.Text      = dr["StudentName"].ToString();
                    lblEmail.Text     = dr["Email"].ToString();
                    lblPhone.Text     = dr["Phone"] == DBNull.Value ? "N/A" : dr["Phone"].ToString();
                }
            }
        }

        private void LoadAcademicSummary()
        {
            string query = @"
                SELECT
                    COUNT(*) AS Total,
                    SUM(CASE WHEN Status='Approved' THEN 1 ELSE 0 END) AS Approved,
                    SUM(CASE WHEN Status='Pending'  THEN 1 ELSE 0 END) AS Pending
                FROM EnrollmentMaster
                WHERE StudentEmail = @Email";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTotal.Text    = dr["Total"].ToString();
                    lblApproved.Text = dr["Approved"].ToString();
                    lblPending.Text  = dr["Pending"].ToString();
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
                WHERE EM.StudentEmail = @Email";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                    lblGPA.Text = Convert.ToDecimal(result).ToString("0.00") + " / 4.00";
                else
                    lblGPA.Text = "N/A";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("StudentLogin.aspx");
        }
    }
}
