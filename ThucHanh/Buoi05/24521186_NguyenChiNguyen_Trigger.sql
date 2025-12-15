-- Họ tên: Nguyễn Chí Nguyên
-- MSSV: 24521186
-- Lớp: IT004.Q18.1

-- Bài tập Trigger QuanLyGiaoVu, phần I câu 9-10, câu 15-23
-- Câu 9: Lớp trưởng của một lớp phải là học viên của lớp đó.
CREATE TRIGGER TRG_Lop_HocVien
ON LOP
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted INS
		WHERE NOT EXISTS (
			SELECT 1
			FROM HOCVIEN HV
			WHERE HV.MAHV = INS.TRGLOP
			AND HV.MALOP = INS.MALOP
		)
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Lớp trưởng của một lớp phải là học viên của lớp đó', 16, 1)
		ROLLBACK TRANSACTION 
		RETURN
	END
END
GO

CREATE TRIGGER TRG_HocVien_Lop
ON HOCVIEN
FOR DELETE, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1 
		FROM deleted DEL 
		JOIN LOP L ON L.TRGLOP = DEL.MAHV
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Lớp trưởng của một lớp phải là học viên của lớp đó', 16, 1)
		ROLLBACK TRANSACTION 
		RETURN
	END
END
GO

-- Câu 10: Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER TRG_Khoa_GiaoVien_TruongKhoa
ON KHOA
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1 
		FROM inserted I
		WHERE NOT EXISTS (
			SELECT *
			FROM GIAOVIEN GV
			WHERE GV.MAGV = I.TRGKHOA
			AND GV.MAKHOA = I.MAKHOA
			AND GV.HOCVI IN ('TS', 'PTS')
		)
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

CREATE TRIGGER TRG_GiaoVien_Khoa_TruongKhoa
ON GIAOVIEN
FOR DELETE, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM deleted D
		JOIN KHOA K ON K.TRGKHOA = D.MAGV
	)
	BEGIN 
		RAISERROR(N'Lỗi ràng buộc: Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END

	IF EXISTS (
		SELECT 1 
		FROM inserted I
		JOIN KHOA K ON K.TRGKHOA = I.MAGV
		AND I.HOCVI NOT IN ('TS', 'PTS')
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

-- Câu 15: Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học
CREATE TRIGGER TRG_KetQuaThi_HocXong
ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        JOIN HOCVIEN HV ON I.MAHV = HV.MAHV
        JOIN GIANGDAY GD ON GD.MALOP = HV.MALOP AND GD.MAMH = I.MAMH
        WHERE I.NGTHI < GD.DENNGAY
    )
    BEGIN
        RAISERROR(N'Lỗi ràng buộc: Học viên chỉ được thi khi lớp đã học xong môn học này (Ngày thi phải >= Ngày kết thúc).', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO


-- Câu 16: Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
CREATE TRIGGER TRG_GiangDay
ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted I
		JOIN GIANGDAY GD 
			ON GD.MALOP = I.MALOP
			AND GD.NAM = I.NAM
			AND GD. HOCKY = I.HOCKY
		GROUP BY GD.MALOP, GD.NAM, GD.HOCKY
		HAVING COUNT(DISTINCT GD.MAMH) > 3
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Mỗi học kỳ của một năm học, một lớp hcir được học tối đa 3 môn học', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

-- Câu 17: Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó. 
CREATE TRIGGER TRG_Lop_HocVien_SiSo
ON LOP
FOR UPDATE
AS
BEGIN
	IF UPDATE(SISO)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Sĩ số của một lớp phải bằng số lượng học viên của lớp đó', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

CREATE TRIGGER TRG_HocVien_Lop_SiSo_Ins
ON HOCVIEN
FOR INSERT, DELETE, UPDATE
AS
BEGIN
    UPDATE L
    SET L.SISO = (
        SELECT COUNT(HV.MAHV)
        FROM HOCVIEN HV
        WHERE HV.MALOP = L.MALOP
    )
    FROM LOP L
    JOIN (
        SELECT MALOP FROM inserted
        UNION
        SELECT MALOP FROM deleted
    ) AS T ON T.MALOP = L.MALOP
END
GO



-- Câu 18: Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng 
-- một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và 
-- (“B”,”A”). 
CREATE TRIGGER TRG_DieuKien
ON DIEUKIEN 
FOR INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted I
		WHERE I.MAMH = I.MAMH_TRUOC
	)
	BEGIN 
		RAISERROR(N'Lỗi ràng buộc: Môn học và môn học trước không được giống nhau', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END

	IF EXISTS (
		SELECT 1
		FROM inserted I
		WHERE I.MAMH <> I.MAMH_TRUOC
		AND NOT EXISTS (
			SELECT 1
			FROM DIEUKIEN DK
			WHERE DK.MAMH = I.MAMH_TRUOC AND DK.MAMH_TRUOC = I.MAMH
		)
	)
	BEGIN 
		RAISERROR(N'Lỗi ràng buộc: Bộ đôi môn học đã tồn tại', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

-- Câu 19: Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. 
CREATE TRIGGER TRG_GiaoVien_MucLuong
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM GIAOVIEN GV
		JOIN inserted I ON I.MAGV = GV.MAGV
		WHERE EXISTS (
			SELECT 1
			FROM GIAOVIEN GV2
			WHERE GV2.HOCHAM = GV.HOCHAM
			AND GV2.HOCVI = GV.HOCVI
			AND GV2.HESO = GV.HESO
			AND GV2.MUCLUONG <> GV.MUCLUONG
		)
	)
	BEGIN
        RAISERROR(N'Lỗi ràng buộc: Các giáo viên có cùng học vị/học hàm và hệ số lương phải có mức lương bằng nhau.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

-- Câu 20: Học viên chỉ được thi lại (lần thi > 1) khi điểm của lần thi trước đó dưới 5. 
CREATE TRIGGER TRG_KetQuaThi_ThiLai
ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM KETQUATHI KQ
		JOIN inserted I ON I.MAHV = KQ.MAHV AND I.MAMH = KQ.MAMH AND I.LANTHI - 1 = KQ.LANTHI
		WHERE I.LANTHI > 1
		AND KQ.DIEM >= 5
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Học viên chỉ được thi lại khi điểm lần thi trước đó < 5', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

-- Câu 21: Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
CREATE TRIGGER TRG_KetQuaThi_NgayThi
ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM KETQUATHI KQ
		JOIN inserted I ON I.MAHV = KQ.MAHV AND I.MAMH = KQ.MAMH AND I.LANTHI - 1 = KQ.LANTHI
		WHERE I.NGTHI <= KQ.NGTHI
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END

	IF EXISTS (
        SELECT 1
        FROM inserted I
        JOIN KETQUATHI KQ_SAU 
            ON I.MAHV = KQ_SAU.MAHV 
            AND I.MAMH = KQ_SAU.MAMH
            AND KQ_SAU.LANTHI = I.LANTHI + 1 -- Tìm lần thi ngay sau
        WHERE I.NGTHI >= KQ_SAU.NGTHI -- Vi phạm: Ngày trước >= Ngày sau
    )
    BEGIN
        RAISERROR(N'Lỗi ràng buộc: Ngày thi của lần thi trước phải nhỏ hơn ngày thi của lần thi sau.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

-- Câu 22: Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau 
-- khi học xong những môn học phải học trước mới được học những môn liền sau). 
CREATE TRIGGER TRG_GiangDay_DieuKien
ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        JOIN DIEUKIEN DK ON DK.MAMH = I.MAMH 
        WHERE NOT EXISTS (
            SELECT 1
            FROM GIANGDAY GD
            WHERE GD.MALOP = I.MALOP  
            AND GD.MAMH = DK.MAMH_TRUOC  
            AND GD.DENNGAY < I.TUNGAY     
        )
    )
    BEGIN
        RAISERROR(N'Lỗi ràng buộc: Sau 
-- khi học xong những môn học phải học trước mới được học những môn liền sau.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

-- Câu 23: Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách. 
CREATE TRIGGER TRG_GiaoVien_GiangDay_MonHoc_GV
ON GIAOVIEN
FOR UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted I
		JOIN GIANGDAY GD ON GD.MAGV = I.MAGV
		JOIN MONHOC MH ON MH.MAMH = GD.MAMH
		WHERE I.MAKHOA <> MH.MAKHOA
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

CREATE TRIGGER TRG_GiaoVien_GiangDay_MonHoc_GD
ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted I
		JOIN GIAOVIEN GV ON GV.MAGV = I.MAGV
		JOIN MONHOC MH ON MH.MAMH = I.MAMH
		WHERE GV.MAKHOA <> MH.MAKHOA
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO

CREATE TRIGGER TRG_GiaoVien_GiangDay_MonHoc_MH
ON MONHOC
FOR UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted I
		JOIN GIANGDAY GD ON GD.MAMH = I.MAMH
		JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGV
		WHERE GV.MAKHOA <> I.MAKHOA
	)
	BEGIN
		RAISERROR(N'Lỗi ràng buộc: Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN
	END
END
GO