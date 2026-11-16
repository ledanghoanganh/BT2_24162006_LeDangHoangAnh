<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác thực mã OTP - Kích hoạt tài khoản</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
body {
	background-color: #f7f7f7;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		Arial, sans-serif;
}

.otp-box {
	max-width: 440px;
	margin: 80px auto;
	background: #fff;
	padding: 30px;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

.otp-input {
	letter-spacing: 6px;
	font-size: 24px;
	text-align: center;
	font-weight: bold;
	height: 50px;
}
</style>
</head>
<body>
	<div class="otp-box">
		<h3 class="text-center" style="margin-top: 0;">Kích Hoạt Tài
			Khoản</h3>
		<p class="text-center text-muted">
			Mã OTP gồm 6 chữ số đã được gửi tới email của bạn (<strong>${sessionScope.REGISTER_EMAIL}</strong>).
			Vui lòng nhập mã để kích hoạt.
		</p>

		<c:if test="${error != null}">
			<div class="alert alert-danger">${error}</div>
		</c:if>
		<c:if test="${message != null}">
			<div class="alert alert-success">${message}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/verify-otp"
			method="post">
			<div class="form-group">
				<input type="text" name="otp" maxlength="6"
					class="form-control otp-input" placeholder="------" required
					autofocus>
			</div>
			<button type="submit" class="btn btn-primary btn-block btn-lg">Xác
				nhận kích hoạt</button>
		</form>

		<form action="${pageContext.request.contextPath}/verify-otp"
			method="post" style="margin-top: 15px;" class="text-center">
			<input type="hidden" name="action" value="resend"> <span>Không
				nhận được mã? </span>
			<button type="submit" class="btn btn-link" style="padding: 0;">Gửi
				lại mã OTP</button>
		</form>
	</div>
</body>
</html>
