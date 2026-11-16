<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
body {
	background-color: #f7f7f7;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		Arial, sans-serif;
}

.box-container {
	max-width: 420px;
	margin: 80px auto;
	background: #fff;
	padding: 30px;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}
</style>
</head>
<body>
	<div class="box-container">
		<h3 class="text-center" style="margin-top: 0;">Khôi Phục Mật Khẩu</h3>
		<p class="text-center text-muted">Nhập tên tài khoản hoặc email của bạn để nhận mã xác thực OTP.</p>

		<c:if test="${error != null}">
			<div class="alert alert-danger">${error}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/forgot-password"
			method="post">
			<div class="form-group">
				<label>Tài khoản hoặc Email:</label>
				<input type="text" name="keyword" class="form-control"
					placeholder="Nhập username hoặc email..." required autofocus>
			</div>
			<button type="submit" class="btn btn-primary btn-block btn-lg">Gửi mã OTP</button>
			<div class="text-center" style="margin-top: 15px;">
				<a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
			</div>
		</form>
	</div>
</body>
</html>
