create database Ung_Dung_Dao_Tao_Chung_Chi_Tieng_Anh

go 
use Ung_Dung_Dao_Tao_Chung_Chi_Tieng_Anh
go

-- Tạo bảng TaiKhoan
CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY IDENTITY(1,1),
    HoTen VARCHAR(50) NOT NULL,
    GioiTinh CHAR(3) NOT NULL CHECK(GioiTinh IN(N'Nam',N'Nữ'))
    Email VARCHAR(30) UNIQUE NOT NULL,
    MatKhau VARCHAR(50) NOT NULL, 
    VaiTro NVARCHAR(100) NOT NULL CHECK(VaiTro IN(N'Người dùng',N'Quản trị viên',N'Chuyên viên')), 
    SoDienThoai VARCHAR(10) NOT NULL, 
    NgaySinh DATE NOT NULL,
    NgayDangKy DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tạo bảng Khóa học
CREATE TABLE KhoaHoc (
    MaKhoaHoc INT PRIMARY KEY IDENTITY(1,1),
    TenKhoaHoc VARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX),
    ThoiLuong INT NOT NULL,
    HocPhi DECIMAL(10, 2) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL
);

-- Tạo bảng Bài học
CREATE TABLE BaiHoc (
    MaBaiHoc INT PRIMARY KEY IDENTITY(1,1),
    MaKhoaHoc INT NOT NULL,
    TieuDe VARCHAR(100) NOT NULL,
    NoiDung NVARCHAR(MAX),
    FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
);

-- Tạo bảng Bài kiểm tra
CREATE TABLE BaiKiemTra (
    MaBaiKiemTra INT PRIMARY KEY IDENTITY(1,1),
    MaKhoaHoc INT NOT NULL,
    LoaiBaiKiemTra NVARCHAR(100) NOT NULL CHECK(LoaiBaiKiemTra IN(N'Đầu vào',N'Giữa kỳ',N'Cuối kỳ')),
    ThoiGian INT NOT NULL,
    FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
);

-- Tạo bảng Kết quả kiểm tra
CREATE TABLE KetQuaKiemTra (
    MaKetQua INT PRIMARY KEY IDENTITY(1,1),
    MaBaiKiemTra INT NOT NULL,
    MaTaiKhoan INT NOT NULL,
    DiemSo DECIMAL(5, 2) NOT NULL,
    NgayLamBai DATETIME NOT NULL,
    FOREIGN KEY (MaBaiKiemTra) REFERENCES BaiKiemTra(MaBaiKiemTra),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Tạo bảng Chứng chỉ
CREATE TABLE ChungChi (
    MaChungChi INT PRIMARY KEY IDENTITY(1,1),
    MaTaiKhoan INT NOT NULL,
    MaKhoaHoc INT NOT NULL,
    NgayCap DATE NOT NULL,
    Theloai String NOT NULL,
    FOREIGN KEY (MaTaiKhoan) REFERENCES NguoiDung(MaTaiKhoan),
    FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
);

-- Tạo bảng Đăng ký khóa học
CREATE TABLE DangKyKhoaHoc (
    MaDangKy INT PRIMARY KEY IDENTITY(1,1),
    MaTaiKhoan INT NOT NULL,
    MaKhoaHoc INT NOT NULL,
    NgayDangKy DATETIME DEFAULT CURRENT_TIMESTAMP,
    TrangThai NVARCHAR(100) CHECK(TrangThai IN(N'Đang học', N'Hoàn thành', N'Hủy bỏ')),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
);
