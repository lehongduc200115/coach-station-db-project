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



INSERT INTO NHA_XE VALUES ('SG0000003', 'V??n Anh', 'Vanh@gmail.com', 'B?? Tri???u, Qu???n 1', 'NV0000003', 1);
INSERT INTO NHA_XE VALUES ('SG0000004', '?????i Nam', 'dNam@gmail.com', 'L?? L???i, Qu???n 2', 'NV0000004', 1);

INSERT INTO SDT_NHA_XE VALUES ('SG0000003', '0939101010');
INSERT INTO SDT_NHA_XE VALUES ('SG0000004', '0939222333');

INSERT INTO tuyen_xe VALUES ('TX0000002', 'Tp.H??? Ch?? Minh', 'V??ng T??u', 1);
INSERT INTO tuyen_xe VALUES ('TX0000003', 'Tp.H??? Ch?? Minh', '???? N???ng', 1);
INSERT INTO tuyen_xe VALUES ('TX0000004', 'Tp.H??? Ch?? Minh', 'C?? Mau', 1);

INSERT INTO CHUYEN_XE VALUES ('CX0000011', 'B?? R???a', '2021-12-15', 110000, 'SG0000000', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000012', 'V??ng T??u', '2021-12-14', 110000, 'SG0000000', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000013', 'B?? R???a', '2021-12-15', 120000, 'SG0000001', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000014', 'V??ng T??u', '2021-12-14', 120000, 'SG0000001', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000015', 'V??ng T??u', '2021-12-14', 120000, 'SG0000002', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000016', 'V??ng T??u', '2021-12-15', 100000, 'SG0000003', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000017', 'V??ng T??u', '2021-12-15', 115000, 'SG0000004', 'TX0000002', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000018', '???? N???ng', '2021-12-14', 100000, 'SG0000000', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000019', '???? N???ng', '2021-12-15', 115000, 'SG0000001', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000020', '???? N???ng', '2021-12-14', 100000, 'SG0000002', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000021', '???? N???ng', '2021-12-15', 100000, 'SG0000002', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000022', '???? N???ng', '2021-12-14', 110000, 'SG0000003', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000023', '???? N???ng', '2021-12-15', 110000, 'SG0000003', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000024', '???? N???ng', '2021-12-15', 100000, 'SG0000004', 'TX0000003', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000025', 'C?? Mau', '2021-12-14', 150000, 'SG0000000', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000026', 'C?? Mau', '2021-12-14', 130000, 'SG0000001', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000027', 'C?? Mau', '2021-12-14', 125000, 'SG0000002', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000028', 'C?? Mau', '2021-12-15', 125000, 'SG0000003', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000029', 'C?? Mau', '2021-12-14', 125000, 'SG0000004', 'TX0000004', 1);
INSERT INTO CHUYEN_XE VALUES ('CX0000030', 'C?? Mau', '2021-12-15', 125000, 'SG0000004', 'TX0000004', 1);

INSERT INTO KHACH_HANG VALUES ('KH0000001', 'Nguy???n Anh', 'Ki???t', '0939890549');
INSERT INTO KHACH_HANG VALUES ('KH0000002', 'Nguy???n V??n', 'M???nh', '0776152899');
INSERT INTO KHACH_HANG VALUES ('KH0000003', 'Nguy???n Th???', 'B??ch', '0122987562');
INSERT INTO KHACH_HANG VALUES ('KH0000004', 'Nguy???n V??n', 'An', '0703894502');
INSERT INTO KHACH_HANG VALUES ('KH0000005', 'Nguy???n Qu???c', 'C?????ng', '0939793356');
INSERT INTO KHACH_HANG VALUES ('KH0000006', 'Nguy???n T?????ng', 'Vi', '0939560032');
INSERT INTO KHACH_HANG VALUES ('KH0000007', 'Nguy???n V??n', 'Tr??', '0939895556');
INSERT INTO KHACH_HANG VALUES ('KH0000008', 'Nguy???n Th???', 'L???', '0939332003');
INSERT INTO KHACH_HANG VALUES ('KH0000009', '?????ng Tr???n', 'B???o', '0939250300');
INSERT INTO KHACH_HANG VALUES ('KH0000010', 'Phan V??n', 'N??m', '0939230301');
INSERT INTO KHACH_HANG VALUES ('KH0000011', 'Tr???n Qu???c', 'Trung', '0939233200');
INSERT INTO KHACH_HANG VALUES ('KH0000012', 'V?? S??n', 'H??', '0939784532');
INSERT INTO KHACH_HANG VALUES ('KH0000013', 'Tr????ng Qu???c', 'An', '0939123202');
INSERT INTO KHACH_HANG VALUES ('KH0000014', 'Tr???n C??ng', 'Tr??', '0939895201');
INSERT INTO KHACH_HANG VALUES ('KH0000015', 'Tr???n Kim', 'C?????ng', '0939645208');

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
INSERT INTO NHAN_VIEN VALUES ('NV0000003', 'V?? V??n', 'Anh', 'N???', '1970-06-15', '513, G?? V???p, TP.HCM', '0939564445', 'Qu???n l??', 'null', 'SG0000003', 'ID0000004');
INSERT INTO NHAN_VIEN VALUES ('NV0000004', 'Tr???n ?????i', 'Nam', 'Nam', '1970-05-13', '3135, B??nh Th???nh, TP.HCM', '0939651230', 'Qu???n l??', 'null', 'SG0000004', 'ID0000005');
INSERT INTO NHAN_VIEN VALUES ('NV0000005', 'V?? Tr??', 'Minh', 'Nam', '1967-06-13', '448, Qu???n 2, TP.HCM', '0775481147', 'Qu???y v??', 'null', 'SG0000000', 'ID0000022');
INSERT INTO NHAN_VIEN VALUES ('NV0000006', 'Phan Minh', 'Nhan', 'Nam', '1978-06-15', '445, Qu???n 3, TP.HCM', '0939654987', 'Xe', 'T??i x???', 'SG0000000', 'ID0000023');
INSERT INTO NHAN_VIEN VALUES ('NV0000007', 'Ng?? V??ng', 'Ph????ng', 'Nam', '1987-07-13', '789, Qu???n 3, TP.HCM', '0939203550', 'Xe', 'L?? xe', 'SG0000000', 'ID0000024');
INSERT INTO NHAN_VIEN VALUES ('NV0000008', 'Phan Qu???c', 'B??nh', 'Nam', '1998-06-05', '58/65, G?? V???p, TP.HCM', '0939561544', 'Qu???y v??', 'null', 'SG0000001', 'ID0000015');
INSERT INTO NHAN_VIEN VALUES ('NV0000009', '?????ng H??ng', 'C?????ng', 'Nam', '1980-05-14', '548, Qu???n 1, TP.HCM', '0939454154', 'Xe', 'T??i x???', 'SG0000001', 'ID0000016');
INSERT INTO NHAN_VIEN VALUES ('NV0000010', 'Nguy???n Qu???c', 'D??ng', 'Nam', '1978-06-05', '548, Qu???n 7, TP.HCM', '0939568444', 'Xe', 'L?? xe', 'SG0000001', 'ID0000017');
INSERT INTO NHAN_VIEN VALUES ('NV0000011', 'Nguy???n Ng???c', 'Hi???u', 'N???', '1998-09-05', '5655, Qu???n 5, TP.HCM', '0939445644', 'Qu???y v??', 'null', 'SG0000002', 'ID0000018');
INSERT INTO NHAN_VIEN VALUES ('NV0000012', 'Phan Tr?????ng', 'Giang', 'Nam', '1998-02-05', '784, Qu???n 5, TP.HCM', '0939888745', 'Qu???y v??', 'null', 'SG0000002', 'ID0000019');
INSERT INTO NHAN_VIEN VALUES ('NV0000013', 'Phan V????ng', 'Khang', 'Nam', '1998-09-16', '588, Qu???n 3, TP.HCM', '0939465555', 'Xe', 'T??i x???', 'SG0000002', 'ID0000020');
INSERT INTO NHAN_VIEN VALUES ('NV0000014', 'Nguy???n Th???', 'Linh', 'N???', '1980-09-05', '456, Qu???n 1, TP.HCM', '0939456488', 'Xe', 'L?? xe', 'SG0000002', 'ID0000021');
INSERT INTO NHAN_VIEN VALUES ('NV0000015', 'Nguy???n Ho??ng', 'Trung', 'Nam', '1990-07-23', '652, G?? V???p, TP.HCM', '0939652215', 'Qu???y v??', 'null', 'SG0000003', 'ID0000006');
INSERT INTO NHAN_VIEN VALUES ('NV0000016', 'Nguy???n Minh', 'Tr??', 'Nam', '1988-12-12', '6562, T??n B??nh, TP.HCM', '0939562202', 'Xe', 'T??i x???', 'SG0000003', 'ID0000007');
INSERT INTO NHAN_VIEN VALUES ('NV0000017', 'B??i Thanh', 'Duy', 'Nam', '1989-12-05', '985, B??nh Th???nh, TP.HCM', '0939561211', 'Xe', 'L?? xe', 'SG0000003', 'ID0000008');
INSERT INTO NHAN_VIEN VALUES ('NV0000018', 'L????ng Tr??', 'Th??ng', 'Nam', '2000-06-30', '98962, Qu???n 1, TP.HCM', '0939656211', 'Qu???y v??', 'null', 'SG0000004', 'ID0000009');
INSERT INTO NHAN_VIEN VALUES ('NV0000019', 'Nguy???n T???n', '?????t', 'Nam', '1978-05-05', '6562, Qu???n 2, TP.HCM', '0939263311', 'Xe', 'T??i x???', 'SG0000004', 'ID0000010');
INSERT INTO NHAN_VIEN VALUES ('NV0000020', 'Phan Nh???t', 'Th???', 'Nam', '1978-06-14', '952, Qu???n 7, TP.HCM', '0939265611', 'Xe', 'L?? xe', 'SG0000004', 'ID0000011');

INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000003', 'H?? B???c');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000005', 'Quang Trung');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000008', 'B???o L???c');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000012', 'Nguy???n Tr??i');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000015', '????ng H???i');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000016', 'Xu??n Di???u');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000018', 'Nguy???n Du');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000021', 'V???nh Xu??n');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000023', 'Tuy???t S??n');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000024', 'Ng??n S??n');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000027', 'Nam X????ng');
INSERT INTO TRAM_DON_TRUNG_GIAN VALUES ('CX0000028', 'Nam H???i');

INSERT INTO THANH_VIEN VALUES ('KH0000001', '1980-12-11', 'T???nh C?? Mau', 'Nam', 'ID0000013');
INSERT INTO THANH_VIEN VALUES ('KH0000003', '1980-12-11', 'T???nh Qu???ng Ng??i', 'N???', 'ID0000014');
INSERT INTO THANH_VIEN VALUES ('KH0000004', '1980-05-03', 'T???nh C?? Mau', 'Nam', 'ID0000012');
INSERT INTO THANH_VIEN VALUES ('KH0000006', '1980-12-11', 'T???nh ?????ng Th??p', 'N???', 'ID0000025');
INSERT INTO THANH_VIEN VALUES ('KH0000007', '2001-05-23', 'T???nh H???u Giang', 'Nam', 'ID0000026');
INSERT INTO THANH_VIEN VALUES ('KH0000008', '1980-11-06', 'T???nh C?? Mau', 'Nam', 'ID0000027');
INSERT INTO THANH_VIEN VALUES ('KH0000009', '1980-10-02', 'T???nh Qu???ng Ng??i', 'N???', 'ID0000028');
INSERT INTO THANH_VIEN VALUES ('KH0000010', '2001-08-23', 'T???nh Ki??n Giang', 'Nam', 'ID0000029');
INSERT INTO THANH_VIEN VALUES ('KH0000012', '1980-12-11', 'T???nh C?? Mau', 'Nam', 'ID0000030');
INSERT INTO THANH_VIEN VALUES ('KH0000013', '2001-01-01', 'T???nh B???c Li??u', 'Nam', 'ID0000031');
INSERT INTO THANH_VIEN VALUES ('KH0000015', '2001-01-01', 'T???nh V??nh Long', 'Nam', 'ID0000032');

INSERT INTO ve VALUES ('PT0000000', 'B???n xe S??i G??n', '2021-12-15', 'LC0000000', 'KH0000000');
INSERT INTO ve VALUES ('PT0000001', 'B???n xe S??i G??n', '2021-12-14', 'LC0000004', 'KH0000001');
INSERT INTO ve VALUES ('PT0000002', 'B???n xe S??i G??n', '2021-12-14', 'LC0000004', 'KH0000002');
INSERT INTO ve VALUES ('PT0000003', 'Nguy???n Tr??i', '2021-12-14', 'LC0000021', 'KH0000003');
INSERT INTO ve VALUES ('TB0000000', 'B???n xe S??i G??n', '2021-12-14', 'LC0000007', 'KH0000004');
INSERT INTO ve VALUES ('TB0000001', 'B???n xe S??i G??n', '2021-12-15', 'LC0000023', 'KH0000005');
INSERT INTO ve VALUES ('TB0000002', 'B???n xe S??i G??n', '2021-12-15', 'LC0000030', 'KH0000006');
INSERT INTO ve VALUES ('ML0000000', 'B???n xe S??i G??n', '2021-12-14', 'LC0000041', 'KH0000007');
INSERT INTO ve VALUES ('ML0000001', 'B???n xe S??i G??n', '2021-12-15', 'LC0000018', 'KH0000008');
INSERT INTO ve VALUES ('ML0000002', 'B???n xe S??i G??n', '2021-12-14', 'LC0000032', 'KH0000009');
INSERT INTO ve VALUES ('VA0000000', 'Xu??n Di???u', '2021-12-15', 'LC0000026', 'KH0000010');
INSERT INTO ve VALUES ('VA0000001', 'B???n xe S??i G??n', '2021-12-15', 'LC0000035', 'KH0000011');
INSERT INTO ve VALUES ('VA0000002', 'B???n xe S??i G??n', '2021-12-15', 'LC0000035', 'KH0000012');
INSERT INTO ve VALUES ('DN0000000', 'Ng??n S??n', '2021-12-15', 'LC0000036', 'KH0000013');
INSERT INTO ve VALUES ('DN0000001', 'B???n xe S??i G??n', '2021-12-14', 'LC0000044', 'KH0000014');
INSERT INTO ve VALUES ('DN0000002', 'B???n xe S??i G??n', '2021-12-15', 'LC0000045', 'KH0000015');

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


create trigger users_table_insert
before insert on USERS
for each ROW 
BEGIN 
	insert into users_seq values (NULL);
	set NEW.userID = concat('ID',LPAD(LAST_INSERT_ID() , 7, '0'));
END;

create trigger khach_hang_table_insert
before insert on KHACH_HANG
for each ROW 
BEGIN 
	insert into khach_hang_seq values (NULL);
	set NEW.ma_khach_hang = concat('KH',LPAD(LAST_INSERT_ID() , 7, '0'));
END;


DROP PROCEDURE IF EXISTS `REGISTER`;
CREATE PROCEDURE REGISTER(
	IN ho varchar(25), 
	IN ten varchar(25),
	IN so_dien_thoai varchar(10),
	IN ngay_sinh date, 
	IN gioi_tinh varchar(3),
	IN dia_chi varchar(50), 
	IN userName varchar(20),
	IN pass varchar(20))
BEGIN
	DECLARE uid char(9);
    DECLARE mkh char(9);

    INSERT INTO USERS (userID, pass, userName, vai_tro) VALUES ('', pass, userName, 'KH');
   	SELECT userID into uid FROM USERS ORDER BY userID DESC LIMIT 1;
    INSERT INTO KHACH_HANG (ma_khach_hang, ho, ten, so_dien_thoai) VALUES ('', ho, ten, so_dien_thoai);
   	SELECT ma_khach_hang into mkh FROM KHACH_HANG ORDER BY ma_khach_hang DESC LIMIT 1;
    INSERT INTO THANH_VIEN (ma_khach_hang, ngay_sinh, dia_chi, gioi_tinh, userID) VALUES (mkh, ngay_sinh, dia_chi, gioi_tinh, uid);
END;

ALTER TABLE SG_coach_station.VE MODIFY COLUMN ngay_dat date DEFAULT CURRENT_DATE() NULL;


-- quan ly chuyen xe luot chay nhan vien xe
-- global configuration
SET GLOBAL log_bin_trust_function_creators = 1;

-- kiet
CREATE FUNCTION `ma_moi`(
    `ma` CHAR(9))
RETURNS CHAR(9)
BEGIN
    DECLARE loai_ma CHAR(2);
    DECLARE ma_so CHAR(7); 
    DECLARE temp INT; 

    SET loai_ma = LEFT(ma, 2);
    SET ma_so = RIGHT(ma, 7);
    SET temp = CAST(ma_so AS SIGNED) + 1;
    SET ma_so = LPAD(CAST(temp AS CHAR), 7, "0");
	
    RETURN CONCAT(loai_ma, ma_so);
END;

DROP PROCEDURE IF EXISTS `them_chuyen_xe`;
CREATE PROCEDURE `them_chuyen_xe`(
	IN ten_tram_den VARCHAR(20),
	IN ngay_khoi_hanh VARCHAR(20),
	IN gia_ve VARCHAR(10),
	IN ma_nhaxe char(9),
	IN ma_tuyenxe char(9))
BEGIN
	DECLARE ma_chuyen_moi CHAR(9);
    
    -- Kiem tra nha xe co ton tai
   	IF (SELECT COUNT(*) FROM NHA_XE WHERE ma_nha_xe = ma_nhaxe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? nh?? xe kh??ng t???n t???i !";
	END IF;
    -- Kiem tra tuyen xe co ton tai
    IF (SELECT COUNT(*) FROM TUYEN_XE WHERE ma_tuyen = ma_tuyenxe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? tuy???n xe kh??ng t???n t???i !";
	END IF;

	-- Tien hanh them moi
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	SET ma_chuyen_moi = (SELECT MAX(ma_chuyen) FROM CHUYEN_XE);
	SET ma_chuyen_moi = ma_moi(ma_chuyen_moi);
	INSERT INTO CHUYEN_XE VALUES (ma_chuyen_moi, ten_tram_den, STR_TO_DATE(ngay_khoi_hanh, "%Y-%m-%d"), gia_ve, ma_nhaxe, ma_tuyenxe, TRUE);
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END;

DELIMITER $$
DROP PROCEDURE IF EXISTS `sua_chuyen_xe`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `sua_chuyen_xe`(
	IN ma_chuyenxe char(9),
    IN ten_tram_den_moi VARCHAR(20),
	IN ngay_khoi_hanh_moi VARCHAR(20),
	IN gia_ve_moi VARCHAR(10))
BEGIN
	-- Kiem tra chuyen xe co ton tai
   	IF (SELECT COUNT(*) FROM chuyen_xe WHERE ma_chuyen = ma_chuyenxe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? chuy???n xe kh??ng t???n t???i !";
	END IF;

	-- Tien hanh update
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	UPDATE  
			chuyen_xe
		SET
			ten_tram_den = ten_tram_den_moi,
            ngay_khoi_hanh = STR_TO_DATE(ngay_khoi_hanh, "%Y-%m-%d"),
            gia_ve = gia_ve_moi
		WHERE
			ma_chuyen = ma_chuyenxe;
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `xoa_chuyen_xe`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `xoa_chuyen_xe`(
	IN ma_chuyenxe CHAR(9))
BEGIN
	-- inactive cac luot chay cua chuyen xe
	UPDATE
		LUOT_CHAY 
	SET
		trang_thai = FALSE
	WHERE
		ma_chuyen = ma_chuyenxe;
        
	-- xoa cac tram don trung gian
	DELETE FROM
		tram_don_trung_gian
	WHERE
		ma_chuyen = ma_chuyenxe;
    
    -- xoa chuyen xe
    DELETE FROM
		chuyen_xe
	WHERE
		ma_chuyen = ma_chuyenxe;
       
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `them_luot_chay`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `them_luot_chay`(
	IN gio_khoi_hanh VARCHAR(8),
	IN phu_thu 	int(11),
	IN ma_chuyenxe  char(9),
	IN bien_so_xe char(9))
BEGIN
	DECLARE ma_luot_moi CHAR(9);
    -- Kiem tra chuyen xe co ton tai
   	IF (SELECT COUNT(*) FROM chuyen_xe WHERE ma_chuyen = ma_chuyenxe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? chuy???n xe kh??ng t???n t???i !";
	END IF;
    -- Kiem tra xe co ton tai
    IF (SELECT COUNT(*) FROM xe WHERE bien_so = bien_so_xe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "Bi???n s??? xe kh??ng t???n t???i !";
	END IF;
    
	-- Tien hanh them moi
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	SET ma_luot_moi = (SELECT MAX(ma_luot) FROM luot_chay);
	SET ma_luot_moi = ma_moi(ma_luot_moi);
	INSERT INTO luot_chay VALUES (ma_luot_moi, STR_TO_DATE(gio_khoi_hanh, "%H:%i:%s"), phu_thu, ma_chuyenxe, bien_so_xe, TRUE, TRUE);
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `sua_luot_chay`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `sua_luot_chay`(
	IN ma_luot_chay CHAR(9),
    IN gio_khoi_hanh_moi VARCHAR(8),
	IN phu_thu_moi int(11),
	IN bien_so_moi char(9))
BEGIN
	-- Kiem tra luot chay co ton tai
   	IF (SELECT COUNT(*) FROM luot_chay WHERE ma_luot = ma_luot_chay) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? l?????t ch???y kh??ng t???n t???i !";
	END IF;
	-- Kiem tra xe co ton tai
    IF (SELECT COUNT(*) FROM xe WHERE bien_so = bien_so_moi) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "Bi???n s??? xe kh??ng t???n t???i !";
	END IF;
    
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	UPDATE  
			luot_chay
		SET
			gio_khoi_hanh = STR_TO_DATE(gio_khoi_hanh_moi, "%H:%i:%s"),
            phu_thu = phu_thu_moi,
            bien_so = bien_so_moi
		WHERE
			ma_luot = ma_luot_chay;
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;

-- Procedure xoa_luot_chay nay co san tren file drive cua Khang
DELIMITER $$
DROP PROCEDURE IF EXISTS `xoa_luot_chay`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `xoa_luot_chay`(
	IN ma_luot_chay CHAR(9))
BEGIN
	-- inactive cac luot chay truoc thoi diem xoa
	UPDATE
		LUOT_CHAY 
	INNER JOIN
		CHUYEN_XE
	ON
		LUOT_CHAY.ma_chuyen = CHUYEN_XE.ma_chuyen
	SET
		LUOT_CHAY.trang_thai = FALSE
	WHERE
		ma_luot = ma_luot_chay AND
		ngay_khoi_hanh <= CURDATE() AND
		gio_khoi_hanh <= CURRENT_TIME();
	-- xoa cac luot chay trong tuong lai	
	DELETE FROM
		LUOT_CHAY
	WHERE
		ma_luot IN (SELECT
						ma_luot
					FROM
						LUOT_CHAY
					WHERE
						ma_luot = ma_luot_chay AND	
						trang_thai = TRUE);	
END $$
DELIMITER ;


-- NHAN_VIEN
DELIMITER $$
DROP PROCEDURE IF EXISTS `them_nhan_vien`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `them_nhan_vien`(
	IN ho VARCHAR(25),
	IN ten VARCHAR(25),
	IN gioi_tinh VARCHAR(3),
	IN ngay_sinh char(10),
	IN dia_chi varchar(50),
    IN so_dien_thoai char(10),
	IN loai_nhan_vien VARCHAR(10),
	IN cong_viec VARCHAR(10),
	IN ma_nhaxe char(9),
	IN user_ID char(9))
BEGIN
	DECLARE ma_nv_moi CHAR(9);
    
    -- Kiem tra nha xe co ton tai
   	IF (SELECT COUNT(*) FROM nha_xe WHERE ma_nha_xe = ma_nhaxe) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? nh?? xe kh??ng t???n t???i !";
	END IF;
    -- Kiem tra user co ton tai
    IF (SELECT COUNT(*) FROM users WHERE userID = user_ID) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? users kh??ng t???n t???i !";
	END IF;
    
	-- Tien hanh them moi
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	SET ma_nv_moi = (SELECT MAX(ma_nhan_vien) FROM nhan_vien);
	SET ma_nv_moi = ma_moi(ma_nv_moi);
	INSERT INTO nhan_vien VALUES (ma_nv_moi, ho, ten, gioi_tinh, STR_TO_DATE(ngay_sinh, "%Y-%m-%d"), dia_chi, so_dien_thoai, loai_nhan_vien, cong_viec, ma_nhaxe, user_ID);
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `sua_nhan_vien`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `sua_nhan_vien`(
	IN ma_nv char(9),
    IN ho_moi VARCHAR(25),
	IN ten_moi VARCHAR(25),
	IN gioi_tinh_moi VARCHAR(3),
	IN ngay_sinh_moi char(10),
	IN dia_chi_moi varchar(50),
    IN so_dien_thoai_moi char(10),
	IN loai_nhan_vien_moi VARCHAR(10),
	IN cong_viec_moi VARCHAR(10))
BEGIN
    
    -- Kiem tra nhan vien co ton tai
   	IF (SELECT COUNT(*) FROM nhan_vien WHERE ma_nhan_vien = ma_nv) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? nh??n vi??n kh??ng t???n t???i !";
	END IF;
    
	-- Tien hanh chinh sua
     SET GLOBAL FOREIGN_KEY_CHECKS = 0;
	UPDATE  
			nhan_vien
		SET
            ho = ho_moi,
        	ten = ten_moi,
            gioi_tinh = gioi_tinh_moi,
			ngay_sinh = STR_TO_DATE(ngay_sinh_moi, "%Y-%m-%d"),
            dia_chi = dia_chi_moi, 
            so_dien_thoai = so_dien_thoai_moi,
            loai_nhan_vien = loai_nhan_vien_moi,
            cong_viec =cong_viec_moi
		WHERE
			ma_nhan_vien = ma_nv;
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `xoa_nhan_vien`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `xoa_nhan_vien`(
	IN ma_nv char(9))
BEGIN
    
    -- Kiem tra nhan vien co ton tai
   	IF (SELECT COUNT(*) FROM nhan_vien WHERE ma_nhan_vien = ma_nv) = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "M?? nh??n vi??n kh??ng t???n t???i !";
	END IF;
    
	-- Tien hanh xoa
    SET GLOBAL FOREIGN_KEY_CHECKS = 0;
    DELETE FROM
		nhan_vien
	WHERE
		ma_nhan_vien = ma_nv;
    SET GLOBAL FOREIGN_KEY_CHECKS = 1;
END $$
DELIMITER ;


select COUNT(ma_ve) as so_ve, CONCAT(nv.ho,nv.ten) as ho_ten from XUAT x, NHAN_VIEN nv 
WHERE nv.ma_nhan_vien = x.ma_nhan_vien
GROUP BY x.ma_nhan_vien;

select sum(doanh_thu) as revenue, ten_tram_den as place from ( select COUNT(ma_ve)*cx.gia_ve as doanh_thu, cx.ten_tram_den from VE as v, LUOT_CHAY as lc, CHUYEN_XE as cx where v.ma_luot = lc.ma_luot and cx.ma_chuyen = lc.ma_chuyen GROUP BY v.ma_luot) as ket_qua group by ten_tram_den