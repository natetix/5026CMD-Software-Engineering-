<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentViewMarks.aspx.cs" Inherits="StudentManagementSystem.StudentViewMarks" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Academic Results &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link active" href="StudentViewMarks.aspx">My Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewAttendance.aspx">My Attendance</a></li>
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

            <h1 class="mb-3">My Academic Results</h1>
            <p class="sims-subtitle">Welcome, <strong><asp:Label ID="lblName" runat="server" /></strong></p>

            <div class="table-responsive">
                <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="CourseCode" HeaderText="Code" />
                        <asp:BoundField DataField="AssignmentMarks" HeaderText="Assignment (20%)" />
                        <asp:BoundField DataField="QuizMarks" HeaderText="Quiz (10%)" />
                        <asp:BoundField DataField="MidTestMarks" HeaderText="Mid Test (30%)" />
                        <asp:BoundField DataField="FinalExamMarks" HeaderText="Final Exam (40%)" />
                        <asp:BoundField DataField="TotalMarks" HeaderText="Total" />
                        <asp:BoundField DataField="Grade" HeaderText="Grade" />
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Label ID="lblNoData" runat="server" ForeColor="Gray"
                Text="No marks published yet." Visible="false" />

            <div class="sims-card p-3 mt-3 d-inline-block">
                <strong>Cumulative GPA: </strong>
                <asp:Label ID="lblGPA" runat="server" Font-Bold="True" ForeColor="DarkBlue" />
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
