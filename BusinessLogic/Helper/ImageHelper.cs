using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic.Helper
{
    public static class ImageHelper
    {
        private const string DefaultImage = "image/no-image.png";

        /// <summary>
        /// Trả về ảnh mặc định nếu chuỗi rỗng hoặc null
        /// </summary>
        public static string GetImageOrDefault(string imagePath)
        {
            return string.IsNullOrWhiteSpace(imagePath) ? DefaultImage : imagePath;
        }
    }
}
