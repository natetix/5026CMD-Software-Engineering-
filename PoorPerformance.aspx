<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PoorPerformance.aspx.cs" Inherits="StudentManagementSystem.PoorPerformance" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Poor Performance &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="LecturerDashboard.aspx"><span class="sims-brand-badge">SIMS</span>Lecturer</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="LecturerDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewAssignedCourses.aspx">Assigned Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageAttendance.aspx">Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="AttendanceReport.aspx">Attendance Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="EnterMarks.aspx">Enter Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="MarksReport.aspx">Marks Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link active" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Poor Performance Report</h1>
            <div class="alert alert-warning">Students with <strong>Total Marks below 50</strong> or <strong>Attendance below 75%</strong> in your courses are listed below.</div>

            <h2 class="h4 mb-3">Low Marks (Below 50)</h2>
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%"
                    EmptyDataText="No students with low marks found.">
                    <Columns>
                        <asp:BoundField DataField="StudentName"  HeaderText="Student" />
                        <asp:BoundField DataField="StudentEmail" HeaderText="Email" />
                        <asp:BoundField DataField="CourseName"   HeaderText="Course" />
                        <asp:BoundField DataField="TotalMarks"   HeaderText="Total Marks" />
                        <asp:BoundField DataField="Grade"        HeaderText="Grade" />
                    </Columns>
                </asp:GridView>
            </div>

            <h2 class="h4 mb-3">Low Attendance (Below 75%)</h2>
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%"
                    EmptyDataText="No students with low attendance found.">
                    <Columns>
                        <asp:BoundField DataField="StudentName"   HeaderText="Student" />
                        <asp:BoundField DataField="StudentEmail"  HeaderText="Email" />
                        <asp:BoundField DataField="CourseName"    HeaderText="Course" />
                        <asp:BoundField DataField="AttendancePct" HeaderText="Attendance %" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
