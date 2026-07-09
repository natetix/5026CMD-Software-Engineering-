using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StudentManagementSystem
{
    public partial class DropCourse : System.Web.UI.Page
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
                LoadCourses();
        }

        private void LoadCourses()
        {
            string query = @"
                SELECT
                    ED.DetailID,
                    EM.EnrolmentID,
                    C.CourseCode,
                    C.CourseName,
                    C.SessionName,
                    EM.Status
                FROM EnrollmentDetails ED
                INNER JOIN EnrollmentMaster EM ON ED.EnrolmentID = EM.EnrolmentID
                INNER JOIN Courses C ON ED.CourseID = C.CourseID
                WHERE EM.StudentEmail = @Email
                AND EM.Status = 'Pending'";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DropCourse")
            {
                int detailID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // STEP 1: Get the EnrolmentID for this detail
                    SqlCommand getEnrolCmd = new SqlCommand(
                        "SELECT EnrolmentID FROM EnrollmentDetails WHERE DetailID=@DetailID", con);
                    getEnrolCmd.Parameters.AddWithValue("@DetailID", detailID);
                    int enrolmentID = Convert.ToInt32(getEnrolCmd.ExecuteScalar());

                    // STEP 2: Delete the detail record
                    SqlCommand detailCmd = new SqlCommand(
                        @"DELETE FROM EnrollmentDetails
                          WHERE DetailID=@DetailID
                          AND EnrolmentID IN (
                              SELECT EnrolmentID FROM EnrollmentMaster
                              WHERE StudentEmail=@Email AND Status='Pending')", con);
                    detailCmd.Parameters.AddWithValue("@DetailID", detailID);
                    detailCmd.Parameters.AddWithValue("@Email", Session["StudentEmail"]);
                    detailCmd.ExecuteNonQuery();

                    // STEP 3: Check if any details remain for this EnrolmentID
                    SqlCommand checkCmd = new SqlCommand(
                        "SELECT COUNT(*) FROM EnrollmentDetails WHERE EnrolmentID=@EnrolmentID", con);
                    checkCmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                    int remaining = (int)checkCmd.ExecuteScalar();

                    // STEP 4: If no details remain, delete the master record
                    if (remaining == 0)
                    {
                        SqlCommand masterCmd = new SqlCommand(
                            "DELETE FROM EnrollmentMaster WHERE EnrolmentID=@EnrolmentID", con);
                        masterCmd.Parameters.AddWithValue("@EnrolmentID", enrolmentID);
                        masterCmd.ExecuteNonQuery();

                        lblMessage.Text = "Course dropped successfully. (Master record cleaned up)";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "Course dropped successfully.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                }

                LoadCourses();
            }
        }
    }
}