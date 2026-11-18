
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account || (sessionScope.account.roleid != 1 && sessionScope.account.roleid != 2)}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa danh mục - Dashboard Admin</title>
<!-- Bootstrap 3.4.1 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Font Awesome 4.7.0 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body, html {
	height: 100%;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
}

/* Header */
.admin-header {
	background-color: #008be5;
	color: #ffffff;
	padding: 12px 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 60px;
}

.admin-header .header-brand {
	font-size: 26px;
	font-weight: 700;
	color: #ffffff;
	text-decoration: none;
}

.admin-header .user-info {
	display: flex;
	align-items: center;
	gap: 15px;
	font-size: 15px;
}

.btn-admin-logout {
	background-color: #ff3b30;
	color: #ffffff;
	padding: 6px 14px;
	border-radius: 4px;
	text-decoration: none;
	font-weight: 500;
	font-size: 14px;
}

.btn-admin-logout:hover {
	background-color: #e02d24;
	color: #ffffff;
}

/* Layout Wrapper */
.admin-wrapper {
	display: flex;
	min-height: calc(100vh - 60px);
}

/* Sidebar */
.admin-sidebar {
	width: 240px;
	background-color: #008be5;
	color: #ffffff;
	flex-shrink: 0;
	padding-top: 15px;
}

.sidebar-profile {
	text-align: center;
	padding-bottom: 20px;
}

.sidebar-avatar {
	width: 105px;
	height: 105px;
	border-radius: 50%;
	border: 3px solid #70c7ff;
	object-fit: cover;
	background-color: #ffffff;
	display: inline-block;
}

.sidebar-role-text {
	color: #ffffff;
	font-size: 14px;
	margin-top: 10px;
	font-weight: 500;
}

/* Sidebar Menu */
.sidebar-menu {
	list-style: none;
	padding: 0;
	margin: 0;
}

.sidebar-menu > li > a {
	display: flex;
	align-items: center;
	padding: 12px 20px;
	color: #ffffff;
	text-decoration: none;
	font-size: 15px;
	font-weight: 500;
}

.sidebar-menu > li.menu-dashboard {
	background-color: #ff0000;
}

.sidebar-menu > li.menu-category {
	background-color: #1a1a1a;
}

.sidebar-menu > li.menu-other {
	background-color: #008be5;
}

.sidebar-menu i.menu-icon {
	width: 26px;
	font-size: 18px;
	margin-right: 10px;
}

/* Submenu */
.sidebar-submenu {
	list-style: none;
	padding: 5px 0 10px 42px;
	margin: 0;
	background-color: #008be5;
	position: relative;
}

.sidebar-submenu::before {
	content: "";
	position: absolute;
	left: 30px;
	top: 5px;
	bottom: 15px;
	width: 2px;
	background-color: #ff6b6b;
}

.sidebar-submenu li {
	position: relative;
	margin: 8px 0;
}

.sidebar-submenu li::before {
	content: "";
	position: absolute;
	left: -12px;
	top: 10px;
	width: 10px;
	height: 2px;
	background-color: #ff6b6b;
}

.sidebar-submenu li a {
	color: #ffffff;
	text-decoration: none;
	font-size: 13px;
}

.sidebar-submenu li a:hover {
	text-decoration: underline;
}

/* Main Content */
.admin-content {
	flex-grow: 1;
	background-color: #ffffff;
	padding: 25px 35px;
	box-shadow: inset 2px 0 6px rgba(0,0,0,0.03);
}

.page-title {
	color: #ff0000;
	font-size: 28px;
	font-weight: 700;
	margin-top: 5px;
	margin-bottom: 4px;
}

.page-subtitle {
	color: #666666;
	font-size: 14px;
	margin-bottom: 25px;
}

/* Panel */
.admin-panel {
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.05);
	max-width: 750px;
}

.admin-panel-header {
	background-color: #f7f7f7;
	border-bottom: 1px solid #e0e0e0;
	padding: 12px 18px;
	font-weight: 600;
	color: #444444;
	font-size: 15px;
}

.admin-panel-body {
	padding: 25px;
}

.current-img-preview {
	width: 120px;
	height: 120px;
	border-radius: 6px;
	object-fit: cover;
	border: 1px solid #dddddd;
	margin-bottom: 12px;
}
</style>
</head>
<body>

	<!-- Top Header -->
	<header class="admin-header">
		<a href="<c:url value='/admin/categories'/>" class="header-brand">Dashboard</a>
		<div class="user-info">
			<span>Xin chào: <strong>
				<c:choose>
					<c:when test="${not empty sessionScope.account.fullname}">${sessionScope.account.fullname}</c:when>
					<c:otherwise>${sessionScope.account.username}</c:otherwise>
				</c:choose>
			</strong></span>
			<a href="<c:url value='/logout'/>" class="btn-admin-logout">Đăng xuất</a>
		</div>
	</header>

	<div class="admin-wrapper">
		<!-- Left Sidebar -->
		<aside class="admin-sidebar">
			<ul class="sidebar-menu">
				<li class="menu-dashboard">
					<a href="<c:url value='/admin/dashboard'/>">
						<i class="fa fa-tachometer menu-icon"></i>
						<span>Dashboard</span>
					</a>
				</li>
				<li class="menu-category">
					<a href="<c:url value='/admin/categories'/>">
						<i class="fa fa-folder-open-o menu-icon"></i>
						<span>Quản lý Danh mục</span>
					</a>
				</li>
				<ul class="sidebar-submenu">
					<li><a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a></li>
					<li><a href="<c:url value='/admin/categories'/>">Danh sách danh mục</a></li>
				</ul>
				<li class="menu-other">
					<a href="<c:url value='/admin/products'/>">
						<i class="fa fa-desktop menu-icon"></i>
						<span>Quản lý sản phẩm</span>
					</a>
				</li>
				<li class="menu-other">
					<a href="<c:url value='/admin/videos'/>">
						<i class="fa fa-video-camera menu-icon"></i>
						<span>Quản lý Video</span>
					</a>
				</li>
				<c:if test="${sessionScope.account.roleid == 1}">
					<li class="menu-other">
						<a href="<c:url value='/admin/users'/>">
							<i class="fa fa-th-large menu-icon"></i>
							<span>Quản lý tài khoản</span>
						</a>
					</li>
				</c:if>
			</ul>
		</aside>

		<!-- Main Content -->
		<main class="admin-content">
			<h1 class="page-title">Chỉnh sửa danh mục</h1>
			<p class="page-subtitle">Nơi bạn có thể cập nhật thông tin danh mục</p>

			<div class="admin-panel">
				<div class="admin-panel-header">
					<i class="fa fa-pencil-square-o"></i> Cập nhật thông tin danh mục #${cate.categoryid}
				</div>
				<div class="admin-panel-body">
					<form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
						<input type="hidden" name="categoryid" value="${cate.categoryid}">

						<div class="form-group">
							<label for="categoryname">Category name:</label>
							<input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" required>
						</div>

						<div class="form-group">
							<label>Hình ảnh hiện tại:</label>
							<div>
								<c:choose>
									<c:when test="${not empty cate.images && cate.images.startsWith('http')}">
										<c:url value="${cate.images}" var="imgUrl" />
									</c:when>
									<c:when test="${not empty cate.images}">
										<c:url value="/image?fname=${cate.images}" var="imgUrl" />
									</c:when>
									<c:otherwise>
										<c:set var="imgUrl" value="https://via.placeholder.com/120?text=No+Image" />
									</c:otherwise>
								</c:choose>
								<img src="${imgUrl}" alt="${cate.categoryname}" class="current-img-preview"
									onerror="this.src='https://via.placeholder.com/120?text=No+Image'" />
							</div>
						</div>

						<div class="form-group">
							<label for="images">Link images mới (nếu có):</label>
							<input type="text" id="images" name="images" value="${cate.images}" class="form-control">
						</div>

						<div class="form-group">
							<label for="images1">Upload images thay thế:</label>
							<input type="file" id="images1" name="images1" class="form-control">
						</div>

						<div class="form-group">
							<label>Status:</label>
							<div class="radio">
								<label>
									<input type="radio" name="status" value="1" ${cate.status == 1 ? "checked" : ""}> Hoạt động
								</label>
								&nbsp;&nbsp;&nbsp;
								<label>
									<input type="radio" name="status" value="0" ${cate.status != 1 ? "checked" : ""}> Khóa
								</label>
							</div>
						</div>

						<div style="margin-top: 25px;">
							<button type="submit" class="btn btn-warning" style="padding: 8px 20px;">
								<i class="fa fa-save"></i> Cập nhật thay đổi
							</button>
							<a href="<c:url value="/admin/categories"/>" class="btn btn-default" style="margin-left: 10px; padding: 8px 18px;">
								Hủy bỏ
							</a>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>

</body>
</html>
