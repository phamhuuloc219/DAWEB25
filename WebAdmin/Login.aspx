<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebAdmin.Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHead" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #4a90e2, #9b59b6);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .login-container {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 420px;
            text-align: center;
            transform: translateY(0);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .form-title {
            font-size: 24px;
            font-weight: 600;
            color: #333333;
            margin-bottom: 20px;
        }

        .login-container input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #dcdcdc;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .login-container input:focus {
            outline: none;
            border-color: #4a90e2;
            box-shadow: 0 0 8px rgba(74, 144, 226, 0.3);
        }

        .login-container button {
            background: linear-gradient(to right, #4a90e2, #9b59b6);
            color: #ffffff;
            border: none;
            padding: 12px;
            border-radius: 6px;
            width: 100%;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .login-container button:hover {
            background: linear-gradient(to right, #357abd, #8e44ad);
            transform: translateY(-2px);
        }

        .error-label {
            color: #e74c3c;
            font-size: 14px;
            margin-bottom: 15px;
            display: block;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container {
            animation: fadeIn 0.6s ease-out forwards;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpHeaderSection" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <div class="login-container">
        <h2 class="form-title">Đăng Nhập Hệ Thống</h2>
        <asp:Label ID="lblError" CssClass="error-label" runat="server" />
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" Placeholder="Tên đăng nhập" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" Placeholder="Mật khẩu" />
        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="login-button" OnClick="btnLogin_Click" />
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cpVendorScript" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cpBottomScript" runat="server">
</asp:Content>