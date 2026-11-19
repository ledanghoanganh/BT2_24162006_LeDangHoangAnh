-- ===================================================
-- DATABASE SCHEMA CHO DỰ ÁN BÁN HÀNG & VIDEO (JPA HIBERNATE)
-- Database Name: BanHang
-- Hệ quản trị CSDL: MySQL 8.x
-- ===================================================

CREATE DATABASE IF NOT EXISTS `BanHang` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `BanHang`;

-- ===================================================
-- 1. BẢNG DANH MỤC (categories)
-- ===================================================
CREATE TABLE IF NOT EXISTS `categories` (
    `categoryid` INT AUTO_INCREMENT PRIMARY KEY,
    `categoryname` VARCHAR(50) NOT NULL,
    `images` VARCHAR(500) NULL,
    `status` INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- 2. BẢNG NGƯỜI DÙNG (users)
-- roleid: 1 (Admin), 2 (Manager), 5 (User)
-- status: 1 (Hoạt động), 0 (Chưa kích hoạt / Cần OTP)
-- ===================================================
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `avatar` VARCHAR(255) NULL,
    `createddate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    `email` VARCHAR(255) NULL,
    `fullname` VARCHAR(255) NULL,
    `password` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) NULL,
    `roleid` INT NOT NULL DEFAULT 5,
    `username` VARCHAR(255) NOT NULL UNIQUE,
    `status` INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- 3. BẢNG VIDEO (videos)
-- Quan hệ 1-Nhiều với users (userId) và categories (CategoryId)
-- ===================================================
CREATE TABLE IF NOT EXISTS `videos` (
    `VideoId` VARCHAR(50) NOT NULL PRIMARY KEY,
    `Title` VARCHAR(500) NOT NULL,
    `Description` VARCHAR(1000) NULL,
    `Poster` VARCHAR(500) NULL,
    `VideoPath` VARCHAR(500) NULL,
    `Views` INT NOT NULL DEFAULT 0,
    `Active` INT NOT NULL DEFAULT 1,
    `userId` INT NOT NULL,
    `CategoryId` INT NULL,
    `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_video_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_video_category` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`categoryid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- DỮ LIỆU MẪU (SEED DATA)
-- Mật khẩu mặc định: 123456
-- (Hệ thống tự động hỗ trợ đăng nhập mật khẩu thô và tự băm BCrypt)
-- ===================================================

-- 1. Dữ liệu Danh mục mẫu
INSERT INTO `categories` (`categoryid`, `categoryname`, `images`, `status`) VALUES
(1, 'Quần Áo Nam', 'https://via.placeholder.com/140x100?text=Quan+Ao+Nam', 1),
(2, 'Quần Áo Nữ', 'https://via.placeholder.com/140x100?text=Quan+Ao+Nu', 1),
(3, 'Iphone', 'https://via.placeholder.com/140x100?text=Iphone', 1)
ON DUPLICATE KEY UPDATE `categoryname` = VALUES(`categoryname`);

-- 2. Dữ liệu Người dùng mẫu
INSERT INTO `users` (`id`, `avatar`, `createddate`, `email`, `fullname`, `password`, `phone`, `roleid`, `username`, `status`) VALUES
(1, 'admin.png', NOW(), 'admin@gmail.com', 'Nguyen Admin', '123456', '0123456789', 1, 'admin', 1),
(2, 'manager.png', NOW(), 'manager@gmail.com', 'Trần Quản Lý', '123456', '0901234567', 2, 'manager', 1),
(3, 'user.png', NOW(), 'user@gmail.com', 'Nguyễn Khách Hàng', '123456', '0987654321', 5, 'user1', 1)
ON DUPLICATE KEY UPDATE `fullname` = VALUES(`fullname`);

-- 3. Dữ liệu Video mẫu
INSERT INTO `videos` (`VideoId`, `Title`, `Description`, `Poster`, `VideoPath`, `Views`, `Active`, `userId`, `CategoryId`, `CreatedDate`) VALUES
('VID01', 'Hướng dẫn lập trình Web Servlet & JSP cơ bản', 'Video hướng dẫn chi tiết kiến trúc MVC trong Java Servlet', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500', 'sample.mp4', 15, 1, 1, 1, NOW()),
('VID02', 'Cấu hình JPA Hibernate với MySQL 8.x', 'Từng bước kết nối JPA Hibernate và sử dụng EntityManagerFactory', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=500', 'sample.mp4', 28, 1, 1, 1, NOW()),
('VID03', 'Xây dựng chức năng Upload Video dung lượng lớn 500MB', 'Xử lý MultipartConfig và phân trang 6 items trên trang', 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=500', 'sample.mp4', 42, 1, 2, 2, NOW()),
('VID04', 'Streaming Video HTML5 với HTTP Range Request', 'Kỹ thuật tua video nhanh mượt mà không bị nghẽn mạng', 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500', 'sample.mp4', 9, 1, 3, 3, NOW())
ON DUPLICATE KEY UPDATE `Title` = VALUES(`Title`);
