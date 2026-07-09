<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MarksReport.aspx.cs"
    Inherits="StudentManagementSystem.MarksReport" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Marks Report &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link active" href="MarksReport.aspx">Marks Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Student Marks Report</h1>

            <div class="sims-card p-4 mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-sm-4">
                        <label class="form-label fw-semibold">Session</label>
                        <asp:DropDownList ID="ddlSession"
                        runat="server"
                        CssClass="sims-input"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-4">
                        <label class="form-label fw-semibold">Course</label>
                        <asp:DropDownList ID="ddlCourse"
                        runat="server"
                        CssClass="sims-input"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-4">
                        <asp:Button ID="btnExport"
                        runat="server"
                        Text="Download CSV"
                        CssClass="btn btn-sims"
                        OnClick="btnExport_Click" />
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvMarks"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="sims-table"
                GridLines="None"
                Width="100%">

                <Columns>

                <asp:BoundField DataField="EnrolmentID"
                HeaderText="Student ID" />

                <asp:BoundField DataField="StudentName"
                HeaderText="Student Name" />

                <asp:BoundField DataField="CourseName"
                HeaderText="Course" />

                <asp:BoundField DataField="AssignmentMarks"
                HeaderText="Assignment" />

                <asp:BoundField DataField="QuizMarks"
                HeaderText="Quiz" />

                <asp:BoundField DataField="MidTestMarks"
                HeaderText="Mid Test" />

                <asp:BoundField DataField="FinalExamMarks"
                HeaderText="Final Exam" />

                <asp:BoundField DataField="TotalMarks"
                HeaderText="Total" />

                </Columns>

                </asp:GridView>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
