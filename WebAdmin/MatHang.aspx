<%@ Page Title="Quản lý mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MatHang.aspx.cs" Inherits="WebAdmin.MatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        .content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .card .card-header {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: #4a90e2;
            color: #ffffff;
            border-radius: 12px 12px 0 0;
        }

        .card-title {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }

        .btn-success {
            background: #27ae60;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-left: auto; /* Đẩy nút Thêm mới sang phải */
        }

        .btn-success:hover {
            background: #219653;
            transform: translateY(-2px);
        }

        .card-body {
            padding: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            background: #ffffff;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333333;
        }

        .table tr:hover {
            background: #f1f5f9;
        }

        .text-primary {
            color: #4a90e2;
            text-decoration: none;
            margin-right: 10px;
        }

        .text-danger {
            color: #e74c3c;
            text-decoration: none;
        }

        .text-primary:hover,
        .text-danger:hover {
            opacity: 0.8;
        }

        .modal-header {
            background: #e74c3c;
            color: #ffffff;
            border-radius: 12px 12px 0 0;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
        }

        .close {
            background: none;
            border: none;
            color: #ffffff;
            font-size: 20px;
            cursor: pointer;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #e5e7eb;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-danger {
            background: #e74c3c;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-danger:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #6c757d;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Quản lý mặt hàng</h3>
                    <a href="ChiTietMatHang.aspx" class="btn btn-success">Thêm mới</a>
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvMatHang" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="MaMH" OnRowCommand="gvMatHang_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="TenMH" HeaderText="Tên mặt hàng" />
                            <asp:BoundField DataField="MoTaMH" HeaderText="Mô tả" />
                            <asp:BoundField DataField="GiaBan" HeaderText="Giá bán" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="TenLoai" HeaderText="Loại mặt hàng" />
                            <asp:TemplateField HeaderText="Ảnh">
                                <ItemTemplate>
                                    <img src='<%# Eval("AnhMH") %>' alt="Ảnh" style="max-width: 100px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href='<%# Eval("MaMH", "ChiTietMatHang.aspx?id={0}") %>' class="text-primary mr-3" title="Sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("MaMH") %>'
                                        CssClass="text-danger" ToolTip="Xoá">
                                        <i class="fas fa-trash-alt"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </section>

    <asp:HiddenField ID="hfMaXoa" runat="server" />

    <div class="modal fade" id="modalXoa" tabindex="-1" role="dialog" aria-labelledby="modalXoaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xoá</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá mặt hàng này không?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnXacNhanXoa" runat="server" CssClass="btn btn-danger" Text="Xoá" OnClick="btnXacNhanXoa_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Huỷ</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</asp:Content>