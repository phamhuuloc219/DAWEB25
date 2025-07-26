using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using static Web.GioHang;

namespace Web
{
    public partial class Default : System.Web.UI.Page
    {
        private Guid? LoaiDangChon
        {
            get { return ViewState["LoaiDangChon"] as Guid?; }
            set { ViewState["LoaiDangChon"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLoaiMatHang();
                LoadMatHang(null);
            }
        }

        private void LoadLoaiMatHang()
        {
            List<LoaiMatHangModel> danhSachLoai = LoaiMatHangManager.DanhSachLoaiMatHang();

            danhSachLoai.Insert(0, new LoaiMatHangModel
            {
                MaLoai = Guid.Empty,
                TenLoai = "Tất cả"
            });

            rptLoaiMatHang.DataSource = danhSachLoai;
            rptLoaiMatHang.DataBind();
        }

        private void LoadMatHang(Guid? maLoai)
        {
            LoaiDangChon = maLoai;
            List<MatHangModel> danhSach = MatHangManager.DanhSachMatHang();

            if (maLoai.HasValue && maLoai.Value != Guid.Empty)
                danhSach = danhSach.Where(x => x.MaLMH == maLoai).ToList();

            rptMatHang.DataSource = danhSach;
            rptMatHang.DataBind();
        }

        protected void LoaiMatHang_Command(object sender, CommandEventArgs e)
        {
            if (Guid.TryParse(e.CommandArgument.ToString(), out Guid maLoai))
                LoadMatHang(maLoai);
            else
                LoadMatHang(null);
        }

        protected void ThemVaoGio_Command(object sender, CommandEventArgs e)
        {
            if (Guid.TryParse(e.CommandArgument.ToString(), out Guid maMH))
            {
                List<CartItem> gioHang = Session["GioHang"] as List<CartItem> ?? new List<CartItem>();

                CartItem item = gioHang.FirstOrDefault(x => x.MaMH == maMH);
                if (item != null)
                {
                    item.SoLuong += 1;
                }
                else
                {
                    gioHang.Add(new CartItem { MaMH = maMH, SoLuong = 1 });
                }

                Session["GioHang"] = gioHang;
                int tongSoLuong = gioHang.Sum(x => x.SoLuong);
                string script = $@"
                    document.getElementById('cartCount').innerText = '{tongSoLuong}';
                    document.getElementById('cartCount').style.display = '{(tongSoLuong > 0 ? "inline-block" : "none")}';
                    toastr.success('Đã thêm vào giỏ hàng!');
                ";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "updateCart", script, true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "testLog", "console.log('Script chạy');", true);

            }
        }
    }
}
