<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="StudentManagementSystem.StudentProfile" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Profile &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link" href="StudentViewAttendance.aspx">My Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="DropCourse.aspx">Drop Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentNotifications.aspx">Notifications</a></li>
                    <li class="nav-item"><a class="nav-link active" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-light btn-sm" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">My Profile</h1>

            <!-- PERSONAL INFO -->
            <div class="sims-card p-4 mb-4" style="max-width:600px;">
                <div class="mb-2"><strong>Student ID:</strong> <asp:Label ID="lblStudentID" runat="server" /></div>
                <div class="mb-2"><strong>Full Name:</strong> <asp:Label ID="lblName" runat="server" /></div>
                <div class="mb-2"><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></div>
                <div class="mb-2"><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" /></div>
            </div>

            <!-- ACADEMIC STATS -->
            <h2 class="h4 mb-3">Academic Summary</h2>
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
            </div>

            <!-- GPA -->
            <div class="sims-card p-3 d-inline-block">
                <span class="fw-bold text-primary">Cumulative GPA: </span>
                <asp:Label ID="lblGPA" runat="server" Font-Bold="True" Font-Size="20px" ForeColor="DarkBlue" />
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
