-- 1
CREATE TABLE KHACHHANG
(
	MAKH char(4) primary key,
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	NGAYDK smalldatetime,
	DOANHSO money
)

CREATE TABLE NHANVIEN
(
	MANV char(4) primary key,
	HOTEN varchar(40),
	SODT varchar(20),
	NGVL smalldatetime
)

CREATE TABLE SANPHAM
(
	MASP char(4) primary key,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money
)

CREATE TABLE HOADON
(
	SOHD int primary key,
	NGHD smalldatetime,
	MAKH char(4),
	MANV char(4),
	TRIGIA money
)

CREATE TABLE CTHD
(
	SOHD int,
	MASP char(4),
	SL int
)

alter table CTHD alter column SOHD int not null
alter table CTHD alter column MASP char(4) not null
alter table CTHD add constraint FK_CTHD primary key(SOHD, MASP)
alter table HOADON add constraint FK_HD_KH foreign key(MAKH) references KHACHHANG(MAKH)
alter table HOADON add constraint FK_HD_NV foreign key(MANV) references NHANVIEN(MANV)
alter table CTHD add constraint FK_CTHD_HD foreign key(SOHD) references HOADON(SOHD)
alter table CTHD add constraint FK_CTHD_SP foreign key(MASP) references SANPHAM(MASP)

-- 2
alter table SANPHAM 
add GHICHU varchar(20)

-- 3
alter table KHACHHANG
add LOAIKH tinyint

-- 4 
alter table SANPHAM alter column GHICHU varchar(100)

-- 5
alter table SANPHAM
drop column GHICHU 

-- 6
alter table KHACHHANG alter column LOAIKH varchar(20)
alter table KHACHHANG
add constraint chkLOAIKH check (LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'))

-- 7
alter table SANPHAM
add constraint chkDVT check (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))

-- 8
alter table SANPHAM
add constraint chkGIABAN check (GIA >= 500)

-- 9

-- 10 
alter table KHACHHANG
add constraint chkNGAYDK_TV 
check ((LOAIKH = 'Vang lai' OR LOAIKH = 'Thuong xuyen' ) AND NGAYDK > NGSINH)

-- 11
alter table KHACHHANG