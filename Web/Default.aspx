<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Trang chủ
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
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

    <div class="row">
        <asp:Repeater ID="rptMatHang" runat="server">
            <ItemTemplate>
                <div class="col-md-3 mb-4 d-flex">
                    <div class="product-card w-100">
                        <img src='<%# Eval("AnhMH") %>' alt="Ảnh mặt hàng" class="product-image" />
                        <div class="product-title"><%# Eval("TenMH") %></div>
                        <div class="product-price"><%# Eval("GiaBan", "{0:N0} đ") %></div>
                        <asp:Button ID="btnAddToCart" runat="server" Text="Thêm vào giỏ hàng"
                            CssClass="btn btn-sm btn-success mt-2"
                            CommandArgument='<%# Eval("MaMH") %>' OnCommand="ThemVaoGio_Command" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
    

<asp:Content ID="Content4" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
