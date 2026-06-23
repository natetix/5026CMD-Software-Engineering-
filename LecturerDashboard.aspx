<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="LecturerDashboard.aspx.cs"
    Inherits="StudentManagementSystem.LecturerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lecturer Dashboard</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <style>

        body {
            margin: 0;
            font-family: Arial;
            background-color: #f4f4f4;
        }

        .navbar {
            background-color: navy;
            padding: 18px;
            overflow: hidden;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: bold;
            margin-right: 20px;
        }

        .navbar a:hover {
            color: yellow;
        }

        .logout-btn {
            float: right;
            background-color: red;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
        }

        .container {
            padding: 40px;
        }

        h1 {
            color: navy;
        }

        .welcome {
            font-size: 20px;
            margin-bottom: 30px;
        }

        .card-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            width: 250px;
            height: 150px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #cccccc;
            text-align: center;
            padding-top: 25px;
        }

        .card-title {
            color: navy;
            font-size: 20px;
            font-weight: bold;
        }

        .card-value {
            margin-top: 25px;
            font-size: 40px;
            font-weight: bold;
        }

        .charts-section {
            margin-top: 40px;
        }

        .charts-section h2 {
            color: navy;
            border-bottom: 2px solid navy;
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
            min-width: 300px;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 0px 10px #cccccc;
        }

        .chart-box h3 {
            color: navy;
            margin-top: 0;
            font-size: 15px;
        }

    </style>

</head>
<body>

<form id="form1" runat="server">

    <div class="navbar">

        <a href="LecturerDashboard.aspx">Dashboard</a>
        <a href="ViewAssignedCourses.aspx">Assigned Courses</a>
        <a href="ManageAttendance.aspx">Attendance</a>
        <a href="AttendanceReport.aspx">Attendance Report</a>
        <a href="EnterMarks.aspx">Enter Marks</a>
        <a href="MarksReport.aspx">Marks Report</a>
        <a href="ManageProfile.aspx">My Profile</a>
        <a href="PoorPerformance.aspx">Poor Performance</a>
        <a href="Announcements.aspx">Announcements</a>

        <asp:Button ID="btnLogout"
            runat="server"
            Text="Logout"
            CssClass="logout-btn"
            OnClick="btnLogout_Click" />

    </div>

    <div class="container">

        <h1>Lecturer Dashboard</h1>

        <div class="welcome">
            Welcome :
            <strong>
                <asp:Label ID="lblLecturerName" runat="server"></asp:Label>
            </strong>
        </div>

        <div class="card-container">

            <div class="card">
                <div class="card-title">Assigned Courses</div>
                <div class="card-value">
                    <asp:Label ID="lblCourses" runat="server"></asp:Label>
                </div>
            </div>

            <div class="card">
                <div class="card-title">Attendance Records</div>
                <div class="card-value">
                    <asp:Label ID="lblAttendance" runat="server"></asp:Label>
                </div>
            </div>

        </div>

        <div class="charts-section">

            <h2>Analytics</h2>

            <div class="chart-row">

                <div class="chart-box">
                    <h3>Grade Distribution (All My Courses)</h3>
                    <canvas id="gradeChart" height="200"></canvas>
                </div>

                <div class="chart-box">
                    <h3>Attendance Rate by Course (%)</h3>
                    <canvas id="attCourseChart" height="200"></canvas>
                </div>

            </div>

        </div>

    </div>

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
                    scales: { y: { beginAtZero: true, max: 100 } },
                    plugins: { legend: { display: false } }
                }
            });
        }

    </script>

</form>

</body>
</html>
