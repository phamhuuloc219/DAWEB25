using System;
using System.Web.UI;
using BusinessLogic;
using CMS.DataAccess;

namespace Web
{
    public partial class DonHangCuaToi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KhachHang"] == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (!IsPostBack)
                LoadDonHang();

            string eventTarget = Request["__EVENTTARGET"];
            string eventArgument = Request["__EVENTARGUMENT"];

            if (eventTarget == "ViewDonHang" && !string.IsNullOrEmpty(eventArgument))
            {
                LoadChiTietDonHang(eventArgument);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModalChiTiet();", true);
            }
        }

        private void LoadDonHang()
        {
            KhachHang kh = Session["KhachHang"] as KhachHang;
            if (kh == null || kh.MaKH == Guid.Empty)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            gvDonHang.DataSource = DonHangManager.GetDonHangByCustomer(kh.MaKH.ToString());
            gvDonHang.DataBind();
        }

        private void LoadChiTietDonHang(string maDH)
        {
            gvChiTietDonHang.DataSource = DonHangManager.GetChiTietDonHang(maDH);
            gvChiTietDonHang.DataBind();
        }

        protected void gvDonHang_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            
        }
    }
}
