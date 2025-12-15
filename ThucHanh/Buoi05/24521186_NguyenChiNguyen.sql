-- TÊN: NGUYỄN CHÍ NGUYÊN
-- MSSV: 24521186
-- LỚP: IT004.Q18.1

-- BÀI TẬP 1: Phần I bài tập QuanLyBanHang từ câu 11 đến 15.
-- Câu 11: Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó 
-- đăng ký thành viên (NGDK).
CREATE TRIGGER TRG_HOADON_NGHD
ON HOADON
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM inserted INS
		JOIN KHACHHANG KH ON KH.MAKH = INS.MAKH
		WHERE INS.NGHD < KH.NGAYDK
	)
	BEGIN
		PRINT(N'Lỗi ràng buộc: Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên')
		ROLLBACK TRAN
		RETURN
	END
END

-- Câu 13: 
CREATE TRIGGER TRG_CHECK_HOADON_CTHD
ON CTHD
FOR DELETE, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM HOADON HD
		LEFT JOIN CTHD CT ON CT.SOHD = HD.SOHD
		GROUP BY HD.SOHD
		HAVING COUNT(CT.SOHD) = 0
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Ngày mua hàng phải lớn hơn hoặc bằng ngày đăng ký thành viên', 16, 1)
		ROLLBACK TRAN
		RETURN
	END
END