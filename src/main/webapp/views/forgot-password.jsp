<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Khôi phục mật khẩu - VideoHub</title>
</head>
<body>
<div class="card shadow-lg border-0" style="width: 100%; max-width: 440px; border-radius: 12px;">
	<div class="card-body p-4 p-md-5">
		<div class="text-center mb-4">
			<i class="fa fa-key text-warning fs-1 mb-2"></i>
			<h4 class="fw-bold text-dark">Khôi Phục Mật Khẩu</h4>
			<p class="text-muted small">Nhập tên tài khoản hoặc email để nhận mã OTP xác thực</p>
		</div>

		<c:if test="${error != null}">
			<div class="alert alert-danger py-2 mb-3 small"><i class="fa fa-exclamation-circle me-1"></i> ${error}</div>
		</c:if>

		<form action="<c:url value='/forgot-password'/>" method="post">
			<div class="mb-4">
				<label class="form-label small fw-semibold text-secondary">Tài khoản hoặc Email</label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-user"></i></span>
					<input type="text" name="keyword" class="form-control" placeholder="Nhập username hoặc email..." required autofocus>
				</div>
			</div>

			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
				<i class="fa fa-paper-plane me-1"></i> Gửi mã OTP
			</button>

			<div class="text-center small text-muted">
				<a href="<c:url value='/login'/>" class="text-decoration-none"><i class="fa fa-arrow-left me-1"></i> Quay lại đăng nhập</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
