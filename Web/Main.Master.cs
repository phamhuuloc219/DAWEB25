using BusinessLogic;
using SubSonic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Web.GioHang;

namespace Web
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AutoLoginWithCookie();

            if (!IsPostBack)
            {
                CapNhatSoLuongGioHang();
                CapNhatTaiKhoanNguoiDung();

                if (Session["LoginSuccess"] != null && (bool)Session["LoginSuccess"])
                {
                    Session.Remove("LoginSuccess");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "toastLoginSuccess", "toastr.success('Đăng nhập thành công!');", true);
                }
            }
        }

        private void AutoLoginWithCookie()
        {
            if (Session["KhachHang"] == null && Request.Cookies["KhachHang"] != null)
            {
                string email = Request.Cookies["KhachHang"]["Email"];

                CMS.DataAccess.KhachHang kh = BusinessLogic.KhachHangManager.GetKhachHangByEmail(email);
                if (kh != null)
                {
                    Session["KhachHang"] = kh;
                }
            }
        }

        private void CapNhatSoLuongGioHang()
        {
            List<CartItem> gioHang = Session["GioHang"] as List<CartItem>;
            int soLuong = gioHang?.Sum(x => x.SoLuong) ?? 0;

            cartCount.InnerText = soLuong.ToString();
            cartCount.Style["display"] = soLuong > 0 ? "inline-block" : "none";
        }

        private void CapNhatTaiKhoanNguoiDung()
        {
            CMS.DataAccess.KhachHang kh = Session["KhachHang"] as CMS.DataAccess.KhachHang;
            if (kh != null)
            {
                phNotLoggedIn.Visible = false;
                phLoggedIn.Visible = true;
                lblTenKH.Text = kh.TenKH;
            }
            else
            {
                phNotLoggedIn.Visible = true;
                phLoggedIn.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblRegisterError.Text = string.Empty;
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblLoginError.Text = "Vui lòng nhập đầy đủ.";
                hfAuthTab.Value = "login";
                return;
            }

            CMS.DataAccess.KhachHang kh = BusinessLogic.KhachHangManager.LoginKhachHang(email, password);
            if (kh != null)
            {
                Session["KhachHang"] = kh;
                Session["LoginSuccess"] = true;
                lblLoginError.Text = "";

                HttpCookie ck = new HttpCookie("KhachHang");
                ck.Values["Email"] = kh.Email;
                ck.Expires = DateTime.Now.AddDays(7);
                Response.Cookies.Add(ck);

                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                lblLoginError.Text = "Email hoặc mật khẩu không đúng.";
                hfAuthTab.Value = "login";
            }
            txtPassword.Attributes["type"] = "password";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblLoginError.Text = string.Empty;
            string tenKH = txtTenKH.Text.Trim();
            string email = txtEmailRegister.Text.Trim();
            string password = txtPasswordRegister.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(tenKH))
            {
                lblRegisterError.Text = "Vui lòng nhập đầy đủ thông tin để đăng ký.";
                hfAuthTab.Value = "register";
                return;
            }

            if (KhachHangManager.CheckEmailIsUsed(email))
            {
                lblRegisterError.Text = "Email đã tồn tại!";
                hfAuthTab.Value = "register";
                return;
            }

            CMS.DataAccess.KhachHang kh = new CMS.DataAccess.KhachHang();
            kh.TenKH = tenKH;
            kh.Email = email;
            kh.MatKhau = password;
            KhachHangManager.InsertKhachHang(kh);

            Session["KhachHang"] = kh;
            Response.Redirect(Request.RawUrl);
        }

    }
}