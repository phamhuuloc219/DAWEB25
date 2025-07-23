using CMS.DataAccess;
using SubSonic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic
{
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
}
