<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="StudentManagementSystem.AdminReport" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Institutional Report &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminDashboard.aspx"><span class="sims-brand-badge">SIMS</span>Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="AdminDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewEnrollment.aspx">View Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="AssignCourse.aspx">Assign Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="RegisterLecturer.aspx">Register Lecturer</a></li>
                    <li class="nav-item"><a class="nav-link" href="RegisterStudent.aspx">Register Student</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageCourses.aspx">Manage Courses</a></li>
                    <li class="nav-item"><a class="nav-link active" href="AdminReport.aspx">Reports</a></li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-light btn-sm" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Institutional Report</h1>

            <!-- ENROLLMENT SUMMARY CARDS -->
            <h2 class="h4 mb-3">Enrollment Summary</h2>
            <div class="row g-3 mb-4">
                <div class="col-6 col-md-3">
                    <div class="sims-stat">
                        <div class="sims-stat-label">Total Enrollments</div>
                        <div class="sims-stat-value"><asp:Label ID="lblTotal" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="sims-stat accent-green">
                        <div class="sims-stat-label">Approved</div>
                        <div class="sims-stat-value"><asp:Label ID="lblApproved" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="sims-stat accent-amber">
                        <div class="sims-stat-label">Pending</div>
                        <div class="sims-stat-value"><asp:Label ID="lblPending" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="sims-stat accent-red">
                        <div class="sims-stat-label">Rejected</div>
                        <div class="sims-stat-value"><asp:Label ID="lblRejected" runat="server" /></div>
                    </div>
                </div>
            </div>

            <!-- MARKS SUMMARY -->
            <h2 class="h4 mb-3">Marks Summary by Course</h2>
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None" Width="100%"
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
            </div>

            <!-- ATTENDANCE SUMMARY -->
            <h2 class="h4 mb-3">Attendance Summary by Course</h2>
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None" Width="100%"
                    EmptyDataText="No attendance data available.">
                    <Columns>
                        <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                        <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                        <asp:BoundField DataField="TotalRecords" HeaderText="Total Records" />
                        <asp:BoundField DataField="PresentCount" HeaderText="Present" />
                        <asp:BoundField DataField="AttendanceRate" HeaderText="Attendance Rate (%)" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- CSV EXPORT -->
            <asp:Button ID="btnExportCSV" runat="server" Text="Export Report as CSV"
                CssClass="btn btn-sims"
                OnClick="btnExportCSV_Click" />

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
