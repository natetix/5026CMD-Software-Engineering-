<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="LecturerDashboard.aspx.cs"
    Inherits="StudentManagementSystem.LecturerDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Lecturer Dashboard &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="LecturerDashboard.aspx">
                <span class="sims-brand-badge">SIMS</span>Lecturer
            </a>
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
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout"
                    CssClass="btn btn-light btn-sm" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1>Lecturer Dashboard</h1>
            <p class="sims-subtitle">Welcome
                <strong><asp:Label ID="lblLecturerName" runat="server" /></strong></p>

            <!-- STAT TILES -->
            <div class="row g-3 mb-4">
                <div class="col-sm-6 col-lg-3">
                    <div class="sims-stat">
                        <div class="sims-stat-label">Assigned Courses</div>
                        <div class="sims-stat-value"><asp:Label ID="lblCourses" runat="server" /></div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="sims-stat accent-green">
                        <div class="sims-stat-label">Attendance Records</div>
                        <div class="sims-stat-value"><asp:Label ID="lblAttendance" runat="server" /></div>
                    </div>
                </div>
            </div>

            <!-- CHARTS -->
            <h2 class="h4 mb-3">Analytics</h2>
            <div class="row g-3">
                <div class="col-lg-6">
                    <div class="sims-card p-3 h-100">
                        <h3 class="h6 text-center mb-3">Grade Distribution (All My Courses)</h3>
                        <canvas id="gradeChart" style="max-height:220px;"></canvas>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="sims-card p-3 h-100">
                        <h3 class="h6 text-center mb-3">Attendance Rate by Course (%)</h3>
                        <canvas id="attCourseChart" style="max-height:220px;"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">

        function initGradeChart(a, b, c, d, f) {
            var ctx = document.getElementById('gradeChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['A (>=80)', 'B (70-79)', 'C (60-69)', 'D (50-59)', 'F (<50)'],
                    datasets: [{
                        label: 'Students',
                        data: [a, b, c, d, f],
                        backgroundColor: ['#28a745', '#17a2b8', '#ffc107', '#fd7e14', '#dc3545']
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    scales: { y: { beginAtZero: true } },
                    plugins: { legend: { display: false } }
                }
            });
        }

        function initAttCourseChart(labels, data) {
            var ctx = document.getElementById('attCourseChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Attendance Rate (%)',
                        data: data,
                        backgroundColor: '#003399'
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    scales: { y: { beginAtZero: true, max: 100 } },
                    plugins: { legend: { display: false } }
                }
            });
        }

    </script>

</form>
</body>
</html>
