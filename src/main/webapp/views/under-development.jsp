<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản phẩm ${categoryName} - Đang phát triển</title>
<style>
.content-box {
	background: #ffffff;
	padding: 40px 30px;
	border-radius: 6px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
	text-align: center;
}
.dev-icon {
	color: #0d6efd;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="container py-4">
		<!-- Breadcrumb -->
		<nav aria-label="breadcrumb" class="mb-4">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang chủ</a></li>
				<li class="breadcrumb-item"><a href="<c:url value='/home'/>">Danh mục</a></li>
				<li class="breadcrumb-item active" aria-current="page">${categoryName}</li>
			</ol>
		</nav>

		<div class="content-box">
			<div class="dev-icon">
				<i class="fa fa-cogs fa-4x text-primary"></i>
			</div>
			<h2 class="fw-bold mb-3">Tính năng đang được phát triển</h2>
			<p class="text-muted fs-5 mb-4 mx-auto" style="max-width: 600px;">
				Trang danh sách sản phẩm thuộc danh mục <strong>"${categoryName}"</strong> hiện đang được hoàn thiện. Vui lòng quay lại sau!
			</p>
			<div class="d-flex justify-content-center gap-3">
				<a href="<c:url value='/home'/>" class="btn btn-primary px-4">
					<i class="fa fa-home me-1"></i> Quay lại Trang chủ
				</a>
				<a href="<c:url value='/video'/>" class="btn btn-outline-secondary px-4">
					<i class="fa fa-video me-1"></i> Xem Kênh Video
				</a>
			</div>
		</div>
	</div>
</body>
</html>
