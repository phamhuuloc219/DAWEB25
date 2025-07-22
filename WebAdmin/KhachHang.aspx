<%@ Page Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="KhachHang.aspx.cs" Inherits="WebAdmin.KhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function showModal() {
            $('#modalAdd').modal('show');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary card-outline mt-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title text-primary">📋 Quản lý khách hàng</h3>
                    <asp:Button ID="btnShowModal" runat="server" Text="➕ Thêm khách hàng mới" CssClass="btn btn-success"
                        OnClientClick="showModal(); return false;" />
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvKhachHang" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="MaKH"
                        OnRowEditing="gvKhachHang_RowEditing"
                        OnRowUpdating="gvKhachHang_RowUpdating"
                        OnRowCancelingEdit="gvKhachHang_RowCancelingEdit"
                        OnRowDeleting="gvKhachHang_RowDeleting"
                        CssClass="table table-bordered table-hover">
                        <Columns>
                            <asp:TemplateField HeaderText="Tên khách hàng">
                                <ItemTemplate>
                                    <%# Eval("TenKH") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditTenKH" runat="server" Text='<%# Bind("TenKH") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SĐT">
                                <ItemTemplate>
                                    <%# Eval("DienThoai") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditSDT" runat="server" Text='<%# Bind("DienThoai") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <%# Eval("Email") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Địa chỉ">
                                <ItemTemplate>
                                    <%# Eval("DiaChi") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditDiaChi" runat="server" Text='<%# Bind("DiaChi") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>

                </div>
            </div>
        </div>
    </section>

    <asp:Panel ID="pnlModalAdd" runat="server">
        <div class="modal fade" id="modalAdd" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalLabel">➕ Thêm khách hàng mới</h5>
                        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
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
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnThemMoi" runat="server" Text="Lưu thông tin" CssClass="btn btn-primary" OnClick="btnThemMoi_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
