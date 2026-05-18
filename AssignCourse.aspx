<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssignCourse.aspx.cs" Inherits="StudentManagementSystem.AssignCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Assign Course</title>

    <style>

        body
        {
            font-family: Arial;
            margin: 0;
            background-color: #f5f5f5;
        }

        .menu
        {
            background-color: darkblue;
            padding: 15px;
        }

        .menu a
        {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }

        .container
        {
            padding: 30px;
        }

        .form-box
        {
            background-color: white;
            width: 500px;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px lightgray;
        }

        .grid
        {
            margin-top: 30px;
        }

        h2
        {
            color: darkblue;
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

    <div class="container">

        <div class="form-box">

            <h2>Assign Course to Lecturer</h2>

            <!-- SESSION -->

            <asp:Label ID="Label1"
                runat="server"
                Text="Select Session">
            </asp:Label>

            <br />

            <asp:DropDownList ID="ddlSession"
                runat="server"
                Width="300px">
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
                Width="300px">

                <asp:ListItem>Semester 1</asp:ListItem>

                <asp:ListItem>Semester 2</asp:ListItem>

            </asp:DropDownList>

            <br /><br />

            <!-- LECTURER -->

            <asp:Label ID="Label3"
                runat="server"
                Text="Select Lecturer">
            </asp:Label>

            <br />

            <asp:DropDownList ID="ddlLecturer"
                runat="server"
                Width="300px">
            </asp:DropDownList>

            <br /><br />

            <!-- COURSE -->

            <asp:Label ID="Label4"
                runat="server"
                Text="Select Course">
            </asp:Label>

            <br />

            <asp:DropDownList ID="ddlCourse"
                runat="server"
                Width="300px">
            </asp:DropDownList>

            <br /><br />

            <!-- BUTTON -->

            <asp:Button ID="btnAssign"
                runat="server"
                Text="Assign Course"
                Width="150px"
                OnClick="btnAssign_Click" />

            <br /><br />

            <asp:Label ID="lblMessage"
                runat="server"
                ForeColor="Green">
            </asp:Label>

        </div>

        <!-- GRIDVIEW -->

        <div class="grid">

            <h2>Assigned Course List</h2>

            <asp:GridView ID="gvAssignment"
                runat="server"
                AutoGenerateColumns="False"
                Width="1000px">

                <Columns>

                    <asp:BoundField DataField="AssignmentID"
                        HeaderText="Assignment ID" />

                    <asp:BoundField DataField="LecturerName"
                        HeaderText="Lecturer Name" />

                    <asp:BoundField DataField="CourseCode"
                        HeaderText="Course Code" />

                    <asp:BoundField DataField="CourseName"
                        HeaderText="Course Name" />

                    <asp:BoundField DataField="SessionName"
                        HeaderText="Session" />

                    <asp:BoundField DataField="Semester"
                        HeaderText="Semester" />

                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>

</body>

</html>