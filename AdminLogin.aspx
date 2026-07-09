<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="StudentManagementSystem.AdminLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login &middot; SIMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/sims-theme.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
    <div class="sims-login-bg">
        <div class="sims-login-card">

            <div class="sims-login-logo">SIMS</div>
            <h1>Head of Programme</h1>
            <p class="sims-login-sub">Student Information Management System</p>

            <div class="mb-3">
                <label class="form-label" for="<%= txtEmail.ClientID %>">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="sims-input"
                    placeholder="admin@gmail.com" />
            </div>

            <div class="mb-3">
                <label class="form-label" for="<%= txtPassword.ClientID %>">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="sims-input"
                    TextMode="Password" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign in"
                CssClass="btn btn-sims w-100 py-2 mt-2" OnClick="btnLogin_Click" />

            <div class="text-center mt-3">
                <asp:Label ID="lblMessage" runat="server" CssClass="sims-msg-err" />
            </div>

        </div>
    </div>
</form>
</body>
</html>
