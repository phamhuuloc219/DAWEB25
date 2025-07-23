using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAdmin
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies["Username"] != null)
            {
                Response.Cookies["Username"].Expires = DateTime.Now.AddDays(-1);
            }

            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}