using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class RegisterLecturer : System.Web.UI.Page
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
                LoadLecturers();
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

            using (SqlConnection checkCon = new SqlConnection(cs))
            {
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Lecturers WHERE Email = @Email", checkCon);
                checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
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
                    string query = @"INSERT INTO Lecturers
                        (LecturerName, Email, Password, Department, Phone)
                        VALUES (@Name, @Email, @Password, @Department, @Phone)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@Department", txtDepartment.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());

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

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Lecturer registered successfully.";

            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtDepartment.Text = "";
            txtPhone.Text = "";

            LoadLecturers();
        }

        private void LoadLecturers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT LecturerID, LecturerName, Email, Department, Phone FROM Lecturers";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvLecturers.DataSource = dt;
                gvLecturers.DataBind();
            }
        }
    }
}
