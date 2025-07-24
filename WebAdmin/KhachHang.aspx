<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="KhachHang.aspx.cs" Inherits="WebAdmin.KhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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