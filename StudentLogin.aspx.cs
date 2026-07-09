using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class StudentLogin : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager
                .ConnectionStrings["CollegeDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT StudentID, StudentName, Email FROM Students " +
                    "WHERE Email=@Email AND Password=@Password";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["StudentID"] = dr["StudentID"];
                    Session["StudentEmail"] = dr["Email"].ToString();
                    Session["StudentName"] = dr["StudentName"].ToString();
                    Response.Redirect("StudentDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid Email or Password";
                }
            }
        }
    }
}