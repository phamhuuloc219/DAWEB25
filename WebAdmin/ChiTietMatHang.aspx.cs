using BusinessLogic;
using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace WebAdmin
{
    public partial class ChiTietMatHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (!IsPostBack)
            {
                LoadLoaiMatHang();

                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadThongTin(id);
                }
            }
        }

        private void LoadLoaiMatHang()
        {
            List<LoaiMatHangModel> dsLoai = LoaiMatHangManager.DanhSachLoaiMatHang();
            ddlLoaiMatHang.DataSource = dsLoai;
            ddlLoaiMatHang.DataTextField = "TenLoai";
            ddlLoaiMatHang.DataValueField = "MaLoai";
            ddlLoaiMatHang.DataBind();
        }

        private void LoadThongTin(string id)
        {
            MatHangModel matHang = MatHangManager.GetMatHangModelById(id);
            if (matHang != null)
            {
                hfMaMH.Value = matHang.MaMH.ToString();
                txtTenMH.Text = matHang.TenMH;
                txtMoTa.Text = matHang.MoTaMH;
                txtGiaBan.Text = matHang.GiaBan.HasValue ? matHang.GiaBan.Value.ToString("0.##") : "";
                ddlLoaiMatHang.SelectedValue = matHang.MaLMH.ToString();

                imgPreview.ImageUrl = "~/" + matHang.AnhMH;
                hfAnhCu.Value = matHang.AnhMH;
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            try
            {
                string ten = txtTenMH.Text.Trim();
                string moTa = txtMoTa.Text.Trim();
                decimal gia = decimal.TryParse(txtGiaBan.Text, out decimal g) ? g : 0;
                Guid maLoai = Guid.Parse(ddlLoaiMatHang.SelectedValue);

                if (string.IsNullOrEmpty(ten))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "required", "toastr.warning('Vui lòng nhập tên mặt hàng');", true);
                    return;
                }

                string anh = hfAnhCu.Value;
                if (fuAnh.HasFile)
                {
                    string ext = System.IO.Path.GetExtension(fuAnh.FileName).ToLower();
                    string[] allowedExts = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

                    if (Array.IndexOf(allowedExts, ext) >= 0)
                    {
                        string fileName = Guid.NewGuid().ToString() + ext;
                        string savePath = Server.MapPath("~/Upload/Images/" + fileName);
                        fuAnh.SaveAs(savePath);
                        anh = "Upload/Images/" + fileName;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "invalid", "toastr.error('Chỉ cho phép định dạng ảnh jpg, png, gif, webp');", true);
                        return;
                    }
                }

                if (string.IsNullOrEmpty(hfMaMH.Value))
                {
                    CMS.DataAccess.MatHang matHang = new CMS.DataAccess.MatHang();

                    matHang.MaMH = Guid.NewGuid();
                    matHang.TenMH = ten;
                    matHang.MoTaMH = moTa;
                    matHang.GiaBan = gia;
                    matHang.AnhMH = anh;
                    matHang.MaLMH = maLoai;

                    MatHangManager.ThemMatHang(matHang);
                    ScriptManager.RegisterStartupScript(this, GetType(), "add", "toastr.success('Thêm mặt hàng thành công');", true);
                }
                else
                {
                    CMS.DataAccess.MatHang matHang = MatHangManager.GetMatHangById(hfMaMH.Value);
                    if (matHang != null)
                    {
                        matHang.TenMH = ten;
                        matHang.MoTaMH = moTa;
                        matHang.GiaBan = gia;
                        matHang.AnhMH = anh;
                        matHang.MaLMH = maLoai;
                        MatHangManager.CapNhatMatHang(matHang);

                        ScriptManager.RegisterStartupScript(this, GetType(), "update", "toastr.success('Cập nhật mặt hàng thành công');", true);
                    }
                }

                Response.Redirect("MatHang.aspx");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"toastr.error('Lỗi: {ex.Message}');", true);
            }
        }
    }
}
