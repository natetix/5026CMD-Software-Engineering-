<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseNotes.aspx.cs" Inherits="StudentManagementSystem.CourseNotes" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Course Notes &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1"
    runat="server"
    enctype="multipart/form-data">

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
                    <li class="nav-item"><a class="nav-link active" href="ViewAssignedCourses.aspx">Assigned Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="ManageAttendance.aspx">Attendance</a></li>
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

            <h1 class="mb-3">Course Notes: <asp:Label ID="lblCourseName" runat="server"></asp:Label></h1>

            <div class="sims-card p-4 mb-4" style="max-width:500px;">

                <div class="mb-3">
                    <label class="form-label fw-semibold"><asp:Label ID="Label1" runat="server" Text="Select Week"></asp:Label></label>
                    <asp:DropDownList ID="ddlWeek"
                        runat="server"
                        CssClass="sims-input">

                        <asp:ListItem>Week 1</asp:ListItem>
                        <asp:ListItem>Week 2</asp:ListItem>
                        <asp:ListItem>Week 3</asp:ListItem>
                        <asp:ListItem>Week 4</asp:ListItem>
                        <asp:ListItem>Week 5</asp:ListItem>
                        <asp:ListItem>Week 6</asp:ListItem>
                        <asp:ListItem>Week 7</asp:ListItem>
                        <asp:ListItem>Week 8</asp:ListItem>
                        <asp:ListItem>Week 9</asp:ListItem>
                        <asp:ListItem>Week 10</asp:ListItem>
                        <asp:ListItem>Week 11</asp:ListItem>
                        <asp:ListItem>Week 12</asp:ListItem>
                        <asp:ListItem>Week 13</asp:ListItem>
                        <asp:ListItem>Week 14</asp:ListItem>

                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <asp:FileUpload ID="FileUpload1"
                        runat="server" CssClass="form-control" />
                </div>

                <asp:Button ID="btnUpload"
                    runat="server"
                    Text="Upload Notes"
                    CssClass="btn btn-sims"
                    OnClick="btnUpload_Click" />

                <div class="mt-3">
                    <asp:Label ID="lblMessage"
                        runat="server"
                        ForeColor="Green">
                    </asp:Label>
                </div>

            </div>

            <h2 class="h4 mb-3">Uploaded Notes</h2>
            <div class="table-responsive">
                <asp:GridView ID="gvNotes"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="sims-table"
                    GridLines="None"
                    Width="100%">

                    <Columns>

                        <asp:BoundField DataField="WeekNo"
                            HeaderText="Week" />

                        <asp:BoundField DataField="FileName"
                            HeaderText="File Name" />

                        <asp:BoundField DataField="UploadDate"
                            HeaderText="Upload Date" />

                        <asp:HyperLinkField
                            HeaderText="Download"
                            Text="Download"
                            DataNavigateUrlFields="FilePath" />

                    </Columns>

                </asp:GridView>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
