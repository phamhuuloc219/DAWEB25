using CMS.DataAccess;
using SubSonic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic
{
    public class KhachHangManager
    {
        public static AdminUser Login(string username, string password)
        {
            return new Select()
                .From(AdminUser.Schema)
                .Where(AdminUser.Columns.Username).IsEqualTo(username)
                .And(AdminUser.Columns.Password).IsEqualTo(password)
                .ExecuteSingle<AdminUser>();
        }

        public static KhachHang InsertKhachHang(KhachHang khachHang)
        {
            return new KhachHangController().Insert(khachHang);
        }

        public static void UpdateKhachHang(KhachHang khachHang)
        {
            new Update(KhachHang.Schema)
                .Set(KhachHang.Columns.TenKH).EqualTo(khachHang.TenKH)
                .Set(KhachHang.Columns.DienThoai).EqualTo(khachHang.DienThoai)
                .Set(KhachHang.Columns.Email).EqualTo(khachHang.Email)
                .Set(KhachHang.Columns.DiaChi).EqualTo(khachHang.DiaChi)
                .Where(KhachHang.Columns.MaKH).IsEqualTo(khachHang.MaKH)
                .Execute();
        }



        public static void DeleteKhachHang(string maKH)
        {
            new Delete()
                .From(KhachHang.Schema.TableName)
                .Where(KhachHang.Columns.MaKH).IsEqualTo(maKH)
                .Execute();
        }

        public static List<KhachHang> DanhSachKhachHang()
        {
            return new Select()
                .From(KhachHang.Schema.TableName)
                .ExecuteTypedList<KhachHang>();
        }
    }
}
