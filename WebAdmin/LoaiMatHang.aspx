<%@ Page Title="Quản lý loại mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="LoaiMatHang.aspx.cs" Inherits="WebAdmin.LoaiMatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary card-outline mt-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title text-primary">Quản lý loại mặt hàng</h3>
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
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="modalTitle">Tiêu đề</h5>
                        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
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
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="modalDeleteLabel">Xác nhận xoá</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
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
