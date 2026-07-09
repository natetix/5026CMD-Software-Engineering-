<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="StudentManagementSystem.StudentDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Student Dashboard &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="StudentDashboard.aspx">
                <span class="sims-brand-badge">SIMS</span>Student
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="StudentDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseEnrollment.aspx">Course Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewEnrolledCourses.aspx">Enrolled Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewMarks.aspx">My Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewAttendance.aspx">My Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="DropCourse.aspx">Drop Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="StudentNotifications.aspx">Notifications
                            <asp:Label ID="lblNotifCount" runat="server" CssClass="sims-notif-badge" Visible="false" />
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout"
                    CssClass="btn btn-light btn-sm" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1>Student Dashboard</h1>
            <p class="sims-subtitle">Welcome
                <strong><asp:Label ID="lblStudentName" runat="server" /></strong></p>

            <div class="row g-3 mb-4">
                <div class="col-sm-6 col-lg-4">
                    <div class="sims-stat">
                        <div class="sims-stat-label">Total Enrolled Courses</div>
                        <div class="sims-stat-value"><asp:Label ID="lblTotalCourses" runat="server" /></div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="sims-stat accent-green">
                        <div class="sims-stat-label">Approved Courses</div>
                        <div class="sims-stat-value"><asp:Label ID="lblApproved" runat="server" /></div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="sims-stat accent-amber">
                        <div class="sims-stat-label">Pending Courses</div>
                        <div class="sims-stat-value"><asp:Label ID="lblPending" runat="server" /></div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>
