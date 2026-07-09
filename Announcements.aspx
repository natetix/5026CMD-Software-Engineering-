<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="StudentManagementSystem.Announcements" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Announcements &middot; SIMS</title>
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
                    <li class="nav-item"><a class="nav-link" href="ManageProfile.aspx">My Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="PoorPerformance.aspx">Poor Performance</a></li>
                    <li class="nav-item"><a class="nav-link active" href="Announcements.aspx">Announcements</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">Post Announcement</h1>

            <div class="sims-card p-4 mb-4" style="max-width:640px;">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="sims-input">
                        <asp:ListItem Value="0" Text="-- Select Course --" />
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="sims-input" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Content</label>
                    <asp:TextBox ID="txtContent" runat="server" CssClass="sims-input" Height="100px" TextMode="MultiLine" />
                </div>

                <asp:Button ID="btnPost" runat="server" Text="Post Announcement"
                    CssClass="btn btn-sims" OnClick="btnPost_Click" />

                <div class="mt-3">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                </div>

            </div>

            <h2 class="h4 mb-3">My Announcements</h2>
            <div class="table-responsive">
                <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False"
                    CssClass="sims-table" GridLines="None" Width="100%" OnRowCommand="gvAnnouncements_RowCommand"
                    EmptyDataText="No announcements posted yet.">
                    <Columns>
                        <asp:BoundField DataField="CourseName"  HeaderText="Course" />
                        <asp:BoundField DataField="Title"       HeaderText="Title" />
                        <asp:BoundField DataField="Content"     HeaderText="Content" />
                        <asp:BoundField DataField="PostedDate"  HeaderText="Posted" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CssClass="btn btn-danger btn-sm" CommandName="DeleteAnn"
                                    CommandArgument='<%# Eval("AnnouncementID") %>'
                                    OnClientClick="return confirm('Delete this announcement?');" />
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
