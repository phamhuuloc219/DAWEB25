using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;

namespace WebAdmin
{
    public partial class DonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx", false);
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
            gvDonHang.DataSource = DonHangManager.GetDanhSachDonHang();
            gvDonHang.DataBind();
        }

        private void LoadChiTietDonHang(string maDH)
        {
            gvChiTietDonHang.DataSource = DonHangManager.GetChiTietDonHang(maDH);
            gvChiTietDonHang.DataBind();
        }

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                string maDH = e.CommandArgument.ToString();
                hfMaXoa.Value = maDH;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmDelete", "$('#modalConfirmDelete').modal('show');", true);
            }
        }

        protected void btnXacNhanXoa_Click(object sender, EventArgs e)
        {
            string maDH = hfMaXoa.Value;
            if (!string.IsNullOrEmpty(maDH))
            {
                bool daXoa = DonHangManager.DeleteDonHang(maDH);
                if (daXoa)
                {
                    LoadDonHang();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "toastSuccess", "toastr.success('Xoá đơn hàng thành công!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "toastError", "toastr.error('Không thể xoá đơn hàng!');", true);
                }
            }
        }
    }
}
