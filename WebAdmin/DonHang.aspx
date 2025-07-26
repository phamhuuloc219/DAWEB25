<%@ Page Title="Quản lý đơn hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DonHang.aspx.cs" Inherits="WebAdmin.DonHang" %>

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
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Quản lý đơn hàng</h3>
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="MaDH"
                        CssClass="table table-bordered table-hover"
                        OnRowCommand="gvDonHang_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="MaDH" HeaderText="Mã đơn hàng" />
                            <asp:BoundField DataField="NgayBan" HeaderText="Ngày bán" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="TenKH" HeaderText="Khách hàng" />
                            <asp:TemplateField HeaderText="Số mặt hàng">
                                <ItemTemplate>
                                    <%# Eval("SoLuongMatHang") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tổng tiền">
                                <ItemTemplate>
                                    <%# Eval("TongTien", "{0:N0} đ") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href="javascript:void(0);" onclick='<%# Eval("MaDH", "viewDetails(\"{0}\")") %>' class="text-primary mr-3" title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="javascript:void(0);" onclick='<%# Eval("MaDH", "confirmDelete(\"{0}\")") %>' class="text-danger" title="Xoá">
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

    <asp:HiddenField ID="hfMaXoa" runat="server" />

    <div class="modal fade" id="modalConfirmDelete" tabindex="-1" role="dialog" aria-labelledby="modalDeleteLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Xác nhận xoá</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xoá đơn hàng này không?
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnXacNhanXoa" runat="server" Text="Xoá" CssClass="btn btn-danger" OnClick="btnXacNhanXoa_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalChiTiet" tabindex="-1" role="dialog" aria-labelledby="modalChiTietLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-white" style="background:#4a90e2">
                    <h5 class="modal-title">Chi tiết đơn hàng</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:GridView ID="gvChiTietDonHang" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                        <Columns>
                            <asp:BoundField DataField="TenMH" HeaderText="Tên mặt hàng" />
                            <asp:BoundField DataField="SLB" HeaderText="Số lượng" />
                            <asp:BoundField DataField="DGB" HeaderText="Đơn giá" DataFormatString="{0:N0}" />
                            <asp:TemplateField HeaderText="Thành tiền">
                                <ItemTemplate>
                                    <%# (Convert.ToInt32(Eval("SLB")) * Convert.ToDecimal(Eval("DGB"))).ToString("N0") %> đ
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function confirmDelete(maDH) {
            $('#<%= hfMaXoa.ClientID %>').val(maDH);
            $('#modalConfirmDelete').modal('show');
        }

        function viewDetails(maDH) {
            __doPostBack('ViewDonHang', maDH);
        }

        function showModalChiTiet() {
            $('#modalChiTiet').modal('show');
        }
    </script>
</asp:Content>
