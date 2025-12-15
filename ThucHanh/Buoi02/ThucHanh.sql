-- Ho va ten: Nguyen Chi Nguyen
-- MSSV: 24521186
-- THUC HANH LAB 2

-- =====QUAN LY BAN HANG=====
-- === BAI TAP 1 - 3 -  5 LAB 2 ===

-- --> BAI TAP 1 <---
-- Phan II cau 1
USE QLBANHANG
GO

INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGAYDK)
VALUES
('KH01', N'Nguyen Van A', N'731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22', 13060000, '2006-07-22'),
('KH02', N'Tran Ngoc Han', N'23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', 280000, '2006-07-30'),
('KH03', N'Tran Ngoc Linh', N'45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-06-12', 3860000, '2006-08-05'),
('KH04', N'Tran Minh Long', N'50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '1965-09-03', 250000, '2006-10-02'),
('KH05', N'Le Nhat Minh', N'34 Truong Dinh, Q3, TpHCM', '08246108', '1950-03-10', 210000, '2006-10-28'),
('KH06', N'Le Hoai Thuong', N'227 Nguyen Van Cu, Q5, TpHCM', '08631738', '1981-12-31', 915000, '2006-11-24'),
('KH07', N'Nguyen Van Tam', N'32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-04-06', 12500, '2006-12-01'),
('KH08', N'Phan Thi Thanh', N'45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-10-01', 365000, '2006-12-13'),
('KH09', N'Le Ha Vinh', N'873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-03-09', 70000, '2007-01-14'),
('KH10', N'Ha Duy Lap', N'34/34B Nguyen Trai, Q1, TpHCM', '08768904', '1983-05-02', 67500, '2007-01-16');

INSERT INTO NHANVIEN (MANV, HOTEN, SODT, NGVL)
VALUES
('NV01', N'Nguyen Nhu Nhut', '0927345678', '2006-04-13'),
('NV02', N'Le Thi Phi Yen', '0987567390', '2006-04-21'),
('NV03', N'Nguyen Van B', '0997047382', '2006-04-27'),
('NV04', N'Ngo Thanh Tuan', '0913758498', '2006-06-24'),
('NV05', N'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');

INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
('BC01', N'But chi', N'cay', N'Singapore', 3000),
('BC02', N'But chi', N'cay', N'Singapore', 5000),
('BC03', N'But chi', N'cay', N'Viet Nam', 3500),
('BC04', N'But chi', N'hop', N'Viet Nam', 30000),
('BB01', N'But bi', N'cay', N'Viet Nam', 5000),
('BB02', N'But bi', N'cay', N'Trung Quoc', 7000),
('BB03', N'But bi', N'hop', N'Thai Lan', 100000),
('TV01', N'Tap 100 giay mong', N'quyen', N'Trung Quoc', 2500),
('TV02', N'Tap 200 giay mong', N'quyen', N'Trung Quoc', 4500),
('TV03', N'Tap 100 giay tot', N'quyen', N'Viet Nam', 3000),
('TV04', N'Tap 200 giay tot', N'quyen', N'Viet Nam', 5500),
('TV05', N'Tap 100 trang', N'chuc', N'Viet Nam', 23000),
('TV06', N'Tap 200 trang', N'chuc', N'Viet Nam', 53000),
('TV07', N'Tap 100 trang', N'chuc', N'Trung Quoc', 34000),
('ST01', N'So tay 500 trang', N'quyen', N'Trung Quoc', 40000),
('ST02', N'So tay loai 1', N'quyen', N'Viet Nam', 55000),
('ST03', N'So tay loai 2', N'quyen', N'Viet Nam', 51000),
('ST04', N'So tay', N'quyen', N'Thai Lan', 55000),
('ST05', N'So tay mong', N'quyen', N'Thai Lan', 20000),
('ST06', N'Phan viet bang', N'hop', N'Viet Nam', 5000),
('ST07', N'Phan khong bui', N'hop', N'Viet Nam', 7000),
('ST08', N'Bong bang', N'cai', N'Viet Nam', 7000),
('ST09', N'But long', N'cay', N'Viet Nam', 5000),
('ST10', N'But long', N'cay', N'Trung Quoc', 7000);

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
(1001, '2006-07-23', 'KH01', 'NV01', 320000),
(1002, '2006-08-12', 'KH01', 'NV02', 840000),
(1003, '2006-08-23', 'KH02', 'NV01', 100000),
(1004, '2006-09-01', 'KH02', 'NV01', 180000),
(1005, '2006-10-20', 'KH01', 'NV02', 3800000),
(1006, '2006-10-16', 'KH01', 'NV03', 2430000),
(1007, '2006-10-28', 'KH03', 'NV03', 510000),
(1008, '2006-10-28', 'KH01', 'NV03', 440000),
(1009, '2006-10-28', 'KH03', 'NV04', 200000),
(1010, '2006-11-01', 'KH01', 'NV01', 5200000),
(1011, '2006-11-04', 'KH04', 'NV03', 250000),
(1012, '2006-11-30', 'KH05', 'NV03', 21000),
(1013, '2006-12-12', 'KH06', 'NV01', 5000),
(1014, '2006-12-31', 'KH03', 'NV02', 3150000),
(1015, '2007-01-01', 'KH06', 'NV01', 910000),
(1016, '2007-01-01', 'KH07', 'NV02', 12500),
(1017, '2007-01-02', 'KH08', 'NV03', 35000),
(1018, '2007-01-13', 'KH03', 'NV03', 330000),
(1019, '2007-01-13', 'KH01', 'NV03', 30000),
(1020, '2007-01-14', 'KH09', 'NV04', 70000),
(1021, '2007-01-16', 'KH10', 'NV04', 67500),
(1022, '2007-01-16', NULL, 'NV01', 7000),
(1023, '2007-01-17', NULL, 'NV01', 330000);

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
(1001,'TV02',10),
(1001,'ST01',5),
(1001,'BC01',5),
(1001,'BC02',10),
(1001,'ST08',10),
(1002,'BC04',20),
(1002,'BB01',20),
(1002,'BB02',20),
(1003,'BB03',10),
(1004,'TV01',20),
(1004,'TV02',10),
(1004,'TV03',10),
(1004,'TV04',10),
(1005,'TV05',50),
(1005,'TV06',50),
(1006,'TV07',20),
(1006,'ST01',30),
(1006,'ST02',10),
(1007,'ST03',10),
(1008,'ST04',8),
(1009,'ST05',10),
(1010,'TV07',50),
(1010,'ST07',50),
(1010,'ST08',100),
(1010,'ST04',50),
(1010,'TV03',100),
(1011,'ST06',50),
(1012,'ST07',3),
(1013,'ST08',5),
(1014,'BC02',80),
(1014,'BB02',100),
(1014,'BC04',60),
(1014,'BB01',50),
(1015,'BB02',30),
(1015,'BB03',7),
(1016,'TV01',5),
(1017,'TV02',1),
(1017,'TV03',1),
(1017,'TV04',5),
(1018,'ST04',6),
(1019,'ST05',1),
(1019,'ST06',2),
(1020,'ST07',10),
(1021,'ST08',5),
(1021,'TV01',7),
(1021,'TV02',10),
(1022,'ST07',1),
(1023,'ST04',6);

-- --> BAI TAP 3 <--
-- Phan II cau 2
SELECT * INTO SANPHAM1 FROM SANPHAM;
SELECT * INTO KHACHHANG1 FROM KHACHHANG;

-- Phan II cau 3
UPDATE SANPHAM1
SET GIA = 1.05 * GIA
WHERE NUOCSX = 'Thai Lan';

-- Phan II cau 4
UPDATE SANPHAM1
SET GIA = 0.95 * GIA
WHERE NUOCSX = 'Trung Quoc' AND GIA < 10000;

-- Phan II cau 5
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGAYDK < '2007-1-1' AND DOANHSO >= 10000000) OR (NGAYDK >= '2007-1-1' AND DOANHSO >= 2000000);

-- --> BAI TAP 5 <--
-- Phan III cau 1
SELECT MASP, TENSP
FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc';


-- Phan III cau 2
SELECT MASP, TENSP
FROM SANPHAM 
WHERE (DVT = 'cay') OR (DVT = 'quyen');

-- Phan III cau 3
SELECT MASP, TENSP
FROM SANPHAM
WHERE (MASP LIKE 'B%01');

-- Phan III cau 4
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND (GIA BETWEEN 30000 AND 40000);

-- Phan III cau 5
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc' OR NUOCSX = 'Thai Lan') AND (GIA BETWEEN 30000 AND 40000);

-- Phan III cau 6
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD IN ('2007-1-1', '2007-1-2');

-- Phan III cau 7
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007
ORDER BY HOADON.NGHD ASC, HOADON.TRIGIA DESC;

-- Phan III cau 8
SELECT DISTINCT KHACHHANG.MAKH, KHACHHANG.HOTEN
FROM KHACHHANG
JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
WHERE NGHD = '2007-1-1';

-- Phan III cau 9
SELECT DISTINCT HOADON.SOHD, HOADON.TRIGIA
FROM HOADON
JOIN NHANVIEN ON HOADON.MANV = NHANVIEN.MANV
WHERE NHANVIEN.HOTEN = 'Nguyen Van B' AND HOADON.NGHD = '2006-10-28';

-- Phan III cau 10
SELECT DISTINCT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM 
JOIN CTHD ON SANPHAM.MASP = CTHD.MASP
JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE KHACHHANG.HOTEN = 'Nguyen Van A' AND MONTH(HOADON.NGHD) = 10 AND YEAR(HOADON.NGHD) = 2006;

-- Phan III cau 11
SELECT DISTINCT SOHD
FROM CTHD
WHERE MASP IN ('BB01', 'BB02');

--============================================================================--
--============================================================================--
--============================================================================--

-- =====QUAN LY GIAO VU=====
-- === BAI TAP 2 - 4 - 6 LAB 2 ===
USE QUANLYGIAOVU
GO

-- --> BAI TAP 2 <--
-- Nhap du lieu cho CSDL Quan ly giao vu

-- Bo qua viec kiem tra khoa ngoai
ALTER TABLE GIAOVIEN NOCHECK CONSTRAINT ALL;
ALTER TABLE KHOA NOCHECK CONSTRAINT ALL;
ALTER TABLE LOP NOCHECK CONSTRAINT ALL;
ALTER TABLE HOCVIEN NOCHECK CONSTRAINT ALL;
ALTER TABLE KETQUATHI NOCHECK CONSTRAINT ALL;
ALTER TABLE GIANGDAY NOCHECK CONSTRAINT ALL;
ALTER TABLE DIEUKIEN NOCHECK CONSTRAINT ALL;
ALTER TABLE MONHOC NOCHECK CONSTRAINT ALL;

DELETE FROM KHOA;
DELETE FROM LOP;
DELETE FROM	MONHOC;
DELETE FROM DIEUKIEN;
DELETE FROM GIAOVIEN;
DELETE FROM GIANGDAY;
DELETE FROM KETQUATHI;
DELETE FROM HOCVIEN;
-- Bat lai viec kiem tra cac khoa chinh
ALTER TABLE GIAOVIEN CHECK CONSTRAINT ALL;
ALTER TABLE KHOA CHECK CONSTRAINT ALL;
ALTER TABLE LOP CHECK CONSTRAINT ALL;
ALTER TABLE HOCVIEN CHECK CONSTRAINT ALL;
ALTER TABLE KETQUATHI CHECK CONSTRAINT ALL;
ALTER TABLE GIANGDAY CHECK CONSTRAINT ALL;
ALTER TABLE DIEUKIEN CHECK CONSTRAINT ALL;
ALTER TABLE MONHOC CHECK CONSTRAINT ALL;


INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES 
('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'),
('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
('MTT',  'Mang va truyen thong', '2005-10-20', 'GV03'),
('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);

INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES 
('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');

INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDL GT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PMTT', 'Phan mem thiet ke thuat toan', 3, 0, 'KHMT'),
('DHTH', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCS DL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTK HTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 1, 'KTMT'),
('NMCN PM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');

INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES 
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');

INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGLV, HESO, MUCLUONG, MAKHOA)
VALUES
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-1-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-12-22', '2005-01-12', 4.50, 2025000, 'KTTT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-12-03', '2005-1-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'ThS', 'GV', 'Nam', '1953-11-13', '2005-1-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Mien Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-11-30', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-12-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1955-04-12', '2005-5-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-09-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Dinh Can', 'ThS', NULL, 'Nam', '1950-08-28', '2005-05-15', 1.69, 760500, 'KTTT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nam', '1979-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-04-15', '2005-05-15', 3.00, 1350000, 'KHMT');

INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES
('K11', 'THDC', 'GV07', 1, 2006, '2006-02-01', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-02-01', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-02-01', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-09-01', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-09-01', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-09-01', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-02-01', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-02-01', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');

INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES
('K1101', 'CSDL', 1, '2006-07-20', 10.00, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),

('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),

('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),

('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dat');

INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) 
VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-08-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-04-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich', 'Thuy', '1986-08-02', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-08-04', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Phan Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-09-03', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '1986-12-03', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nga', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-08-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');

-- --> BAI TAP 4: Sinh viên hoàn thành Phần I bài tập QuanLyGiaoVu từ câu 11 đến câu 14 <--

ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_TUOIHV CHECK (YEAR(NGSINH) + 18 < GETDATE());

-- Phan I cau 12: Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_NGGIANGDAY CHECK (TUNGAY < DENNGAY);

-- Phan I cau 13: Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_TUOIGV CHECK (YEAR(NGLV) - YEAR(NGSINH) >= 22);

-- Phan I cau 14: Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3. 
ALTER TABLE MONHOC
ADD CONSTRAINT CHK_CHENHLECHTC CHECK (ABS(TCLT - TCTH) <= 3);

-- --> BAI TAP 6: Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 1 đến câu 5. <--
-- Phan III cau 1
SELECT HV.MAHV, HV.HO, HV.TEN, HV.NGSINH, HV.MALOP
FROM HOCVIEN HV
JOIN LOP ON HV.MAHV = LOP.TRGLOP;

-- Phan III cau 2
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, KETQUATHI.LANTHI, KETQUATHI.DIEM
FROM KETQUATHI
JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE KETQUATHI.MAMH = 'CTRR' AND HOCVIEN.MALOP = 'K12'
ORDER BY HOCVIEN.TEN ASC, HOCVIEN.HO ASC;

-- Phan III cau 3
SELECT * from KETQUATHI;

