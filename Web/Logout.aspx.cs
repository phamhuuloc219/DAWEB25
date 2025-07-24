using System;
using System.Web;
using System.Web.UI;

namespace Web
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies["Username"] != null)
            {
                HttpCookie expiredCookie = new HttpCookie("Username");
                expiredCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(expiredCookie);
            }

            Response.Redirect("Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
