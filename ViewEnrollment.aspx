<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewEnrollment.aspx.cs" Inherits="StudentManagementSystem.ViewEnrollment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>View Enrollment</title>

    <style>

        body
        {
            font-family: Arial;
            margin: 20px;
        }

        h2
        {
            color: darkblue;
        }

        .menu
        {
            background-color: darkblue;
            padding: 15px;
            margin-bottom: 20px;
        }

        .menu a
        {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }

        .grid
        {
            margin-top: 20px;
        }

        .course-grid
        {
            margin-left: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- MENU -->

    <div class="menu">
        <a href="AdminDashboard.aspx">Dashboard</a>
        <a href="ViewEnrollment.aspx">View Enrollment</a>
        <a href="AssignCourse.aspx">Assign Course</a>
        <a href="RegisterLecturer.aspx">Register Lecturer</a>
        <a href="RegisterStudent.aspx">Register Student</a>
        <a href="ManageCourses.aspx">Manage Courses</a>
        <a href="AdminReport.aspx">Reports</a>
    </div>

    <h2>Student Enrollment List</h2>

    <!-- SESSION -->

    <asp:Label ID="Label1"
        runat="server"
        Text="Select Session">
    </asp:Label>

    <br />

    <asp:DropDownList ID="ddlSession"
        runat="server"
        Width="250px"
        AutoPostBack="True"
        OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
    </asp:DropDownList>

    <br /><br />

    <!-- MAIN GRID -->

    <asp:GridView ID="gvEnrollment"
        runat="server"
        AutoGenerateColumns="False"
        Width="1200px"
        DataKeyNames="EnrolmentID"
        OnRowDataBound="gvEnrollment_RowDataBound">

        <Columns>

            <asp:BoundField DataField="EnrolmentID"
                HeaderText="Enrollment ID" />

            <asp:BoundField DataField="StudentName"
                HeaderText="Student Name" />

            <asp:BoundField DataField="StudentEmail"
                HeaderText="Student Email" />

            <asp:BoundField DataField="SessionName"
                HeaderText="Session" />

            <asp:BoundField DataField="Semester"
                HeaderText="Semester" />

            <asp:BoundField DataField="Status"
                HeaderText="Status" />

            <asp:TemplateField HeaderText="Approve">

                <ItemTemplate>

                    <asp:Button ID="btnApprove"
                        runat="server"
                        Text="Approve"
                        Width="90px"
                        CommandArgument='<%# Eval("EnrolmentID") %>'
                        OnClick="btnApprove_Click"
                        Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                </ItemTemplate>

            </asp:TemplateField>

            <asp:TemplateField HeaderText="Reject">

                <ItemTemplate>

                    <asp:Button ID="btnReject"
                        runat="server"
                        Text="Reject"
                        Width="90px"
                        CommandArgument='<%# Eval("EnrolmentID") %>'
                        OnClick="btnReject_Click"
                        Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                </ItemTemplate>

            </asp:TemplateField>

            <asp:TemplateField HeaderText="Enrolled Courses">

                <ItemTemplate>

                    <asp:GridView ID="gvCourses"
                        runat="server"
                        AutoGenerateColumns="False"
                        Width="500px"
                        CssClass="course-grid">

                        <Columns>

                            <asp:BoundField DataField="CourseCode"
                                HeaderText="Course Code" />

                            <asp:BoundField DataField="CourseName"
                                HeaderText="Course Name" />

                            <asp:BoundField DataField="CreditHours"
                                HeaderText="Credit Hours" />

                        </Columns>

                    </asp:GridView>

                </ItemTemplate>

            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</form>

</body>

</html>