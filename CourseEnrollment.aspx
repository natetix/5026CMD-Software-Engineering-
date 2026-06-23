﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseEnrollment.aspx.cs" Inherits="StudentManagementSystem.CourseEnrollment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Course Enrollment</title>

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

    <h2>Course Enrollment</h2>

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

    <!-- SEMESTER -->

    <asp:Label ID="Label2"
        runat="server"
        Text="Select Semester">
    </asp:Label>

    <br />

    <asp:DropDownList ID="ddlSemester"
        runat="server"
        Width="250px"
        AutoPostBack="True"
        OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged">

        <asp:ListItem>Semester 1</asp:ListItem>

        <asp:ListItem>Semester 2</asp:ListItem>

    </asp:DropDownList>

    <br /><br />

    <!-- COURSE GRID -->

    <asp:GridView ID="gvCourses"
        runat="server"
        AutoGenerateColumns="False"
        Width="1200px"
        CssClass="grid">

        <Columns>

            <asp:TemplateField HeaderText="Select">

                <ItemTemplate>

                    <asp:CheckBox ID="chkSelect"
                        runat="server" />

                </ItemTemplate>

            </asp:TemplateField>

            <asp:BoundField DataField="CourseID"
                HeaderText="Course ID" />

            <asp:BoundField DataField="CourseCode"
                HeaderText="Course Code" />

            <asp:BoundField DataField="CourseName"
                HeaderText="Course Name" />

            <asp:BoundField DataField="CreditHours"
                HeaderText="Credit Hours" />

        </Columns>

    </asp:GridView>

    <br />

    <!-- SUBMIT BUTTON -->

    <asp:Button ID="btnSubmit"
        runat="server"
        Text="Submit Enrollment"
        Width="200px"
        OnClick="btnSubmit_Click" />

    <br /><br />

    <asp:Label ID="lblMessage"
        runat="server"
        ForeColor="Green">
    </asp:Label>

    <hr />

    <h2>Submitted Enrollment Details</h2>

    <!-- ENROLLMENT GRID -->

    <asp:GridView ID="gvEnrollment"
        runat="server"
        AutoGenerateColumns="True"
        Width="1200px">

    </asp:GridView>

</form>

</body>

</html>