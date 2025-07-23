<%@ Page Title="Quản lý loại mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="LoaiMatHang.aspx.cs" Inherits="WebAdmin.LoaiMatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Quản lý loại mặt hàng</h4>
                <asp:Button ID="btnShowModal" runat="server" Text="Thêm mới" CssClass="btn btn-light text-primary"
                    OnClientClick="openModal(); return false;" />
            </div>
            <div class="card-body">
                <asp:GridView ID="gvLoaiMatHang" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                    DataKeyNames="MaLoai"
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
                                <asp:LinkButton ID="btnEdit" runat="server" Text='<i class="fas fa-edit"></i>' CssClass="text-primary mr-3"
                                    CommandName="EditItem" CommandArgument='<%# Eval("MaLoai") %>' ToolTip="Sửa" />

                                <asp:LinkButton ID="btnDelete" runat="server" Text='<i class="fas fa-trash-alt"></i>' CssClass="text-danger"
                                    CommandName="ConfirmDelete" CommandArgument='<%# Eval("MaLoai") %>' ToolTip="Xóa" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="modalLoai" tabindex="-1" role="dialog" aria-labelledby="modalLoaiLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalLoaiLabel">Thông tin loại mặt hàng</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaLoai" runat="server" />
                    <div class="form-group">
                        <label>Tên loại mặt hàng</label>
                        <asp:TextBox ID="txtTenLoai" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Mô tả</label>
                        <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnLuu" runat="server" Text="Lưu" CssClass="btn btn-success" OnClick="btnLuu_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalXoa" tabindex="-1" role="dialog" aria-labelledby="modalXoaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="modalXoaLabel">Xác nhận xóa</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaXoa" runat="server" />
                    <p>Bạn có chắc chắn muốn xóa loại mặt hàng này không?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnXacNhanXoa" runat="server" Text="Xóa" CssClass="btn btn-danger" OnClick="btnXacNhanXoa_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script>
        window.openModal = function () {
            $('#<%= hfMaLoai.ClientID %>').val('');
            $('#<%= txtTenLoai.ClientID %>').val('');
            $('#<%= txtMoTa.ClientID %>').val('');
            $('#modalLoai').modal('show');
        };

        window.editModal = function (ma, ten, mota) {
            $('#<%= hfMaLoai.ClientID %>').val(ma);
            $('#<%= txtTenLoai.ClientID %>').val(ten);
            $('#<%= txtMoTa.ClientID %>').val(mota);
            $('#modalLoai').modal('show');
        };

        window.confirmDelete = function (id) {
            $('#<%= hfMaXoa.ClientID %>').val(id);
            $('#modalXoa').modal('show');
        };
    </script>
</asp:Content>
