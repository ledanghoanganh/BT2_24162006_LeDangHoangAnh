-- Thêm tài khoản test (Mật khẩu: 123456)
-- Tài khoản admin (roleid = 1) vào được trang quản lý /admin/category/list
INSERT INTO users (avatar, createddate, email, fullname, password, phone, roleid, username)
VALUES ('admin.png', NULL, "admin@gmail.com", 'Nguyen Admin', 123456, '0123456789', 1, 'admin'),
('user.png', CURDATE(), 'user@gmail.com', 'Nguyễn Văn A', 123456, '0901234567', 2, 'user1');