using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAdmin
{
    public partial class LoaiMatHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadLoaiMatHang();
        }

        private void LoadLoaiMatHang()
        {
            List<LoaiMatHangModel> ds = LoaiMatHangManager.DanhSachLoaiMatHang();
            gvLoaiMatHang.DataSource = ds;
            gvLoaiMatHang.DataBind();
        }

        protected void gvLoaiMatHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditItem")
            {
                string id = e.CommandArgument.ToString();
                LoaiMH loai = LoaiMatHangManager.GetLoaiMHById(id);
                if (loai != null)
                {
                    hfMaLoai.Value = loai.MaLMH.ToString();
                    txtTenLoai.Text = loai.TenLMH;
                    txtMoTa.Text = loai.MoTaLMH;

                    ScriptManager.RegisterStartupScript(this, GetType(), "editModal",
                        $"editModal('{loai.MaLMH}', '{HttpUtility.JavaScriptStringEncode(loai.TenLMH)}', `{HttpUtility.JavaScriptStringEncode(loai.MoTaLMH)}`);", true);
                }
            }
            else if (e.CommandName == "ConfirmDelete")
            {
                string id = e.CommandArgument.ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "confirmDelete", $"confirmDelete('{id}');", true);
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                string tenLoai = txtTenLoai.Text.Trim();
                string moTa = txtMoTa.Text.Trim();

                if (string.IsNullOrEmpty(tenLoai))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err", "toastr.error('Vui lòng nhập tên loại.');", true);
                    return;
                }

                if (string.IsNullOrEmpty(hfMaLoai.Value))
                {
                    LoaiMH loai = new LoaiMH();
                    loai.MaLMH = Guid.NewGuid();
                    loai.TenLMH = tenLoai;
                    loai.MoTaLMH = moTa;

                    LoaiMatHangManager.ThemLoaiMatHang(loai);
                    ScriptManager.RegisterStartupScript(this, GetType(), "add", "toastr.success('Thêm loại mặt hàng thành công');", true);
                }
                else
                {
                    LoaiMH loai = LoaiMatHangManager.GetLoaiMHById(hfMaLoai.Value);

                    if (loai != null)
                    {
                        loai.TenLMH = tenLoai;
                        loai.MoTaLMH = moTa;

                        LoaiMatHangManager.CapNhatLoaiMatHang(loai);
                        ScriptManager.RegisterStartupScript(this, GetType(), "update", "toastr.success('Cập nhật thành công');", true);
                    }

                }

                LoadLoaiMatHang();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "fail",
                    $"toastr.error('Lỗi: {ex.Message}');", true);
            }
        }
        protected void btnXacNhanXoa_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfMaLoaiXoa.Value) && Guid.TryParse(hfMaLoaiXoa.Value, out Guid id))
            {
                try
                {
                    LoaiMatHangManager.XoaLoaiMatHang(id.ToString());
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleted", "toastr.success('Đã xóa thành công');", true);
                    LoadLoaiMatHang();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleteFail", $"toastr.error('Lỗi xóa: {ex.Message}');", true);
                }
            }
        }

    }
}