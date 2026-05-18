<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="StudentManagementSystem.AdminReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Institutional Report</title>
    <style>
        body { font-family: Arial; margin: 0; background-color: #f5f5f5; }
        .menu { background-color: darkblue; padding: 15px; }
        .menu a { color: white; text-decoration: none; margin-right: 25px; font-weight: bold; font-size: 16px; }
        .content { padding: 30px; }
        h2 { color: darkblue; }
        h3 { color: #333; margin-top: 30px; }
        .summary-cards { margin-bottom: 30px; }
        .card {
            width: 200px; background-color: white; padding: 20px;
            border-radius: 10px; display: inline-block; margin-right: 20px;
            margin-bottom: 20px; box-shadow: 0px 0px 10px lightgray; text-align: center;
        }
        .card h4 { color: darkblue; margin-bottom: 10px; }
        .card .num { font-size: 28px; font-weight: bold; color: #333; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; }
        th { background-color: darkblue; color: white; padding: 10px; text-align: left; }
        td { padding: 8px 10px; border: 1px solid #ccc; }
        tr:nth-child(even) { background-color: #f9f9f9; }
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
        <a href="AdminReport.aspx">Reports</a>
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
    </div>

    <div class="content">
        <h2>Institutional Report</h2>

        <!-- ENROLLMENT SUMMARY CARDS -->
        <h3>Enrollment Summary</h3>
        <div class="summary-cards">
            <div class="card">
                <h4>Total Enrollments</h4>
                <div class="num"><asp:Label ID="lblTotal" runat="server" /></div>
            </div>
            <div class="card">
                <h4>Approved</h4>
                <div class="num"><asp:Label ID="lblApproved" runat="server" /></div>
            </div>
            <div class="card">
                <h4>Pending</h4>
                <div class="num"><asp:Label ID="lblPending" runat="server" /></div>
            </div>
            <div class="card">
                <h4>Rejected</h4>
                <div class="num"><asp:Label ID="lblRejected" runat="server" /></div>
            </div>
        </div>

        <!-- MARKS SUMMARY -->
        <h3>Marks Summary by Course</h3>
        <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False"
            EmptyDataText="No marks data available.">
            <Columns>
                <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                <asp:BoundField DataField="TotalStudents" HeaderText="Students Assessed" />
                <asp:BoundField DataField="AvgMarks" HeaderText="Average Total Marks" />
                <asp:BoundField DataField="PassCount" HeaderText="Pass (>=50)" />
                <asp:BoundField DataField="FailCount" HeaderText="Fail (<50)" />
            </Columns>
        </asp:GridView>

        <!-- ATTENDANCE SUMMARY -->
        <h3>Attendance Summary by Course</h3>
        <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False"
            EmptyDataText="No attendance data available.">
            <Columns>
                <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                <asp:BoundField DataField="TotalRecords" HeaderText="Total Records" />
                <asp:BoundField DataField="PresentCount" HeaderText="Present" />
                <asp:BoundField DataField="AttendanceRate" HeaderText="Attendance Rate (%)" />
            </Columns>
        </asp:GridView>

        <!-- CSV EXPORT -->
        <asp:Button ID="btnExportCSV" runat="server" Text="Export Report as CSV"
            OnClick="btnExportCSV_Click"
            Style="background-color:darkblue; color:white; padding:10px 20px;
                   border:none; border-radius:5px; cursor:pointer; font-size:14px;" />
    </div>

</form>
</body>
</html>
