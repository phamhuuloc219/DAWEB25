<%@ Page Title="Đơn hàng của tôi" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DonHangCuaToi.aspx.cs" Inherits="Web.DonHangCuaToi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
        OnRowCommand="gvDonHang_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Mã đơn">
                <ItemTemplate>
                    <a href="javascript:;" onclick="__doPostBack('ViewDonHang', '<%# Eval("MaDonHang") %>')">
                        <%# Eval("MaDonHang") %>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Ngày tạo" DataField="NgayTao" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField HeaderText="Tổng tiền" DataField="TongTien" DataFormatString="{0:N0} ₫" />
            <asp:TemplateField HeaderText="Xem">
                <ItemTemplate>
                    <a href="javascript:;" onclick="__doPostBack('ViewDonHang', '<%# Eval("MaDonHang") %>')">
                        <i class="fa fa-eye"></i>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="modal fade" id="modalChiTietDonHang" tabindex="-1" role="dialog" aria-labelledby="modalChiTietLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết đơn hàng</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:GridView ID="gvChiTietDonHang" runat="server" AutoGenerateColumns="False" CssClass="table">
                        <Columns>
                            <asp:BoundField HeaderText="Tên sản phẩm" DataField="TenMH" />
                            <asp:BoundField HeaderText="Số lượng" DataField="SLB" />
                            <asp:BoundField HeaderText="Đơn giá" DataField="DGB" DataFormatString="{0:N0} ₫" />
                            <asp:TemplateField HeaderText="Thành tiền">
                                <ItemTemplate>
                                    <%# (Convert.ToInt32(Eval("SLB")) * Convert.ToDecimal(Eval("DGB"))).ToString("N0") %> đ
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="scripts" runat="server">
    <script>
        function showModalChiTiet() {
            $('#modalChiTietDonHang').modal('show');
        }
    </script>
</asp:Content>
