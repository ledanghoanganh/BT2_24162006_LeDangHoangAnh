-- ===================================================
-- DATABASE SCHEMA CHO DỰ ÁN BÁN HÀNG (JPA HIBERNATE)
-- Database Name: BanHang
-- ===================================================

CREATE DATABASE IF NOT EXISTS `BanHang` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `BanHang`;

-- 1. Bảng danh mục sản phẩm (categories)
CREATE TABLE IF NOT EXISTS `categories` (
    `CategoryId` INT AUTO_INCREMENT PRIMARY KEY,
    `CategoryName` VARCHAR(50) NOT NULL,
    `Images` VARCHAR(500) NULL,
    `Status` INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng video liên kết với danh mục (videos)
CREATE TABLE IF NOT EXISTS `videos` (
    `VideoId` VARCHAR(50) PRIMARY KEY,
    `Active` INT NOT NULL DEFAULT 1,
    `Description` VARCHAR(500) NULL,
    `Poster` VARCHAR(500) NULL,
    `Title` VARCHAR(500) NULL,
    `Views` INT DEFAULT 0,
    `CategoryId` INT NULL,
    CONSTRAINT `fk_video_category` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng người dùng (users)
-- roleid: 1 (Admin), 2 (Manager), 5 (User)
-- status: 1 (Đã kích hoạt / Hoạt động), 0 (Chưa kích hoạt / Cần OTP)
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NULL,
    `username` VARCHAR(255) NOT NULL UNIQUE,
    `fullname` VARCHAR(255) NULL,
    `password` VARCHAR(255) NOT NULL,
    `avatar` VARCHAR(255) NULL,
    `roleid` INT NOT NULL DEFAULT 5,
    `phone` VARCHAR(50) NULL,
    `createddate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    `status` INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- DỮ LIỆU MẪU (SEED DATA)
-- Mật khẩu mặc định của các tài khoản mẫu: 123456
-- (Hệ thống hỗ trợ tự động băm BCrypt khi đăng nhập lần đầu)
-- ===================================================

-- Dữ liệu danh mục mẫu
INSERT INTO `categories` (`CategoryId`, `CategoryName`, `Images`, `Status`) VALUES
(1, 'Quần Áo Nam', 'https://via.placeholder.com/140x100?text=Quan+Ao+Nam', 1),
(2, 'Quần Áo Nữ', 'https://via.placeholder.com/140x100?text=Quan+Ao+Nu', 1),
(3, 'Iphone', 'https://via.placeholder.com/140x100?text=Iphone', 1)
ON DUPLICATE KEY UPDATE `CategoryName` = VALUES(`CategoryName`);

-- Dữ liệu người dùng mẫu
-- Mật khẩu: 123456 (hoặc băm BCrypt $2a$10$wE7YgO0zO0W4E5M2F7x.Nu4x2e9fF5u8i.p6k9y0a3b2c1d0e)
INSERT INTO `users` (`id`, `email`, `username`, `fullname`, `password`, `avatar`, `roleid`, `phone`, `createddate`, `status`) VALUES
(1, 'admin@gmail.com', 'admin', 'Nguyen Admin', '123456', 'admin.png', 1, '0123456789', NOW(), 1),
(2, 'manager@gmail.com', 'manager', 'Trần Quản Lý', '123456', 'manager.png', 2, '0901234567', NOW(), 1),
(3, 'user@gmail.com', 'user1', 'Nguyễn Khách Hàng', '123456', 'user.png', 5, '0987654321', NOW(), 1)
ON DUPLICATE KEY UPDATE `fullname` = VALUES(`fullname`);
