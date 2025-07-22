<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebAdmin.Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #6dd5fa, #2980b9);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #fff;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            text-align: center;
            width: 400px;
        }

            .login-container input {
                width: 100%;
                margin: 10px 0;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .login-container button {
                background-color: #2980b9;
                color: white;
                border: none;
                padding: 12px;
                border-radius: 5px;
                width: 100%;
            }

            .login-container input[type="submit"]:hover {
                cursor: pointer;
                border-color: #2980b9;
                background-color: #f0faff;
            }


        .error-label {
            color: red;
            margin-bottom: 10px;
            display: block;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpHeaderSection" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <div class="login-container">
        <asp:Label ID="lblError" CssClass="error-label" runat="server" />
        <asp:TextBox ID="txtUsername" runat="server" Placeholder="Tên đăng nhập" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Mật khẩu" />
        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="login-button" OnClick="btnLogin_Click" />
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpVendorScript" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cpBottomScript" runat="server">
</asp:Content>
