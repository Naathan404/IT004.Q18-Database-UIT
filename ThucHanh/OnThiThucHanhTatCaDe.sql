-- Nguyễn Chí Nguyên
-- 24521186

-- ĐỀ 101 --
-- Câu 1
CREATE DATABASE QLPT;
GO

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
	CONSTRAINT PK_ChiTietTTDV PRIMARY KEY (MaPTT, MaDV),
	CONSTRAINT FK_ChiTiet_PhieuTT FOREIGN KEY (MaPTT) REFERENCES PHIEUTINHTIEN(MaPTT),
	CONSTRAINT FK_ChiTiet_DichVu FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV)
)

-- Câu 2
-- 2.1 Diện tích của một căn phòng trọ có giá trị từ 10 đến 50 m2.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CK_PhongTro_DienTich CHECK (DienTich BETWEEN 10 AND 50)

-- 2.2 Tình trạng thanh toán của phiếu tính tiền chỉ nhận một trong hai giá trị ‘Chưa thanh 
-- toán’ hoặc ‘Đã thanh toán’
ALTER TABLE PHIEUTINHTIEN 
ADD CONSTRAINT CK_PhieuTT_TinhTrangTT CHECK (TinhTrangTT IN (N'Chưa thanh toán', N'Đã thanh toán'))
GO

-- 2.3 Số tiền của mỗi dịch vụ đã sử dụng (ThanhTien) trong chi tiết tính tiền được tính bằng 
-- chỉ số đã sử dụng (ChiSoDV) nhân với đơn giá (DonGia) của dịch vụ đó. Hãy viết trigger để 
-- tạo ràng buộc trên cho thao tác thêm mới một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_ChiTietTTDV_ThanhTien 
ON CHITIETTTDV
FOR INSERT
AS
BEGIN
	UPDATE CT
	SET ThanhTien = CT.ChiSoDV * DV.DonGia
	FROM CHITIETTTDV CT
	JOIN DICHVU DV ON DV.MaDV = CT.MaDV
	JOIN inserted I ON I.MaDV = CT.MaDV AND I.MaPTT = CT.MaPTT
END

-- Câu 3
-- 3.1 Liệt kê thông tin các phòng trọ (mã, tên phòng) có giá thuê trên 5,000,000 VNĐ cùng 
-- với thông tin cư dân (mã, họ tên) đã ký hợp đồng thuê các phòng đó trong năm 2024.
SELECT PT.MaPT, PT.TenPT, CD.MaCD, CD.HoTen
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
JOIN CUDAN CD ON CD.MaCD = HD.MaCD
WHERE PT.GiaPT > 5000000
AND YEAR(HD.NgayKy) = 2024

-- 3.2 Liệt kê các dịch vụ (mã, tên dịch vụ) đã được thanh toán trong các phiếu tính tiền của 
-- cả hai tháng 11 và tháng 12 năm 2024 cho hợp đồng có mã ‘HD002’
SELECT DV.MaDV, DV.TenDV
FROM DICHVU DV
JOIN CHITIETTTDV CT ON CT.MaDV = DV.MaDV
JOIN PHIEUTINHTIEN PTT ON PTT.MaPTT = CT.MaPTT
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND MONTH(PTT.NgayTinhTien) = 11 AND YEAR(PTT.NgayTinhTien) = 2024
AND PTT.MaHD = 'HD002'
INTERSECT 
SELECT DV.MaDV, DV.TenDV
FROM DICHVU DV
JOIN CHITIETTTDV CT ON CT.MaDV = DV.MaDV
JOIN PHIEUTINHTIEN PTT ON PTT.MaPTT = CT.MaPTT
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND MONTH(PTT.NgayTinhTien) = 12 AND YEAR(PTT.NgayTinhTien) = 2024
AND PTT.MaHD = 'HD002'

-- 3.3 Tìm thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) trong năm 2024 và 
-- đã sử dụng tất cả các dịch vụ có đơn giá từ 150,000 VNĐ trở xuống.
SELECT PTT.MaPTT, PTT.MaHD
FROM PHIEUTINHTIEN PTT
WHERE YEAR(PTT.NgayTinhTien) = 2024
AND NOT EXISTS (
	SELECT * 
	FROM DICHVU DV
	WHERE DV.DonGia <= 150000
	AND NOT EXISTS (
		SELECT * 
		FROM CHITIETTTDV CT
		WHERE CT.MaDV = DV.MaDV
		AND CT.MaPTT = PTT.MaPTT
	)
)

-- 3.4 Với mỗi hợp đồng, hãy cho biết số lượng phiếu tính tiền đã được thanh toán bằng phương 
-- thức ‘Chuyển khoản’ trong năm 2024. Thông tin hiển thị: Mã hợp đồng, mã cư dân, số lượng. 
SELECT HD.MaHD, HD.MaCD, COUNT(PTT.MaPTT) AS SoLuongPTT
FROM HOPDONG HD
LEFT JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
AND PTT.TinhTrangTT = N'Đã thanh toán'						-- Các điều kiện chọn ở bảng được kết trái 
AND PTT.PhuongThucTT = N'Chuyển khoản'						-- thì để ở trong điều kiện kết của LEFT JOIN
AND YEAR(PTT.NgayTinhTien) = 2024
GROUP BY HD.MaHD, HD.MaCD

-- 3.5 Trong các cư dân có số lần ký hợp đồng nhiều nhất, tìm cư dân (mã, họ tên) có tổng số 
-- tiền đã thanh toán trong năm 2024 nhiều hơn 15,000,000 VNĐ.
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PTT.TinhTrangTT = 'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
AND CD.MaCD IN (
	SELECT TOP 1 WITH TIES HD.MaCD
	FROM HOPDONG HD
	GROUP BY HD.MaCD
	ORDER BY COUNT(HD.MaCD) DESC
)
GROUP BY CD.MaCD, CD.HoTen
HAVING SUM(PTT.TongTienTT) > 15000000

-- ĐỀ 102
-- Câu 1 Tương tự câu 1 đề 101
-- Câu 2
-- 2.1 Giá thuê phòng trọ có giá trị trong khoảng từ 500,000 VNĐ đến 20,000,000 VNĐ.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CHK_PhongTro_Gia CHECK (GiaPT BETWEEN 500000 AND 20000000)

-- 2.2 Trạng thái cư dân chỉ nhận một trong hai giá trị ‘Đang ở’ hoặc ‘Đã rời đi’.
ALTER TABLE CUDAN
ADD CONSTRAINT CHK_CuDan_TrangThai CHECK (TrangThaiCD IN (N'Đang ở', N'Đã rời đi'))
GO

-- 2.3 Số tiền của mỗi dịch vụ đã sử dụng (ThanhTien) trong chi tiết tính tiền được tính bằng 
-- chỉ số đã sử dụng (ChiSoDV) nhân với đơn giá (DonGia) của dịch vụ đó. Hãy viết trigger để 
-- tạo ràng buộc trên cho thao tác sửa một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_ChiTietTTDV_ThanhTien1
ON CHITIETTTDV
FOR UPDATE 
AS
BEGIN
	UPDATE CT
	SET CT.ThanhTien = CT.ChiSoDV * DV.DonGia
	FROM CHITIETTTDV CT
	JOIN DICHVU DV ON DV.MaDV = CT.MaDV
	JOIN inserted I ON I.MaDV = CT.MaDV AND I.MaPTT = CT.MaPTT
END

-- Câu 3
-- 3.1 Liệt kê thông tin các cư dân (mã, họ tên) cùng thông tin phòng trọ (mã, tên phòng) mà 
-- cư dân đó đã ký hợp đồng với trạng thái hợp đồng ‘Đã hết hạn’ trong năm 2024.
SELECT CD.MaCD, CD.HoTen, PT.MaPT, PT.TenPT
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHONGTRO PT ON PT.MaPT = HD.MaPT
WHERE HD.TrangThaiHD = N'Đã hết hạn'
AND YEAR(HD.NgayKy) = 2024

-- 3.2 Tìm các hợp đồng (mã hợp đồng, mã phòng trọ) đã thanh toán các phiếu tính tiền trong 
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
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
AND CT.ChiSoDV >= 5

-- 3.3 Tìm thông tin các dịch vụ (mã, tên dịch vụ) có đơn giá trên 10,000 VNĐ và có trong chi 
-- tiết của tất cả các phiếu tính tiền ngày 15/12/2024.
SELECT DV.MaDV, DV.TenDV
FROM DICHVU DV
WHERE DV.DonGia > 10000
AND NOT EXISTS (
	SELECT * 
	FROM PHIEUTINHTIEN PTT
	WHERE PTT.NgayTinhTien = '2024-12-15'
	AND NOT EXISTS (
		SELECT * 
		FROM CHITIETTTDV CT
		WHERE CT.MaDV = DV.MaDV
		AND CT.MaPTT = PTT.MaPTT
	)
)

-- Câu 3.4 Với mỗi hợp đồng đã hết hạn, hãy cho biết số lượng phiếu tính tiền trong năm 2024 đã 
-- được thanh toán. Thông tin hiển thị: Mã hợp đồng, mã cư dân, số lượng. 
SELECT HD.MaHD, HD.MaCD, COUNT(PTT.MaPTT) AS SoLuongPTT
FROM HOPDONG HD
LEFT JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
AND PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
WHERE HD.TrangThaiHD = N'Đã hết hạn'
GROUP BY HD.MaHD, HD.MaCD

-- Câu 3.5 Trong các cư dân có số lần ký hợp đồng ít nhất, tìm cư dân (mã, họ tên) có tổng số tiền 
-- đã thanh toán trong năm 2024 nhiều hơn 5,000,000 VNĐ.
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND YEAR(PTT.NgayTinhTien) = 2024
AND CD.MaCD IN (
	SELECT TOP 1 WITH TIES HD.MaCD
	FROM HOPDONG HD
	GROUP BY HD.MaCD
	ORDER BY COUNT(HD.MaHD) ASC
)
GROUP BY CD.MaCD, CD.HoTen
HAVING SUM(PTT.TongTienTT) > 5000000

-- ĐỀ 201
-- Câu 1: Tương tự như đề 101 và 102
-- Câu 2
-- 2.1 Đơn giá của các dịch vụ có giá trị từ 2,000 VNĐ đến 500,000 VNĐ.
ALTER TABLE DICHVU
ADD CONSTRAINT CK_DichVu_DonGia CHECK (DonGia BETWEEN 2000 AND 500000)

-- 2.2 Loại phòng trọ chỉ nhận một trong các giá trị ‘Kiot’, ‘Có gác xép’, ‘Không gác xép’.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CK_PhongTro_LoaiPT CHECK (LoaiPT IN (N'Kiot', N'Có gác xép', N'Không gác xép'))
GO

-- 2.3 Số tiền của các dịch vụ đã sử dụng (SoTienDichVu) trong phiếu tính tiền được tính bằng 
-- tổng thành tiền của các chi tiết sử dụng dịch vụ (ThanhTien) của phiếu tính tiền đó. Hãy viết 
-- trigger để tạo ràng buộc trên cho thao tác thêm mới một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_PhieuTT_SoTienDV
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

-- Câu 3
-- 3.1 Liệt kê thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) trong năm 2024 
-- cùng với thông tin chi tiết của dịch vụ (chỉ số, thành tiền) đã sử dụng có tên là ‘Điện’.
SELECT PTT.MaPTT, PTT.MaHD, CT.ChiSoDV, CT.ThanhTien
FROM PHIEUTINHTIEN PTT
JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
JOIN DICHVU DV ON DV.MaDV = CT.MaDV
WHERE YEAR(PTT.NgayTinhTien) = 2024
AND DV.TenDV = N'Điện'

-- 3.2 Tìm các phòng trọ (mã, tên phòng trọ) thuộc loại ‘Không gác xép’ được ký hợp đồng 
-- trong năm 2024 nhưng chưa có phiếu tính tiền nào có tổng tiền thanh toán lớn hơn 4,000,000 
-- VNĐ và thanh toán bằng phương thức ‘Chuyển khoản’.
SELECT PT.MaPT, PT.TenPT
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
WHERE PT.LoaiPT = N'Không gác xép'
AND YEAR(HD.NgayKy) = 2024
EXCEPT
SELECT PT.MaPT, PT.TenPT
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PT.LoaiPT = N'Không gác xép'
AND YEAR(HD.NgayKy) = 2024
AND PTT.TongTienTT > 4000000
AND PTT.PhuongThucTT = N'Chuyển khoản'

-- 3.3 Tìm thông tin cư dân (mã, họ tên) đang ở và đã ký hợp đồng thuê tất cả các phòng trọ 
-- thuộc loại ‘Kiot’ và diện tích bằng 40 m2.
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
WHERE CD.TrangThaiCD = N'Đang ở'
AND NOT EXISTS (
	SELECT *
	FROM PHONGTRO PT
	WHERE PT.LoaiPT = N'Kiot'
	AND PT.DienTich = 40
	AND NOT EXISTS (
		SELECT *
		FROM HOPDONG HD
		WHERE HD.MaPT = PT.MaPT
		AND HD.MaCD = CD.MaCD
	)
)

-- 3.4 Với mỗi cư dân đã rời đi, hãy thống kê số lượng hợp đồng có ngày ký từ năm 2022 đến 
-- năm 2024. Thông tin hiển thị: Mã cư dân, họ tên cư dân, số lượng hợp đồng.
SELECT CD.MaCD, CD.HoTen, COUNT(HD.MaHD)
FROM CUDAN CD
LEFT JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
AND YEAR(HD.NgayKy) BETWEEN 2022 AND 2024
WHERE CD.TrangThaiCD = N'Đã rời đi'
GROUP BY CD.MaCD, CD.HoTen

-- 3.5 Trong các hợp đồng có số lượng phiếu tính tiền đã thanh toán từ 2 trở lên, tìm mã hợp 
-- đồng có tổng chỉ số đã sử dụng của dịch vụ có tên là ‘Điện’ ít nhất.
SELECT TOP 1 WITH TIES PTT.MaHD
FROM PHIEUTINHTIEN PTT
JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
JOIN DICHVU DV ON DV.MaDV = CT.MaDV
WHERE DV.TenDV = N'Điện'
AND PTT.TinhTrangTT = N'Đã thanh toán'
AND PTT.MaHD IN (
	SELECT PTT.MaHD
	FROM PHIEUTINHTIEN PTT
	WHERE PTT.TinhTrangTT = N'Đã thanh toán'
	GROUP BY PTT.MaHD
	HAVING COUNT(PTT.MaPTT) >= 2
)
GROUP BY PTT.MaHD
ORDER BY SUM(CT.ChiSoDV) ASC

-- ĐỀ 202
-- Câu 1: Tương tự như đề 101, 102 và 201
-- Câu 2
-- 2.1 Ngày ký hợp đồng không được lớn hơn ngày hết hạn hợp đồng.
ALTER TABLE HOPDONG
ADD CONSTRAINT CHK_HopDong_NgayKy_NgayHetHan CHECK (NgayKy <= NgayHetHan)

-- 2.2 Tình trạng phòng trọ chỉ nhận một trong hai giá trị ‘Trống’ hoặc ‘Đã cho thuê’.
ALTER TABLE PHONGTRO
ADD CONSTRAINT CHK_PhongTro_TinhTrang CHECK (TinhTrangPT IN (N'Trống', N'Đã cho thuê'))
GO

-- 2.3 Số tiền của các dịch vụ đã sử dụng (SoTienDichVu) trong phiếu tính tiền được tính bằng 
-- tổng thành tiền của các chi tiết sử dụng dịch vụ (ThanhTien) của phiếu tính tiền đó. Hãy viết 
-- trigger để tạo ràng buộc trên cho thao tác xóa một chi tiết sử dụng dịch vụ.
CREATE TRIGGER TRG_PhieuTT_SoTienDV2
ON CHITIETTTDV
FOR DELETE
AS
BEGIN
	UPDATE PTT
	SET PTT.SoTienDichVu = (
		SELECT SUM(CT.ThanhTien)
		FROM CHITIETTTDV CT
		WHERE CT.MaPTT = PTT.MaPTT
	)
	FROM PHIEUTINHTIEN PTT
	JOIN deleted D ON D.MaPTT = PTT.MaPTT
END

-- Câu 3
-- 3.1  Liệt kê thông tin các phòng trọ (mã, tên phòng trọ) có tình trạng ‘Đã cho thuê’ cùng 
-- thông tin phiếu tính tiền (mã phiếu tính tiền, tổng tiền thanh toán) trong năm 2024 của phòng
-- trọ đó.
SELECT PT.MaPT, PT.TenPT, PTT.MaPTT, PTT.TongTienTT
FROM PHONGTRO PT
JOIN HOPDONG HD ON HD.MaPT = PT.MaPT
JOIN PHIEUTINHTIEN PTT ON PTT.MaHD = HD.MaHD
WHERE PT.TinhTrangPT = N'Đã cho thuê'
AND YEAR(PTT.NgayTinhTien) = 2024

-- 3.2 Liệt kê các cư dân (mã, họ tên) đã ký hợp đồng thuê các phòng trọ có diện tích trên 20 
-- m2 thuộc cả hai loại ‘Kiot’ và ‘Có gác xép’ trong năm 2024. 
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHONGTRO PT ON PT.MaPT = HD.MaPT
WHERE YEAR(HD.NgayKy) = 2024
AND PT.DienTich > 20
AND PT.LoaiPT = N'Kiot'
INTERSECT 
SELECT CD.MaCD, CD.HoTen
FROM CUDAN CD
JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
JOIN PHONGTRO PT ON PT.MaPT = HD.MaPT
WHERE YEAR(HD.NgayKy) = 2024
AND PT.DienTich > 20
AND PT.LoaiPT = N'Có gác xép'

-- 3.3 Tìm thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) có tổng tiền thanh 
-- toán trên 2,000,000 VNĐ, thanh toán bằng phương thức ‘Tiền mặt’ và đã sử dụng tất cả các 
-- dịch vụ có đơn giá từ 50,000 trở xuống. 
SELECT PTT.MaPTT, PTT.MaHD
FROM PHIEUTINHTIEN PTT
WHERE PTT.TongTienTT > 2000000
AND PTT.PhuongThucTT = N'Tiền mặt'
AND NOT EXISTS (
	SELECT * 
	FROM DICHVU DV
	WHERE DV.DonGia <= 50000
	AND NOT EXISTS (
		SELECT *
		FROM CHITIETTTDV CT
		WHERE CT.MaDV = DV.MaDV
		AND CT.MaPTT = PTT.MaPTT
	)
)

-- 3.4 Với mỗi cư dân đang ở, hãy thống kê số lượng hợp đồng có trạng thái hợp đồng ‘Đã hết 
-- hạn’ và có ngày hết hạn trong năm 2024. Thông tin hiển thị: Mã cư dân, họ tên cư dân, số 
-- lượng hợp đồng.
SELECT CD.MaCD, CD.HoTen, COUNT(HD.MaHD) AS SoLuongHD
FROM CUDAN CD
LEFT JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
AND HD.TrangThaiHD = N'Đã hết hạn'
AND YEAR(HD.NgayHetHan) = 2024
WHERE CD.TrangThaiCD = N'Đang ở'
GROUP BY CD.MaCD, CD.HoTen

SELECT CD.MaCD, CD.HoTen, COUNT(HD.MaHD) AS SoLuongHD
FROM CUDAN CD
LEFT JOIN HOPDONG HD ON HD.MaCD = CD.MaCD
WHERE CD.TrangThaiCD = N'Đang ở'
AND HD.TrangThaiHD = N'Đã hết hạn'
AND YEAR(HD.NgayHetHan) = 2024
GROUP BY CD.MaCD, CD.HoTen

-- 3.5 Trong các hợp đồng có tổng chỉ số đã sử dụng của dịch vụ có tên là ‘Điện’ ít nhất, tìm 
-- mã hợp đồng có số lượng phiếu tính tiền đã thanh toán từ 2 trở lên.
SELECT PTT.MaHD
FROM PHIEUTINHTIEN PTT
WHERE PTT.TinhTrangTT = N'Đã thanh toán'
AND PTT.MaHD IN (
	SELECT TOP 1 WITH TIES PTT.MaHD
	FROM PHIEUTINHTIEN PTT 
	JOIN CHITIETTTDV CT ON CT.MaPTT = PTT.MaPTT
	JOIN DICHVU DV ON DV.MaDV = CT.MaDV
	WHERE DV.TenDV = N'Điện'
	AND PTT.TinhTrangTT = N'Đã thanh toán'
	GROUP BY PTT.MaHD
	ORDER BY SUM(CT.ChiSoDV) ASC
)
GROUP BY PTT.MaHD
HAVING COUNT(PTT.MaPTT) >= 2


-- ĐỀ 301
-- Câu 1
CREATE DATABASE QLKB
GO

CREATE TABLE BENHNHAN
(
	MaBN CHAR(5) PRIMARY KEY,
	HoTenBN NVARCHAR(50),
	NgaySinh SMALLDATETIME,
	CCCD NVARCHAR(12),
	SoBHYT NVARCHAR(15),
	BHYTChiTra FLOAT,
	DiaChi NVARCHAR(100)
)

CREATE TABLE BACSI
(
	MaBS CHAR(5) PRIMARY KEY,
	HoTenBS NVARCHAR(50),
	NgayBDLV SMALLDATETIME,
	ChuyenKhoa NVARCHAR(50)
)

CREATE TABLE KHAMBENH
(
	MaKB CHAR(5) PRIMARY KEY,
	MaBN CHAR(5),
	MaBS CHAR(5),
	NgayKham SMALLDATETIME,
	TrieuChung NVARCHAR(255),
	KetLuan NVARCHAR(255),
	TaiKham INT,
	CONSTRAINT FK_KhamBenh_BenhNhan FOREIGN KEY (MaBN) REFERENCES BENHNHAN(MaBN),
	CONSTRAINT FK_KhamBenh_BacSi FOREIGN KEY (MaBS) REFERENCES BACSI(MaBS)
)

CREATE TABLE THUOC 
(
	MaThuoc CHAR(5) PRIMARY KEY,
	TenThuoc NVARCHAR(50),
	LoaiThuoc NVARCHAR(50),
	DVT NVARCHAR(20),
	DonGia MONEY
)

CREATE TABLE DONTHUOC 
(
	MaDT CHAR(5) PRIMARY KEY,
	MaKB CHAR(5),
	TriGiaDT MONEY,
	BHYTChiTra FLOAT,
	NgayCapThuoc SMALLDATETIME,
	TongTienTT MONEY,
	TinhTrangDT NVARCHAR(30),
	CONSTRAINT FK_DonThuoc_KhamBenh FOREIGN KEY (MaKB) REFERENCES KHAMBENH(MaKB)
)	

CREATE TABLE CHITIETDT
(
	MaDT CHAR(5),
	MaThuoc CHAR(5),
	SoLuong INT,
	ThanhTien MONEY,
	CONSTRAINT PK_ChiTietDT PRIMARY KEY (MaDT, MaThuoc),
	CONSTRAINT FK_ChiTietDT_DonThuoc FOREIGN KEY (MaDT) REFERENCES DONTHUOC(MaDT),
	CONSTRAINT FK_ChiTietDT_Thuoc FOREIGN KEY (MaThuoc) REFERENCES THUOC(MaThuoc)
)

-- Câu 2
-- 2.1 Tỷ lệ chi phí do bảo hiểm y tế chi trả của mỗi bệnh nhân có giá trị từ 0 đến 0.7.
ALTER TABLE BENHNHAN
ADD CONSTRAINT CHK_BenhNhan_BHYTChiTra CHECK (BHYTChiTra BETWEEN 0 AND 0.7)

-- 2.2 Tình trạng thanh toán của đơn thuốc chỉ nhận một trong hai giá trị ‘Chưa thanh toán’ 
-- hoặc ‘Đã thanh toán’.
ALTER TABLE DONTHUOC
ADD CONSTRAINT CHK_DonThuoc_TinhTrangDT CHECK (TinhTrangDT IN (N'Chưa thanh toán', N'Đã thanh toán'))
GO

-- 2.3 Trị giá của đơn thuốc (TriGiaDT) được tính bằng tổng thành tiền (ThanhTien) của các 
-- chi tiết thuộc đơn thuốc đó. Hãy viết trigger để tạo ràng buộc trên cho thao tác thêm mới một 
-- chi tiết đơn thuốc.
CREATE TRIGGER TRG_DonThuoc_TriGiaDT
ON CHITIETDT
FOR INSERT
AS
BEGIN
	UPDATE DT
	SET TriGiaDT = (
		SELECT SUM(CT.ThanhTien)
		FROM CHITIETDT CT
		WHERE CT.MaDT = DT.MaDT
	)
	FROM DONTHUOC DT
	JOIN inserted I ON I.MaDT = DT.MaDT
END

-- Câu 3:
-- 3.1 Liệt kê thông tin các bác sĩ (mã, họ tên) thuộc chuyên khoa ‘Tai mũi họng’ cùng với 
-- thông tin các bệnh nhân (mã, họ tên) mà bác sĩ đó khám bệnh trong năm 2024.
SELECT BS.MaBS, BS.HoTenBS, BN.MaBN, BN.HoTenBN
FROM BACSI BS
JOIN KHAMBENH KB ON KB.MaBS = BS.MaBS
JOIN BENHNHAN BN ON BN.MaBN = KB.MaBN
WHERE BS.ChuyenKhoa = N'Tai mũi họng'
AND YEAR(KB.NgayKham) = 2024

-- 3.2 Liệt kê các bệnh nhân (mã, họ tên) đã được khám bệnh trong năm 2024 nhưng không 
-- có đơn thuốc nào đã thanh toán có tổng tiền thanh toán từ 100,000 VNĐ trở lên.
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
WHERE YEAR(KB.NgayKham) = 2024
EXCEPT 
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
JOIN DONTHUOC DT ON DT.MaKB = KB.MaKB
WHERE YEAR(KB.NgayKham) = 2024
AND DT.TinhTrangDT = N'Đã thanh toán'
AND DT.TongTienTT >= 100000

-- 3.3 Tìm thông tin các đơn thuốc (mã đơn thuốc, mã khám bệnh) cấp trong năm 2024 đã 
-- được thanh toán và trong chi tiết đơn thuốc có tất cả các thuốc thuộc loại ‘Thuốc dị ứng’
SELECT DT.MaDT, DT.MaKB
FROM DONTHUOC DT
WHERE YEAR(DT.NgayCapThuoc) = 2024
AND DT.TinhTrangDT = N'Đã thanh toán'
AND NOT EXISTS (
	SELECT * 
	FROM THUOC T
	WHERE T.LoaiThuoc = N'Thuốc dị ứng'
	AND NOT EXISTS (
		SELECT * 
		FROM CHITIETDT CT
		WHERE CT.MaThuoc = T.MaThuoc
		AND CT.MaDT = DT.MaDT
	)
)

-- 3.4 Với mỗi bệnh nhân không có thẻ bảo hiểm y tế, hãy cho biết số lượng đơn thuốc cấp 
-- trong năm 2024 đã được thanh toán. Thông tin hiển thị: Mã bệnh nhân, họ tên bệnh nhân, số 
-- lượng.
SELECT BN.MaBN, BN.HoTenBN, COUNT(DT.MaDT) AS SoLuongDT
FROM BENHNHAN BN
LEFT JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
LEFT JOIN DONTHUOC DT ON DT.MaKB = KB.MaKB
AND YEAR(DT.NgayCapThuoc) = 2024 
AND DT.TinhTrangDT = N'Đã thanh toán'
WHERE BN.SoBHYT IS NULL
GROUP BY BN.MaBN, BN.HoTenBN

-- 3.5 Trong các bệnh nhân có số lần khám bệnh ít nhất, tìm bệnh nhân (mã, họ tên) có tổng 
-- số tiền đã thanh toán cho các đơn thuốc cấp trong năm 2024 ít hơn 100,000 VNĐ.
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
LEFT JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
LEFT JOIN DONTHUOC DT ON DT.MaKB = KB.MaKB
AND DT.TinhTrangDT = N'Đã thanh toán'
AND YEAR(DT.NgayCapThuoc) = 2024
WHERE BN.MaBN IN (
	SELECT TOP 1 WITH TIES BN.MaBN
	FROM BENHNHAN BN
	LEFT JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
	GROUP BY BN.MaBN
	ORDER BY COUNT(KB.MaKB) ASC
)
GROUP BY BN.MaBN, BN.HoTenBN
HAVING ISNULL(SUM(DT.TongTienTT), 0) < 100000

-- ĐỀ 302
