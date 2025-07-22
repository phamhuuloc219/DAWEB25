using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAdmin
{
    public partial class KhachHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadKhachHang();
        }

        private void LoadKhachHang()
        {
            List<CMS.DataAccess.KhachHang> danhSach = KhachHangManager.DanhSachKhachHang();
            gvKhachHang.DataSource = danhSach;
            gvKhachHang.DataBind();
        }

        protected void btnThemMoi_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtTenKH.Text) ||
                    string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showError", "alert('Vui lòng nhập đầy đủ Tên và email.');", true);
                    return;
                }

                CMS.DataAccess.KhachHang kh = new CMS.DataAccess.KhachHang();
                kh.MaKH = Guid.NewGuid();
                kh.TenKH = txtTenKH.Text.Trim();
                kh.DienThoai = txtSDT.Text.Trim();
                kh.Email = txtEmail.Text.Trim();
                kh.DiaChi = txtDiaChi.Text.Trim();

                KhachHangManager.InsertKhachHang(kh);

                // Reset form
                txtTenKH.Text = txtSDT.Text = txtEmail.Text = txtDiaChi.Text = "";

                LoadKhachHang();

                // close modal
                ScriptManager.RegisterStartupScript(this, GetType(), "hideModal", "$('#modalAdd').modal('hide');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showError", $"alert('Lỗi: {ex.Message}');", true);
            }
        }

        protected void gvKhachHang_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvKhachHang.EditIndex = e.NewEditIndex;
            LoadKhachHang();
        }

        protected void gvKhachHang_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvKhachHang.EditIndex = -1;
            LoadKhachHang();
        }

        protected void gvKhachHang_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string key = gvKhachHang.DataKeys[e.RowIndex].Value.ToString();
                if (!Guid.TryParse(key, out Guid maKH))
                    return;

                GridViewRow row = gvKhachHang.Rows[e.RowIndex];

                var txtTenKH = (TextBox)row.FindControl("txtEditTenKH");
                var txtSDT = (TextBox)row.FindControl("txtEditSDT");
                var txtEmail = (TextBox)row.FindControl("txtEditEmail");
                var txtDiaChi = (TextBox)row.FindControl("txtEditDiaChi");

                CMS.DataAccess.KhachHang kh = new CMS.DataAccess.KhachHang();
                kh.MaKH = maKH;
                kh.TenKH = txtTenKH?.Text.Trim();
                kh.DienThoai = txtSDT?.Text.Trim();
                kh.Email = txtEmail?.Text.Trim();
                kh.DiaChi = txtDiaChi?.Text.Trim();

                KhachHangManager.UpdateKhachHang(kh);

                gvKhachHang.EditIndex = -1;
                LoadKhachHang();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "updateFail", $"alert('Lỗi cập nhật: {ex.Message}');", true);
            }
        }

        protected void gvKhachHang_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string key = gvKhachHang.DataKeys[e.RowIndex].Value.ToString();
            if (!Guid.TryParse(key, out Guid maKH))
                return;

            KhachHangManager.DeleteKhachHang(maKH.ToString());
            LoadKhachHang();
        }
    }
}
