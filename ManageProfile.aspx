<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="StudentManagementSystem.ManageProfile" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Profile &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link" href="MarksReport.aspx">Marks Report</a></li>
                    <li class="nav-item"><a class="nav-link active" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Manage My Profile</h1>

            <div class="sims-card p-4" style="max-width:640px;">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Lecturer Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="sims-input" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="sims-input" ReadOnly="true" BackColor="#eeeeee" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">New Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="sims-input" TextMode="Password" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Department</label>
                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="sims-input" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="sims-input" />
                </div>

                <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                    CssClass="btn btn-sims" OnClick="btnSave_Click" />

                <div class="mt-3">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                </div>

            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
