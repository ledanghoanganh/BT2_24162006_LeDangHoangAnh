<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản phẩm ${categoryName} - Đang phát triển</title>
<!-- Bootstrap 3.4.1 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Font Awesome 4.7.0 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	background-color: #f5f5f5;
	font-family: Arial, sans-serif;
}

.top-navbar {
	background-color: #0099e6;
	color: white;
	padding: 12px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-navbar a {
	color: white;
	text-decoration: none;
}

.top-navbar .btn-logout,
.top-navbar .btn-login {
	background-color: #e65100;
	padding: 5px 12px;
	border-radius: 3px;
	color: white;
	font-weight: 500;
	display: inline-block;
}

.top-navbar .btn-logout:hover,
.top-navbar .btn-login:hover {
	background-color: #bf360c;
	color: white;
	text-decoration: none;
}

.main-container {
	padding: 25px;
}

.content-box {
	background: #ffffff;
	padding: 30px;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.dev-container {
	text-align: center;
	padding: 40px 20px;
}

.dev-icon {
	color: #0099e6;
	margin-bottom: 20px;
}

.breadcrumb {
	background-color: #f8f9fa;
	margin-bottom: 25px;
	font-size: 14px;
}
</style>
</head>
<body>
	<!-- Top Navbar đồng bộ giao diện người dùng -->
	<div class="top-navbar">
		<div>
			<a href="<c:url value='/home'/>" style="font-size: 18px; font-weight: bold;">
				<i class="fa fa-shopping-bag"></i> Trang chủ
			</a>
			<span style="margin: 0 10px;">|</span>
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<span>Xin chào: <strong>
						<c:choose>
							<c:when test="${not empty sessionScope.account.fullname}">${sessionScope.account.fullname}</c:when>
							<c:otherwise>${sessionScope.account.username}</c:otherwise>
						</c:choose>
					</strong></span>
					<c:if test="${sessionScope.account.roleid == 1}">
						<span class="label label-danger" style="margin-left: 8px;">Admin</span>
					</c:if>
					<c:if test="${sessionScope.account.roleid == 2}">
						<span class="label label-warning" style="margin-left: 8px;">Manager</span>
					</c:if>
					<c:if test="${sessionScope.account.roleid == 5}">
						<span class="label label-info" style="margin-left: 8px;">User</span>
					</c:if>
				</c:when>
				<c:otherwise>
					<span>Xin chào <strong>Guest</strong></span>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<c:if test="${sessionScope.account.roleid == 1}">
						<a href="<c:url value='/admin/categories'/>" class="btn btn-sm btn-info" style="margin-right: 10px; color: white;">
							<i class="fa fa-cogs"></i> Trang Quản Trị
						</a>
					</c:if>
					<a href="<c:url value='/logout'/>" class="btn-logout">
						<i class="fa fa-sign-out"></i> Đăng xuất
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/login'/>" class="btn-login">
						<i class="fa fa-sign-in"></i> Đăng nhập
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Khung nội dung chính -->
	<div class="container-fluid main-container">
		<div class="content-box">
			<ol class="breadcrumb">
				<li><a href="<c:url value='/home'/>"><i class="fa fa-home"></i> Trang chủ</a></li>
				<li><a href="<c:url value='/home'/>">Danh mục</a></li>
				<li class="active">${categoryName}</li>
			</ol>

			<div class="dev-container">
				<div class="dev-icon">
					<i class="fa fa-cubes fa-5x"></i>
				</div>
				<h2 style="color: #333333; font-weight: bold; margin-top: 0;">
					Sản phẩm thuộc danh mục: <span style="color: #0099e6;">${categoryName}</span>
				</h2>
				<h3 style="color: #e65100; font-weight: 600; margin-top: 15px;">
					<i class="fa fa-wrench"></i> Tính năng đang được phát triển
				</h3>
				<p style="color: #777777; font-size: 16px; margin: 15px auto 30px auto; max-width: 550px; line-height: 1.6;">
					Chức năng hiển thị danh sách các sản phẩm và chi tiết sản phẩm thuộc danh mục <strong>${categoryName}</strong> hiện đang được xây dựng và sẽ sớm ra mắt.
				</p>
				<a href="<c:url value='/home'/>" class="btn btn-primary btn-lg" style="border-radius: 4px; padding: 10px 30px;">
					<i class="fa fa-arrow-left"></i> Quay lại Danh sách danh mục
				</a>
			</div>
		</div>
	</div>
</body>
</html>
