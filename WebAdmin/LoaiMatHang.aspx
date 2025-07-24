<%@ Page Title="Quản lý loại mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="LoaiMatHang.aspx.cs" Inherits="WebAdmin.LoaiMatHang" %>

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
            margin-left: auto; /* Đẩy button sang bên phải */
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
            background: #4a90e2;
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

        .form-group {
            margin-bottom: 15px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #dcdcdc;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #4a90e2;
            box-shadow: 0 0 8px rgba(74, 144, 226, 0.3);
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #e5e7eb;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-primary {
            background: #4a90e2;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-primary:hover {
            background: #357abd;
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
                    <h3 class="card-title">Quản lý loại mặt hàng</h3>
                    <asp:Button ID="btnShowModal" runat="server" Text="Thêm mới" CssClass="btn btn-success"
                        OnClientClick="showModal(); return false;" />
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvLoaiMatHang" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="MaLoai"
                        CssClass="table table-bordered table-hover"
                        OnRowCommand="gvLoaiMatHang_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="TenLoai" HeaderText="Tên loại mặt hàng" />
                            <asp:BoundField DataField="MoTa" HeaderText="Mô tả" />
                            <asp:TemplateField HeaderText="Số lượng sản phẩm">
                                <ItemTemplate>
                                    <%# Eval("SoLuongSanPham") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href="javascript:void(0);" onclick='<%# Eval("MaLoai", "editModal(\"{0}\", \"" + Eval("TenLoai") + "\", `" + Eval("MoTa") + "`)") %>'
                                        class="text-primary mr-3" title="Sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="javascript:void(0);" onclick='<%# Eval("MaLoai", "confirmDelete(\"{0}\")") %>' title="Xoá" class="text-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </section>

    <asp:Panel ID="pnlModalAdd" runat="server">
        <div class="modal fade" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Tiêu đề</h5>
                        <button type="button" class="close" data-dismiss="modal">×</button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfMaLoai" runat="server" />
                        <div class="form-group">
                            <asp:TextBox ID="txtTenLoai" runat="server" CssClass="form-control" Placeholder="Tên loại mặt hàng" />
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Mô tả" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnLuu" runat="server" Text="Lưu thông tin" CssClass="btn btn-primary" OnClick="btnLuu_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:HiddenField ID="hfMaLoaiXoa" runat="server" />
    <div class="modal fade" id="modalConfirmDelete" tabindex="-1" role="dialog" aria-labelledby="modalDeleteLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: #e74c3c; color: #ffffff;">
                    <h5 class="modal-title" id="modalDeleteLabel">Xác nhận xoá</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xoá loại mặt hàng này không?
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnXacNhanXoa" runat="server" Text="Xoá" CssClass="btn btn-danger" OnClick="btnXacNhanXoa_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Script xử lý modal -->
    <script>
        function showModal() {
            $('#<%= hfMaLoai.ClientID %>').val('');
            $('#<%= txtTenLoai.ClientID %>').val('');
            $('#<%= txtMoTa.ClientID %>').val('');
            $('#modalTitle').text('Thêm mới loại mặt hàng');
            $('#modalAdd').modal('show');
        }

        function editModal(id, ten, mota) {
            $('#<%= hfMaLoai.ClientID %>').val(id);
            $('#<%= txtTenLoai.ClientID %>').val(ten);
            $('#<%= txtMoTa.ClientID %>').val(mota);
            $('#modalTitle').text('Cập nhật loại mặt hàng');
            $('#modalAdd').modal('show');
        }

        function confirmDelete(id) {
            $('#<%= hfMaLoaiXoa.ClientID %>').val(id);
            $('#modalConfirmDelete').modal('show');
        }
    </script>
</asp:Content>