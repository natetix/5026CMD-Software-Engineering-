using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace StudentManagementSystem
{
    public partial class RegisterStudent : System.Web.UI.Page
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
                LoadStudents();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Name, Email, and Password are required.";
                return;
            }

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string programme = txtProgramme.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string ic = txtIC.Text.Trim();

            if (name.Length > 100)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Name must be 100 characters or fewer.";
                return;
            }

            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter a valid email address.";
                return;
            }

            if (email.Length > 100)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Email must be 100 characters or fewer.";
                return;
            }

            if (phone.Length > 20)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Phone must be 20 characters or fewer.";
                return;
            }

            if (ic.Length > 20)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "IC must be 20 characters or fewer.";
                return;
            }

            using (SqlConnection checkCon = new SqlConnection(cs))
            {
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Students WHERE Email = @Email", checkCon);
                checkCmd.Parameters.AddWithValue("@Email", email);
                checkCon.Open();
                int exists = (int)checkCmd.ExecuteScalar();
                if (exists > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error: this email is already registered.";
                    return;
                }
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Students
                        (StudentName, Email, Password, Programme, Phone, IC)
                        VALUES (@Name, @Email, @Password, @Programme, @Phone, @IC)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@Programme", programme);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@IC", ic);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex) when (ex.Number == 2627 || ex.Number == 2601)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: this email is already registered.";
                return;
            }
            catch (SqlException)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Unable to register student. Please check your input and try again.";
                return;
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Student registered successfully.";

            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtProgramme.Text = "";
            txtPhone.Text = "";
            txtIC.Text = "";

            LoadStudents();
        }

        private void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT StudentID, StudentName, Email, Programme, Phone, IC, CreatedDate FROM Students ORDER BY CreatedDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }
    }
}
