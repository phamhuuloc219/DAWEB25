using System;
using System.Web.UI;
using CMS.DataAccess;
using BusinessLogic;

namespace Web
{
    public partial class ThongTinCaNhan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KhachHang"] == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (!IsPostBack)
            {
                LoadKhachHang();
                lblMessage.Text = string.Empty;
            }
        }

        protected void LoadKhachHang()
        {
            try
            {
                KhachHang kh = Session["KhachHang"] as KhachHang;
                if (kh == null || kh.MaKH == Guid.Empty)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                txtEmail.Text = kh.Email;
                txtTenKH.Text = kh.TenKH;
                txtDienThoai.Text = kh.DienThoai;
                txtDiaChi.Text = kh.DiaChi;
                txtMatKhau.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi tải dữ liệu: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                KhachHang kh = Session["KhachHang"] as KhachHang;
                if (kh == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                kh.TenKH = txtTenKH.Text.Trim();
                kh.DienThoai = txtDienThoai.Text.Trim();
                kh.DiaChi = txtDiaChi.Text.Trim();

                string matKhauMoi = txtMatKhau.Text.Trim();
                if (!string.IsNullOrEmpty(matKhauMoi))
                {
                    if (matKhauMoi.Length >= 8)
                    {
                        kh.MatKhau = matKhauMoi;
                    }
                    else
                    {
                        lblMessage.Text = "Mật khẩu phải có ít nhất 8 ký tự.";
                        lblMessage.CssClass = "text-danger";
                        return;
                    }
                }

                KhachHangManager.UpdateKhachHang(kh);
                Session["KhachHang"] = kh;

                lblMessage.Text = "Cập nhật thông tin thành công!";
                lblMessage.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }
    }
}
