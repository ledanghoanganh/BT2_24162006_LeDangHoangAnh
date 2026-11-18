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
<title>Thêm Video Mới - Dashboard Admin</title>
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

.admin-wrapper {
	display: flex;
	min-height: calc(100vh - 60px);
}

.admin-sidebar {
	width: 240px;
	background-color: #008be5;
	color: #ffffff;
	flex-shrink: 0;
	padding-top: 15px;
}

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

.admin-panel {
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.05);
	max-width: 800px;
}

.admin-panel-header {
	background-color: #f7f7f7;
	border-bottom: 1px solid #e0e0e0;
	padding: 12px 18px;
	font-weight: 500;
	color: #444444;
	font-size: 14px;
}

.admin-panel-body {
	padding: 25px 30px;
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
					<li><a href="<c:url value='/admin/video/add'/>"><strong>Thêm video mới</strong></a></li>
					<li><a href="<c:url value='/admin/videos'/>">Danh sách video</a></li>
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
			<h1 class="page-title">Thêm Video Mới</h1>
			<p class="page-subtitle">Nhập thông tin và tải lên video để phát trên hệ thống</p>

			<div class="admin-panel">
				<div class="admin-panel-header">
					<span>Thông tin Video</span>
				</div>
				<div class="admin-panel-body">
					<form action="<c:url value='/admin/video/insert'/>" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>Mã Video (VideoId): <span class="text-danger">*</span></label>
							<input type="text" name="videoId" class="form-control" placeholder="VD: VID15" required autofocus>
						</div>

						<div class="form-group">
							<label>Tiêu đề Video: <span class="text-danger">*</span></label>
							<input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video" required>
						</div>

						<div class="form-group">
							<label>Mô tả Video:</label>
							<textarea name="description" rows="3" class="form-control" placeholder="Nhập nội dung mô tả video"></textarea>
						</div>

						<!-- FILE UPLOAD THEO CODE MẪU GIẢNG VIÊN -->
						<div class="form-group">
							<label>Ảnh Poster Thumbnail (Upload File):</label>
							<input type="file" name="posterFile" class="form-control" accept="image/*">
							<small class="text-muted">Hoặc nhập URL ảnh trực tuyến:</small>
							<input type="text" name="posterUrl" class="form-control" placeholder="https://example.com/poster.jpg" style="margin-top: 4px;">
						</div>

						<!-- FILE VIDEO MULTIPART THEO CODE MẪU GIẢNG VIÊN -->
						<div class="form-group">
							<label>File Video .mp4 (Upload File):</label>
							<input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
							<small class="text-muted">Hoặc nhập tên file/URL video mẫu (mặc định: sample.mp4):</small>
							<input type="text" name="videoPathUrl" class="form-control" placeholder="sample.mp4" style="margin-top: 4px;">
						</div>

						<div class="form-group">
							<label>Danh mục (Category):</label>
							<select name="categoryId" class="form-control">
								<option value="">-- Chọn danh mục (Không bắt buộc) --</option>
								<c:forEach items="${categories}" var="c">
									<option value="${c.categoryid}">${c.categoryname}</option>
								</c:forEach>
							</select>
						</div>

						<div class="form-group">
							<label>Trạng thái:</label>
							<select name="active" class="form-control">
								<option value="1">Hoạt động (Active)</option>
								<option value="0">Tạm khóa (Inactive)</option>
							</select>
						</div>

						<div style="margin-top: 25px;">
							<button type="submit" class="btn btn-primary" style="padding: 8px 20px;">
								<i class="fa fa-save"></i> Lưu Video
							</button>
							<a href="<c:url value='/admin/videos'/>" class="btn btn-default" style="margin-left: 10px; padding: 8px 18px;">
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
