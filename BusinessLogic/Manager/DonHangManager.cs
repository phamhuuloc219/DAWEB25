using CMS.DataAccess;
using SubSonic;
using System;
using System.Collections.Generic;

namespace BusinessLogic
{
    public class DonHangManager
    {
        public static DonHang InsertDonHang(DonHang donHang)
        {
            return new DonHangController().Insert(donHang);
        }

        public static DonHang UpdateDonHang(DonHang donHang)
        {
            return new DonHangController().Update(donHang);
        }

        public static bool DeleteDonHang(string maDH)
        {
            // Xoá chi tiết đơn hàng trước
            new Delete()
                .From(Ctdh.Schema)
                .Where(Ctdh.Columns.MaDH).IsEqualTo(maDH)
                .Execute();

            // Xoá đơn hàng
            int rows = new Delete()
                .From(DonHang.Schema)
                .Where(DonHang.Columns.MaDH).IsEqualTo(maDH)
                .Execute();

            return rows > 0;
        }

        public static List<object> GetDanhSachDonHang()
        {
            List<object> result = new List<object>();

            var dsDonHang = new Select()
                .From(DonHang.Schema)
                .ExecuteTypedList<DonHang>();

            foreach (var dh in dsDonHang)
            {
                var kh = new Select(KhachHang.Columns.TenKH)
                    .From(KhachHang.Schema)
                    .Where(KhachHang.Columns.MaKH).IsEqualTo(dh.MaKH)
                    .ExecuteSingle<KhachHang>();

                var chiTiet = new Select(Ctdh.Columns.Slb, Ctdh.Columns.Dgb)
                    .From(Ctdh.Schema)
                    .Where(Ctdh.Columns.MaDH).IsEqualTo(dh.MaDH)
                    .ExecuteTypedList<Ctdh>();

                int soLuongMatHang = chiTiet.Count;
                decimal tongTien = 0;

                foreach (var ct in chiTiet)
                {
                    tongTien += (ct.Slb ?? 0) * (ct.Dgb ?? 0m);
                }



                result.Add(new
                {
                    MaDH = dh.MaDH,
                    NgayBan = dh.NgayBan,
                    TenKH = kh != null ? kh.TenKH : "Không rõ",
                    SoLuongMatHang = soLuongMatHang,
                    TongTien = tongTien
                });
            }

            return result;
        }

        public static List<object> GetChiTietDonHang(string maDH)
        {
            List<object> result = new List<object>();

            var dsCT = new Select()
                .From(Ctdh.Schema)
                .Where(Ctdh.Columns.MaDH).IsEqualTo(maDH)
                .ExecuteTypedList<Ctdh>();

            foreach (var ct in dsCT)
            {
                var mh = new Select(MatHang.Columns.TenMH)
                    .From(MatHang.Schema)
                    .Where(MatHang.Columns.MaMH).IsEqualTo(ct.MaMH)
                    .ExecuteSingle<MatHang>();

                result.Add(new
                {
                    TenMH = mh != null ? mh.TenMH : "Không rõ",
                    Slb = ct.Slb,
                    Dgb = ct.Dgb,
                    ThanhTien = ct.Slb * ct.Dgb
                });
            }

            return result;
        }
    }
}
