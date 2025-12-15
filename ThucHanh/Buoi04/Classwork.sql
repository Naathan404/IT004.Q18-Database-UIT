-- HỌ TÊN: NGUYỄN CHÍ NGUYÊN
-- MSSV: 24521186
-- LỚP: IT004.Q18.1

-- Cau 19 Phan III: Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
SELECT COUNT(SOHD) AS "Số hóa đơn"
FROM HOADON 
WHERE MAKH IS NULL

-- Cau 20 Phan III: Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006. 
SELECT COUNT( DISTINCT CTHD.MASP) AS "Số sản phầm"
FROM CTHD
JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
WHERE YEAR(NGHD) = 2006

-- Cau 21 Phan III: Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu? 
SELECT MAX(TRIGIA) AS "Trị giá cao nhất", MIN(TRIGIA) AS "Trị giá thấp nhất"
FROM HOADON

-- Cau 22 Phan III: Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS N'Trị giá trung bình'
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- Cau 23 Phan III: Tính doanh thu bán hàng trong năm 2006. 
SELECT SUM(TRIGIA) AS "Doanh thu 2006"
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- Cau 24 Phan III: Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT TOP 1 SOHD
FROM HOADON HD
WHERE YEAR(NGHD) = 2006
ORDER BY TRIGIA DESC

-- Cau 25 Phan III: Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN
FROM KHACHHANG
WHERE MAKH = (
	SELECT TOP 1 MAKH
	FROM HOADON HD
	WHERE YEAR(NGHD) = 2006
	ORDER BY TRIGIA DESC
)
				
-- Cau 26 Phan III: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất. 
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- Cau 27 Phan III: In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (
    SELECT DISTINCT TOP 3 GIA
    FROM SANPHAM
    ORDER BY GIA DESC
);

-- Cau 28 Phan III: In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức 
-- giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP 
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan' AND GIA IN (
	SELECT DISTINCT TOP 3 GIA
	FROM SANPHAM
	ORDER BY GIA DESC
)

-- Cau 29 Phan III: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức 
-- giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP 
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA IN (
	SELECT DISTINCT TOP 3 GIA
	FROM SANPHAM
	WHERE NUOCSX = 'Trung Quoc'
	ORDER BY GIA DESC
)

-- Cau 30 Phan III: * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 KH.MAKH, KH.HOTEN, 
RANK() OVER (
    ORDER BY DOANHSO DESC
) AS RANKING 
FROM KHACHHANG KH

-- Cau 31 Phan III: Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(DISTINCT MASP) AS "Số sản phầm TQ sản xuất"
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

-- Cau 32 Phan III: Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(DISTINCT MASP) AS "Số sản phẩm"
FROM SANPHAM
GROUP BY NUOCSX

-- Cau 33 Phan III: Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, 
	MAX(GIA) AS "Giá cao nhất", 
	MIN(GIA) AS "Giá thấp nhất", 
	AVG(GIA) AS "Giá trung bình"
FROM SANPHAM
GROUP BY NUOCSX

-- Cau 34 Phan III: Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) AS "Doanh thu"
FROM HOADON
GROUP BY NGHD

-- Cau 35 Phan III: Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(SL) AS "Số lượng"
FROM CTHD
JOIN HOADON ON HOADON.SOHD = CTHD.SOHD
WHERE MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006
GROUP BY MASP

-- Cau 36 Phan III: Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) AS "Tháng", SUM(TRIGIA) AS "Doanh thu"
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)

-- Cau 37 Phan III: Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau. 
SELECT SOHD, COUNT(DISTINCT MASP) AS SOSP
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4

-- Cau 38 Phan III: Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT SOHD, COUNT(DISTINCT CTHD.MASP) AS SOSP
FROM CTHD
JOIN SANPHAM SP ON SP.MASP = CTHD.MASP
WHERE NUOCSX = 'Viet Nam'
GROUP BY CTHD.SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 3
