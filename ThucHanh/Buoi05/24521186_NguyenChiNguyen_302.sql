-- Họ tên: Nguyễn Chí Nguyên
-- MSSV: 24521186
-- Lớp: IT004.Q18.1

-- MÃ ĐỀ: 302
-- CÂU 1: Tạo cơ sở dữ liệu tên “QLKB” bao gồm các quan hệ như bảng thuộc tính trên. Khai báo khóa 
-- chính, khóa ngoại.
CREATE DATABASE QLKB

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
	TaiKham INT

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
	TinhTrangDT NVARCHAR(30)

	CONSTRAINT FK_DonThuoc_KhamBenh FOREIGN KEY (MaKB) REFERENCES KHAMBENH(MaKB)
)	

CREATE TABLE CHITIETDT
(
	MaDT CHAR(5),
	MaThuoc CHAR(5),
	SoLuong INT,
	ThanhTien MONEY

	CONSTRAINT PK_ChiTietDT PRIMARY KEY (MaDT, MaThuoc),
	CONSTRAINT FK_ChiTietDT_DonThuoc FOREIGN KEY (MaDT) REFERENCES DONTHUOC(MaDT),
	CONSTRAINT FK_ChiTietDT_Thuoc FOREIGN KEY (MaThuoc) REFERENCES THUOC(MaThuoc)
)

-- CÂU 2
-- Câu 2.1: Thời gian tái khám của khám bệnh có giá trị từ 0 đến 365 ngày.
ALTER TABLE KHAMBENH
ADD CONSTRAINT CHK_KhamBenh_TaiKham CHECK (TaiKham BETWEEN 0 AND 365)

-- Câu 2.2: Đơn vị tính của thuốc chỉ nhận một trong các giá trị ‘viên’, ‘hộp’, ‘lọ’, ‘vỉ’.
ALTER TABLE THUOC
ADD CONSTRAINT CHK_Thuoc_Dvt CHECK (DVT IN(N'viên', N'hộp', N'lọ', N'vỉ'))
GO

-- Câu 2.3: Trị giá của đơn thuốc (TriGiaDT) được tính bằng tổng thành tiền (ThanhTien) của các 
-- chi tiết thuộc đơn thuốc đó. Hãy viết trigger để tạo ràng buộc trên cho thao tác xóa một chi 
-- tiết đơn thuốc.
CREATE TRIGGER TRG_DonThuoc_ChiTietDT_TriGiaDT_ThanhTien
ON CHITIETDT
FOR DELETE
AS
BEGIN
	UPDATE DT
	SET DT.TriGiaDT = (
		SELECT SUM(CT.ThanhTien)
		FROM CHITIETDT CT
		WHERE CT.MaDT = DT.MaDT
	)
	FROM DONTHUOC DT
	JOIN deleted D ON D.MaDT = DT.MaDT
END

-- CÂU 3
-- Câu 3.1: Liệt kê thông tin các bệnh nhân (mã, họ tên) có địa chỉ ở ‘Tp.HCM’ cùng thông tin đơn 
-- thuốc (mã đơn thuốc, tổng tiền thanh toán) cấp trong năm 2024 của bệnh nhân đó.
SELECT BN.MaBN, BN.HoTenBN, DT.MaDT, DT.TongTienTT
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
JOIN DONTHUOC DT ON DT.MaKB = KB.MaKB
WHERE BN.DiaChi = N'Tp.HCM'
AND YEAR(DT.NgayCapThuoc) = 2024

-- Câu 3.2: Liệt kê các bệnh nhân (mã, họ tên) có tỷ lệ chi phí do bảo hiểm y tế chi trả từ 0.1 trở lên 
-- và được khám bởi bác sĩ thuộc cả hai chuyên khoa ‘Nội khoa’ và ‘Tai mũi họng’ trong năm 
-- 2024.
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
JOIN BACSI BS ON BS.MaBS = KB.MaBS
WHERE BN.BHYTChiTra >= 0.1
AND BS.ChuyenKhoa = N'Nội khoa'
AND YEAR(KB.NgayKham) = 2024
INTERSECT
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
JOIN BACSI BS ON BS.MaBS = KB.MaBS
WHERE BN.BHYTChiTra >= 0.1
AND BS.ChuyenKhoa = N'Tai mũi họng'
AND YEAR(KB.NgayKham) = 2024

-- Câu 3.3: Tìm thông tin các thuốc (mã, tên thuốc) thuộc loại ‘Thuốc giảm đau’ có trong chi tiết 
-- của tất cả các đơn thuốc cấp vào ngày 01/12/2024 và đã được thanh toán.
SELECT T.MaThuoc, T.TenThuoc
FROM THUOC T
WHERE T.LoaiThuoc = N'Thuốc giảm đau'
AND NOT EXISTS (
	SELECT 1
	FROM DONTHUOC DT
	WHERE DT.NgayCapThuoc = '2024-12-01'
	AND DT.TinhTrangDT = N'Đã thanh toán'
	AND NOT EXISTS (
		SELECT 1
		FROM CHITIETDT CT
		WHERE CT.MaDT = DT.MaDT
		AND CT.MaThuoc = T.MaThuoc
	)
)

-- Câu 3.4: Với mỗi bác sĩ, hãy cho biết số lượt bệnh nhân có thẻ bảo hiểm y tế mà bác sĩ đó đã 
-- khám trong năm 2024. Thông tin hiển thị: Mã bác sĩ, họ tên bác sĩ, số lượt.
SELECT BS.MaBS, BS.HoTenBS, COUNT(BN.MaBN) AS SoLuotBNBHYT
FROM BACSI BS
JOIN KHAMBENH KB ON KB.MaBS = BS.MaBS
JOIN BENHNHAN BN ON BN.MaBN = KB.MaBN
WHERE YEAR(KB.NgayKham) = 2024
AND BN.SoBHYT IS NOT NULL
GROUP BY BS.MaBS, BS.HoTenBS

-- Câu 3.5: Trong các bệnh nhân có số lần khám bệnh nhiều nhất, tìm bệnh nhân (mã, họ tên) có 
-- tổng số tiền đã thanh toán cho các đơn thuốc cấp trong năm 2024 nhiều hơn 250,000 VNĐ.
SELECT BN.MaBN, BN.HoTenBN
FROM BENHNHAN BN
JOIN KHAMBENH KB ON KB.MaBN = BN.MaBN
JOIN DONTHUOC DT ON DT.MaKB = KB.MaKB
WHERE DT.TinhTrangDT = N'Đã thanh toán'
AND YEAR(DT.NgayCapThuoc) = 2024
AND BN.MaBN IN (
	SELECT TOP 1 WITH TIES BN2.MaBN
	FROM BENHNHAN BN2
	JOIN KHAMBENH KB2 ON KB2.MaBN = BN2.MaBN
	GROUP BY BN2.MaBN
	ORDER BY COUNT(KB2.MaKB) DESC
)
GROUP BY BN.MaBN, BN.HoTenBN
HAVING SUM(DT.TongTienTT) > 250000