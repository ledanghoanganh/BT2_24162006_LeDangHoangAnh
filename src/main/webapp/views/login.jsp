<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập hệ thống - VideoHub</title>
</head>
<body>
<div class="card shadow-lg border-0" style="width: 100%; max-width: 420px; border-radius: 12px;">
	<div class="card-body p-4 p-md-5">
		<div class="text-center mb-4">
			<i class="fa fa-play-circle text-primary fs-1 mb-2"></i>
			<h4 class="fw-bold text-dark">Đăng Nhập Vào Hệ Thống</h4>
			<p class="text-muted small">Nhập thông tin tài khoản của bạn để tiếp tục</p>
		</div>

		<c:if test="${alert != null}">
			<div class="alert alert-danger py-2 mb-3 small"><i class="fa fa-exclamation-circle me-1"></i> ${alert}</div>
		</c:if>

		<form action="<c:url value='/login'/>" method="post">
			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Tên đăng nhập</label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-user"></i></span>
					<input type="text" name="username" class="form-control" placeholder="Nhập tài khoản" required autofocus>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label small fw-semibold text-secondary">Mật khẩu</label>
				<div class="input-group">
					<span class="input-group-text bg-light text-muted"><i class="fa fa-lock"></i></span>
					<input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
				</div>
			</div>

			<div class="d-flex justify-content-between align-items-center mb-4 small">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" name="remember" value="ok" id="rememberMe">
					<label class="form-check-label text-secondary" for="rememberMe">Nhớ tôi</label>
				</div>
				<a href="<c:url value='/forgot-password'/>" class="text-decoration-none">Quên mật khẩu?</a>
			</div>

			<button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
				<i class="fa fa-sign-in-alt me-1"></i> Đăng nhập
			</button>

			<div class="text-center small text-muted">
				Chưa có tài khoản? <a href="<c:url value='/register'/>" class="fw-semibold text-decoration-none">Đăng ký ngay</a>
			</div>
		</form>
	</div>
</div>
</body>
</html>
