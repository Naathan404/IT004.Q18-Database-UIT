-- Họ tên: Nguyễn Chí Nguyên
-- MSSV: 24521186
-- Lớp: IT004.Q18.1

-- MÃ ĐỀ 102PT
-- CÂU 1: Tạo cơ sở dữ liệu tên “QLPT” bao gồm các quan hệ như bảng thuộc tính trên. Khai báo khóa 
-- chính, khóa ngoại.
CREATE DATABASE QLPT

CREATE TABLE PHONGTRO
(
	MaPT CHAR(5) PRIMARY KEY,
	TenPT NVARCHAR(50),
	DienTich FLOAT,
	GiaPT MONEY,
	TinhTrangPT NVARCHAR(20)
)

CREATE TABLE CUDAN
(
	MaCD CHAR(5) PRIMARY KEY,
	HoTen NVARCHAR(50),
	CCCD NVARCHAR(12),
	DiaChi NVARCHAR(100),
	SoDT VARCHAR(15),
	NgayThue SMALLDATETIME, 
	TrangThaiCD NVARCHAR(15)
)

CREATE TABLE HOPDONG
(
	MaHD CHAR(5) PRIMARY KEY,
	MaCD CHAR(5),
	MaPT CHAR(5),
	NgayKy SMALLDATETIME,
	NgayHetHan SMALLDATETIME,
	TrangThaiHD NVARCHAR(20)
	
	CONSTRAINT FK_HopDong_CuDan FOREIGN KEY (MaCD) REFERENCES CUDAN(MaCD),
	CONSTRAINT FK_HopDong_PhongTro FOREIGN KEY (MaPT) REFERENCES PHONGTRO(MaPT)
)

CREATE TABLE DICHVU
(
	MaDV CHAR(5) PRIMARY KEY,
	TenDV NVARCHAR(50),
	DonGia MONEY
)

CREATE TABLE PHIEUTINHTIEN
(
	MaPTT CHAR(5) PRIMARY KEY,
	MaHD CHAR(5),
	SoTienDichVu MONEY,
	SoTienThuePT MONEY,
	TongTienTT MONEY,
	NgayTinhTien SMALLDATETIME,
	TinhTrangTT NVARCHAR(20),
	PhuongThucTT NVARCHAR(20)

	CONSTRAINT FK_PhieuTT_HopDong FOREIGN KEY (MaHD) REFERENCES HOPDONG(MaHD)
)

CREATE TABLE CHITIETTTDV
(
	MaPTT CHAR(5),
	MaDV CHAR(5),
	ChiSoDV FLOAT,
	ThanhTien MONEY

	CONSTRAINT PK_ChiTietTtDV PRIMARY KEY (MaPTT, MaDV),
	CONSTRAINT FK_ChiTietTtV_PhieuTT FOREIGN KEY (MaPTT) REFERENCES PHIEUTINHTIEN(MaPTT),
	CONSTRAINT FK_ChiTietTtDV_DichVu FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV),
)

-- CÂU 2:
-- Câu 2.1: Giá thuê phòng trọ có giá trị trong khoảng từ 500,000 VNĐ đến 20,000,000 VNĐ.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CHK_PhongTro_GiaPT CHECK (GiaPT BETWEEN 500000 AND 20000000)

-- Câu 2.2: Trạng thái cư dân chỉ nhận một trong hai giá trị ‘Đang ở’ hoặc ‘Đã rời đi’.
ALTER TABLE CUDAN
ADD CONSTRAINT CHK_CuDan_TrangThai CHECK (TrangThaiCD IN (N'Đang ở', N'Đã rời đi'))
GO


-- Câu 2.3: Số tiền của mỗi dịch vụ đã sử dụng (ThanhTien) trong chi tiết tính tiền được tính bằng 
-- chỉ số đã sử dụng (ChiSoDV) nhân với đơn giá (DonGia) của dịch vụ đó. Hãy viết trigger để 
-- tạo ràng buộc trên cho thao tác sửa một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_ChiTietTTDV_DichVu_ThanhTien
ON CHITIETTTDV
FOR UPDATE
AS
BEGIN
	UPDATE CT
	SET ThanhTien = CT.ChiSoDV * DV.DonGia
	FROM CHITIETTTDV CT
	JOIN inserted I ON I.MaDV = CT.MaDV AND I.MaPTT = CT.MaPTT
	JOIN DICHVU DV ON DV.MaDV = CT.MaDV
END


-- CÂU 3: 
-- Câu 3.1: Liệt kê thông tin các cư dân (mã, họ tên) cùng thông tin phòng trọ (mã, tên phòng) mà 
-- cư dân đó đã ký hợp đồng với trạng thái hợp đồng ‘Đã hết hạn’ trong năm 2024.
SELECT CD.MaCD, CD.HoTen, PT.MaPT, PT.TenPT
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHONGTRO PT ON PT.MaPT = HD.MaPT
WHERE HD.TrangThaiHD = N'Đã hết hạn' 
AND YEAR(HD.NgayHetHan) = 2024

-- Câu 3.2: Tìm các hợp đồng (mã hợp đồng, mã phòng trọ) đã thanh toán các phiếu tính tiền trong 
-- năm 2024 nhưng không sử dụng dịch vụ nào có chỉ số từ 5 trở lên trong những chi tiết của 
-- phiếu tính tiền đó.
SELECT HD.MaHD, HD.MaPT
FROM HOPDONG HD
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
EXCEPT 
SELECT HD.MaHD, HD.MaPT
FROM HOPDONG HD
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
WHERE CT.ChiSoDV >= 5

-- Câu 3.3: Tìm thông tin các dịch vụ (mã, tên dịch vụ) có đơn giá trên 10,000 VNĐ và có trong chi 
-- tiết của tất cả các phiếu tính tiền ngày 15/12/2024.
SELECT DV.MaDV, DV.TenDV
FROM DICHVU DV
WHERE DV.DonGia > 10000
AND NOT EXISTS (
	SELECT 1
	FROM PHIEUTINHTIEN PTT
	WHERE PTT.NgayTinhTien = '2024-12-15'
	AND NOT EXISTS (
		SELECT 1
		FROM CHITIETTTDV CT
		WHERE CT.MaPTT = PTT.MaPTT
		AND CT.MaDV = DV.MaDV
	)
)

-- Câu 3.4: Với mỗi hợp đồng đã hết hạn, hãy cho biết số lượng phiếu tính tiền trong năm 2024 đã 
-- được thanh toán. Thông tin hiển thị: Mã hợp đồng, mã cư dân, số lượng.
SELECT HD.MaHD, HD.MaCD, COUNT(PTT.MaPTT) AS SoLuongPTT
FROM HOPDONG HD
LEFT JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = Hd.MaHD
AND PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
WHERE 
HD.TrangThaiHD = N'Đã hết hạn'
GROUP BY HD.MaHD, HD.MaCD

-- Câu 3.5: Trong các cư dân có số lần ký hợp đồng ít nhất, tìm cư dân (mã, họ tên) có tổng số tiền 
-- đã thanh toán trong năm 2024 nhiều hơn 5,000,000 VNĐ.
SELECT CD.MaCD, CD.HoTen, SUM(PTT.TongTienTT) AS TongTT
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD 
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
AND CD.MaCD IN (
	SELECT TOP 1 WITH TIES CD2.MaCD
	FROM CUDAN CD2
	JOIN HOPDONG HD2 ON HD2.MaCD = CD2.MaCD
	GROUP BY CD2.MaCD
	ORDER BY COUNT(HD2.MaHD) ASC
)
GROUP BY CD.MaCD, CD.HoTen
HAVING SUM(PTT.TongTienTT) > 5000000