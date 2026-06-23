﻿<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MarksReport.aspx.cs"
    Inherits="StudentManagementSystem.MarksReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Marks Report</title>

<style>

body{
    font-family:Arial;
    margin:20px;
}

h2{
    color:navy;
}

.grid{
    width:100%;
    border-collapse:collapse;
}

.grid th{
    background-color:navy;
    color:white;
    padding:10px;
}

.grid td{
    padding:8px;
    border:1px solid #ccc;
}

.btn{
    background:green;
    color:white;
    border:none;
    padding:10px 20px;
    margin-right:10px;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<h2>Student Marks Report</h2>

<table>

<tr>

<td>Session</td>

<td>
<asp:DropDownList ID="ddlSession"
runat="server"
AutoPostBack="true"
OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
</asp:DropDownList>
</td>

<td>Course</td>

<td>
<asp:DropDownList ID="ddlCourse"
runat="server"
AutoPostBack="true"
OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
</asp:DropDownList>
</td>

<td>
<asp:Button ID="btnExport"
runat="server"
Text="Download CSV"
CssClass="btn"
OnClick="btnExport_Click" />
</td>

</tr>

</table>

<br />

<asp:GridView ID="gvMarks"
runat="server"
AutoGenerateColumns="False"
CssClass="grid">

<Columns>

<asp:BoundField DataField="EnrolmentID"
HeaderText="Student ID" />

<asp:BoundField DataField="StudentName"
HeaderText="Student Name" />

<asp:BoundField DataField="CourseName"
HeaderText="Course" />

<asp:BoundField DataField="AssignmentMarks"
HeaderText="Assignment" />

<asp:BoundField DataField="QuizMarks"
HeaderText="Quiz" />

<asp:BoundField DataField="MidTestMarks"
HeaderText="Mid Test" />

<asp:BoundField DataField="FinalExamMarks"
HeaderText="Final Exam" />

<asp:BoundField DataField="TotalMarks"
HeaderText="Total" />

</Columns>

</asp:GridView>

</form>

</body>
</html>