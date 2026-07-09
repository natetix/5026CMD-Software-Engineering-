<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentViewAttendance.aspx.cs" Inherits="StudentManagementSystem.StudentViewAttendance" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Attendance &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="StudentDashboard.aspx"><span class="sims-brand-badge">SIMS</span>Student</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="StudentDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseEnrollment.aspx">Course Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewEnrolledCourses.aspx">Enrolled Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewMarks.aspx">My Marks</a></li>
                    <li class="nav-item"><a class="nav-link active" href="StudentViewAttendance.aspx">My Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="DropCourse.aspx">Drop Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentNotifications.aspx">Notifications</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">My Attendance Records</h1>
            <p class="sims-subtitle">Welcome, <strong><asp:Label ID="lblName" runat="server" /></strong></p>

            <h2 class="h4 mb-3">Attendance Summary by Course</h2>
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="CourseCode" HeaderText="Code" />
                        <asp:BoundField DataField="TotalClasses" HeaderText="Total Classes" />
                        <asp:BoundField DataField="Present" HeaderText="Present" />
                        <asp:BoundField DataField="Absent" HeaderText="Absent" />
                        <asp:BoundField DataField="AttendancePct" HeaderText="Attendance %" />
                    </Columns>
                </asp:GridView>
            </div>

            <h2 class="h4 mb-3">Detailed Attendance Log</h2>
            <div class="table-responsive mb-3">
                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="AttendanceDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Label ID="lblNoData" runat="server" ForeColor="Gray"
                Text="No attendance records found." Visible="false" />

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
