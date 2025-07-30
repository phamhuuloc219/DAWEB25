
DECLARE @Loai TABLE (MaLMH UNIQUEIDENTIFIER, TenLoai NVARCHAR(255));

INSERT INTO LoaiMH (MaLMH, TenLMH, MoTaLMH)
OUTPUT INSERTED.MaLMH, INSERTED.TenLMH INTO @Loai
VALUES 
(NEWID(), N'Điện thoại', N'Smartphone các hãng'),
(NEWID(), N'Laptop', N'Máy tính xách tay phổ thông'),
(NEWID(), N'Tai nghe - Loa', N'Thiết bị âm thanh'),
(NEWID(), N'Màn hình', N'Màn hình máy tính'),
(NEWID(), N'Phụ kiện', N'Chuột, bàn phím, USB...');

-- Điện thoại
DECLARE @Loai1 UNIQUEIDENTIFIER = (SELECT MaLMH FROM @Loai WHERE TenLoai = N'Điện thoại');
INSERT INTO MatHang (MaMH, TenMH, MoTaMH, GiaBan, AnhMH, MaLMH)
VALUES
(NEWID(), N'iPhone 14', N'Smartphone Apple', 22990000, '/images/iphone14.jpg', @Loai1),
(NEWID(), N'Samsung S22', N'Dòng S cao cấp', 20990000, '/images/s22.jpg', @Loai1),
(NEWID(), N'Xiaomi Redmi Note 12', N'Hiệu năng cao, giá rẻ', 5990000, '/images/redmi12.jpg', @Loai1),
(NEWID(), N'OPPO Reno8', N'Design thời trang', 8490000, '/images/oppo8.jpg', @Loai1),
(NEWID(), N'iPhone 15 Pro', N'Mới nhất của Apple', 32990000, '/images/iphone15pro.jpg', @Loai1),
(NEWID(), N'Samsung A54', N'Máy tầm trung hot', 9990000, '/images/a54.jpg', @Loai1);

-- Laptop
DECLARE @Loai2 UNIQUEIDENTIFIER = (SELECT MaLMH FROM @Loai WHERE TenLoai = N'Laptop');
INSERT INTO MatHang (MaMH, TenMH, MoTaMH, GiaBan, AnhMH, MaLMH)
VALUES
(NEWID(), N'MacBook Air M2', N'Mỏng nhẹ, pin trâu', 26990000, '/images/macbook.jpg', @Loai2),
(NEWID(), N'Dell XPS 13', N'Laptop cao cấp', 30990000, '/images/xps13.jpg', @Loai2),
(NEWID(), N'ASUS Vivobook 15', N'Sinh viên - văn phòng', 12990000, '/images/vivobook.jpg', @Loai2),
(NEWID(), N'Acer Aspire 7', N'Gaming giá tốt', 17990000, '/images/aspire7.jpg', @Loai2),
(NEWID(), N'MSI Modern 14', N'Thiết kế gọn nhẹ', 14990000, '/images/msi14.jpg', @Loai2),
(NEWID(), N'HP Pavilion', N'Laptop học tập', 13990000, '/images/pavilion.jpg', @Loai2);

-- Tai nghe - Loa
DECLARE @Loai3 UNIQUEIDENTIFIER = (SELECT MaLMH FROM @Loai WHERE TenLoai = N'Tai nghe - Loa');
INSERT INTO MatHang (MaMH, TenMH, MoTaMH, GiaBan, AnhMH, MaLMH)
VALUES
(NEWID(), N'Sony WH-1000XM5', N'Tai nghe chống ồn', 6990000, '/images/sony.jpg', @Loai3),
(NEWID(), N'AirPods Pro 2', N'Tai nghe Apple', 5990000, '/images/airpods.jpg', @Loai3),
(NEWID(), N'Loa JBL Charge 5', N'Loa di động chống nước', 3390000, '/images/jbl.jpg', @Loai3),
(NEWID(), N'Samsung Buds2 Pro', N'Tai nghe không dây', 3290000, '/images/buds2.jpg', @Loai3),
(NEWID(), N'Tai nghe Logitech H390', N'Dành cho call center', 690000, '/images/h390.jpg', @Loai3),
(NEWID(), N'Loa Bluetooth Anker', N'Nhỏ gọn, pin lâu', 990000, '/images/anker.jpg', @Loai3);

-- Màn hình
DECLARE @Loai4 UNIQUEIDENTIFIER = (SELECT MaLMH FROM @Loai WHERE TenLoai = N'Màn hình');
INSERT INTO MatHang (MaMH, TenMH, MoTaMH, GiaBan, AnhMH, MaLMH)
VALUES
(NEWID(), N'Màn hình LG 24"', N'Màn IPS giá rẻ', 2990000, '/images/lg24.jpg', @Loai4),
(NEWID(), N'Màn hình Dell 27"', N'Dell UltraSharp', 6890000, '/images/dell27.jpg', @Loai4),
(NEWID(), N'Màn hình Samsung cong', N'Màn hình chơi game', 3990000, '/images/samsungcong.jpg', @Loai4),
(NEWID(), N'Màn hình ASUS TUF 165Hz', N'Gaming tốc độ cao', 4990000, '/images/tuf.jpg', @Loai4),
(NEWID(), N'Màn hình Viewsonic', N'Màn thiết kế đồ họa', 7390000, '/images/viewsonic.jpg', @Loai4),
(NEWID(), N'Màn hình AOC 24G2E', N'Phổ thông chơi game', 3690000, '/images/aoc.jpg', @Loai4);

-- Phụ kiện
DECLARE @Loai5 UNIQUEIDENTIFIER = (SELECT MaLMH FROM @Loai WHERE TenLoai = N'Phụ kiện');
INSERT INTO MatHang (MaMH, TenMH, MoTaMH, GiaBan, AnhMH, MaLMH)
VALUES
(NEWID(), N'Chuột Logitech G102', N'Chuột gaming giá tốt', 399000, '/images/g102.jpg', @Loai5),
(NEWID(), N'Bàn phím DareU EK87', N'Bàn phím cơ giá rẻ', 649000, '/images/dareu.jpg', @Loai5),
(NEWID(), N'USB Kingston 64GB', N'Lưu trữ cá nhân', 250000, '/images/kingston.jpg', @Loai5),
(NEWID(), N'Webcam Logitech C270', N'Họp trực tuyến', 790000, '/images/c270.jpg', @Loai5),
(NEWID(), N'Bàn di chuột Razer', N'Dành cho game thủ', 290000, '/images/razerpad.jpg', @Loai5),
(NEWID(), N'Tay cầm Xbox', N'Chơi game PC/Console', 1690000, '/images/xbox.jpg', @Loai5);
