using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["CollegeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
                LoadCourses();
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CourseID, CourseCode, CourseName, SessionName, CreditHours FROM Courses ORDER BY CourseName", con);

                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int courseID = Convert.ToInt32(hfCourseID.Value);

            if (!int.TryParse(txtCreditHours.Text.Trim(), out int cr) || cr <= 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Credit hours must be a positive number.";
                return;
            }

            if (cr > 20)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Credit hours must be 20 or less.";
                return;
            }

            string code = txtCode.Text.Trim();
            string name = txtName.Text.Trim();
            string session = txtSession.Text.Trim();

            if (string.IsNullOrWhiteSpace(code) || string.IsNullOrWhiteSpace(name))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Course Code and Course Name are required.";
                return;
            }

            if (code.Length > 20)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Course Code must be 20 characters or fewer.";
                return;
            }

            if (name.Length > 100)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Course Name must be 100 characters or fewer.";
                return;
            }

            if (session.Length > 50)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Session must be 50 characters or fewer.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd;

                    if (courseID == 0)
                    {
                        cmd = new SqlCommand(
                            @"INSERT INTO Courses (CourseCode, CourseName, SessionName, CreditHours)
                              VALUES (@Code, @Name, @Session, @CreditHours)", con);
                    }
                    else
                    {
                        cmd = new SqlCommand(
                            @"UPDATE Courses SET CourseCode=@Code, CourseName=@Name,
                              SessionName=@Session, CreditHours=@CreditHours
                              WHERE CourseID=@CourseID", con);
                        cmd.Parameters.AddWithValue("@CourseID", courseID);
                    }

                    cmd.Parameters.AddWithValue("@Code", code);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Session", session);
                    cmd.Parameters.AddWithValue("@CreditHours", cr);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Unable to save course. Please check your input and try again.";
                return;
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = courseID == 0 ? "Course added." : "Course updated.";
            ClearForm();
            LoadCourses();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblMessage.Text = string.Empty;
        }

        protected void gvCourses_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int courseID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteCourse")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand(
                            "DELETE FROM Courses WHERE CourseID=@CourseID", con);
                        cmd.Parameters.AddWithValue("@CourseID", courseID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Course deleted.";
                }
                catch (SqlException)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Cannot delete: this course has existing enrollments or assignments.";
                }
                LoadCourses();
            }
            else if (e.CommandName == "EditCourse")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT CourseCode, CourseName, SessionName, CreditHours FROM Courses WHERE CourseID=@CourseID", con);
                    cmd.Parameters.AddWithValue("@CourseID", courseID);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfCourseID.Value = courseID.ToString();
                        txtCode.Text = dr["CourseCode"].ToString();
                        txtName.Text = dr["CourseName"].ToString();
                        txtSession.Text = dr["SessionName"].ToString();
                        txtCreditHours.Text = dr["CreditHours"].ToString();
                        btnSave.Text = "Update Course";
                    }
                }
            }
        }

        private void ClearForm()
        {
            hfCourseID.Value = "0";
            txtCode.Text = txtName.Text = txtSession.Text = txtCreditHours.Text = string.Empty;
            btnSave.Text = "Add Course";
        }
    }
}
