<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentNotifications.aspx.cs" Inherits="StudentManagementSystem.StudentNotifications" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Notifications &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
    <style>

        .notif-item {
            background: white;
            border-left: 5px solid darkblue;
            border-radius: 5px;
            padding: 15px 20px;
            margin-bottom: 12px;
            box-shadow: 0 1px 4px lightgray;
        }

        .notif-unread {
            border-left-color: #e53935;
            background: #fff8f8;
        }

        .notif-read {
            border-left-color: #aaa;
            color: #555;
        }

        .notif-msg {
            font-size: 15px;
            margin: 0 0 5px 0;
        }

        .notif-meta {
            font-size: 12px;
            color: #888;
        }

        .notif-category {
            display: inline-block;
            font-size: 11px;
            background: darkblue;
            color: white;
            border-radius: 8px;
            padding: 2px 8px;
            margin-right: 8px;
        }

        .empty-msg {
            color: #888;
            font-style: italic;
            font-size: 15px;
        }

    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark sims-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="StudentDashboard.aspx"><span class="sims-brand-badge">SIMS</span>Student</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="StudentDashboard.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseEnrollment.aspx">Course Enrollment</a></li>
                    <li class="nav-item"><a class="nav-link" href="ViewEnrolledCourses.aspx">Enrolled Courses</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewMarks.aspx">My Marks</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentViewAttendance.aspx">My Attendance</a></li>
                    <li class="nav-item"><a class="nav-link" href="DropCourse.aspx">Drop Course</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentAnnouncements.aspx">Announcements</a></li>
                    <li class="nav-item"><a class="nav-link active" href="StudentNotifications.aspx">Notifications</a></li>
                    <li class="nav-item"><a class="nav-link" href="StudentProfile.aspx">My Profile</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENT -->
    <div class="sims-page">
        <div class="container-fluid px-4">

            <h1 class="mb-3">My Notifications</h1>

            <asp:Button ID="btnMarkAllRead"
                runat="server"
                Text="Mark All as Read"
                CssClass="btn btn-sims mb-3"
                OnClick="btnMarkAllRead_Click" />

            <div class="mb-3">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
            </div>

            <asp:Repeater ID="rptNotifications" runat="server">
                <ItemTemplate>
                    <div class='notif-item <%# (bool)Eval("IsRead") ? "notif-read" : "notif-unread" %>'>
                        <p class="notif-msg"><%# System.Web.HttpUtility.HtmlEncode(Eval("Message").ToString()) %></p>
                        <div class="notif-meta">
                            <span class="notif-category"><%# System.Web.HttpUtility.HtmlEncode(Eval("Category") != DBNull.Value ? Eval("Category").ToString() : "General") %></span>
                            <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy, hh:mm tt") %>
                            &nbsp;&mdash;&nbsp;
                            <%# (bool)Eval("IsRead") ? "Read" : "<strong style='color:#e53935'>Unread</strong>" %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Label ID="lblEmpty" runat="server" CssClass="empty-msg" Visible="false"
                Text="You have no notifications."></asp:Label>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</form>
</body>
</html>
