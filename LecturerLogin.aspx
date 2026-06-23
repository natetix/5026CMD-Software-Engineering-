﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerLogin.aspx.cs" Inherits="StudentManagementSystem.LecturerLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Lecturer Login</title>

    <style>

        body
        {
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .login-box
        {
            width: 350px;
            margin: auto;
            margin-top: 100px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px lightgray;
        }

        h2
        {
            color: darkblue;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="login-box">

        <h2>Lecturer Login</h2>

        <asp:Label ID="Label1"
            runat="server"
            Text="Email">
        </asp:Label>

        <br />

        <asp:TextBox ID="txtEmail"
            runat="server"
            Width="300px">
        </asp:TextBox>

        <br /><br />

        <asp:Label ID="Label2"
            runat="server"
            Text="Password">
        </asp:Label>

        <br />

        <asp:TextBox ID="txtPassword"
            runat="server"
            Width="300px"
            TextMode="Password">
        </asp:TextBox>

        <br /><br />

        <asp:Button ID="btnLogin"
            runat="server"
            Text="Login"
            Width="120px"
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