<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewEnrolledCourses.aspx.cs" Inherits="StudentManagementSystem.ViewEnrolledCourses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>View Enrolled Courses</title>

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

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- MENU -->

    <div class="menu">
        <a href="StudentDashboard.aspx">Dashboard</a>
        <a href="CourseEnrollment.aspx">Course Enrollment</a>
        <a href="ViewEnrolledCourses.aspx">View Enrolled Courses</a>
        <a href="StudentViewMarks.aspx">My Marks</a>
        <a href="StudentViewAttendance.aspx">My Attendance</a>
        <a href="DropCourse.aspx">Drop Course</a>
        <a href="StudentAnnouncements.aspx">Announcements</a>
        <a href="StudentProfile.aspx">My Profile</a>
    </div>

    <h2>My Enrolled Courses</h2>

    <!-- GRIDVIEW -->

    <asp:GridView ID="gvCourses"
        runat="server"
        AutoGenerateColumns="False"
        Width="1000px">

        <Columns>

            <asp:BoundField DataField="CourseCode"
                HeaderText="Course Code" />

            <asp:BoundField DataField="CourseName"
                HeaderText="Course Name" />

            <asp:BoundField DataField="CreditHours"
                HeaderText="Credit Hours" />

            <asp:BoundField DataField="Status"
                HeaderText="Enrollment Status" />

            <asp:TemplateField HeaderText="Notes">

                <ItemTemplate>

                    <asp:Button ID="btnViewNotes"
                        runat="server"
                        Text="View Notes"
                        CommandArgument='<%# Eval("CourseID") %>'
                        OnClick="btnViewNotes_Click" />

                </ItemTemplate>

            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</form>

</body>

</html>