using BusinessLogic.Helper;
using CMS.DataAccess;
using SubSonic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic
{
    public class MatHangManager {

        public static List<MatHangModel> DanhSachMatHang()
        {
            List<MatHang> ds = new Select()
                .From(MatHang.Schema)
                .ExecuteTypedList<MatHang>();

            return ds.Select(m => new MatHangModel
            {
                MaMH = m.MaMH,
                TenMH = m.TenMH,
                MoTaMH = m.MoTaMH,
                GiaBan = m.GiaBan ?? 0,
                AnhMH = ImageHelper.GetImageOrDefault(m.AnhMH),
                MaLMH = m.MaLMH ?? Guid.Empty,
                TenLoai = GetTenLoaiMatHang(m.MaLMH ?? Guid.Empty)
            }).ToList();
        }


        public static string GetTenLoaiMatHang(Guid maLMH)
        {
            LoaiMH loai = new LoaiMH(maLMH);
            return loai?.TenLMH ?? "(Không rõ)";
        }

        public static MatHangModel GetMatHangModelById(string id)
        {
            if (!Guid.TryParse(id, out Guid maMH)) return null;

            MatHang mh = new MatHang(maMH);
            return new MatHangModel
            {
                MaMH = mh.MaMH,
                TenMH = mh.TenMH,
                MoTaMH = mh.MoTaMH,
                GiaBan = mh.GiaBan ?? 0,
                AnhMH = ImageHelper.GetImageOrDefault(mh.AnhMH),
                MaLMH = mh.MaLMH ?? Guid.Empty,
                TenLoai = GetTenLoaiMatHang(mh.MaLMH ?? Guid.Empty)
            };
        }

        public static MatHang GetMatHangById(string id)
        {
            if (!Guid.TryParse(id, out Guid maMH)) return null;
            return new MatHang(maMH);
        }

        public static MatHang ThemMatHang(MatHang m)
        {
            return new MatHangController().Insert(m);
        }

        public static MatHang CapNhatMatHang(MatHang m)
        {
            return new MatHangController().Update(m);
        }

        public static void XoaMatHang(string maMH)
        {
            new Delete()
                .From(MatHang.Schema)
                .Where(MatHang.Columns.MaMH).IsEqualTo(maMH)
                .Execute();
        }
    }

    public class LoaiMatHangManager
    {
        public static List<LoaiMatHangModel> DanhSachLoaiMatHang()
        {
            List<LoaiMH> ds = new Select()
                .From(LoaiMH.Schema)
                .ExecuteTypedList<LoaiMH>();

            List<LoaiMatHangModel> result = ds.Select(l => new LoaiMatHangModel
            {
                MaLoai = l.MaLMH,
                TenLoai = l.TenLMH,
                MoTa = l.MoTaLMH,
                SoLuongSanPham = DemSoLuongMatHangTheoLoai(l.MaLMH)
            }).ToList();

            return result;
        }

        public static int DemSoLuongMatHangTheoLoai(Guid maLMH)
        {
            return new Select()
                .From(MatHang.Schema)
                .Where(MatHang.Columns.MaLMH).IsEqualTo(maLMH)
                .GetRecordCount();
        }

        public static LoaiMH GetLoaiMHById(string id)
        {
            if (!Guid.TryParse(id, out Guid maLMH))
                return null;

            return new LoaiMH(maLMH);
        }

        public static LoaiMH ThemLoaiMatHang(LoaiMH model)
        {
            return new LoaiMHController().Insert(model);
        }

        public static LoaiMH CapNhatLoaiMatHang(LoaiMH model)
        {
            return new LoaiMHController().Update(model);
        }
        public static void XoaLoaiMatHang(string maLMH)
        {
            new Delete()
                .From(LoaiMH.Schema.TableName)
                .Where(LoaiMH.Columns.MaLMH).IsEqualTo(maLMH)
                .Execute();
        }
    }
    public class LoaiMatHangModel
    {
        public Guid MaLoai { get; set; }
        public string TenLoai { get; set; }
        public string MoTa { get; set; }
        public int SoLuongSanPham { get; set; }
    }
    public class MatHangModel
    {
        public Guid MaMH { get; set; }
        public string TenMH { get; set; }
        public string MoTaMH { get; set; }
        public decimal? GiaBan { get; set; }
        public string AnhMH { get; set; }
        public Guid? MaLMH { get; set; }
        public string TenLoai { get; set; }
    }
}
