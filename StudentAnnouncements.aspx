<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentAnnouncements.aspx.cs" Inherits="StudentManagementSystem.StudentAnnouncements" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Announcements &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
    <style>
        .ann-card { background: white; border-left: 5px solid #1a237e; padding: 16px 20px; margin-bottom: 16px; border-radius: 4px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
        .ann-card h4 { margin: 0 0 6px 0; color: #1a237e; }
        .ann-card p { margin: 0 0 6px 0; }
        .ann-meta { font-size: 12px; color: #888; }
        .empty { color: #666; font-style: italic; }
    </style>
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
                    <li class="nav-item"><a class="nav-link active" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentNotifications.aspx">Notifications</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Announcements</h1>

            <asp:Repeater ID="rptAnnouncements" runat="server">
                <ItemTemplate>
                    <div class="ann-card">
                        <h4><%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %></h4>
                        <p><%# System.Web.HttpUtility.HtmlEncode(Eval("Content").ToString()) %></p>
                        <span class="ann-meta">
                            Course: <strong><%# System.Web.HttpUtility.HtmlEncode(Eval("CourseName").ToString()) %></strong> &nbsp;|&nbsp;
                            Lecturer: <strong><%# System.Web.HttpUtility.HtmlEncode(Eval("LecturerName").ToString()) %></strong> &nbsp;|&nbsp;
                            Posted: <%# Convert.ToDateTime(Eval("PostedDate")).ToString("dd/MM/yyyy HH:mm") %>
                        </span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Label ID="lblEmpty" runat="server" CssClass="empty" Visible="false"
                Text="No announcements available for your courses." />

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
