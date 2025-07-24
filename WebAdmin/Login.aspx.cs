using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAdmin
{
    public partial class Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null && Request.Cookies["AdminLogin"] != null)
            {
                string username = Request.Cookies["AdminLogin"]["Username"];

                if (!string.IsNullOrEmpty(username))
                {
                    Session["Admin"] = username;
                    Response.Redirect("~/Default.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }

            lblError.Text = "";
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtUsername.Text;
                string password = txtPassword.Text;

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    lblError.Text = "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.";
                    return;
                }

                AdminUser user = KhachHangManager.Login(username, password);

                if (user != null)
                {
                    Session["Admin"] = user.Username;

                    HttpCookie ck = new HttpCookie("AdminLogin");
                    ck.Values["Username"] = user.Username;
                    ck.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(ck);

                    Response.Redirect("~/Default.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }

                else
                {
                    lblError.Text = "Tên đăng nhập hoặc mật khẩu không đúng.";
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}