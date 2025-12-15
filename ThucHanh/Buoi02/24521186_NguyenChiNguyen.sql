-- HỌ TÊN: NGUYỄN CHÍ NGUYÊN 
-- MSSV: 24521186 
-- LAB: 02

-- BAI TAP 2: VIẾT CÁC CÂU LỆNH NHẬP DỮ LIỆU CHO CSDL QUANLYGIAOVU
-- 1. Thêm dữ liệu cho bảng KHOA. Hiện tại chưa có dữ liệu về giáo viên nên trưởng khoa để NULL.
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) 
VALUES
('KHMT', 'Khoa hoc may tinh', '2005-06-07', NULL),
('HTTT', 'He thong thong tin', '2005-06-07', NULL),
('CNPM', 'Cong nghe phan mem', '2005-06-07', NULL),
('MTT', 'Mang va truyen thong', '2005-10-20', NULL),
('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);

-- 2. Thêm dữ liệu cho bảng GIAOVIEN
INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGLV, HESO, MUCLUONG, MAKHOA) 
VALUES
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');

-- 3. Thêm dữ liệu cho bảng MONHOC
INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) 
VALUES
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 1, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');

-- 4. Thêm dữ liệu cho bảng DIEUKIEN
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

-- 5. Thêm dữ liệu cho bảng LOP. Hiện tại chưa có dữ liệu về học viên nên trưởng lớp để NULL.
INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) 
VALUES
('K11', 'Lop 1 khoa 1', NULL, 11, 'GV07'),
('K12', 'Lop 2 khoa 1', NULL, 12, 'GV09'),
('K13', 'Lop 3 khoa 1', NULL, 12, 'GV14');


-- 6. Thêm dữ liệu cho bảng HOCVIEN
INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) 
VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
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
('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');

-- 7. Thêm dữ liệu cho bảng GIANGDAY
INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) 
VALUES
('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');

-- 8. Thêm dữ liệu cho bảng KETQUATHI
INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM) 
VALUES
('K1101', 'CSDL', 1, '2006-07-20', 10.00),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00),
('K1101', 'THDC', 1, '2006-05-20', 9.00),
('K1101', 'CTRR', 1, '2006-05-13', 9.50),
('K1102', 'CSDL', 1, '2006-07-20', 4.00),
('K1102', 'CSDL', 2, '2006-07-27', 4.25),
('K1102', 'CSDL', 3, '2006-08-10', 4.50),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.50),
('K1102', 'CTDLGT', 2, '2007-01-05', 4.00),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00),
('K1102', 'THDC', 1, '2006-05-20', 5.00),
('K1102', 'CTRR', 1, '2006-05-13', 7.00),
('K1103', 'CSDL', 1, '2006-07-20', 3.50),
('K1103', 'CSDL', 2, '2006-07-27', 8.25),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00),
('K1103', 'THDC', 1, '2006-05-20', 8.00),
('K1103', 'CTRR', 1, '2006-05-13', 6.50),
('K1104', 'CSDL', 1, '2006-07-20', 3.75),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00),
('K1104', 'THDC', 1, '2006-05-20', 4.00),
('K1104', 'CTRR', 1, '2006-05-13', 4.00),
('K1104', 'CTRR', 2, '2006-05-20', 3.50),
('K1104', 'CTRR', 3, '2006-06-30', 4.00),
('K1201', 'CSDL', 1, '2006-07-20', 6.00),
('K1201', 'CTDLGT', 1, '2006-12-28', 5.00),
('K1201', 'THDC', 1, '2006-05-20', 8.50),
('K1201', 'CTRR', 1, '2006-05-13', 9.00),
('K1202', 'CSDL', 1, '2006-07-20', 8.00),
('K1202', 'CTDLGT', 1, '2006-12-28', 4.00),
('K1202', 'CTDLGT', 2, '2007-01-05', 5.00),
('K1202', 'THDC', 1, '2006-05-20', 4.00),
('K1202', 'THDC', 2, '2006-05-27', 4.00),
('K1202', 'CTRR', 1, '2006-05-13', 3.00),
('K1202', 'CTRR', 2, '2006-05-20', 4.00),
('K1202', 'CTRR', 3, '2006-06-30', 6.25),
('K1203', 'CSDL', 1, '2006-07-20', 9.25),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.50),
('K1203', 'THDC', 1, '2006-05-20', 10.00),
('K1203', 'CTRR', 1, '2006-05-13', 10.00),
('K1204', 'CSDL', 1, '2006-07-20', 8.50),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75),
('K1204', 'THDC', 1, '2006-05-20', 4.00),
('K1204', 'CTRR', 1, '2006-05-13', 6.00),
('K1301', 'CSDL', 1, '2006-12-20', 4.25),
('K1301', 'CTDLGT', 1, '2006-07-25', 8.00),
('K1301', 'THDC', 1, '2006-05-20', 7.75),
('K1301', 'CTRR', 1, '2006-05-13', 8.00),
('K1302', 'CSDL', 1, '2006-12-20', 6.75),
('K1302', 'CTDLGT', 1, '2006-07-25', 5.00),
('K1302', 'THDC', 1, '2006-05-20', 8.00),
('K1302', 'CTRR', 1, '2006-05-13', 8.50),
('K1303', 'CSDL', 1, '2006-12-20', 4.00),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.50),
('K1303', 'CTDLGT', 2, '2006-08-07', 4.00),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25),
('K1303', 'THDC', 1, '2006-05-20', 4.50),
('K1303', 'CTRR', 1, '2006-05-13', 3.25),
('K1303', 'CTRR', 2, '2006-05-20', 5.00),
('K1304', 'CSDL', 1, '2006-12-20', 7.75),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75),
('K1304', 'THDC', 1, '2006-05-20', 5.50),
('K1304', 'CTRR', 1, '2006-05-13', 5.00),
('K1305', 'CSDL', 1, '2006-12-20', 9.25),
('K1305', 'CTDLGT', 1, '2006-07-25', 10.00),
('K1305', 'THDC', 1, '2006-05-20', 8.00),
('K1305', 'CTRR', 1, '2006-05-13', 10.00);

-- 8.1 Thêm dữ liệu cho cột KQUA của KETQUATHI dựa trên điểm 
UPDATE KETQUATHI
SET KQUA =
    CASE
        WHEN DIEM >= 5 THEN 'Dat'
        ELSE 'Khong dat'
    END;

-- 9. Cập nhật trưởng khoa (TRGKHOA) cho các khoa
UPDATE KHOA SET TRGKHOA = 'GV01' WHERE MAKHOA = 'KHMT';
UPDATE KHOA SET TRGKHOA = 'GV02' WHERE MAKHOA = 'HTTT';
UPDATE KHOA SET TRGKHOA = 'GV04' WHERE MAKHOA = 'CNPM';
UPDATE KHOA SET TRGKHOA = 'GV03' WHERE MAKHOA = 'MTT';

-- 10. Sau khi có dữ liệu về học viên. Cập nhật lại lớp trưởng cho các lớp
UPDATE LOP SET TRGLOP = 'K1108' WHERE MALOP = 'K11';
UPDATE LOP SET TRGLOP = 'K1205' WHERE MALOP = 'K12';
UPDATE LOP SET TRGLOP = 'K1305' WHERE MALOP = 'K13';

--================================================================================================================================

-- BÀI TẬP 4: HOÀN THÀNH PHẦN I BÀI TẬP QuanLyGiaoVu TỪ CÂU 11 ĐẾN CÂU 14
-- Phan I cau 11: Học viên ít nhất là 18 tuổi. 
ALTER TABLE HOCVIEN 
ADD CONSTRAINT CHK_HV_DU18TUOI CHECK (DATEADD(YEAR, 18, NGSINH) <= GETDATE());

-- Phan I cau 12: Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_GD_NGBDATDAU_HOPLE CHECK (TUNGAY < DENNGAY);

-- Phan I cau 13: Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GV_DU22TUOI CHECK (DATEADD(YEAR, 22, NGSINH) <= GETDATE());

-- Phan I cau 14: Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC
ADD CONSTRAINT CHK_MH_CHENHLECHTC CHECK(ABS(TCLT - TCTH) <= 3);

--================================================================================================================================

-- BÀI TẬP 6: SINH VIÊN HOÀN THÀNH PHẦN III BẢI TẬP QuanLyGiaoVu TỪ CÂU 1 ĐẾN CÂU 5.
-- Phần III câu 1: In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của cá
SELECT HV.MAHV, HV.HO, HV.TEN, HV.NGSINH, HV.MALOP
FROM HOCVIEN HV
JOIN LOP ON HV.MAHV = LOP.TRGLOP;

-- Phần III câu 2: In ra bảng điểm khi thi (mã học viên, họ tên, lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên. 
SELECT DISTINCT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, KETQUATHI.LANTHI, KETQUATHI.DIEM
FROM KETQUATHI
JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE KETQUATHI.MAMH = 'CTRR' AND HOCVIEN.MALOP = 'K12'
ORDER BY HOCVIEN.TEN ASC, HOCVIEN.HO ASC;

-- Phần III câu 3: In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT DISTINCT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, MONHOC.TENMH
FROM HOCVIEN HV
JOIN KETQUATHI AS KQ ON KQ.MAHV = HV.MAHV
JOIN MONHOC ON MONHOC.MAMH = KQ.MAMH
WHERE KQ.LANTHI = 1 AND KQ.KQUA = 'Dat';

-- Phần III câu 4: In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT DISTINCT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
WHERE HV.MALOP = 'K11' AND KQ.MAMH = 'CTRR' AND KQ.KQUA = 'Khong dat' AND KQ.LANTHI = 1;

-- Phần III câu ̀̉̀5: Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi). 
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
WHERE HV.MALOP LIKE 'K%' AND KQ.MAMH = 'CTRR'
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING MAX(KQ.DIEM) < 5;

--======BÀI TẬP THÊM (QuanLyGiaoVu): PHẦN II CÂU 1 -> CÂU 4=====--
-- Phần II câu 1: Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
FROM GIAOVIEN
JOIN KHOA ON KHOA.TRGKHOA = GIAOVIEN.MAGV;

-- Phần II câu 2: Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các 
-- môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
UPDATE HOCVIEN
SET DIEMTB = DTB.DIEMTBMOI
FROM HOCVIEN HV
JOIN 
(
    SELECT 
        DIEMCUOI.MAHV,
        AVG(CAST(DIEMCUOI.DIEM AS FLOAT)) AS DIEMTBMOI
    FROM KETQUATHI DIEMCUOI
    JOIN
        (SELECT MAHV, MAMH, MAX(LANTHI) AS LANTHIMAX FROM KETQUATHI GROUP BY MAHV, MAMH) AS LANTHICUOI 
    ON 
        DIEMCUOI.MAHV = LANTHICUOI.MAHV
        AND DIEMCUOI.MAMH = LANTHICUOI.MAMH
        AND DIEMCUOI.LANTHI = LANTHICUOI.LANTHIMAX
    GROUP BY DIEMCUOI.MAHV
) AS DTB ON HV.MAHV = DTB.MAHV

-- Phần II câu 3: Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất 
-- kỳ thi lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
FROM HOCVIEN
JOIN KETQUATHI KQ ON HOCVIEN.MAHV = KQ.MAHV
WHERE KQ.LANTHI = 3 AND KQ.DIEM < 5;

-- Phần II câu 4: Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
-- Nếu DIEMTB ≥ 9 thì XEPLOAI =”XS”
UPDATE HOCVIEN
SET
    XEPLOAI = CASE
        WHEN DIEMTB >= 9 THEN 'XS'
        WHEN DIEMTB >= 8 THEN 'G'
        WHEN DIEMTB >= 6.5 THEN 'K'
        WHEN DIEMTB >= 5 THEN 'TB'
        ELSE 'Y'
    END;

--=====BÀI TẬP THÊM (QuanLyBanHang)
-- Câu 1: Liệt kê danh sách các sản phẩm được sản xuất tại "Trung Quoc" hoặc "Việt Nam". (Sử dụng UNION)
SELECT * FROM SANPHAM
WHERE NUOCSX = 'Viet Nam'
UNION 
SELECT * FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

-- Câu 2: Liệt kê danh sách các khách hàng có doanh số > 5.000.000 hoặc đã đăng ký thành viên trước năm 2006. (Sử dụng UNION)
SELECT * FROM KHACHHANG
WHERE DOANHSO > 5000000
UNION 
SELECT * FROM KHACHHANG
WHERE YEAR(NGAYDK) < 2006

-- Câu 3: Tìm các sản phẩm do "Trung Quoc" sản xuất và có giá từ 30.000 đến 40.000. (Sử dụng INTERSECT)
SELECT * FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc'
INTERSECT 
SELECT * FROM SANPHAM
WHERE GIA BETWEEN 30000 AND 40000;

-- Câu 4: Tìm các khách hàng vừa có doanh số > 2.000.000 vừa đăng ký trước năm 2007. (Sử dụng INTERSECT)
SELECT * FROM KHACHHANG
WHERE DOANHSO > 2000000
INTERSECT 
SELECT * FROM KHACHHANG
WHERE YEAR(NGAYDK) < 2007;

-- Câu 5: Liệt kê các sản phẩm chưa từng được bán ra trong bảng CTHD. (Sử dụng EXCEPT)
SELECT * FROM SANPHAM
WHERE MASP IN 
(
    SELECT MASP FROM SANPHAM
    EXCEPT
    SELECT MASP FROM CTHD
);

-- Câu 6: Liệt kê các nhân viên chưa từng lập hóa đơn nào. (Sử dụng EXCEPT)
SELECT * FROM NHANVIEN
WHERE MANV IN
(
    SELECT MANV FROM NHANVIEN
    EXCEPT
    SELECT MANV FROM HOADON
);

-- Câu 7: Hãy liệt kê các hóa đơn có trị giá lớn hơn 500.000, gồm các thông tin số hóa đơn, ngày hóa đơn, trị giá, tên khách hàng (TenKhachHang) và tên nhân viên (TenNhanVien) lập hóa đơn, sắp xếp giảm dần theo ngày lập hóa đơn. (Sử dụng INNER JOIN)
SELECT SOHD, NGHD, TRIGIA, KH.HOTEN, NV.HOTEN
FROM HOADON HD
INNER JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
INNER JOIN NHANVIEN NV ON NV.MANV = HD.MANV
WHERE TRIGIA > 500000
ORDER BY NGHD DESC;

-- Câu 8: Hãy hiển thị số hóa đơn, mã sản phẩm, số lượng, tên sản phẩm, chỉ lấy các chi tiết hóa đơn của sản phẩm sản xuất tại Trung Quốc, sắp xếp theo số lượng tăng dần.(Sử dụng INNER JOIN)
SELECT SOHD, CTHD.MASP, SL, TENSP
FROM CTHD
INNER JOIN SANPHAM ON SANPHAM.MASP = CTHD.MASP
WHERE NUOCSX = 'Trung Quoc'
ORDER BY SL ASC;

-- Câu 9: Liệt kê toàn bộ nhân viên, kèm thông tin số hóa đơn và ngày họ đã lập hóa đơn (nếu có). (Sử dụng LEFT JOIN)
SELECT NHANVIEN.MANV, HOTEN, SODT, NGVL, SOHD, NGHD FROM NHANVIEN
LEFT JOIN HOADON ON HOADON.MANV = NHANVIEN.MANV;

-- Câu 10: Hãy hiển thị tất cả sản phẩm với mã sản phẩm, tên sản phẩm, đơn vị tính, cùng số hóa đơn và số lượng nếu có, chỉ lấy sản phẩm có giá từ 5000 đồng trở lên, sắp xếp theo tên sản phẩm giảm dần. (Sử dụng LEFT JOIN)
SELECT SP.MASP, SP.TENSP, SP.DVT, CTHD.SOHD, CTHD.SL
FROM SANPHAM SP
LEFT JOIN CTHD ON SP.MASP = CTHD.MASP
WHERE SP.GIA > 5000
ORDER BY SP.TENSP DESC;

-- Câu 11: Hãy liệt kê tên sản phẩm và số lượng bán, kể cả sản phẩm chưa từng được bán ra. (Sử dụng RIGHT JOIN)
SELECT SP.MASP, SP.TENSP, ISNULL(SUM(CTHD.SL), 0) AS SOLUONGBAN
FROM CTHD
RIGHT JOIN SANPHAM SP ON SP.MASP = CTHD.MASP
GROUP BY SP.MASP, SP.TENSP;

-- Câu 12: Hãy hiển thị tất cả nhân viên với mã nhân viên, họ tên, ngày vào làm, cùng số hóa đơn và trị giá nếu có, chỉ lấy nhân viên vào làm trong năm 2006, sắp xếp theo ngày vào làm giảm dần. (Sử dụng RIGHT JOIN)
SELECT NV.MANV, NV.HOTEN, NV.NGVL, HD.SOHD, HD.TRIGIA
FROM HOADON HD
RIGHT JOIN NHANVIEN NV ON NV.MANV = HD.MANV
WHERE YEAR(NV.NGVL) = '2006'
ORDER BY NV.NGVL DESC;

-- Câu 13: liệt kê tất cả khách hàng với mã khách hàng, họ tên, cùng số hóa đơn, ngày hóa đơn, bao gồm cả khách hàng chưa có hóa đơn và hóa đơn không có khách hàng. (Sử dụng FULL JOIN)
SELECT KH.MAKH, KH.HOTEN, HD.SOHD, HD.NGHD
FROM KHACHHANG KH
FULL JOIN HOADON HD ON KH.MAKH = HD.MAKH;

-- Câu 14: Liệt kê tất cả hóa đơn với số hóa đơn, ngày hóa đơn, cùng mã nhân viên, họ tên nhân viên, chỉ lấy các bản ghi liên quan đến nhân viên có số điện thoại bắt đầu bằng '09', sắp xếp theo ngày hóa đơn tăng dần. (Sử dụng FULL JOIN)
SELECT HD.SOHD, HD.NGHD, NV.MANV, NV.HOTEN
FROM HOADON HD
FULL JOIN NHANVIEN NV ON NV.MANV = HD.MANV
WHERE NV.SODT LIKE '09%'
ORDER BY HD.NGHD ASC