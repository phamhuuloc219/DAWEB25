using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Web.UI;

namespace WebAdmin
{
    public partial class ChiTietKhachHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (!IsPostBack)
            {
                LoadKhachHang();
                lbNoti.Text = string.Empty;
            }
        }

        protected void LoadKhachHang()
        {
            try
            {
                string maKHStr = Request.QueryString["id"];
                if (!Guid.TryParse(maKHStr, out Guid maKH))
                {
                    Response.Redirect("KhachHang.aspx");
                    return;
                }

                CMS.DataAccess.KhachHang khachHang = KhachHangManager.GetKhachHangById(maKH);
                if (khachHang == null || khachHang.MaKH == Guid.Empty)
                {
                    Response.Redirect("KhachHang.aspx");
                    return;
                }

                hfMaKH.Value = khachHang.MaKH.ToString();
                txtTenKH.Text = khachHang.TenKH;
                txtSDT.Text = khachHang.DienThoai;
                txtEmail.Text = khachHang.Email;
                txtDiaChi.Text = khachHang.DiaChi;
                txtMatKhau.Text = string.Empty;

            }
            catch (Exception ex) { }
        }
        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                lbNoti.Text = string.Empty;
                if (!Guid.TryParse(hfMaKH.Value, out Guid maKH))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", "toastr.error('ID không hợp lệ');", true);
                    return;
                }

                CMS.DataAccess.KhachHang khachHang = KhachHangManager.GetKhachHangById(maKH);

                if (khachHang != null)
                {
                    khachHang.TenKH = txtTenKH.Text.Trim();
                    khachHang.DienThoai = txtSDT.Text.Trim();
                    khachHang.Email = txtEmail.Text.Trim();
                    khachHang.DiaChi = txtDiaChi.Text.Trim();
                    if (!string.IsNullOrEmpty(txtMatKhau.Text.Trim()))
                    {
                        if (txtMatKhau.Text.Trim().Length > 8)
                        {
                            khachHang.MatKhau = txtMatKhau.Text.Trim();
                        }
                        else
                        {
                            lbNoti.Text = "Mật khẩu phải lớn hơn 8 ký tự";
                            return;
                        }
                    }
                }

                KhachHangManager.UpdateKhachHang(khachHang);
                ScriptManager.RegisterStartupScript(this, GetType(), "success", "toastr.success('Cập nhật thành công');", true);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"toastr.error('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
