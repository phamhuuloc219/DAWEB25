<%@ Page Title="Chi tiết khách hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChiTietKhachHang.aspx.cs" Inherits="WebAdmin.ChiTietKhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        .content {
            max-width: 800px;
            margin: 0 auto;
        }

        .card .card-header {
            background:  #4a90e2;
            color: #ffffff;
            border-radius: 12px 12px 0 0;
        }

        .card-title {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }

        .form-label {
            font-weight: 600;
            color: #333333;
        }

        .form-control:focus {
            border-color: #4a90e2;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
        }

        .lbNoti {
            color: #e74c3c;
            font-size: 13px;
            font-style: italic;
        }

        .card-footer {
            background: #f8f9fa;
            border-top: 1px solid #e5e7eb;
        }

        .back-btn {
            display: flex;
            align-items: center;
            color: #6c757d;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .back-btn i {
            margin-right: 8px;
        }

        .back-btn:hover {
            color: #4a90e2;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Chi tiết khách hàng</h4>
            </div>
            <div class="card-body">
                <asp:HiddenField ID="hfMaKH" runat="server" />

                <div class="form-group">
                    <label class="form-label">Tên khách hàng</label>
                    <asp:TextBox ID="txtTenKH" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label class="form-label">Số điện thoại</label>
                    <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label class="form-label">Địa chỉ</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label class="form-label">Mật khẩu</label>
                    <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" />
                </div>
                <asp:Label ID="lbNoti" runat="server" CssClass="lbNoti"></asp:Label>
            </div>
            <div class="card-footer text-right">
                <asp:Button ID="btnLuu" runat="server" Text="Lưu" CssClass="btn btn-success" OnClick="btnLuu_Click" />
                <a href="KhachHang.aspx" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </div>
</asp:Content>
