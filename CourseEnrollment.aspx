<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseEnrollment.aspx.cs" Inherits="StudentManagementSystem.CourseEnrollment" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Course Enrollment &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="StudentDashboard.aspx">
                <span class="sims-brand-badge">SIMS</span>Student
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="StudentDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="CourseEnrollment.aspx">Course Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewEnrolledCourses.aspx">Enrolled Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewMarks.aspx">My Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewAttendance.aspx">My Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="DropCourse.aspx">Drop Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Course Enrollment</h1>

            <div class="sims-card p-4 mb-4" style="max-width:640px;">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Select Session</label>
                        <asp:DropDownList ID="ddlSession" runat="server" CssClass="sims-input"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Select Semester</label>
                        <asp:DropDownList ID="ddlSemester" runat="server" CssClass="sims-input"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged">
                            <asp:ListItem>Semester 1</asp:ListItem>
                            <asp:ListItem>Semester 2</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <h2 class="h5 mb-3">Available Courses</h2>
            <div class="table-responsive mb-3">
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CourseID"    HeaderText="Course ID" />
                        <asp:BoundField DataField="CourseCode"  HeaderText="Course Code" />
                        <asp:BoundField DataField="CourseName"  HeaderText="Course Name" />
                        <asp:BoundField DataField="CreditHours" HeaderText="Credit Hours" />
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit Enrollment"
                CssClass="btn btn-sims px-4" OnClick="btnSubmit_Click" />
            <div class="mt-3">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
            </div>

            <hr class="my-4" />

            <h2 class="h5 mb-3">Submitted Enrollment Details</h2>
            <div class="table-responsive">
                <asp:GridView ID="gvEnrollment" runat="server" AutoGenerateColumns="True"
                    CssClass="sims-table" GridLines="None" Width="100%">
                </asp:GridView>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>
