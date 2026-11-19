<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký tài khoản - VideoHub</title>
</head>
<body>
<div class="card shadow-lg border-0 my-3" style="width: 100%; max-width: 480px; border-radius: 12px;">
	<div class="card-body p-4 p-md-5">
		<div class="text-center mb-4">
			<i class="fa fa-user-plus text-primary fs-1 mb-2"></i>
			<h4 class="fw-bold text-dark">Tạo Tài Khoản Mới</h4>
			<p class="text-muted small">Điền các thông tin bên dưới để đăng ký</p>
		</div>

		<c:if test="${alert != null}">
			<div class="alert alert-danger py-2 mb-3 small"><i class="fa fa-exclamation-circle me-1"></i> ${alert}</div>
		</c:if>

		<form action="<c:url value='/register'/>" method="post">
			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-user"></i></span>
					<input type="text" name="username" class="form-control" placeholder="Tên đăng nhập (3-50 ký tự)" required autofocus>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Họ và tên <span class="text-danger">*</span></label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-id-card"></i></span>
					<input type="text" name="fullname" class="form-control" placeholder="Họ và tên của bạn" required>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Email <span class="text-danger">*</span></label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-envelope"></i></span>
					<input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Số điện thoại</label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-phone"></i></span>
					<input type="tel" name="phone" class="form-control" placeholder="0901234567">
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-lock"></i></span>
					<input type="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" required>
				</div>
			</div>

			<div class="mb-4">
				<label class="form-label small fw-semibold text-secondary">Nhập lại mật khẩu <span class="text-danger">*</span></label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-check-circle"></i></span>
					<input type="password" name="repassword" class="form-control" placeholder="Xác nhận lại mật khẩu" required>
				</div>
			</div>

			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
				<i class="fa fa-check me-1"></i> Tạo tài khoản
			</button>

			<div class="text-center small text-muted">
				Đã có tài khoản? <a href="<c:url value='/login'/>" class="fw-semibold text-decoration-none">Đăng nhập ngay</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
