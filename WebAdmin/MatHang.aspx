<%@ Page Title="Quản lý mặt hàng" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MatHang.aspx.cs" Inherits="WebAdmin.MatHang" %>

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
                    <h3 class="card-title text-primary">Quản lý mặt hàng</h3>
                    <a href="ChiTietMatHang.aspx" class="btn btn-success">Thêm mới</a>
                </div>

                <div class="card-body">
                    <asp:GridView ID="gvMatHang" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="MaMH" OnRowCommand="gvMatHang_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="TenMH" HeaderText="Tên mặt hàng" />
                            <asp:BoundField DataField="MoTaMH" HeaderText="Mô tả" />
                            <asp:BoundField DataField="GiaBan" HeaderText="Giá bán" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="TenLoai" HeaderText="Loại mặt hàng" />
                            <asp:TemplateField HeaderText="Ảnh">
                                <ItemTemplate>
                                    <img src='<%# Eval("AnhMH") %>' alt="Ảnh" style="max-width: 100px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <a href='<%# Eval("MaMH", "ChiTietMatHang.aspx?id={0}") %>' class="text-primary mr-3" title="Sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("MaMH") %>'
                                        CssClass="text-danger" ToolTip="Xoá">
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

    <asp:HiddenField ID="hfMaXoa" runat="server" />

    <div class="modal fade" id="modalXoa" tabindex="-1" role="dialog" aria-labelledby="modalXoaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Xác nhận xoá</h5>
                    <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xoá mặt hàng này không?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnXacNhanXoa" runat="server" CssClass="btn btn-danger" Text="Xoá" OnClick="btnXacNhanXoa_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Huỷ</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</asp:Content>
