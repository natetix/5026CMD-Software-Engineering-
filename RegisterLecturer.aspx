<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterLecturer.aspx.cs" Inherits="StudentManagementSystem.RegisterLecturer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register Lecturer</title>
    <style>
        body { font-family: Arial; margin: 0; background-color: #f5f5f5; }
        .menu { background-color: darkblue; padding: 15px; }
        .menu a { color: white; text-decoration: none; margin-right: 25px; font-weight: bold; font-size: 16px; }
        .content { padding: 30px; }
        .form-table td { padding: 8px 12px; }
        .btn { background-color: darkblue; color: white; border: none; padding: 10px 25px; cursor: pointer; font-size: 14px; }
        h2 { color: darkblue; }
        .grid th { background-color: darkblue; color: white; padding: 10px; }
        .grid td { padding: 8px; border: 1px solid #ccc; }
        .grid { width: 100%; border-collapse: collapse; margin-top: 20px; }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="menu">
        <a href="AdminDashboard.aspx">Dashboard</a>
        <a href="ViewEnrollment.aspx">View Enrollment</a>
        <a href="AssignCourse.aspx">Assign Course</a>
        <a href="RegisterLecturer.aspx">Register Lecturer</a>
        <a href="RegisterStudent.aspx">Register Student</a>
        <a href="ManageCourses.aspx">Manage Courses</a>
    </div>

    <div class="content">
        <h2>Register New Lecturer</h2>

        <table class="form-table">
            <tr>
                <td>Lecturer Name</td>
                <td><asp:TextBox ID="txtName" runat="server" Width="280px" /></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><asp:TextBox ID="txtEmail" runat="server" Width="280px" /></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><asp:TextBox ID="txtPassword" runat="server" Width="280px" TextMode="Password" /></td>
            </tr>
            <tr>
                <td>Department</td>
                <td><asp:TextBox ID="txtDepartment" runat="server" Width="280px" /></td>
            </tr>
            <tr>
                <td>Phone</td>
                <td><asp:TextBox ID="txtPhone" runat="server" Width="280px" /></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnRegister" runat="server" Text="Register Lecturer"
                        CssClass="btn" OnClick="btnRegister_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                </td>
            </tr>
        </table>

        <h3>Registered Lecturers</h3>
        <asp:GridView ID="gvLecturers" runat="server" AutoGenerateColumns="False" CssClass="grid">
            <Columns>
                <asp:BoundField DataField="LecturerID" HeaderText="ID" />
                <asp:BoundField DataField="LecturerName" HeaderText="Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
            </Columns>
        </asp:GridView>
    </div>

</form>
</body>
</html>
