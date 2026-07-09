using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager
                .ConnectionStrings["CollegeDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT AdminName FROM AdminUsers " +
                    "WHERE Email=@Email AND Password=@Password";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    Session["Admin"] = txtEmail.Text.Trim();
                    Session["AdminName"] = result.ToString();
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid Email or Password";
                }
            }
        }
    }
}