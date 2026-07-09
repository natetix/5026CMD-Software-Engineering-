<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageAttendance.aspx.cs"
Inherits="StudentManagementSystem.ManageAttendance" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Attendance &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link active" href="ManageAttendance.aspx">Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="AttendanceReport.aspx">Attendance Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="EnterMarks.aspx">Enter Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="MarksReport.aspx">Marks Report</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Manage Attendance</h1>

            <div class="sims-card p-4 mb-4" style="max-width:500px;">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Session</label>
                    <asp:DropDownList
                        ID="ddlSession"
                        runat="server"
                        CssClass="sims-input"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Course</label>
                    <asp:DropDownList
                        ID="ddlCourse"
                        runat="server"
                        CssClass="sims-input"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Attendance Date</label>
                    <asp:TextBox
                        ID="txtDate"
                        runat="server"
                        CssClass="sims-input"
                        TextMode="Date">
                    </asp:TextBox>
                </div>

            </div>

            <div class="table-responsive mb-3">
                <asp:GridView
                    ID="gvStudents"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="sims-table"
                    GridLines="None"
                    Width="100%">

                    <Columns>

                        <asp:BoundField
                        DataField="StudentName"
                        HeaderText="Student Name" />

                        <asp:BoundField
                        DataField="StudentEmail"
                        HeaderText="Email" />

                        <asp:TemplateField HeaderText="Attendance">

                            <ItemTemplate>

                                <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="sims-input sims-input-sm">

                                    <asp:ListItem>Present</asp:ListItem>
                                    <asp:ListItem>Absent</asp:ListItem>

                                </asp:DropDownList>

                            </ItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>
            </div>

            <asp:Button
            ID="btnSave"
            runat="server"
            Text="Save Attendance"
            CssClass="btn btn-sims"
            OnClick="btnSave_Click" />

            <div class="mt-3">
                <asp:Label
                ID="lblMessage"
                runat="server"
                ForeColor="Green">
                </asp:Label>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
