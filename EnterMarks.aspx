﻿<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EnterMarks.aspx.cs"
    Inherits="StudentManagementSystem.EnterMarks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enter Student Marks</title>

    <style>

        body {
            font-family: Arial;
            margin: 20px;
        }

        h2 {
            color: navy;
        }

        table {
            margin-bottom: 20px;
        }

        td {
            padding: 8px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background-color: navy;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .grid td {
            padding: 8px;
            border: 1px solid #ccc;
        }

        .btn {
            background-color: green;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

    </style>

    <script>

        function calculateTotal(txt) {

            var row = txt.parentNode.parentNode;

            var assignment =
                parseFloat(row.cells[2].getElementsByTagName("input")[0].value) || 0;

            var quiz =
                parseFloat(row.cells[3].getElementsByTagName("input")[0].value) || 0;

            var mid =
                parseFloat(row.cells[4].getElementsByTagName("input")[0].value) || 0;

            var finalExam =
                parseFloat(row.cells[5].getElementsByTagName("input")[0].value) || 0;

            var total =
                assignment + quiz + mid + finalExam;

            var lblTotal =
                row.cells[6].getElementsByTagName("span")[0];

            lblTotal.innerHTML = total;
        }

    </script>

</head>

<body>

<form id="form1" runat="server">

    <h2>Enter Student Marks</h2>

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
        </tr>

        <tr>
            <td>Course</td>
            <td>
                <asp:DropDownList ID="ddlCourse"
                    runat="server"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>

    </table>

    <asp:GridView ID="gvStudents"
        runat="server"
        AutoGenerateColumns="False"
        CssClass="grid">

        <Columns>

            <asp:BoundField DataField="EnrolmentID"
                HeaderText="Student ID" />

            <asp:BoundField DataField="StudentName"
                HeaderText="Student Name" />

            <asp:TemplateField HeaderText="Assignment (20%)">
                <ItemTemplate>
                    <asp:TextBox ID="txtAssignment"
                        runat="server"
                        Width="70"
                        onkeyup="calculateTotal(this)">
                    </asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Quiz (10%)">
                <ItemTemplate>
                    <asp:TextBox ID="txtQuiz"
                        runat="server"
                        Width="70"
                        onkeyup="calculateTotal(this)">
                    </asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Mid Test (30%)">
                <ItemTemplate>
                    <asp:TextBox ID="txtMidTest"
                        runat="server"
                        Width="70"
                        onkeyup="calculateTotal(this)">
                    </asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Final Exam (40%)">
                <ItemTemplate>
                    <asp:TextBox ID="txtFinalExam"
                        runat="server"
                        Width="70"
                        onkeyup="calculateTotal(this)">
                    </asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Total">
                <ItemTemplate>
                    <span>0</span>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

    <br />

    <asp:Button ID="btnSave"
        runat="server"
        Text="Save Marks"
        CssClass="btn"
        OnClick="btnSave_Click" />

    <br /><br />

    <asp:Label ID="lblMessage"
        runat="server"
        ForeColor="Green"></asp:Label>

</form>

</body>
</html>