<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PoorPerformance.aspx.cs" Inherits="StudentManagementSystem.PoorPerformance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Poor Performance</title>
    <style>
        body { font-family: Arial; margin: 0; background-color: #f4f4f4; }
        .navbar { background-color: navy; padding: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 15px; font-weight: bold; margin-right: 20px; }
        .container { padding: 40px; }
        h2, h3 { color: navy; }
        .grid th { background-color: navy; color: white; padding: 10px; }
        .grid td { padding: 8px; border: 1px solid #ccc; }
        .grid { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        .alert { background-color: #fff3cd; border: 1px solid #ffc107; padding: 10px 16px; border-radius: 4px; margin-bottom: 20px; }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="navbar">
        <a href="LecturerDashboard.aspx">Dashboard</a>
        <a href="ViewAssignedCourses.aspx">Assigned Courses</a>
        <a href="ManageAttendance.aspx">Attendance</a>
        <a href="EnterMarks.aspx">Enter Marks</a>
        <a href="MarksReport.aspx">Marks Report</a>
        <a href="ManageProfile.aspx">My Profile</a>
        <a href="PoorPerformance.aspx">Poor Performance</a>
        <a href="Announcements.aspx">Announcements</a>
    </div>

    <div class="container">
        <h2>Poor Performance Report</h2>
        <p class="alert">Students with <strong>Total Marks below 50</strong> or <strong>Attendance below 75%</strong> in your courses are listed below.</p>

        <h3>Low Marks (Below 50)</h3>
        <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False" CssClass="grid"
            EmptyDataText="No students with low marks found.">
            <Columns>
                <asp:BoundField DataField="StudentName"  HeaderText="Student" />
                <asp:BoundField DataField="StudentEmail" HeaderText="Email" />
                <asp:BoundField DataField="CourseName"   HeaderText="Course" />
                <asp:BoundField DataField="TotalMarks"   HeaderText="Total Marks" />
                <asp:BoundField DataField="Grade"        HeaderText="Grade" />
            </Columns>
        </asp:GridView>

        <h3>Low Attendance (Below 75%)</h3>
        <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="grid"
            EmptyDataText="No students with low attendance found.">
            <Columns>
                <asp:BoundField DataField="StudentName"   HeaderText="Student" />
                <asp:BoundField DataField="StudentEmail"  HeaderText="Email" />
                <asp:BoundField DataField="CourseName"    HeaderText="Course" />
                <asp:BoundField DataField="AttendancePct" HeaderText="Attendance %" />
            </Columns>
        </asp:GridView>
    </div>

</form>
</body>
</html>
