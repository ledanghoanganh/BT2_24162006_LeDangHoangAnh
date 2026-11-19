<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu - VideoHub</title>
<style>
.otp-input {
	letter-spacing: 6px;
	font-size: 22px;
	text-align: center;
	font-weight: bold;
}
</style>
</head>
<body>
<div class="card shadow-lg border-0" style="width: 100%; max-width: 440px; border-radius: 12px;">
	<div class="card-body p-4 p-md-5">
		<div class="text-center mb-4">
			<i class="fa fa-shield-alt text-success fs-1 mb-2"></i>
			<h4 class="fw-bold text-dark">Đặt Lại Mật Khẩu</h4>
			<p class="text-muted small">
				Mã OTP đã được gửi đến email <strong>${sessionScope.RESET_EMAIL}</strong>
			</p>
		</div>

		<c:if test="${error != null}">
			<div class="alert alert-danger py-2 mb-3 small"><i class="fa fa-exclamation-circle me-1"></i> ${error}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/reset-password" method="post">
			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Mã xác thực OTP (6 chữ số)</label>
				<input type="text" name="otp" maxlength="6" class="form-control otp-input" placeholder="------" required autofocus>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Mật khẩu mới</label>
				<input type="password" name="newPassword" class="form-control" placeholder="Tối thiểu 6 ký tự" required>
			</div>

			<div class="mb-4">
				<label class="form-label small fw-semibold text-secondary">Xác nhận mật khẩu mới</label>
				<input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
			</div>

			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
				<i class="fa fa-check me-1"></i> Lưu mật khẩu mới
			</button>

			<div class="text-center small text-muted">
				<a href="<c:url value='/login'/>" class="text-decoration-none">Quay lại đăng nhập</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
