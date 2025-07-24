<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ThongTinCaNhan.aspx.cs" Inherits="Web.ThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin cá nhân
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h3 class="mb-4 text-center">Thông tin cá nhân</h3>
            <asp:Label ID="lblMessage" runat="server" CssClass="d-block text-center my-3" />

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
            </div>
            <div class="form-group">
                <label>Họ tên</label>
                <asp:TextBox ID="txtTenKH" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label>Địa chỉ</label>
                <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
            </div>
            <div class="form-group">
                <label>Mật khẩu (để trống nếu không đổi)</label>
                <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" />
            </div>
            <asp:Button ID="btnLuu" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" OnClick="btnLuu_Click" />

        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
