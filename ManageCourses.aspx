<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="StudentManagementSystem.ManageCourses" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Courses &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link" href="RegisterStudent.aspx">Register Student</a></li>
                    <li class="nav-item"><a class="nav-link active" href="ManageCourses.aspx">Manage Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="AdminReport.aspx">Reports</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Manage Courses</h1>

            <div class="sims-card p-4 mb-4" style="max-width:740px;">
                <asp:HiddenField ID="hfCourseID" runat="server" Value="0" />
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Course Code</label>
                        <asp:TextBox ID="txtCode" runat="server" CssClass="sims-input" />
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Course Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="sims-input" />
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Session</label>
                        <asp:TextBox ID="txtSession" runat="server" CssClass="sims-input" />
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Semester</label>
                        <asp:DropDownList ID="ddlSemester" runat="server" CssClass="sims-input">
                            <asp:ListItem Text="-- Select --" Value="" />
                            <asp:ListItem Text="Semester 1" Value="Semester 1" />
                            <asp:ListItem Text="Semester 2" Value="Semester 2" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Credits</label>
                        <asp:TextBox ID="txtCreditHours" runat="server" CssClass="sims-input" />
                    </div>
                </div>
                <div class="mt-3">
                    <asp:Button ID="btnSave" runat="server" Text="Add Course"
                        CssClass="btn btn-sims px-4 me-2" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear"
                        CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
                </div>
                <div class="mt-3">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                </div>
            </div>

            <h2 class="h5 mb-3">All Courses</h2>
            <div class="table-responsive">
                <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None" OnRowCommand="gvCourses_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="CourseID"    HeaderText="ID" />
                        <asp:BoundField DataField="CourseCode"  HeaderText="Code" />
                        <asp:BoundField DataField="CourseName"  HeaderText="Course Name" />
                        <asp:BoundField DataField="SessionName" HeaderText="Session" />
                        <asp:BoundField DataField="Semester"    HeaderText="Semester" />
                        <asp:BoundField DataField="CreditHours" HeaderText="Credits" />
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                    CssClass="btn btn-sm btn-sims" CommandName="EditCourse"
                                    CommandArgument='<%# Eval("CourseID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CssClass="btn btn-sm btn-danger" CommandName="DeleteCourse"
                                    CommandArgument='<%# Eval("CourseID") %>'
                                    OnClientClick="return confirm('Delete this course?');" />
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