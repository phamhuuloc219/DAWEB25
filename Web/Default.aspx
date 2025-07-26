<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Trang chủ
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="category-filter mb-4">
        <asp:Repeater ID="rptLoaiMatHang" runat="server">
            <ItemTemplate>
                <asp:LinkButton ID="lnkLoai" runat="server" CssClass="btn btn-outline-primary mr-2 mb-2"
                    CommandArgument='<%# Eval("MaLoai") %>' OnCommand="LoaiMatHang_Command">
                    <%# Eval("TenLoai") %>
                </asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:UpdatePanel ID="upMatHang" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div class="row">
                <asp:Repeater ID="rptMatHang" runat="server">
                    <ItemTemplate>
                        <div class="col-md-3 mb-4 d-flex">
                            <div class="product-card w-100"
                                onclick="showProductModal(
                    '<%# Eval("TenMH").ToString().Replace("'", "\\'") %>',
                    '<%# Eval("AnhMH") %>',
                    '<%# Eval("MoTaMH").ToString().Replace("'", "\\'") %>',
                    '<%# Eval("GiaBan") %>',
                    '<%# Eval("MaMH") %>')">

                                <img src='<%# Eval("AnhMH") %>' alt="Ảnh mặt hàng" class="product-image" />
                                <div class="product-title"><%# Eval("TenMH") %></div>
                                <div class="product-price"><%# Eval("GiaBan", "{0:N0} đ") %></div>

                                <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="btnAddToCart" runat="server"
    CssClass="btn btn-sm btn-success mt-2"
    OnClientClick="event.stopPropagation();"
    CommandArgument='<%# Eval("MaMH") %>'
    OnClick="btnAddToCart_Click"
    Text="Thêm vào giỏ hàng" />

                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnAddToCart" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <!-- Modal chi tiết sản phẩm -->
    <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTenMH">Tên sản phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body d-flex">
                    <img id="modalAnhMH" src="" class="img-fluid mr-4" style="max-width: 200px; max-height: 200px;" />
                    <div>
                        <p id="modalMoTaMH">Mô tả sản phẩm</p>
                        <h5 id="modalGiaBan">Giá: 0 đ</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="scripts" runat="server">
    <script>
        function showProductModal(tenMH, anhMH, moTaMH, giaBan, maMH) {
            document.getElementById('modalTenMH').innerText = tenMH;
            document.getElementById('modalAnhMH').src = anhMH;
            document.getElementById('modalMoTaMH').innerText = moTaMH;
            document.getElementById('modalGiaBan').innerText = 'Giá: ' + parseInt(giaBan).toLocaleString() + ' đ';
            $('#productModal').modal('show');
        }

    </script>
</asp:Content>
