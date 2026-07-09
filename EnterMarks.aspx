<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EnterMarks.aspx.cs"
    Inherits="StudentManagementSystem.EnterMarks" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Enter Student Marks &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />

    <script>
        function calculateTotal(txt) {
            var row = txt.parentNode.parentNode;
            var assignment = parseFloat(row.cells[2].getElementsByTagName("input")[0].value) || 0;
            var quiz       = parseFloat(row.cells[3].getElementsByTagName("input")[0].value) || 0;
            var mid        = parseFloat(row.cells[4].getElementsByTagName("input")[0].value) || 0;
            var finalExam  = parseFloat(row.cells[5].getElementsByTagName("input")[0].value) || 0;
            var total = assignment + quiz + mid + finalExam;
            var lblTotal = row.cells[6].getElementsByTagName("span")[0];
            lblTotal.innerHTML = total;
        }
    </script>
</head>
<body>
<form id="form1" runat="server">

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
                    <li class="nav-item"><a class="nav-link active" href="EnterMarks.aspx">Enter Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="MarksReport.aspx">Marks Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Enter Student Marks</h1>

            <div class="sims-card p-4 mb-4" style="max-width:520px;">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Session</label>
                        <asp:DropDownList ID="ddlSession" runat="server" CssClass="sims-input"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold">Course</label>
                        <asp:DropDownList ID="ddlCourse" runat="server" CssClass="sims-input"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="table-responsive mb-3">
                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="EnrolmentID" HeaderText="Student ID" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                        <asp:TemplateField HeaderText="Assignment (20%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAssignment" runat="server"
                                    CssClass="sims-input-sm" onkeyup="calculateTotal(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quiz (10%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQuiz" runat="server"
                                    CssClass="sims-input-sm" onkeyup="calculateTotal(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mid Test (30%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtMidTest" runat="server"
                                    CssClass="sims-input-sm" onkeyup="calculateTotal(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Final Exam (40%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtFinalExam" runat="server"
                                    CssClass="sims-input-sm" onkeyup="calculateTotal(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total">
                            <ItemTemplate>
                                <span class="fw-bold">0</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Button ID="btnSave" runat="server" Text="Save Marks"
                CssClass="btn btn-sims px-4" OnClick="btnSave_Click" />
            <div class="mt-3">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>
