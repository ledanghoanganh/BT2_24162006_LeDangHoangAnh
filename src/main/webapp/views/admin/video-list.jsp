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
<style>
.page-title {
	color: #ff0000;
	font-size: 26px;
	font-weight: 700;
	margin-top: 0;
	margin-bottom: 4px;
}
.page-subtitle {
	color: #666666;
	font-size: 14px;
	margin-bottom: 20px;
}
.admin-panel {
	background: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 6px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.admin-panel-header {
	background-color: #f7f7f7;
	border-bottom: 1px solid #e0e0e0;
	padding: 14px 20px;
	font-weight: 600;
	color: #333333;
	font-size: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.admin-panel-body {
	padding: 20px;
}
.video-table {
	width: 100%;
	border-collapse: collapse;
}
.video-table th {
	border-top: 1px solid #eeeeee;
	border-bottom: 2px solid #dddddd;
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
	object-fit: cover;
	border-radius: 4px;
	border: 1px solid #dee2e6;
}
.action-links a {
	margin-right: 8px;
	text-decoration: none;
	font-weight: 500;
}
.action-links a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<div>
			<h1 class="page-title"><i class="fa fa-video-camera text-danger me-2"></i>Quản lý Video</h1>
			<p class="page-subtitle mb-0">Nơi bạn có thể quản lý danh sách video và upload video mới</p>
		</div>
		<a href="<c:url value='/admin/video/add'/>" class="btn btn-success">
			<i class="fa fa-plus me-1"></i> Thêm video mới
		</a>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<span><i class="fa fa-list me-1"></i> Danh sách video</span>
		</div>
		<div class="admin-panel-body">
			<table class="video-table table-hover">
				<thead>
					<tr>
						<th style="width: 60px;">STT</th>
						<th style="width: 130px;">Hình ảnh</th>
						<th>Tiêu đề video</th>
						<th style="width: 140px;">Người đăng</th>
						<th style="width: 100px;">Lượt xem</th>
						<th style="width: 110px;">Trạng thái</th>
						<th style="width: 200px;">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listvideo}" var="v" varStatus="loop">
						<tr>
							<td>${loop.index + 1}</td>
							<td>
								<c:choose>
									<c:when test="${not empty v.poster && v.poster.startsWith('http')}">
										<img src="${v.poster}" class="video-thumb-img" alt="${v.title}">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/image?fname=${v.poster}'/>" class="video-thumb-img" alt="${v.title}">
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<a href="<c:url value='/video/detail?id=${v.videoId}'/>" target="_blank" style="font-weight: 600; color: #0d6efd; text-decoration: none;">
									${v.title}
								</a>
								<p style="color: #777; font-size: 12px; margin: 4px 0 0 0; max-width: 400px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
									${v.description}
								</p>
							</td>
							<td><strong>${not empty v.user ? v.user.fullname : 'Admin'}</strong></td>
							<td><span class="badge bg-info text-dark">${v.views}</span></td>
							<td>
								<c:choose>
									<c:when test="${v.active == 1}">
										<span class="badge bg-success">Hoạt động</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">Tạm khóa</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="action-links">
								<a href="<c:url value='/video/detail?id=${v.videoId}'/>" target="_blank" class="btn btn-sm btn-outline-success me-1">
									<i class="fa fa-play-circle me-1"></i>Play
								</a>
								<a href="<c:url value='/admin/video/edit?id=${v.videoId}'/>" class="btn btn-sm btn-outline-primary me-1">
									<i class="fa fa-pencil me-1"></i>Sửa
								</a>
								<a href="<c:url value='/admin/video/delete?id=${v.videoId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn xóa video này?');">
									<i class="fa fa-trash me-1"></i>Xóa
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
