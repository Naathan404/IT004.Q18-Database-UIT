-- Họ tên: Nguyễn Chí Nguyên
-- MSSV: 24521186
-- Lớp: IT004.Q18.1

-- MÃ ĐỀ: 201
-- CÂU 1: Tạo cơ sở dữ liệu tên “QLPT” bao gồm các quan hệ như bảng thuộc tính trên. Khai báo khóa 
-- chính, khóa ngoại.
CREATE DATABASE QLPT

CREATE TABLE PHONGTRO
(
	MaPT CHAR(5) PRIMARY KEY,
	TenPT NVARCHAR(50),
	DienTich FLOAT,
	LoaiPT NVARCHAR(15),
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

-- CÂU 2
-- Câu 2.1: Đơn giá của các dịch vụ có giá trị từ 2,000 VNĐ đến 500,000 VNĐ.
ALTER TABLE DICHVU
ADD CONSTRAINT CHK_DichVu_DonGia CHECK (DonGia BETWEEN 2000 AND 500000)

-- Câu 2.2: Loại phòng trọ chỉ nhận một trong các giá trị ‘Kiot’, ‘Có gác xép’, ‘Không gác xép’.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CHK_PhongTro_LoaiPT CHECK (LoaiPT IN (N'Kiot', N'Có gác xép', N'Không gác xép'))
GO

-- Câu 2.3: Số tiền của các dịch vụ đã sử dụng (SoTienDichVu) trong phiếu tính tiền được tính bằng 
-- tổng thành tiền của các chi tiết sử dụng dịch vụ (ThanhTien) của phiếu tính tiền đó. Hãy viết 
-- trigger để tạo ràng buộc trên cho thao tác thêm mới một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_PhieuTinhTien_ChiTietTTDV_SoTienDichVu
ON CHITIETTTDV
FOR INSERT
AS
BEGIN
	UPDATE PTT
	SET PTT.SoTienDichVu = (
		SELECT SUM(CT.ThanhTien)
		FROM CHITIETTTDV CT
		WHERE CT.MaPTT = PTT.MaPTT
	)	
	FROM PHIEUTINHTIEN PTT
	JOIN inserted I ON I.MaPTT = PTT.MaPTT
END

-- CÂU 3
-- Câu 3.1: Liệt kê thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) trong năm 2024 
-- cùng với thông tin chi tiết của dịch vụ (chỉ số, thành tiền) đã sử dụng có tên là ‘Điện’.
SELECT PTT.MaPTT, PTT.MaHD, CT.ChiSoDV, CT.ThanhTien
FROM PHIEUTINHTIEN PTT
JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
JOIN DICHVU DV ON DV.MaDV = CT.MaDV
WHERE YEAR(PTT.NgayTinhTien) = 2024
AND DV.TenDV = N'Điện'

-- Câu 3.2: Tìm các phòng trọ (mã, tên phòng trọ) thuộc loại ‘Không gác xép’ được ký hợp đồng 
-- trong năm 2024 nhưng chưa có phiếu tính tiền nào có tổng tiền thanh toán lớn hơn 4,000,000 
-- VNĐ và thanh toán bằng phương thức ‘Chuyển khoản’. 
SELECT PT.MaPT, PT.TenPT
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
WHERE PT.LoaiPT = N'Không gác xép'
AND YEAR(HD.NgayKy) = 2024
EXCEPT
SELECt PT.MaPT, PT.TenPT
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PTT.TongTienTT > 4000000
AND PTT.PhuongThucTT = N'Chuyển khoản'

-- Câu 3.3: Tìm thông tin cư dân (mã, họ tên) đang ở và đã ký hợp đồng thuê tất cả các phòng trọ 
-- thuộc loại ‘Kiot’ và diện tích bằng 40 m2.
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
WHERE CD.TrangThaiCD = N'Đang ở'
AND NOT EXISTS (
	SELECT 1
	FROM PHONGTRO PT
	WHERE PT.LoaiPT = N'Kiot'
	AND PT.DienTich = 40
	AND NOT EXISTS (
		SELECT 1
		FROM HOPDONG HD
		WHERE HD.MaPT = PT.MaPT 
		AND HD.MaCD = CD.MaCD
	)
)

-- Câu 3.4: Với mỗi cư dân đã rời đi, hãy thống kê số lượng hợp đồng có ngày ký từ năm 2022 đến 
-- năm 2024. Thông tin hiển thị: Mã cư dân, họ tên cư dân, số lượng hợp đồng.
SELECT CD.MaCD, CD.HoTen, COUNT(HD.MaHD) AS SoLuongHD
FROM CUDAN CD
LEFT JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
AND YEAR(HD.NgayKy) BETWEEN 2022 AND 2024
WHERE CD.TrangThaiCD = N'Đã rời đi'
GROUP BY Cd.MaCD, CD.HoTen

-- Câu 3.5: Trong các hợp đồng có số lượng phiếu tính tiền đã thanh toán từ 2 trở lên, tìm mã hợp 
-- đồng có tổng chỉ số đã sử dụng của dịch vụ có tên là ‘Điện’ ít nhất.
SELECT TOP 1 WITH TIES HD.MaHD
FROM HOPDONG HD
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
JOIN DICHVU DV ON DV.MaDV = CT.MaDV
WHERE DV.TenDV = N'Điện'
AND HD.MaHD IN (
	SELECT HD2.MaHD
	FROM HOPDONG HD2
	JOIN PHIEUTINHTIEN PTT2 ON PTT2.MaHD = HD2.MaHD
	WHERE PTT2.TinhTrangTT = N'Đã thanh toán'
	GROUP BY HD2.MaHD
	HAVING COUNT(PTT2.MaPTT) >= 2
)
GROUP BY HD.MaHD
ORDER BY SUM(CT.ChiSoDV) ASC