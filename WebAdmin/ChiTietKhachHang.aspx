<%@ Page Title="Chi tiết khách hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChiTietKhachHang.aspx.cs" Inherits="WebAdmin.ChiTietKhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: 600;
        }
        .lbNoti{
            color: red !important;
            font-size: 13px !important;
            font-style: italic !important;
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
