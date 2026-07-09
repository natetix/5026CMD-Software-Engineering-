<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterStudent.aspx.cs" Inherits="StudentManagementSystem.RegisterStudent" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Register Student &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

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
                    <li class="nav-item"><a class="nav-link active" href="RegisterStudent.aspx">Register Student</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageCourses.aspx">Manage Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="AdminReport.aspx">Reports</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Register New Student</h1>

            <div class="row g-4">
                <div class="col-lg-5">
                    <div class="sims-card p-4">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Student Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="sims-input" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="sims-input" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="sims-input" TextMode="Password" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Programme</label>
                            <asp:TextBox ID="txtProgramme" runat="server" CssClass="sims-input" />
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-sm-6">
                                <label class="form-label fw-semibold">Phone</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="sims-input" />
                            </div>
                            <div class="col-sm-6">
                                <label class="form-label fw-semibold">IC Number</label>
                                <asp:TextBox ID="txtIC" runat="server" CssClass="sims-input" />
                            </div>
                        </div>
                        <asp:Button ID="btnRegister" runat="server" Text="Register Student"
                            CssClass="btn btn-sims px-4" OnClick="btnRegister_Click" />
                        <div class="mt-3">
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-7">
                    <h2 class="h5 mb-3">Registered Students</h2>
                    <div class="table-responsive">
                        <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" CssClass="sims-table" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="StudentID" HeaderText="ID" />
                                <asp:BoundField DataField="StudentName" HeaderText="Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:BoundField DataField="Programme" HeaderText="Programme" />
                                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                                <asp:BoundField DataField="IC" HeaderText="IC" />
                                <asp:BoundField DataField="CreatedDate" HeaderText="Registered" DataFormatString="{0:dd/MM/yyyy}" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>
