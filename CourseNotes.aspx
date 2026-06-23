<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseNotes.aspx.cs" Inherits="StudentManagementSystem.CourseNotes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Course Notes</title>

</head>

<body>

<form id="form1"
    runat="server"
    enctype="multipart/form-data">

    <h2>

        Course Notes :

        <asp:Label ID="lblCourseName"
            runat="server">
        </asp:Label>

    </h2>

    <!-- WEEK -->

    <asp:Label ID="Label1"
        runat="server"
        Text="Select Week">
    </asp:Label>

    <br />

    <asp:DropDownList ID="ddlWeek"
        runat="server"
        Width="250px">

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

    <br /><br />

    <!-- FILE -->

    <asp:FileUpload ID="FileUpload1"
        runat="server" />

    <br /><br />

    <asp:Button ID="btnUpload"
        runat="server"
        Text="Upload Notes"
        OnClick="btnUpload_Click" />

    <br /><br />

    <asp:Label ID="lblMessage"
        runat="server"
        ForeColor="Green">
    </asp:Label>

    <hr />

    <!-- NOTES -->

    <asp:GridView ID="gvNotes"
        runat="server"
        AutoGenerateColumns="False"
        Width="900px">

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

</form>

</body>

</html>