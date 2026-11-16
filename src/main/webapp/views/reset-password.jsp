<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
body {
	background-color: #f7f7f7;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		Arial, sans-serif;
}

.box-container {
	max-width: 440px;
	margin: 70px auto;
	background: #fff;
	padding: 30px;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

.otp-input {
	letter-spacing: 5px;
	font-size: 20px;
	text-align: center;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="box-container">
		<h3 class="text-center" style="margin-top: 0;">Đặt Lại Mật Khẩu</h3>
		<p class="text-center text-muted">
			Mã OTP đã gửi tới email <strong>${sessionScope.RESET_EMAIL}</strong>.
		</p>

		<c:if test="${error != null}">
			<div class="alert alert-danger">${error}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/reset-password"
			method="post">
			<div class="form-group">
				<label>Mã OTP (6 số):</label> <input type="text" name="otp"
					maxlength="6" class="form-control otp-input" placeholder="------"
					required autofocus>
			</div>
			<div class="form-group">
				<label>Mật khẩu mới:</label> <input type="password"
					name="newPassword" class="form-control"
					placeholder="Nhập mật khẩu mới" required>
			</div>
			<div class="form-group">
				<label>Xác nhận mật khẩu mới:</label> <input type="password"
					name="confirmPassword" class="form-control"
					placeholder="Nhập lại mật khẩu mới" required>
			</div>
			<button type="submit" class="btn btn-success btn-block btn-lg">Cập
				nhật mật khẩu</button>
			<div class="text-center" style="margin-top: 15px;">
				<a href="${pageContext.request.contextPath}/login">Hủy bỏ và
					quay lại</a>
			</div>
		</form>
	</div>
</body>
</html>
