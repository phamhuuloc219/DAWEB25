<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebAdmin.Login1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpHeaderSection" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <asp:Label ID="lblError" runat="server" ForeColor="Red" />
    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username" />
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password" />
    <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" OnClick="btnLogin_Click" />

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpVendorScript" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cpBottomScript" runat="server">
</asp:Content>
