-- =====BAITAP 1: Cau 12->Cau 13 phan III QuanLyBanHang
-- Cau 12: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20. 
SELECT SOHD FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
UNION
SELECT SOHD FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20

-- Cau 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20. 
SELECT SOHD FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
INTERSECT
SELECT SOHD FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20

-- === BAITAP 4: Cau 14->Cau 18 phan III QuanLyBanHang
-- Cau 14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
UNION 
SELECT SP.MASP, SP.TENSP FROM SANPHAM SP
	JOIN CTHD ON CTHD.MASP = SP.MASP
	JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
WHERE HD.NGHD = '2007-1-1'

-- Cau 15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được. 
SELECT MASP, TENSP
FROM SANPHAM
EXCEPT 
SELECT CTHD.MASP, SP.TENSP
FROM CTHD
	JOIN SANPHAM SP ON SP.MASP = CTHD.MASP

-- Cau 16: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006. 
SELECT MASP, TENSP
FROM SANPHAM
EXCEPT 
SELECT SP.MASP, SP.TENSP
FROM CTHD
	JOIN SANPHAM SP ON SP.MASP = CTHD.MASP
	JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
WHERE YEAR(HD.NGHD) = 2006

-- Cau 17: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006. 
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
EXCEPT 
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
	JOIN CTHD ON CTHD.MASP = SP.MASP
	JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
WHERE YEAR(HD.NGHD) = 2006 AND SP.NUOCSX = 'Trung Quoc'

-- Cau 18: Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT HD.SOHD
FROM HOADON HD
WHERE YEAR(HD.NGHD) = 2006
AND NOT EXISTS (
	SELECT * 
	FROM SANPHAM SP
	WHERE SP.NUOCSX = 'Singapore'
	AND NOT EXISTS (
		SELECT *
		FROM CTHD 
		WHERE CTHD.MASP = SP.MASP
		AND CTHD.SOHD = HD.SOHD))

				