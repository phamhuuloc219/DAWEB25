using CMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
