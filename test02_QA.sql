-- Kiểm tra xem đã có CSDL HighlandsCoffee chưa, nếu có rồi thì xoá nó đi
if exists (select * from sys.databases where name = 'HighlandsCoffee')
	drop database HighlandsCoffee
go
-- Tạo lại CSDL HighlandsCoffee
create database HighlandsCoffee
go
use HighlandsCoffee
go
-- Tạo bảng lưu các tỉnh, TP và mã tỉnh
create table Provinces (
	ProvinceID int primary key,
	ProvinceName nvarchar(200)
)
go
-- Tạo bảng lưu các Huyện 
create table District(
	DistrictID int primary key,
	DistrictName nvarchar(300),
	ProvinceID int foreign key references Provinces(ProvinceID)
)
go
-- Tạo bảng lưu các tiện ích
create table Utilities (
	UtilitiesID int primary key,
	UtilitiesName nvarchar(200)
)
go
-- Tạo bảng lưu trữ tên quán, địa chỉ quán
create table HighLandsCoffeeStore (
	StoreName nvarchar(400) primary key,
	ProvincesID int foreign key references Provinces(ProvinceID),
	DistrictID int foreign key references District(DistrictID),
	Address nvarchar(400),
	UtilitiesID　int foreign key references Utilities
)
-- Thêm dữ liệu vào các bảng
insert into Provinces(ProvinceID, ProvinceName)
	values
		(29, N'Hà Nội'),
		(35, N'Ninh Bình'),
		(50, N'Thành Phố Hồ Chí Minh')
select * from Provinces
insert into District(ProvinceID, DistrictID, DistrictName)
	values
		(29, 01, N'Hà Đông'),
		(29, 02, N'Thanh Xuân'),
		(29, 03, N'Cầu Giấy'),
		(35, 04, N'Thành Phố Ninh Bình'),
		(50, 05, N'Quận 1'),
		(50, 06, N'Quận 10'),
		(50, 07, N'Quận Bình Thạnh')
select * from District
insert into  Utilities(UtilitiesID, UtilitiesName)
	values
		(1, N'Wifi miễn phí'),
		(2, N'Thanh toán bằng thẻ'),
		(3, N'Wifi miễn phí và Thanh toán bằng thẻ')
select * from Utilities
insert into HighLandsCoffeeStore(StoreName, ProvincesID, DistrictID, Address ,UtilitiesID)
	values
		(N'Highlands Coffee Nguyễn Văn Lộc', 29, 01, N'16b2 Nguyễn Văn Lộc', 3),
		(N'Highlands Coffee AEON MALL Hà Đông', 29, 01, N'AEON MALL Dương Nội, Hà Đông', 3),
		(N'Highlands Coffee Phúc Thành', 35, 04, N'12b Phúc Thành, Tp.Ninh Bình', 1),
		(N'Highlands Coffee Nguyễn Bỉnh Khiêm', 50, 05, N'16a Nguyễn Bỉnh Khiêm', 3),
		(N'Highlands Coffee Nguyễn Chí Thanh', 50, 06, N'21b2 Nguyễn Chí Thanh', 2),
		(N'Highlands Coffee Đinh Tiên Hoàng', 50, 07, N'82b Đinh Tiên Hoàng', 3)
select * from HighlandsCoffeeStore
-- Truy Vấn
	-- Truy vấn tới các quán ở Hà Nội
	select StoreName, Address from HighLandsCoffeeStore
	where ProvincesID = 29
	-- Truy vấn tới các quán ở quận 1 Tp.HCM
	select StoreName, Address from HighLandsCoffeeStore
	where ProvincesID = 50 and DistrictID = 05
	-- Truy vấn tới các quán có tiện ích wifi miễn phí
	select StoreName, Address from HighLandsCoffeeStore
	where UtilitiesID = 1 or UtilitiesID = 3
