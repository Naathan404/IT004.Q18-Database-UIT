-- ========= LAB 3 =========
-- === Ho ten: NGUYEN CHI NGUYEN ===
-- === MSSV: 24521186 ===

-- BAI TAP 2: Phan II, cau 1 -> cau 4 QuanLyGiaoVu
-- Cau 1: Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
FROM GIAOVIEN
JOIN KHOA ON KHOA.TRGKHOA = GIAOVIEN.MAGV;

-- Cau 2: Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các 
-- môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng). 
UPDATE HOCVIEN
SET DIEMTB = DTBTEMP
FROM HOCVIEN
JOIN (
	SELECT DIEMSAUCUNG2.MAHV, AVG(DIEMSAUCUNG2.DIEM) AS DTBTEMP
	FROM (
		SELECT KQ.MAHV, KQ.MAMH, KQ.DIEM 
		FROM KETQUATHI KQ
		JOIN 
			(SELECT MAHV, MAMH, MAX(LANTHI) AS LANTHICUOI
			FROM KETQUATHI
			GROUP BY MAHV, MAMH) AS DIEMSAUCUNG
			ON KQ.LANTHI = DIEMSAUCUNG.LANTHICUOI 
			AND KQ.MAHV = DIEMSAUCUNG.MAHV 
			AND KQ.MAMH = DIEMSAUCUNG.MAMH) AS DIEMSAUCUNG2
	GROUP BY DIEMSAUCUNG2.MAHV) AS DTB
ON HOCVIEN.MAHV = DTB.MAHV

-- Cau 3: Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất 
-- kỳ thi lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
FROM HOCVIEN
	JOIN KETQUATHI KQ ON KQ.MAHV = HOCVIEN.MAHV
WHERE KQ.LANTHI = 3 AND KQ.DIEM < 5;

-- Cau 4: Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
-- o Nếu DIEMTB ≥ 9 thì XEPLOAI =”XS” 
-- o Nếu  8 ≤ DIEMTB < 9 thì XEPLOAI = “G” 
-- o Nếu  6.5 ≤ DIEMTB < 8 thì XEPLOAI = “K” 
-- o Nếu  5  ≤  DIEMTB < 6.5 thì XEPLOAI = “TB” 
-- o Nếu  DIEMTB < 5 thì XEPLOAI = "Y"
UPDATE HOCVIEN
SET XEPLOAI = CASE
	WHEN DIEMTB >= 9 THEN 'XS'
	WHEN DIEMTB >= 8 THEN 'G'
	WHEN DIEMTB >= 6.5 THEN 'K'
	WHEN DIEMTB >= 5 THEN 'TB'
	ELSE 'Y'
	END;

-- BAI TAP 3: Phan III, cau 6 -> cau 10 QuanLyGiaoVu
-- CAU 6: Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT TENMH
FROM MONHOC MH
JOIN GIANGDAY GD ON GD.MAMH = MH.MAMH
JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGV
WHERE GV.HOTEN = 'Tran Tam Thanh'
AND HOCKY = 1
AND NAM = 2006;

-- Cau 7: Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy 
-- trong học kỳ 1 năm 2006. 
SELECT DISTINCT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN GIANGDAY GD ON GD.MAMH = MH.MAMH
JOIN LOP ON LOP.MAGVCN = GD.MAGV
WHERE LOP.MALOP = 'K11'
AND GD.HOCKY = 1
AND GD.NAM = 2006

-- Cau 8: Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So 
-- Du Lieu”.
SELECT HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN LOP ON LOP.TRGLOP = HV.MAHV
JOIN GIANGDAY GD ON GD.MALOP = LOP.MALOP
JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGV
WHERE GV.HOTEN = 'Nguyen To Lan' AND GD.MAMH = 'CSDL'

-- Cau 9: In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So 
-- Du Lieu”. 
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN DIEUKIEN DK ON DK.MAMH_TRUOC = MH.MAMH
WHERE DK.MAMH = 'CSDL'

-- Cau 10: Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, 
-- tên môn học) nào. 
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN DIEUKIEN DK ON DK.MAMH = MH.MAMH
WHERE DK.MAMH_TRUOC = 'CTRR'

-- BAI TAP 5: Phan III, cau 11 -> cau 18 QuanLyGiaoVu
-- Cau 11: Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT HOTEN
FROM GIAOVIEN GV
JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
WHERE GD.MALOP = 'K11' AND GD.NAM = 2006 AND GD.HOCKY = 1
INTERSECT 
SELECT HOTEN
FROM GIAOVIEN GV
JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
WHERE GD.MALOP = 'K12' AND GD.NAM = 2006 AND GD.HOCKY = 1

-- Cau 12: Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này. 
SELECT DISTINCT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ1 ON KQ1.MAHV = HV.MAHV
WHERE KQ1.MAMH = 'CSDL'
AND KQ1.LANTHI = 1
AND KQ1.KQUA = 'Khong Dat'
AND NOT EXISTS (
	SELECT *
	FROM KETQUATHI KQ2
	WHERE KQ2.MAMH = 'CSDL'
	AND KQ2.LANTHI > 1
	AND KQ2.MAHV = KQ1.MAHV)

-- Cau 13: Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào. 
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
	SELECT * 
	FROM GIANGDAY GD
	WHERE GD.MAGV = GV.MAGV)

SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
EXCEPT
SELECT GD.MAGV, GV.HOTEN
FROM GIANGDAY GD
JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGV

-- Cau 14: Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào 
-- thuộc khoa giáo viên đó phụ trách.
SELECT MAGV, HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
	SELECT * 
	FROM MONHOC MH
	JOIN GIANGDAY GD ON GD.MAMH = MH.MAMH
	WHERE MH.MAKHOA = GV.MAKHOA
	AND GD.MAGV = GV.MAGV);

-- Cau 15: Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” 
-- hoặc thi lần thứ 2 môn CTRR được 5 điểm. 
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
WHERE HV.MALOP = 'K11' 
AND KQ.LANTHI > 3 AND KQ.KQUA = 'Khong Dat'
UNION
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
WHERE HV.MALOP = 'K11'
AND KQ.LANTHI = 2 AND KQ.MAMH = 'CTRR' AND KQ.DIEM = 5;

-- Cau 16: Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
WHERE GD.MAMH = 'CTRR'
GROUP BY GV.MAGV, GV.HOTEN, HOCKY, NAM
HAVING COUNT(GD.MALOP) >= 2

-- Cau 17: Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng). 
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, GIOITINH, MALOP, KQ.DIEM
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
JOIN (
	SELECT MAHV, MAX(LANTHI) AS LANTHICUOI
	FROM KETQUATHI
	WHERE MAMH = 'CSDL'
	GROUP BY MAHV) AS TEMP
ON KQ.MAHV = TEMP.MAHV AND KQ.LANTHI = TEMP.LANTHICUOI 
WHERE KQ.MAMH = 'CSDL'
ORDER BY MAHV ASC

-- Cau 18: Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, GIOITINH, MALOP, KQ.DIEM
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
JOIN (
	SELECT MAHV, MAX(DIEM) AS DIEMCAONHAT
	FROM KETQUATHI
	WHERE MAMH = 'CSDL'
	GROUP BY MAHV) AS TEMP
ON KQ.MAHV = TEMP.MAHV AND KQ.DIEM = TEMP.DIEMCAONHAT
WHERE KQ.MAMH = 'CSDL'