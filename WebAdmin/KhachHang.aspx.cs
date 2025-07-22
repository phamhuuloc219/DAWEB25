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
                string defaultPass = "123456789";
                if (string.IsNullOrWhiteSpace(txtTenKH.Text) ||
                    string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", "toastr.error('Vui lòng nhập đầy đủ Tên và email.');", true);
                    return;
                }

                CMS.DataAccess.KhachHang kh = new CMS.DataAccess.KhachHang();
                kh.MaKH = Guid.NewGuid();
                kh.TenKH = txtTenKH.Text.Trim();
                kh.DienThoai = txtSDT.Text.Trim();
                kh.Email = txtEmail.Text.Trim();
                kh.DiaChi = txtDiaChi.Text.Trim();
                kh.MatKhau = defaultPass;

                KhachHangManager.InsertKhachHang(kh);

                // Reset form
                txtTenKH.Text = txtSDT.Text = txtEmail.Text = txtDiaChi.Text = "";

                LoadKhachHang();

                // close modal
                ScriptManager.RegisterStartupScript(this, GetType(), "hideModal", "$('#modalAdd').modal('hide');", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "success", "toastr.success('Thêm mới thông tin khách hàng thành công');", true);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showError", $"alert('Lỗi: {ex.Message}');", true);
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
