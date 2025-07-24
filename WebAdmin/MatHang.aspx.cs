using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAdmin
{
    public partial class MatHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (!IsPostBack)
                LoadMatHang();
        }

        private void LoadMatHang()
        {
            List<MatHangModel> danhSach = MatHangManager.DanhSachMatHang();
            gvMatHang.DataSource = danhSach;
            gvMatHang.DataBind();
        }

        protected void gvMatHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                string id = e.CommandArgument.ToString();
                hfMaXoa.Value = id;
                ScriptManager.RegisterStartupScript(this, GetType(), "showDeleteModal", "$('#modalXoa').modal('show');", true);
            }
        }

        protected void btnXacNhanXoa_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Guid.TryParse(hfMaXoa.Value, out Guid maMH))
                    return;

                MatHangManager.XoaMatHang(maMH.ToString());
                LoadMatHang();

                ScriptManager.RegisterStartupScript(this, GetType(), "success", "toastr.success('Xóa mặt hàng thành công');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "fail", $"toastr.error('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
