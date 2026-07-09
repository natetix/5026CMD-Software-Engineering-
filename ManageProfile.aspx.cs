using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StudentManagementSystem
{
    public partial class ManageProfile : System.Web.UI.Page
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
                LoadProfile();
        }

        private void LoadProfile()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT LecturerName, Email, Department, Phone FROM Lecturers WHERE LecturerID=@ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", Session["LecturerID"]);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtName.Text = dr["LecturerName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtDepartment.Text = dr["Department"].ToString();
                    txtPhone.Text = dr["Phone"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query;

                if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    query = @"UPDATE Lecturers SET
                        LecturerName=@Name, Department=@Dept, Phone=@Phone, Password=@Password
                        WHERE LecturerID=@ID";
                }
                else
                {
                    query = @"UPDATE Lecturers SET
                        LecturerName=@Name, Department=@Dept, Phone=@Phone
                        WHERE LecturerID=@ID";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Dept", txtDepartment.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@ID", Session["LecturerID"]);

                if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            Session["LecturerName"] = txtName.Text.Trim();
            lblMessage.Text = "Profile updated successfully.";
        }
    }
}
