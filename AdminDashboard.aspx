<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="StudentManagementSystem.AdminDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminDashboard.aspx">
                <span class="sims-brand-badge">SIMS</span>Admin
            </a>
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
                    <li class="nav-item"><a class="nav-link" href="AdminReport.aspx">Reports</a></li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout"
                    CssClass="btn btn-light btn-sm" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1>Admin Dashboard</h1>
            <p class="sims-subtitle">Welcome <asp:Label ID="lblWelcome" runat="server" /></p>

            <!-- STAT TILES -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-md-4 col-xl">
                    <div class="sims-stat">
                        <div class="sims-stat-label">Total Enrollments</div>
                        <div class="sims-stat-value"><asp:Label ID="lblTotalEnrollment" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl">
                    <div class="sims-stat accent-green">
                        <div class="sims-stat-label">Approved</div>
                        <div class="sims-stat-value"><asp:Label ID="lblApproved" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl">
                    <div class="sims-stat accent-amber">
                        <div class="sims-stat-label">Pending</div>
                        <div class="sims-stat-value"><asp:Label ID="lblPending" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl">
                    <div class="sims-stat accent-red">
                        <div class="sims-stat-label">Rejected</div>
                        <div class="sims-stat-value"><asp:Label ID="lblRejected" runat="server" /></div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl">
                    <div class="sims-stat">
                        <div class="sims-stat-label">Course Assignments</div>
                        <div class="sims-stat-value"><asp:Label ID="lblAssignment" runat="server" /></div>
                    </div>
                </div>
            </div>

            <!-- CHARTS -->
            <h2 class="h4 mb-3">Analytics</h2>
            <div class="row g-3">
                <div class="col-lg-4">
                    <div class="sims-card p-3 h-100">
                        <h3 class="h6 text-center mb-3">Enrollment Status Distribution</h3>
                        <canvas id="enrollmentChart" style="max-height:220px;"></canvas>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="sims-card p-3 h-100">
                        <h3 class="h6 text-center mb-3">Average Marks by Course</h3>
                        <canvas id="marksChart" style="max-height:220px;"></canvas>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="sims-card p-3 h-100">
                        <h3 class="h6 text-center mb-3">Attendance Rate by Course (%)</h3>
                        <canvas id="attendanceChart" style="max-height:220px;"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">

        function initEnrollmentChart(approved, pending, rejected) {
            var ctx = document.getElementById('enrollmentChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Approved', 'Pending', 'Rejected'],
                    datasets: [{
                        data: [approved, pending, rejected],
                        backgroundColor: ['#28a745', '#ffc107', '#dc3545']
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'bottom' } }
                }
            });
        }

        function initMarksChart(labels, data) {
            var ctx = document.getElementById('marksChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Avg Total Marks',
                        data: data,
                        backgroundColor: '#1a237e'
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    scales: { y: { beginAtZero: true, suggestedMax: 400 } },
                    plugins: { legend: { display: false } }
                }
            });
        }

        function initAttendanceChart(labels, data) {
            var ctx = document.getElementById('attendanceChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Attendance Rate (%)',
                        data: data,
                        backgroundColor: '#00796b'
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
