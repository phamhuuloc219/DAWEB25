<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="KhachHang.aspx.cs" Inherits="WebAdmin.KhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
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
            justify-content: flex-start;
            align-items: center;
            padding: 15px 20px;
            background: #4a90e2; 
            color: #ffffff;
            border-radius: 12px 12px 0 0;
        }


        .card-title {
            font-size: 22px;
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
            margin-left: auto; 
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

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal.show {
            display: block;
        }

        .modal-dialog {
            max-width: 600px;
            margin: 10% auto;
        }

        .modal-content {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.3s ease-out;
        }

        .modal-header {
            background:#4a90e2;
            color: #ffffff;
            padding: 15px 20px;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .error-label {
            color: #e74c3c;
            font-style: italic;
            font-size: 14px;
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
    </style>
    <script>
        function showModal() {
            document.getElementById('modalAdd').classList.add('show');
        }

        function closeModal() {
            document.getElementById('modalAdd').classList.remove('show');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Quản lý khách hàng</h2>
                    <asp:Button ID="btnShowModal" runat="server" Text="Thêm mới" CssClass="btn-success"
                        OnClientClick="showModal(); return false;" />
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvKhachHang" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="MaKH"
                        OnRowDeleting="gvKhachHang_RowDeleting"
                        CssClass="table">
                        <Columns>
                            <asp:TemplateField HeaderText="Tên khách hàng">
                                <ItemTemplate>
                                    <%# Eval("TenKH") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Số điện thoại">
                                <ItemTemplate>
                                    <%# Eval("DienThoai") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <%# Eval("Email") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Địa chỉ">
                                <ItemTemplate>
                                    <%# Eval("DiaChi") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href='<%# Eval("MaKH", "ChiTietKhachHang.aspx?id={0}") %>' title="Sửa" class="text-primary mr-2">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                        CommandArgument='<%# Eval("MaKH") %>' CssClass="text-danger"
                                        OnClientClick="return confirm('Bạn có chắc muốn xoá khách hàng này?');"
                                        ToolTip="Xoá">
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

    <asp:Panel ID="pnlModalAdd" runat="server">
        <div class="modal" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel">Thêm khách hàng mới</h5>
                        <button type="button" class="close" onclick="closeModal()">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:TextBox ID="txtTenKH" runat="server" CssClass="form-control" Placeholder="Tên khách hàng" />
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" Placeholder="Số điện thoại" />
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" />
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" Placeholder="Địa chỉ" />
                        </div>
                        <div class="form-group">
                            <label class="error-label">* Mật khẩu mặc định là "123456789"</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnThemMoi" runat="server" Text="Lưu thông tin" CssClass="btn-primary" OnClick="btnThemMoi_Click" />
                        <button type="button" class="btn-secondary" onclick="closeModal()">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>