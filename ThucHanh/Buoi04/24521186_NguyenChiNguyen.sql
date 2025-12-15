-- HỌ TÊN: NGUYỄN CHÍ NGUYÊN
-- MSSV: 24521186
-- LỚP: IT004.Q18.1

-- BÀI TẬP 2: Phần III bài tập QUANLYGIAOVU từ câu 19 đến câu 25
-- Câu 19 phần III: Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA, NGTLAP
FROM KHOA
WHERE NGTLAP = (
	SELECT MIN(NGTLAP)
	FROM KHOA
)

-- Câu 20 phần III: Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(MAGV) AS N'Số GS, PGS'
FROM GIAOVIEN 
WHERE HOCHAM = 'GS' OR HOCHAM = 'PGS'

-- Câu 21 phần III: Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa. 
SELECT MAKHOA, COUNT(MAGV) AS SOGV
FROM GIAOVIEN
WHERE HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS')
GROUP BY MAKHOA

-- Câu 22 phần III: Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MAMH, KQUA, COUNT(DISTINCT MAHV) AS SOHV
FROM KETQUATHI
GROUP BY KQUA, MAMH

-- Câu 23 phần III: Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho 
-- lớp đó ít nhất một môn học.
SELECT DISTINCT GV.MAGV, HOTEN
FROM GIAOVIEN GV
JOIN LOP L ON L.MAGVCN = GV.MAGV
JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
GROUP BY GV.MAGV, HOTEN

-- Câu 24 phần III: Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất. 
SELECT HO + ' ' + TEN AS HOTEN
FROM HOCVIEN HV
JOIN LOP L ON L.TRGLOP = HV.MAHV
WHERE SISO = (
	SELECT MAX(SISO)
	FROM LOP
)

-- Câu 25 phần III: * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả 
-- các lần thi). 
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN HV
JOIN LOP L ON L.TRGLOP = HV.MAHV
WHERE MAHV IN (
	-- chọn ra các học viên thi không đạt ở tất cả các môn đã từng thi
	SELECT MAHV 
	FROM (
		SELECT MAMH, MAHV 
		FROM KETQUATHI
		EXCEPT
		SELECT MAMH, MAHV
		FROM KETQUATHI
		WHERE KQUA = 'Dat'
	) AS HVROTTATCAMON
	GROUP BY MAHV
	HAVING COUNT(MAMH) > 3
)

-- BÀI TẬP 3: Phần III bài tập QUANLYBANHANG từ câu 39 đến câu 44
-- Câu 39 phần III: Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
-- Cách 1
SELECT TOP 3 WITH TIES KH.MAKH, HOTEN
FROM KHACHHANG KH
JOIN HOADON HD ON HD.MAKH = KH.MAKH
GROUP BY KH.MAKH, HOTEN
ORDER BY COUNT(SOHD) DESC
-- Cách 2
SELECT MAKH, HOTEN, RANKSOLANMUA
FROM (
	SELECT KH.MAKH, HOTEN,
	RANK() OVER (
		ORDER BY COUNT(SOHD) DESC 
	) AS RANKSOLANMUA
	FROM KHACHHANG KH
	JOIN HOADON HD ON HD.MAKH = KH.MAKH
	GROUP BY KH.MAKH, HOTEN
) AS BANGTAM
WHERE RANKSOLANMUA = 1

-- Câu 40 phần III: Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
-- Cách 1
SELECT  MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHSOBANHANG
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
-- Cách 2
SELECT THANG, RANKDOANHTHUTHANG
FROM (
	SELECT MONTH(NGHD) AS THANG,
	RANK() OVER (
		ORDER BY SUM(TRIGIA) DESC
	) AS RANKDOANHTHUTHANG
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
	GROUP BY MONTH(NGHD)
) AS XH_DOANHSO
WHERE RANKDOANHTHUTHANG = 1

-- Câu 41 phần III: Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT MASP, TENSP
FROM (
	SELECT SP.MASP, TENSP, 
	RANK() OVER (
		ORDER BY SUM(SL) ASC
	) AS RANKSOLUONGBAN
	FROM CTHD 
	JOIN SANPHAM SP ON SP.MASP = CTHD.MASP
	JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
	WHERE YEAR(NGHD) = 2006
	GROUP BY SP.MASP, TENSP
) AS XH_SOLUONGBANSP
WHERE RANKSOLUONGBAN = 1

-- Câu 42 phần III: *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX, MASP, TENSP
FROM (
	SELECT NUOCSX, MASP, TENSP,
	RANK() OVER (
		PARTITION BY NUOCSX
		ORDER BY GIA DESC
	) AS RANKGIA
	FROM SANPHAM
) AS XH_GIATHEONUOCSX
WHERE RANKGIA = 1

-- Câu 43 phần III: Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
SELECT NUOCSX, COUNT(DISTINCT GIA) AS N'Số sản phẩm có giá khác nhau'
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3

-- Câu 44 phần III: *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT MAKH, HOTEN
FROM (
	SELECT TOPKH.MAKH, TOPKH.HOTEN,
	RANK() OVER (
		ORDER BY COUNT(SOHD) DESC
	) AS RANKSOLANMUA
	FROM (
		SELECT TOP 10 MAKH, HOTEN
		FROM KHACHHANG
		ORDER BY DOANHSO DESC
	) AS TOPKH
	JOIN HOADON HD ON HD.MAKH = TOPKH.MAKH
	GROUP BY TOPKH.MAKH, TOPKH.HOTEN
) AS XH_SOLANMUA
WHERE RANKSOLANMUA = 1

-- BÀI TẬP 4:  Phần III bài tập QUANLYGIAOVU từ câu 26 đến câu 35
-- Câu 26 phần III: Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
SELECT MAHV, HOTEN, SOMONDIEMCAO
FROM (
	SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, COUNT(MAMH) SOMONDIEMCAO,
	RANK() OVER (
		ORDER BY COUNT(MAMH) DESC
	) AS RANKDIEM
	FROM HOCVIEN HV
	JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	WHERE DIEM BETWEEN 9 AND 10
	GROUP BY HV.MAHV, HO, TEN
) AS BANGXEPHANG
WHERE RANKDIEM = 1

-- Câu 27 phần III: Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
SELECT MALOP, MAHV, HOTEN, SOMONDIEMCAO
FROM (
	SELECT MALOP, HV.MAHV, HO + ' ' + TEN AS HOTEN, COUNT(MAMH) AS SOMONDIEMCAO,
	RANK() OVER (
		PARTITION BY MALOP
		ORDER BY COUNT(MAMH) DESC
	) AS RANKDIEMTHEOLOP
	FROM HOCVIEN HV
	JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	WHERE DIEM BETWEEN 9 AND 10
	GROUP BY MALOP, HV.MAHV, HO, TEN
) AS BANGXEPHANG
WHERE RANKDIEMTHEOLOP = 1

-- Câu 28 phần III: Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp. 
SELECT NAM, HOCKY, MAGV, COUNT(DISTINCT MAMH) AS SOMH, COUNT(DISTINCT MALOP) AS SOLOP
FROM GIANGDAY
GROUP BY NAM, HOCKY, MAGV

-- Câu 29 phần III: Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất. 
SELECT NAM, HOCKY, MAGV, HOTEN
FROM (
	SELECT NAM, HOCKY, GV.MAGV, HOTEN,
	RANK() OVER (
		PARTITION BY NAM, HOCKY
		ORDER BY COUNT(MAMH) DESC
	) AS RANKGIANGDAY
	FROM GIAOVIEN GV
	JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	GROUP BY NAM, HOCKY, GV.MAGV, HOTEN
) AS BANGTAM
WHERE RANKGIANGDAY = 1

--Câu 30 phần III: Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT MAMH, TENMH
FROM (
	SELECT MH.MAMH, TENMH, 
	RANK() OVER (
		ORDER BY COUNT(MAHV) DESC
	) AS RANKKQ
	FROM MONHOC MH 
	JOIN KETQUATHI KQ ON KQ.MAMH = MH.MAMH
	WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
	GROUP BY MH.MAMH, TENMH
) AS BANGTAM
WHERE RANKKQ = 1

-- Câu 31 phần III: Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1). 
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN 
WHERE MAHV NOT IN (
	SELECT MAHV
	FROM KETQUATHI
	WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
)

-- Câu 32 phần III: 32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN
WHERE MAHV NOT IN (
	SELECT MAHV
	FROM (
		-- xếp hạng lần thi (phân theo từng học viên và theo kết quả) giảm dần
		SELECT MAHV, KQUA,
		RANK() OVER (
			PARTITION BY MAHV, MAMH
			ORDER BY LANTHI DESC
		) AS RANKLANTHITHEOMONVASINHVIEN
		FROM KETQUATHI
	) AS XH_LANTHI
	WHERE RANKLANTHITHEOMONVASINHVIEN = 1 AND KQUA = 'Khong Dat'
)

-- Câu 33 phần III:  * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi thứ 1).
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN HV
WHERE NOT EXISTS (
	SELECT *
	FROM MONHOC MH
	WHERE NOT EXISTS (
		SELECT *
		FROM KETQUATHI KQ
		WHERE HV.MAHV = KQ.MAHV AND MH.MAMH = KQ.MAMH
		AND LANTHI = 1 AND KQUA = 'Dat'
	)
)

-- Câu 34 phần III: * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi sau cùng).
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN HV
WHERE NOT EXISTS (
	SELECT *
	FROM MONHOC MH
	WHERE NOT EXISTS (
		-- chọn ra những bộ mà có kết quả là đạt ở lần thi sau cùng
		SELECT *
		FROM (
			-- xếp hạng lần thi (phân hoạch theo MAMH, MAHV) --> lần thi sau cùng sẽ có Rank là 1
			SELECT KQUA, MAMH, MAHV,
			RANK() OVER (
				PARTITION BY MAMH, MAHV
				ORDER BY LANTHI DESC
			) AS RANKLANTHI
			FROM KETQUATHI
		) AS XH
		WHERE HV.MAHV = XH.MAHV AND MH.MAMH = XH.MAMH
		AND KQUA = 'Dat' AND RANKLANTHI = 1
	)
)

-- Câu 35 phần III: ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần
-- thi sau cùng). 
SELECT MAMH, HV.MAHV, HO + ' ' + TEN AS HOTEN, DIEM
FROM (
	-- xếp hạng điểm của các bộ bảng XH1, phân hoạch theo môn học
	SELECT MAMH, MAHV, DIEM,
	RANK() OVER (
		PARTITION BY MAMH
		ORDER BY DIEM DESC
	) AS RANKDIEM
	FROM (
		-- xếp hạng lần thi (phân hoạch theo MAMH, MAHV) --> lần thi sau cùng sẽ có Rank là 1
		SELECT MAMH, MAHV, DIEM,
		RANK() OVER (
			PARTITION BY MAMH, MAHV
			ORDER BY LANTHI DESC
		) AS RANKLT1
		FROM KETQUATHI
	) AS XH1		
	WHERE RANKLT1 = 1
) AS XH2
JOIN HOCVIEN HV ON HV.MAHV = XH2.MAHV
WHERE RANKDIEM = 1	