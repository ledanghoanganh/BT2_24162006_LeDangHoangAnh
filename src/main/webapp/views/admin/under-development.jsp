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
<title>${featureTitle} - Quản trị hệ thống</title>
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
}
.admin-panel-body {
	padding: 40px 25px;
	text-align: center;
}
.dev-icon {
	color: #008be5;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="mb-3">
		<h1 class="page-title"><i class="fa fa-cogs text-danger me-2"></i>${featureTitle}</h1>
		<p class="page-subtitle mb-0">Nơi bạn có thể quản lý hệ thống của mình</p>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<i class="fa fa-info-circle me-1"></i> Thông báo trạng thái hệ thống
		</div>
		<div class="admin-panel-body">
			<div class="dev-icon">
				<i class="fa fa-cogs fa-4x text-primary"></i>
			</div>
			<h3 class="fw-bold text-dark mb-2">Tính năng đang được phát triển</h3>
			<p class="text-muted fs-6 mx-auto mb-4" style="max-width: 500px;">
				Chức năng <strong>${featureTitle}</strong> hiện đang trong quá trình xây dựng và sẽ sớm được ra mắt trong các phiên bản cập nhật tiếp theo.
			</p>
			<a href="<c:url value='/admin/categories'/>" class="btn btn-primary px-4 py-2">
				<i class="fa fa-arrow-left me-1"></i> Quay lại Quản lý Danh mục
			</a>
		</div>
	</div>
</body>
</html>
