DROP SCHEMA IF EXISTS SG_coach_station;

CREATE SCHEMA SG_coach_station;

USE SG_coach_station;

CREATE TABLE NHA_XE
(
	ma_nha_xe 			CHAR(9)			NOT NULL,
	ten_nha_xe 			VARCHAR(50) 	NOT NULL,
	email 				VARCHAR(30),
	dia_chi 			VARCHAR(100),
	NV_quan_ly 			CHAR(9) 		NOT NULL,
	trang_thai 			BOOLEAN,
	PRIMARY KEY 		(ma_nha_xe)
);

CREATE TABLE SDT_NHA_XE
(
	ma_nha_xe 			CHAR(9) 		NOT NULL,
	so_dien_thoai 		CHAR(10) 		NOT NULL,
	PRIMARY KEY 		(ma_nha_xe, so_dien_thoai)
);

CREATE TABLE NHAN_VIEN
(
	ma_nhan_vien 		CHAR(9) 		NOT NULL,
	ho 					VARCHAR(25) 	NOT NULL,
	ten 				VARCHAR(25) 	NOT NULL,
	gioi_tinh 			VARCHAR(3) 		NOT NULL,	-- Nam / Nu
	ngay_sinh 			DATE, 						-- yyyy-mm-dd
	dia_chi 			VARCHAR(50),
	so_dien_thoai 		CHAR(10) 		NOT NULL,
	loai_nhan_vien 		VARCHAR(10) 	NOT NULL, 	-- Quan ly / Quay ve / Xe
	cong_viec 			VARCHAR(10),
	ma_nha_xe 			CHAR(9) 		NOT NULL,
	userID 				CHAR(9),
	PRIMARY KEY 		(ma_nhan_vien)
);

CREATE TABLE TUYEN_XE
(
	ma_tuyen 			CHAR(9) 		NOT NULL,
	noi_di 				VARCHAR(20),
	noi_den 			VARCHAR(20),
	trang_thai 			BOOLEAN,
	PRIMARY KEY 		(ma_tuyen)
);

CREATE TABLE CHUYEN_XE
(
	ma_chuyen 			CHAR(9) 		NOT NULL,
	ten_tram_den 		VARCHAR(20) 	NOT NULL,
	ngay_khoi_hanh 		DATE,
	gia_ve 				INT,
	ma_nha_xe 			CHAR(9) 		NOT NULL,
	ma_tuyen 			CHAR(9) 		NOT NULL,
	trang_thai 			BOOLEAN,
	PRIMARY KEY 		(ma_chuyen)
);

CREATE TABLE TRAM_DON_TRUNG_GIAN
(
	ma_chuyen 			CHAR(9) 		NOT NULL,
	tram_trung_gian 	VARCHAR(40) 	NOT NULL,
	PRIMARY KEY 		(ma_chuyen, tram_trung_gian)
);

CREATE TABLE XE
(
	bien_so 			CHAR(9) 		NOT NULL,
	so_luong_ghe 		INT,
	ma_nha_xe 			CHAR(9) 		NOT NULL,
	PRIMARY KEY 		(bien_so)
);

CREATE TABLE PHU_TRACH
(
	ma_nhan_vien 		CHAR(9) 		NOT NULL,
	bien_so 			CHAR(9) 		NOT NULL,
	PRIMARY KEY 		(ma_nhan_vien, bien_so)
);

CREATE TABLE LUOT_CHAY
(
	ma_luot 			CHAR(9) 		NOT NULL,
	gio_khoi_hanh 		TIME,
	phu_thu 			INT,
	ma_chuyen 			CHAR(9) 		NOT NULL,
	bien_so 			CHAR(9) 		NOT NULL,
	tinh_trang 			BOOLEAN,						-- true: con ve; false: het ve
	trang_thai 			BOOLEAN,
	PRIMARY KEY 		(ma_luot)
);

CREATE TABLE KHACH_HANG
(
	ma_khach_hang 		CHAR(9) 		NOT NULL,
	ho 					VARCHAR(25) 	NOT NULL,
	ten 				VARCHAR(25) 	NOT NULL,
	so_dien_thoai 		VARCHAR(10) 	NOT NULL,
	PRIMARY KEY 		(ma_khach_hang)
);

CREATE TABLE THANH_VIEN
(
	ma_khach_hang 		CHAR(9) 		NOT NULL,
	ngay_sinh 			DATE, 							-- yyyy-mm-dd
	dia_chi 			VARCHAR(50) ,
	gioi_tinh 			VARCHAR(3), 					-- Nam/Nu
	userID 				CHAR(9),
	PRIMARY KEY 		(ma_khach_hang)
);

CREATE TABLE HANG_HOA
(
	ma_khach_hang 		CHAR(9) 		NOT NULL,
	ma_hang_hoa 		CHAR(9) 		NOT NULL,
	chieu_dai 			INT,
	chieu_rong 			INT,
	khoi_luong 			INT,
	PRIMARY KEY 		(ma_khach_hang, ma_hang_hoa)
);

CREATE TABLE VE
(
	ma_ve 				CHAR(9) 		NOT NULL,
	tram_len 			VARCHAR(30),
	ngay_dat 			DATE,
	ma_luot 			CHAR(9) 		NOT NULL,
	ma_khach_hang 		CHAR(9) 		NOT NULL,
	PRIMARY KEY 		(ma_ve)
);

CREATE TABLE XUAT
(
	ma_ve 				CHAR(9) 		NOT NULL,
	ma_nhan_vien 		CHAR(9) 		NOT NULL,
	PRIMARY KEY 		(ma_ve)
);

CREATE TABLE USERS
(
	userID 				CHAR(9) 		NOT NULL,
	pass 				VARCHAR(20) 	NOT NULL,
	userName 			VARCHAR(20) 	NOT NULL,
	vai_tro 			CHAR(2) 		NOT NULL, 		-- Khach hang: KH, Nhan vien: NV, Quan ly: QL
	PRIMARY KEY 		(userID)
);


-- Foreign Key
ALTER TABLE 		NHA_XE
ADD FOREIGN KEY 	(NV_quan_ly) 	REFERENCES 	NHAN_VIEN (ma_nhan_vien);

ALTER TABLE 		SDT_NHA_XE
ADD FOREIGN KEY 	(ma_nha_xe) 	REFERENCES 	NHA_XE (ma_nha_xe);

ALTER TABLE 		NHAN_VIEN
ADD FOREIGN KEY 	(ma_nha_xe) 	REFERENCES 	NHA_XE (ma_nha_xe),
ADD FOREIGN KEY 	(userID) 		REFERENCES 	USERS (userID);

ALTER TABLE 		CHUYEN_XE
ADD FOREIGN KEY 	(ma_nha_xe) 	REFERENCES 	NHA_XE (ma_nha_xe),
ADD FOREIGN KEY 	(ma_tuyen) 		REFERENCES 	TUYEN_XE (ma_tuyen);

ALTER TABLE 		TRAM_DON_TRUNG_GIAN
ADD FOREIGN KEY 	(ma_chuyen) 	REFERENCES 	CHUYEN_XE (ma_chuyen);

ALTER TABLE 		XE
ADD FOREIGN KEY 	(ma_nha_xe) 	REFERENCES 	NHA_XE (ma_nha_xe);

ALTER TABLE 		PHU_TRACH
ADD FOREIGN KEY 	(bien_so) 		REFERENCES 	XE (bien_so);

ALTER TABLE 		LUOT_CHAY
ADD FOREIGN KEY 	(ma_chuyen) 	REFERENCES 	CHUYEN_XE (ma_chuyen),
ADD FOREIGN KEY 	(bien_so) 		REFERENCES 	XE (bien_so);

ALTER TABLE 		VE
ADD FOREIGN KEY 	(ma_luot) 		REFERENCES 	LUOT_CHAY (ma_luot),
ADD FOREIGN KEY 	(ma_khach_hang) REFERENCES 	KHACH_HANG (ma_khach_hang);

ALTER TABLE 		THANH_VIEN
ADD FOREIGN KEY 	(userID) 		REFERENCES 	USERS (userID);

ALTER TABLE 		HANG_HOA
ADD FOREIGN KEY 	(ma_khach_hang) REFERENCES 	KHACH_HANG (ma_khach_hang);



INSERT INTO NHA_XE VALUES ('SG0000003', 'Vân Anh', 'Vanh@gmail.com', 'Bà Triệu, Quận 1', 'NV0000003', 1);
INSERT INTO NHA_XE VALUES ('SG0000004', 'Đại Nam', 'dNam@gmail.com', 'Lê Lợi, Quận 2', 'NV0000004', 1);

INSERT INTO SDT_NHA_XE VALUES ('SG0000003', '0939101010');
INSERT INTO SDT_NHA_XE VALUES ('SG0000004', '0939222333');

INSERT INTO tuyen_xe VALUES ('TX0000002', 'Tp.Hồ Chí Minh', 'Vũng Tàu', 1);
INSERT INTO tuyen_xe VALUES ('TX0000003', 'Tp.Hồ Chí Minh', 'Đà Nẵng', 1);
INSERT INTO tuyen_xe VALUES ('TX0000004', 'Tp.Hồ Chí Minh', 'Cà Mau', 1);

INSERT INTO CHUYEN_XE VALUES ('CX0000011', 'Bà Rịa', '2021-12-15', 110000, 'SG0000000', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000012', 'Vũng Tàu', '2021-12-14', 110000, 'SG0000000', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000013', 'Bà Rịa', '2021-12-15', 120000, 'SG0000001', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000014', 'Vũng Tàu', '2021-12-14', 120000, 'SG0000001', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000015', 'Vũng Tàu', '2021-12-14', 120000, 'SG0000002', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000016', 'Vũng Tàu', '2021-12-15', 100000, 'SG0000003', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000017', 'Vũng Tàu', '2021-12-15', 115000, 'SG0000004', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000018', 'Đà Nẵng', '2021-12-14', 100000, 'SG0000000', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000019', 'Đà Nẵng', '2021-12-15', 115000, 'SG0000001', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000020', 'Đà Nẵng', '2021-12-14', 100000, 'SG0000002', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000021', 'Đà Nẵng', '2021-12-15', 100000, 'SG0000002', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000022', 'Đà Nẵng', '2021-12-14', 110000, 'SG0000003', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000023', 'Đà Nẵng', '2021-12-15', 110000, 'SG0000003', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000024', 'Đà Nẵng', '2021-12-15', 100000, 'SG0000004', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000025', 'Cà Mau', '2021-12-14', 150000, 'SG0000000', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000026', 'Cà Mau', '2021-12-14', 130000, 'SG0000001', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000027', 'Cà Mau', '2021-12-14', 125000, 'SG0000002', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000028', 'Cà Mau', '2021-12-15', 125000, 'SG0000003', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000029', 'Cà Mau', '2021-12-14', 125000, 'SG0000004', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000030', 'Cà Mau', '2021-12-15', 125000, 'SG0000004', 'TX0000004', 1);

INSERT INTO KHACH_HANG VALUES ('KH0000001', 'Nguyễn Anh', 'Kiệt', '0939890549');
INSERT INTO KHACH_HANG VALUES ('KH0000002', 'Nguyễn Văn', 'Mạnh', '0776152899');
INSERT INTO KHACH_HANG VALUES ('KH0000003', 'Nguyễn Thị', 'Bích', '0122987562');
INSERT INTO KHACH_HANG VALUES ('KH0000004', 'Nguyễn Văn', 'An', '0703894502');
INSERT INTO KHACH_HANG VALUES ('KH0000005', 'Nguyễn Quốc', 'Cường', '0939793356');
INSERT INTO KHACH_HANG VALUES ('KH0000006', 'Nguyễn Tường', 'Vi', '0939560032');
INSERT INTO KHACH_HANG VALUES ('KH0000007', 'Nguyễn Văn', 'Trí', '0939895556');
INSERT INTO KHACH_HANG VALUES ('KH0000008', 'Nguyễn Thị', 'Lệ', '0939332003');
INSERT INTO KHACH_HANG VALUES ('KH0000009', 'Đặng Trần', 'Bảo', '0939250300');
INSERT INTO KHACH_HANG VALUES ('KH0000010', 'Phan Văn', 'Năm', '0939230301');
INSERT INTO KHACH_HANG VALUES ('KH0000011', 'Trần Quốc', 'Trung', '0939233200');
INSERT INTO KHACH_HANG VALUES ('KH0000012', 'Võ Sơn', 'Hà', '0939784532');
INSERT INTO KHACH_HANG VALUES ('KH0000013', 'Trương Quốc', 'An', '0939123202');
INSERT INTO KHACH_HANG VALUES ('KH0000014', 'Trần Công', 'Trí', '0939895201');
INSERT INTO KHACH_HANG VALUES ('KH0000015', 'Trần Kim', 'Cường', '0939645208');

INSERT INTO XE VALUES ('51-HK1998', 45, 'SG0000000');
INSERT INTO XE VALUES ('51-HK4566', 45, 'SG0000000');
INSERT INTO XE VALUES ('51-HK9877', 45, 'SG0000000');
INSERT INTO XE VALUES ('51-HK0777', 45, 'SG0000000');
INSERT INTO XE VALUES ('51-HK5688', 45, 'SG0000000');
INSERT INTO XE VALUES ('51-UL1516', 45, 'SG0000001');
INSERT INTO XE VALUES ('51-UL6454', 45, 'SG0000001');
INSERT INTO XE VALUES ('51-UL9985', 45, 'SG0000001');
INSERT INTO XE VALUES ('51-UL1234', 45, 'SG0000001');
INSERT INTO XE VALUES ('51-UL6568', 45, 'SG0000001');
INSERT INTO XE VALUES ('51-ER6565', 45, 'SG0000002');
INSERT INTO XE VALUES ('51-ER8994', 45, 'SG0000002');
INSERT INTO XE VALUES ('51-ER2325', 45, 'SG0000002');
INSERT INTO XE VALUES ('51-ER5657', 45, 'SG0000002');
INSERT INTO XE VALUES ('51-ER2368', 45, 'SG0000002');
INSERT INTO XE VALUES ('51-AV5132', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-AV2132', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-AV9532', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-AV1354', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-AV8794', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-AV9856', 45, 'SG0000003');
INSERT INTO XE VALUES ('51-ND9865', 45, 'SG0000004');
INSERT INTO XE VALUES ('51-ND2326', 45, 'SG0000004');
INSERT INTO XE VALUES ('51-ND8796', 45, 'SG0000004');
INSERT INTO XE VALUES ('51-ND8651', 45, 'SG0000004');
INSERT INTO XE VALUES ('51-ND4651', 45, 'SG0000004');
INSERT INTO XE VALUES ('51-ND8789', 45, 'SG0000004');

INSERT INTO LUOT_CHAY VALUES ('LC0000003', '16:00:00', 10000, 'CX0000000', '51-HK4566', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000004', '13:00:00', 0, 'CX0000001', '51-HK1998', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000005', '15:00:00', 0, 'CX0000001', '51-HK0777', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000006', '16:00:00', 10000, 'CX0000002', '51-UL1516', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000007', '09:00:00', 0, 'CX0000003', '51-UL8234', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000008', '13:00:00', 0, 'CX0000003', '51-UL9985', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000009', '15:00:00', 0, 'CX0000004', '51-ER6565', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000010', '16:00:00', 0, 'CX0000005', '51-HK9877', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000011', '09:00:00', 0, 'CX0000005', '51-HK1998', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000012', '12:00:00', 10000, 'CX0000006', '51-HK0777', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000013', '08:00:00', 0, 'CX0000007', '51-HK2251', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000014', '07:00:00', 0, 'CX0000007', '51-HK4566', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000015', '13:00:00', 10000, 'CX0000008', '51-UL1234', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000016', '13:00:00', 0, 'CX0000009', '51-UL1516', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000017', '16:00:00', 10000, 'CX0000010', '51-ER2325', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000018', '09:00:00', 10000, 'CX0000010', '51-ER2368', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000019', '16:00:00', 10000, 'CX0000011', '51-HK4566', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000020', '09:00:00', 0, 'CX0000012', '51-HK5688', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000021', '11:00:00', 0, 'CX0000012', '51-HK2251', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000022', '14:00:00', 0, 'CX0000012', '51-HK9877', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000023', '09:00:00', 10000, 'CX0000013', '51-UL6568', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000024', '12:00:00', 0, 'CX0000014', '51-UL8234', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000025', '08:00:00', 0, 'CX0000015', '51-ER2325', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000026', '07:00:00', 10000, 'CX0000016', '51-AV2132', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000027', '13:00:00', 10000, 'CX0000016', '51-AV1354', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000028', '13:00:00', 10000, 'CX0000017', '51-ND8796', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000029', '16:00:00', 0, 'CX0000018', '51-HK5688', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000030', '09:00:00', 10000, 'CX0000019', '51-UL6454', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000031', '16:00:00', 0, 'CX0000020', '51-ER5657', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000032', '09:00:00', 0, 'CX0000020', '51-ER2368', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000033', '11:00:00', 10000, 'CX0000021', '51-ER5680', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000034', '14:00:00', 0, 'CX0000022', '51-AV9856', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000035', '09:00:00', 10000, 'CX0000023', '51-AV9532', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000036', '12:00:00', 10000, 'CX0000024', '51-ND2326', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000037', '08:00:00', 0, 'CX0000025', '51-HK0777', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000038', '07:00:00', 0, 'CX0000026', '51-UL1234', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000039', '13:00:00', 0, 'CX0000026', '51-UL1516', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000040', '13:00:00', 0, 'CX0000027', '51-ER5657', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000041', '16:00:00', 0, 'CX0000027', '51-ER2325', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000042', '09:00:00', 10000, 'CX0000028', '51-AV8794', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000043', '16:00:00', 10000, 'CX0000028', '51-AV1354', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000044', '09:00:00', 0, 'CX0000029', '51-ND8789', 1, 1);
INSERT INTO LUOT_CHAY VALUES ('LC0000045', '11:00:00', 10000, 'CX0000030', '51-ND4651', 1, 1);

INSERT INTO USERS VALUES ('ID0000004', 'vanhvo', 'VanhVo', 'QL');
INSERT INTO USERS VALUES ('ID0000005', 'dainam', 'TranDaiNam', 'QL');
INSERT INTO USERS VALUES ('ID0000006', '123456', 'htrungNig', 'NV');
INSERT INTO USERS VALUES ('ID0000007', '123456', 'MinhTrihj', 'NV');
INSERT INTO USERS VALUES ('ID0000008', '123456', 'TDBui', 'NV');
INSERT INTO USERS VALUES ('ID0000009', '123456', 'ThongDB', 'NV');
INSERT INTO USERS VALUES ('ID0000010', '123456', 'TanDatBi', 'NV');
INSERT INTO USERS VALUES ('ID0000011', '123456', 'PNThu', 'NV');
INSERT INTO USERS VALUES ('ID0000015', '123456', 'BinhBT', 'NV');
INSERT INTO USERS VALUES ('ID0000016', '123456', 'CuongQQ', 'NV');
INSERT INTO USERS VALUES ('ID0000017', '123456', 'DungCT', 'NV');
INSERT INTO USERS VALUES ('ID0000018', '123456', 'HieuPC', 'NV');
INSERT INTO USERS VALUES ('ID0000019', '123456', 'GiangPP', 'NV');
INSERT INTO USERS VALUES ('ID0000020', '123456', 'Khang98', 'NV');
INSERT INTO USERS VALUES ('ID0000021', '123456', 'Linh23', 'NV');
INSERT INTO USERS VALUES ('ID0000022', '123456', 'MinhUT', 'NV');
INSERT INTO USERS VALUES ('ID0000023', '123456', 'Nhan456', 'NV');
INSERT INTO USERS VALUES ('ID0000024', '123456', 'PhuongKL', 'NV');
INSERT INTO USERS VALUES ('ID0000012', '123456', 'AnVanVo', 'KH');
INSERT INTO USERS VALUES ('ID0000013', '123456', 'Kiet333', 'KH');
INSERT INTO USERS VALUES ('ID0000014', '123456', 'BichQte', 'KH');
INSERT INTO USERS VALUES ('ID0000025', '123456', 'ViNguyen', 'KH');
INSERT INTO USERS VALUES ('ID0000026', '123456', 'TriVan', 'KH');
INSERT INTO USERS VALUES ('ID0000027', '123456', 'LeThij', 'KH');
INSERT INTO USERS VALUES ('ID0000028', '123456', 'DangwBaor', 'KH');
INSERT INTO USERS VALUES ('ID0000029', '123456', 'PhanVan5', 'KH');
INSERT INTO USERS VALUES ('ID0000030', '123456', 'SonHaVo', 'KH');
INSERT INTO USERS VALUES ('ID0000031', '123456', 'AnQuocTruong', 'KH');
INSERT INTO USERS VALUES ('ID0000032', '123456', 'KimcuongTran', 'KH');
INSERT INTO NHAN_VIEN VALUES ('NV0000003', 'Võ Vân', 'Anh', 'Nữ', '1970-06-15', '513, Gò Vấp, TP.HCM', '0939564445', 'Quản lý', 'null', 'SG0000003', 'ID0000004');
INSERT INTO NHAN_VIEN VALUES ('NV0000004', 'Trần Đại', 'Nam', 'Nam', '1970-05-13', '3135, Bình Thạnh, TP.HCM', '0939651230', 'Quản lý', 'null', 'SG0000004', 'ID0000005');
INSERT INTO NHAN_VIEN VALUES ('NV0000005', 'Võ Trí', 'Minh', 'Nam', '1967-06-13', '448, Quận 2, TP.HCM', '0775481147', 'Quầy vé', 'null', 'SG0000000', 'ID0000022');
INSERT INTO NHAN_VIEN VALUES ('NV0000006', 'Phan Minh', 'Nhan', 'Nam', '1978-06-15', '445, Quận 3, TP.HCM', '0939654987', 'Xe', 'Tài xế', 'SG0000000', 'ID0000023');
INSERT INTO NHAN_VIEN VALUES ('NV0000007', 'Ngô Văng', 'Phương', 'Nam', '1987-07-13', '789, Quận 3, TP.HCM', '0939203550', 'Xe', 'Lơ xe', 'SG0000000', 'ID0000024');
INSERT INTO NHAN_VIEN VALUES ('NV0000008', 'Phan Quốc', 'Bình', 'Nam', '1998-06-05', '58/65, Gò Vấp, TP.HCM', '0939561544', 'Quầy vé', 'null', 'SG0000001', 'ID0000015');
INSERT INTO NHAN_VIEN VALUES ('NV0000009', 'Đặng Hùng', 'Cường', 'Nam', '1980-05-14', '548, Quận 1, TP.HCM', '0939454154', 'Xe', 'Tài xế', 'SG0000001', 'ID0000016');
INSERT INTO NHAN_VIEN VALUES ('NV0000010', 'Nguyễn Quốc', 'Dũng', 'Nam', '1978-06-05', '548, Quận 7, TP.HCM', '0939568444', 'Xe', 'Lơ xe', 'SG0000001', 'ID0000017');
INSERT INTO NHAN_VIEN VALUES ('NV0000011', 'Nguyễn Ngọc', 'Hiếu', 'Nữ', '1998-09-05', '5655, Quận 5, TP.HCM', '0939445644', 'Quầy vé', 'null', 'SG0000002', 'ID0000018');
INSERT INTO NHAN_VIEN VALUES ('NV0000012', 'Phan Trường', 'Giang', 'Nam', '1998-02-05', '784, Quận 5, TP.HCM', '0939888745', 'Quầy vé', 'null', 'SG0000002', 'ID0000019');
INSERT INTO NHAN_VIEN VALUES ('NV0000013', 'Phan Vương', 'Khang', 'Nam', '1998-09-16', '588, Quận 3, TP.HCM', '0939465555', 'Xe', 'Tài xế', 'SG0000002', 'ID0000020');
INSERT INTO NHAN_VIEN VALUES ('NV0000014', 'Nguyễn Thị', 'Linh', 'Nữ', '1980-09-05', '456, Quận 1, TP.HCM', '0939456488', 'Xe', 'Lơ xe', 'SG0000002', 'ID0000021');
INSERT INTO NHAN_VIEN VALUES ('NV0000015', 'Nguyễn Hoàng', 'Trung', 'Nam', '1990-07-23', '652, Gò Vấp, TP.HCM', '0939652215', 'Quầy vé', 'null', 'SG0000003', 'ID0000006');
INSERT INTO NHAN_VIEN VALUES ('NV0000016', 'Nguyễn Minh', 'Trí', 'Nam', '1988-12-12', '6562, Tân Bình, TP.HCM', '0939562202', 'Xe', 'Tài xế', 'SG0000003', 'ID0000007');
INSERT INTO NHAN_VIEN VALUES ('NV0000017', 'Bùi Thanh', 'Duy', 'Nam', '1989-12-05', '985, Bình Thạnh, TP.HCM', '0939561211', 'Xe', 'Lơ xe', 'SG0000003', 'ID0000008');
INSERT INTO NHAN_VIEN VALUES ('NV0000018', 'Lương Trí', 'Thông', 'Nam', '2000-06-30', '98962, Quận 1, TP.HCM', '0939656211', 'Quầy vé', 'null', 'SG0000004', 'ID0000009');
INSERT INTO NHAN_VIEN VALUES ('NV0000019', 'Nguyễn Tấn', 'Đạt', 'Nam', '1978-05-05', '6562, Quận 2, TP.HCM', '0939263311', 'Xe', 'Tài xế', 'SG0000004', 'ID0000010');
INSERT INTO NHAN_VIEN VALUES ('NV0000020', 'Phan Nhất', 'Thụ', 'Nam', '1978-06-14', '952, Quận 7, TP.HCM', '0939265611', 'Xe', 'Lơ xe', 'SG0000004', 'ID0000011');

INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000003', 'Hà Bắc');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000005', 'Quang Trung');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000008', 'Bảo Lộc');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000012', 'Nguyễn Trãi');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000015', 'Đông Hải');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000016', 'Xuân Diệu');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000018', 'Nguyễn Du');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000021', 'Vịnh Xuân');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000023', 'Tuyết Sơn');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000024', 'Ngân Sơn');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000027', 'Nam Xương');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000028', 'Nam Hải');

INSERT INTO THANH_VIEN VALUES ('KH0000001', '1980-12-11', 'Tỉnh Cà Mau', 'Nam', 'ID0000013');
INSERT INTO THANH_VIEN VALUES ('KH0000003', '1980-12-11', 'Tỉnh Quảng Ngãi', 'Nữ', 'ID0000014');
INSERT INTO THANH_VIEN VALUES ('KH0000004', '1980-05-03', 'Tỉnh Cà Mau', 'Nam', 'ID0000012');
INSERT INTO THANH_VIEN VALUES ('KH0000006', '1980-12-11', 'Tỉnh Đồng Tháp', 'Nữ', 'ID0000025');
INSERT INTO THANH_VIEN VALUES ('KH0000007', '2001-05-23', 'Tỉnh Hậu Giang', 'Nam', 'ID0000026');
INSERT INTO THANH_VIEN VALUES ('KH0000008', '1980-11-06', 'Tỉnh Cà Mau', 'Nam', 'ID0000027');
INSERT INTO THANH_VIEN VALUES ('KH0000009', '1980-10-02', 'Tỉnh Quảng Ngãi', 'Nữ', 'ID0000028');
INSERT INTO THANH_VIEN VALUES ('KH0000010', '2001-08-23', 'Tỉnh Kiên Giang', 'Nam', 'ID0000029');
INSERT INTO THANH_VIEN VALUES ('KH0000012', '1980-12-11', 'Tỉnh Cà Mau', 'Nam', 'ID0000030');
INSERT INTO THANH_VIEN VALUES ('KH0000013', '2001-01-01', 'Tỉnh Bạc Liêu', 'Nam', 'ID0000031');
INSERT INTO THANH_VIEN VALUES ('KH0000015', '2001-01-01', 'Tỉnh Vĩnh Long', 'Nam', 'ID0000032');

INSERT INTO ve VALUES ('PT0000000', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000000', 'KH0000000');
INSERT INTO ve VALUES ('PT0000001', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000004', 'KH0000001');
INSERT INTO ve VALUES ('PT0000002', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000004', 'KH0000002');
INSERT INTO ve VALUES ('PT0000003', 'Nguyễn Trãi', '2021-12-14', 'LC0000021', 'KH0000003');
INSERT INTO ve VALUES ('TB0000000', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000007', 'KH0000004');
INSERT INTO ve VALUES ('TB0000001', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000023', 'KH0000005');
INSERT INTO ve VALUES ('TB0000002', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000030', 'KH0000006');
INSERT INTO ve VALUES ('ML0000000', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000041', 'KH0000007');
INSERT INTO ve VALUES ('ML0000001', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000018', 'KH0000008');
INSERT INTO ve VALUES ('ML0000002', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000032', 'KH0000009');
INSERT INTO ve VALUES ('VA0000000', 'Xuân Diệu', '2021-12-15', 'LC0000026', 'KH0000010');
INSERT INTO ve VALUES ('VA0000001', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000035', 'KH0000011');
INSERT INTO ve VALUES ('VA0000002', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000035', 'KH0000012');
INSERT INTO ve VALUES ('DN0000000', 'Ngân Sơn', '2021-12-15', 'LC0000036', 'KH0000013');
INSERT INTO ve VALUES ('DN0000001', 'Bến xe Sài Gòn', '2021-12-14', 'LC0000044', 'KH0000014');
INSERT INTO ve VALUES ('DN0000002', 'Bến xe Sài Gòn', '2021-12-15', 'LC0000045', 'KH0000015');

INSERT INTO xuat VALUES ('PT0000000', 'NV0000005');
INSERT INTO xuat VALUES ('PT0000001', 'NV0000005');
INSERT INTO xuat VALUES ('PT0000002', 'NV0000005');
INSERT INTO xuat VALUES ('TB0000000', 'NV0000008');
INSERT INTO xuat VALUES ('TB0000001', 'NV0000008');
INSERT INTO xuat VALUES ('TB0000002', 'NV0000008');
INSERT INTO xuat VALUES ('ML0000000', 'NV0000011');
INSERT INTO xuat VALUES ('ML0000001', 'NV0000011');
INSERT INTO xuat VALUES ('ML0000002', 'NV0000012');
INSERT INTO xuat VALUES ('VA0000001', 'NV0000015');
INSERT INTO xuat VALUES ('VA0000002', 'NV0000015');
INSERT INTO xuat VALUES ('DN0000001', 'NV0000018');
INSERT INTO xuat VALUES ('DN0000002', 'NV0000018');

INSERT INTO phu_trach VALUES ('NV0000006', '51-HK0777');
INSERT INTO phu_trach VALUES ('NV0000006', '51-HK1998');
INSERT INTO phu_trach VALUES ('NV0000006', '51-HK2251');
INSERT INTO phu_trach VALUES ('NV0000007', '51-HK4566');
INSERT INTO phu_trach VALUES ('NV0000007', '51-HK5688');
INSERT INTO phu_trach VALUES ('NV0000007', '51-HK9877');
INSERT INTO phu_trach VALUES ('NV0000009', '51-UL1234');
INSERT INTO phu_trach VALUES ('NV0000009', '51-UL1516');
INSERT INTO phu_trach VALUES ('NV0000009', '51-UL6454');
INSERT INTO phu_trach VALUES ('NV0000010', '51-UL6568');
INSERT INTO phu_trach VALUES ('NV0000010', '51-UL8234');
INSERT INTO phu_trach VALUES ('NV0000010', '51-UL9985');
INSERT INTO phu_trach VALUES ('NV0000013', '51-ER2325');
INSERT INTO phu_trach VALUES ('NV0000013', '51-ER2368');
INSERT INTO phu_trach VALUES ('NV0000013', '51-ER5657');
INSERT INTO phu_trach VALUES ('NV0000014', '51-ER5680');
INSERT INTO phu_trach VALUES ('NV0000014', '51-ER6565');
INSERT INTO phu_trach VALUES ('NV0000014', '51-ER8994');
INSERT INTO phu_trach VALUES ('NV0000016', '51-AV1354');
INSERT INTO phu_trach VALUES ('NV0000016', '51-AV2132');
INSERT INTO phu_trach VALUES ('NV0000016', '51-AV5132');
INSERT INTO phu_trach VALUES ('NV0000017', '51-AV8794');
INSERT INTO phu_trach VALUES ('NV0000017', '51-AV9532');
INSERT INTO phu_trach VALUES ('NV0000017', '51-AV9856');
INSERT INTO phu_trach VALUES ('NV0000019', '51-ND2326');
INSERT INTO phu_trach VALUES ('NV0000019', '51-ND4651');
INSERT INTO phu_trach VALUES ('NV0000019', '51-ND8651');
INSERT INTO phu_trach VALUES ('NV0000020', '51-ND8789');
INSERT INTO phu_trach VALUES ('NV0000020', '51-ND8796');
INSERT INTO phu_trach VALUES ('NV0000020', '51-ND9865');

INSERT INTO hang_hoa VALUES ('KH0000001', 'HH0000000', 200, 100, 10);
INSERT INTO hang_hoa VALUES ('KH0000005', 'HH0000001', 80, 50, 3);
INSERT INTO hang_hoa VALUES ('KH0000009', 'HH0000002', 150, 100, 8);
INSERT INTO hang_hoa VALUES ('KH0000012', 'HH0000003', 100, 100, 8);
INSERT INTO hang_hoa VALUES ('KH0000015', 'HH0000004', 200, 50, 5);