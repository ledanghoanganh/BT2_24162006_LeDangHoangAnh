<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kích hoạt tài khoản - VideoHub</title>
<style>
.otp-input {
	letter-spacing: 8px;
	font-size: 24px;
	text-align: center;
	font-weight: bold;
	height: 52px;
}
</style>
</head>
<body>
<div class="card shadow-lg border-0" style="width: 100%; max-width: 440px; border-radius: 12px;">
	<div class="card-body p-4 p-md-5">
		<div class="text-center mb-4">
			<i class="fa fa-envelope-open text-primary fs-1 mb-2"></i>
			<h4 class="fw-bold text-dark">Kích Hoạt Tài Khoản</h4>
			<p class="text-muted small">
				Mã OTP 6 số đã được gửi tới email <strong>${sessionScope.REGISTER_EMAIL}</strong>
			</p>
		</div>

		<c:if test="${error != null}">
			<div class="alert alert-danger py-2 mb-3 small"><i class="fa fa-exclamation-circle me-1"></i> ${error}</div>
		</c:if>
		<c:if test="${message != null}">
			<div class="alert alert-success py-2 mb-3 small"><i class="fa fa-check-circle me-1"></i> ${message}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/verify-otp" method="post">
			<div class="mb-4">
				<input type="text" name="otp" maxlength="6" class="form-control otp-input" placeholder="------" required autofocus>
			</div>

			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
				<i class="fa fa-check me-1"></i> Xác nhận kích hoạt
			</button>

			<div class="text-center small text-muted">
				<a href="<c:url value='/login'/>" class="text-decoration-none">Quay lại đăng nhập</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
