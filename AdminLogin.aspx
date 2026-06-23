<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="StudentManagementSystem.AdminLogin" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Admin Login</title>

    <style>

        body
        {
            font-family: Arial;
        }

        .login-box
        {
            width: 350px;
            margin: auto;
            margin-top: 100px;
            border: 1px solid gray;
            padding: 30px;
            border-radius: 10px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="login-box">

        <h2>Admin Login</h2>

        <asp:Label ID="Label1"
            runat="server"
            Text="Email">
        </asp:Label>

        <br />

        <asp:TextBox ID="txtEmail"
            runat="server"
            Width="300">
        </asp:TextBox>

        <br /><br />

        <asp:Label ID="Label2"
            runat="server"
            Text="Password">
        </asp:Label>

        <br />

        <asp:TextBox ID="txtPassword"
            runat="server"
            TextMode="Password"
            Width="300">
        </asp:TextBox>

        <br /><br />

        <asp:Button ID="btnLogin"
            runat="server"
            Text="Login"
            Width="120"
            OnClick="btnLogin_Click" />

        <br /><br />

        <asp:Label ID="lblMessage"
            runat="server"
            ForeColor="Red">
        </asp:Label>

    </div>

</form>

</body>
</html>