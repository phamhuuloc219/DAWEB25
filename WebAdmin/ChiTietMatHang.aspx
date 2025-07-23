<%@ Page Title="Chi tiết mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChiTietMatHang.aspx.cs" Inherits="WebAdmin.ChiTietMatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <style>
        .img-upload {
            cursor: pointer;
            border: 2px dashed #007bff;
            border-radius: 5px;
            width: 200px;
            height: 200px;
            object-fit: cover;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <section class="content">
        <div class="container mt-4">
            <div class="card card-outline card-primary">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title">Thông tin mặt hàng</h5>
                </div>
                <div class="card-body">
                    <asp:HiddenField ID="hfMaMH" runat="server" />
                    <asp:HiddenField ID="hfAnhCu" runat="server" />

                    <div class="form-group">
                        <label>Ảnh mặt hàng</label><br />
                        <asp:Image ID="imgPreview" runat="server" CssClass="img-upload" />
                        <asp:FileUpload ID="fuAnh" runat="server" CssClass="d-none" />
                    </div>

                    <div class="form-group">
                        <label>Tên mặt hàng</label>
                        <asp:TextBox ID="txtTenMH" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Mô tả</label>
                        <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Giá bán</label>
                        <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Loại mặt hàng</label>
                        <asp:DropDownList ID="ddlLoaiMatHang" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="card-footer text-right">
                    <asp:Button ID="btnLuu" runat="server" Text="Lưu thông tin" CssClass="btn btn-primary" OnClick="btnLuu_Click" />
                    <a href="MatHang.aspx" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const img = document.getElementById("<%= imgPreview.ClientID %>");
            const input = document.getElementById("<%= fuAnh.ClientID %>");

            if (img && input) {
                img.addEventListener("click", function () {
                    input.click();
                });

                input.addEventListener("change", function (e) {
                    if (input.files && input.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            img.src = e.target.result;
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                });
            }
        });
    </script>
</asp:Content>
