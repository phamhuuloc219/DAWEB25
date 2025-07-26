<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="Web.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Giỏ hàng
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        .cart-summary {
            font-weight: bold;
            font-size: 1.2rem;
            text-align: right;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cpMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="upCart" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:Panel ID="pnlCart" runat="server" Visible="false">
                <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
                    <HeaderTemplate>
                        <table class="table table-bordered table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Ảnh</th>
                                    <th>Tên mặt hàng</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th>Xoá</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <img src='<%# Eval("AnhMH") %>' class="product-img" /></td>
                            <td><%# Eval("TenMH") %></td>
                            <td><%# Eval("GiaBan", "{0:N0} đ") %></td>
                            <td>
                                <div class="input-group input-group-sm">
                                    <div class="input-group-prepend">
                                        <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary" CommandName="Giam" CommandArgument='<%# Eval("MaMH") %>' Text="-" />
                                    </div>
                                    <asp:Label runat="server" CssClass="form-control text-center" Text='<%# Eval("SoLuong") %>' />
                                    <div class="input-group-append">
                                        <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary" CommandName="Tang" CommandArgument='<%# Eval("MaMH") %>' Text="+" />
                                    </div>
                                </div>
                            </td>
                            <td><%# Eval("ThanhTien", "{0:N0} đ") %></td>
                            <td>
                                <asp:LinkButton ID="btnXoa" runat="server" CommandArgument='<%# Eval("MaMH") %>' CommandName="Xoa"
                                    CssClass="text-danger" ToolTip="Xoá khỏi giỏ hàng">
                            <i class="fas fa-trash-alt"></i>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="cart-summary mt-3">
                    Tổng tiền:
                    <asp:Label ID="lblTongTien" runat="server" CssClass="text-danger font-weight-bold" />
                </div>

                <div class="text-right mt-3">
                    <asp:Button ID="btnThanhToan" runat="server" Text="Tiến hành thanh toán" CssClass="btn btn-primary" OnClick="btnThanhToan_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="alert alert-info text-center">
                Giỏ hàng của bạn đang trống.
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
