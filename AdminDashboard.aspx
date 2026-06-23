<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="StudentManagementSystem.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Admin Dashboard</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <style>

        body {
            font-family: Arial;
            margin: 0;
            background-color: #f5f5f5;
        }

        .menu {
            background-color: darkblue;
            padding: 15px;
        }

        .menu a {
            color: white;
            text-decoration: none;
            margin-right: 25px;
            font-weight: bold;
            font-size: 16px;
        }

        .dashboard {
            padding: 30px;
        }

        .card {
            width: 180px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            margin-right: 15px;
            margin-bottom: 20px;
            box-shadow: 0px 0px 10px lightgray;
            text-align: center;
        }

        .card h3 {
            color: darkblue;
            font-size: 13px;
            margin-top: 0;
        }

        .title {
            color: darkblue;
        }

        .charts-section {
            margin-top: 30px;
        }

        .charts-section h2 {
            color: darkblue;
            border-bottom: 2px solid darkblue;
            padding-bottom: 8px;
        }

        .chart-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .chart-box {
            flex: 1;
            min-width: 260px;
            max-width: 33%;
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0px 0px 10px lightgray;
        }

        .chart-box h3 {
            color: darkblue;
            margin-top: 0;
            font-size: 14px;
        }

        .chart-box canvas {
            max-height: 220px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- MENU -->

    <div class="menu">

        <a href="AdminDashboard.aspx">Dashboard</a>
        <a href="ViewEnrollment.aspx">View Enrollment</a>
        <a href="AssignCourse.aspx">Assign Course</a>
        <a href="RegisterLecturer.aspx">Register Lecturer</a>
        <a href="RegisterStudent.aspx">Register Student</a>
        <a href="ManageCourses.aspx">Manage Courses</a>
        <a href="AdminReport.aspx">Reports</a>

        <asp:Button ID="btnLogout"
            runat="server"
            Text="Logout"
            OnClick="btnLogout_Click" />

    </div>

    <!-- DASHBOARD CONTENT -->

    <div class="dashboard">

        <h1 class="title">Admin Dashboard</h1>
        <h3>Welcome Admin</h3>

        <!-- STAT CARDS -->

        <div class="card">
            <h3>Total Enrollments</h3>
            <asp:Label ID="lblTotalEnrollment" runat="server" Font-Size="25px" Font-Bold="True"></asp:Label>
        </div>

        <div class="card">
            <h3>Approved</h3>
            <asp:Label ID="lblApproved" runat="server" Font-Size="25px" Font-Bold="True" ForeColor="Green"></asp:Label>
        </div>

        <div class="card">
            <h3>Pending</h3>
            <asp:Label ID="lblPending" runat="server" Font-Size="25px" Font-Bold="True" ForeColor="Orange"></asp:Label>
        </div>

        <div class="card">
            <h3>Rejected</h3>
            <asp:Label ID="lblRejected" runat="server" Font-Size="25px" Font-Bold="True" ForeColor="Red"></asp:Label>
        </div>

        <div class="card">
            <h3>Course Assignments</h3>
            <asp:Label ID="lblAssignment" runat="server" Font-Size="25px" Font-Bold="True"></asp:Label>
        </div>

        <!-- CHARTS SECTION -->

        <div class="charts-section">

            <h2>Analytics</h2>

            <div class="chart-row">

                <div class="chart-box">
                    <h3>Enrollment Status Distribution</h3>
                    <canvas id="enrollmentChart"></canvas>
                </div>

                <div class="chart-box">
                    <h3>Average Marks by Course</h3>
                    <canvas id="marksChart"></canvas>
                </div>

                <div class="chart-box">
                    <h3>Attendance Rate by Course (%)</h3>
                    <canvas id="attendanceChart"></canvas>
                </div>

            </div>

        </div>

    </div>

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
