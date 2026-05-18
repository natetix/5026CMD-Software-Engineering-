<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="StudentManagementSystem.ManageCourses" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Courses</title>
    <style>
        body { font-family: Arial; margin: 0; background-color: #f4f4f4; }
        .navbar { background-color: navy; padding: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 15px; font-weight: bold; margin-right: 20px; }
        .container { padding: 40px; }
        h2 { color: navy; }
        .form-box { background: white; padding: 25px; border-radius: 6px; margin-bottom: 30px; max-width: 600px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        .form-box table td { padding: 8px 12px; }
        .form-box input[type=text] { width: 260px; padding: 6px; border: 1px solid #ccc; }
        .btn { background-color: navy; color: white; border: none; padding: 9px 22px; cursor: pointer; font-size: 14px; margin-right: 8px; }
        .btn-clear { background-color: gray; color: white; border: none; padding: 9px 18px; cursor: pointer; font-size: 14px; }
        .grid th { background-color: navy; color: white; padding: 10px; }
        .grid td { padding: 8px; border: 1px solid #ccc; }
        .grid { width: 100%; border-collapse: collapse; }
        .btn-del { background-color: red; color: white; border: none; padding: 4px 10px; cursor: pointer; }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="navbar">
        <a href="AdminDashboard.aspx">Dashboard</a>
        <a href="ViewEnrollment.aspx">View Enrollment</a>
        <a href="AssignCourse.aspx">Assign Course</a>
        <a href="RegisterLecturer.aspx">Register Lecturer</a>
        <a href="RegisterStudent.aspx">Register Student</a>
        <a href="ManageCourses.aspx">Manage Courses</a>
        <a href="AdminReport.aspx">Reports</a>
    </div>

    <div class="container">
        <h2>Manage Courses</h2>

        <div class="form-box">
            <asp:HiddenField ID="hfCourseID" runat="server" Value="0" />
            <table>
                <tr>
                    <td><strong>Course Code</strong></td>
                    <td><asp:TextBox ID="txtCode" runat="server" /></td>
                </tr>
                <tr>
                    <td><strong>Course Name</strong></td>
                    <td><asp:TextBox ID="txtName" runat="server" /></td>
                </tr>
                <tr>
                    <td><strong>Session</strong></td>
                    <td><asp:TextBox ID="txtSession" runat="server" /></td>
                </tr>
                <tr>
                    <td><strong>Credits</strong></td>
                    <td><asp:TextBox ID="txtCreditHours" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-top:12px;">
                        <asp:Button ID="btnSave" runat="server" Text="Add Course"
                            CssClass="btn" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn-clear" OnClick="btnClear_Click" CausesValidation="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                    </td>
                </tr>
            </table>
        </div>

        <h3>All Courses</h3>
        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False"
            CssClass="grid" OnRowCommand="gvCourses_RowCommand">
            <Columns>
                <asp:BoundField DataField="CourseID"    HeaderText="ID" />
                <asp:BoundField DataField="CourseCode"  HeaderText="Code" />
                <asp:BoundField DataField="CourseName"  HeaderText="Course Name" />
                <asp:BoundField DataField="SessionName" HeaderText="Session" />
                <asp:BoundField DataField="CreditHours" HeaderText="Credits" />
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit"
                            CssClass="btn" CommandName="EditCourse"
                            CommandArgument='<%# Eval("CourseID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete"
                            CssClass="btn-del" CommandName="DeleteCourse"
                            CommandArgument='<%# Eval("CourseID") %>'
                            OnClientClick="return confirm('Delete this course?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</form>
</body>
</html>
