using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using CMS.DataAccess;

namespace Web
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadGioHang();
        }

        private void LoadGioHang()
        {
            List<CartItem> gioHang = Session["GioHang"] as List<CartItem>;
            if (gioHang == null || gioHang.Count == 0)
            {
                pnlCart.Visible = false;
                pnlEmpty.Visible = true;
                return;
            }

            decimal tongTien = 0;
            List<object> danhSach = new List<object>();

            foreach (var item in gioHang)
            {
                MatHangModel mh = MatHangManager.GetMatHangModelById(item.MaMH.ToString());
                if (mh != null)
                {
                    decimal gia = mh.GiaBan ?? 0;
                    int sl = item.SoLuong;
                    tongTien += gia * sl;

                    danhSach.Add(new
                    {
                        mh.MaMH,
                        mh.TenMH,
                        mh.AnhMH,
                        mh.GiaBan,
                        SoLuong = sl,
                        ThanhTien = gia * sl
                    });
                }
            }

            rptGioHang.DataSource = danhSach;
            rptGioHang.DataBind();

            lblTongTien.Text = tongTien.ToString("N0") + " đ";
            pnlCart.Visible = true;
            pnlEmpty.Visible = false;
        }

        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Guid maMH;
            if (!Guid.TryParse(e.CommandArgument.ToString(), out maMH)) return;

            List<CartItem> gioHang = Session["GioHang"] as List<CartItem> ?? new List<CartItem>();
            CartItem item = gioHang.FirstOrDefault(x => x.MaMH == maMH);

            if (item != null)
            {
                switch (e.CommandName)
                {
                    case "Tang":
                        item.SoLuong++;
                        break;
                    case "Giam":
                        if (item.SoLuong > 1)
                            item.SoLuong--;
                        break;
                    case "Xoa":
                        gioHang.RemoveAll(x => x.MaMH == maMH);
                        break;
                }
            }

            Session["GioHang"] = gioHang;
            LoadGioHang();
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            CMS.DataAccess.KhachHang kh = Session["KhachHang"] as CMS.DataAccess.KhachHang;

            if (kh == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showLoginModal", "$('#loginModal').modal('show');", true);
                return;
            }

            List<CartItem> gioHang = Session["GioHang"] as List<CartItem>;
            if (gioHang == null || gioHang.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "empty", "toastr.warning('Giỏ hàng trống!');", true);
                return;
            }

            string prefix = DateTime.Now.ToString("yyMMdd");

            int countToday = DonHangManager.GetMaDonHang();

            string maDH = prefix + (countToday + 1).ToString("D4");


            DonHang dh = new DonHang();
            dh.MaDH = maDH;
            dh.MaKH = kh.MaKH;
            dh.NgayBan = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            DonHangManager.InsertDonHang(dh);

            foreach (var item in gioHang)
            {
                MatHang mh = MatHangManager.GetMatHangById(item.MaMH.ToString());
                if (mh != null)
                {
                    Ctdh ct = new Ctdh();
                    ct.MaDH = maDH;
                    ct.MaMH = mh.MaMH;
                    ct.Slb = item.SoLuong;
                    ct.Dgb = mh.GiaBan ?? 0;
                    CtdhManager.ThemChiTietDonHang(ct);
                }
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "toastr.success('Thanh toán thành công!');", true);
            Session["GioHang"] = new List<CartItem>();
            Response.Redirect(Request.RawUrl);
            LoadGioHang();
        }
        public class CartItem
        {
            public Guid MaMH { get; set; }
            public int SoLuong { get; set; }
        }
    }
}
