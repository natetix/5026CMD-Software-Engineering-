﻿<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageAttendance.aspx.cs"
Inherits="StudentManagementSystem.ManageAttendance" %>

<!DOCTYPE html>

<html>
<head runat="server">
<title>Manage Attendance</title>

<style>

body{
    font-family:Arial;
    margin:20px;
}

h2{
    color:navy;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<h2>Manage Attendance</h2>

Session

<br />

<asp:DropDownList
ID="ddlSession"
runat="server"
AutoPostBack="True"
OnSelectedIndexChanged="ddlSession_SelectedIndexChanged"
Width="300">
</asp:DropDownList>

<br /><br />

Course

<br />

<asp:DropDownList
ID="ddlCourse"
runat="server"
AutoPostBack="True"
OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"
Width="400">
</asp:DropDownList>

<br /><br />

Attendance Date

<br />

<asp:TextBox
ID="txtDate"
runat="server"
TextMode="Date">
</asp:TextBox>

<br /><br />

<asp:GridView
ID="gvStudents"
runat="server"
AutoGenerateColumns="False">

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
            runat="server">

                <asp:ListItem>Present</asp:ListItem>
                <asp:ListItem>Absent</asp:ListItem>

            </asp:DropDownList>

        </ItemTemplate>

    </asp:TemplateField>

</Columns>

</asp:GridView>

<br />

<asp:Button
ID="btnSave"
runat="server"
Text="Save Attendance"
OnClick="btnSave_Click" />

<br /><br />

<asp:Label
ID="lblMessage"
runat="server"
ForeColor="Green">
</asp:Label>

</form>

</body>
</html>