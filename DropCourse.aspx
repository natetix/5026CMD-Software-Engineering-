<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DropCourse.aspx.cs" Inherits="StudentManagementSystem.DropCourse" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Drop Course &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link active" href="DropCourse.aspx">Drop Course</a></li>
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

            <h1 class="mb-3">Drop a Course</h1>
            <p class="sims-subtitle">Only <strong>Pending</strong> enrollments can be dropped.</p>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />

            <div class="table-responsive mt-3">
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None" Width="100%"
                    OnRowCommand="gvCourses_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="EnrolmentID" HeaderText="Enrolment ID" />
                        <asp:BoundField DataField="CourseCode" HeaderText="Code" />
                        <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                        <asp:BoundField DataField="SessionName" HeaderText="Session" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnDrop" runat="server" Text="Drop"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandName="DropCourse"
                                    CommandArgument='<%# Eval("DetailID") %>'
                                    OnClientClick="return confirm('Drop this course?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
