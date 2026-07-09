<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewEnrollment.aspx.cs" Inherits="StudentManagementSystem.ViewEnrollment" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>View Enrollment &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminDashboard.aspx"><span class="sims-brand-badge">SIMS</span>Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="AdminDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="ViewEnrollment.aspx">View Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="AssignCourse.aspx">Assign Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="RegisterLecturer.aspx">Register Lecturer</a></li>
                    <li class="nav-item"><a class="nav-link" href="RegisterStudent.aspx">Register Student</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageCourses.aspx">Manage Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="AdminReport.aspx">Reports</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Student Enrollment List</h1>

            <div class="sims-card p-4 mb-4" style="max-width:420px;">
                <label class="form-label fw-semibold" for="<%= ddlSession.ClientID %>">
                    <asp:Label ID="Label1" runat="server" Text="Select Session"></asp:Label>
                </label>
                <asp:DropDownList ID="ddlSession"
                    runat="server"
                    CssClass="sims-input"
                    AutoPostBack="True"
                    OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvEnrollment"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="sims-table"
                    GridLines="None"
                    Width="100%"
                    DataKeyNames="EnrolmentID"
                    OnRowDataBound="gvEnrollment_RowDataBound">

                    <Columns>

                        <asp:BoundField DataField="EnrolmentID"
                            HeaderText="Enrollment ID" />

                        <asp:BoundField DataField="StudentName"
                            HeaderText="Student Name" />

                        <asp:BoundField DataField="StudentEmail"
                            HeaderText="Student Email" />

                        <asp:BoundField DataField="SessionName"
                            HeaderText="Session" />

                        <asp:BoundField DataField="Semester"
                            HeaderText="Semester" />

                        <asp:BoundField DataField="Status"
                            HeaderText="Status" />

                        <asp:TemplateField HeaderText="Approve">

                            <ItemTemplate>

                                <asp:Button ID="btnApprove"
                                    runat="server"
                                    Text="Approve"
                                    CssClass="btn btn-sims btn-sm"
                                    CommandArgument='<%# Eval("EnrolmentID") %>'
                                    OnClick="btnApprove_Click"
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                            </ItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Reject">

                            <ItemTemplate>

                                <asp:Button ID="btnReject"
                                    runat="server"
                                    Text="Reject"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandArgument='<%# Eval("EnrolmentID") %>'
                                    OnClick="btnReject_Click"
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />

                            </ItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Enrolled Courses">

                            <ItemTemplate>

                                <div class="table-responsive">
                                    <asp:GridView ID="gvCourses"
                                        runat="server"
                                        AutoGenerateColumns="False"
                                        CssClass="course-grid"
                                        GridLines="None"
                                        Width="100%">

                                        <Columns>

                                            <asp:BoundField DataField="CourseCode"
                                                HeaderText="Course Code" />

                                            <asp:BoundField DataField="CourseName"
                                                HeaderText="Course Name" />

                                            <asp:BoundField DataField="CreditHours"
                                                HeaderText="Credit Hours" />

                                        </Columns>

                                    </asp:GridView>
                                </div>

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
