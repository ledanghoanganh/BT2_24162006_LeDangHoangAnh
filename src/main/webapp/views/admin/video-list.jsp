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
<title>Quản lý Video - Dashboard Admin</title>
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

.sidebar-menu > li.menu-active {
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
}

.admin-panel-header {
	background-color: #f7f7f7;
	border-bottom: 1px solid #e0e0e0;
	padding: 12px 18px;
	font-weight: 500;
	color: #444444;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.admin-panel-body {
	padding: 15px 18px;
}

.table-toolbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	font-size: 13px;
	color: #555555;
}

/* Video Table */
.video-table {
	width: 100%;
	border-collapse: collapse;
}

.video-table th {
	border-top: 1px solid #eeeeee;
	border-bottom: 1px solid #dddddd;
	padding: 12px 15px;
	font-weight: 600;
	color: #333333;
	font-size: 14px;
}

.video-table td {
	border-bottom: 1px solid #eeeeee;
	padding: 14px 15px;
	vertical-align: middle;
	font-size: 14px;
	color: #444444;
}

.video-thumb-img {
	width: 110px;
	height: 65px;
	border-radius: 4px;
	object-fit: cover;
	border: 1px solid #ddd;
}

.action-links a {
	color: #337ab7;
	text-decoration: none;
	font-weight: 500;
	margin-right: 8px;
}

.action-links a:hover {
	text-decoration: underline;
}

.action-links a.text-danger {
	color: #d9534f;
}

.action-links a.text-success {
	color: #5cb85c;
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
				<li class="menu-other">
					<a href="<c:url value='/admin/categories'/>">
						<i class="fa fa-folder-open-o menu-icon"></i>
						<span>Quản lý Danh mục</span>
					</a>
				</li>
				<li class="menu-other">
					<a href="<c:url value='/admin/products'/>">
						<i class="fa fa-desktop menu-icon"></i>
						<span>Quản lý sản phẩm</span>
					</a>
				</li>
				<!-- MỤC QUẢN LÝ VIDEO (ACTIVE) -->
				<li class="menu-active">
					<a href="<c:url value='/admin/videos'/>">
						<i class="fa fa-video-camera menu-icon"></i>
						<span>Quản lý Video</span>
					</a>
				</li>
				<ul class="sidebar-submenu">
					<li><a href="<c:url value='/admin/video/add'/>">Thêm video mới</a></li>
					<li><a href="<c:url value='/admin/videos'/>"><strong>Danh sách video</strong></a></li>
				</ul>
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
			<h1 class="page-title">Quản lý Video</h1>
			<p class="page-subtitle">Nơi bạn có thể quản lý danh sách video và upload video mới</p>

			<div class="admin-panel">
				<div class="admin-panel-header">
					<span>Danh sách video</span>
					<a href="<c:url value='/admin/video/add'/>" class="btn btn-sm btn-success">
						<i class="fa fa-plus"></i> Thêm video mới
					</a>
				</div>
				<div class="admin-panel-body">
					<table class="video-table">
						<thead>
							<tr>
								<th style="width: 60px;">STT</th>
								<th style="width: 130px;">Hình ảnh</th>
								<th>Tiêu đề video</th>
								<th style="width: 140px;">Người đăng</th>
								<th style="width: 100px;">Lượt xem</th>
								<th style="width: 110px;">Trạng thái</th>
								<th style="width: 180px;">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listvideo}" var="v" varStatus="loop">
								<tr>
									<td>${loop.index + 1}</td>
									<td>
										<c:choose>
											<c:when test="${v.poster.startsWith('http')}">
												<img src="${v.poster}" class="video-thumb-img" alt="${v.title}">
											</c:when>
											<c:otherwise>
												<img src="<c:url value='/image?fname=${v.poster}'/>" class="video-thumb-img" alt="${v.title}">
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a href="<c:url value='/video/detail?id=${v.videoId}'/>" target="_blank" style="font-weight: 600; color: #0077b5;">
											${v.title}
										</a>
										<p style="color: #777; font-size: 12px; margin: 4px 0 0 0; max-width: 400px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${v.description}
										</p>
									</td>
									<td><strong>${not empty v.user ? v.user.fullname : 'Admin'}</strong></td>
									<td><span class="badge" style="background-color: #5bc0de;">${v.views}</span></td>
									<td>
										<c:choose>
											<c:when test="${v.active == 1}">
												<span class="label label-success">Hoạt động</span>
											</c:when>
											<c:otherwise>
												<span class="label label-default">Tạm khóa</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="action-links">
										<a href="<c:url value='/video/detail?id=${v.videoId}'/>" target="_blank" class="text-success">
											<i class="fa fa-play-circle"></i> Play
										</a>
										<a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>">
											Sửa
										</a>
										<a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="text-danger" onclick="return confirm('Bạn chắc chắn muốn xóa video này?');">
											Xóa
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</main>
	</div>

</body>
</html>
