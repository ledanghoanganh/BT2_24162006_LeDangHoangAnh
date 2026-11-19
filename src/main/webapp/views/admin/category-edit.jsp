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
	max-width: 750px;
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
	padding: 25px;
}
.current-img-preview {
	width: 100px;
	height: 100px;
	object-fit: contain;
	border-radius: 6px;
	border: 1px solid #dee2e6;
	padding: 4px;
	background-color: #f8f9fa;
	margin-top: 8px;
}
</style>
</head>
<body>
	<div class="mb-3">
		<h1 class="page-title"><i class="fa fa-pencil-square-o text-danger me-2"></i>Chỉnh sửa danh mục</h1>
		<p class="page-subtitle mb-0">Nơi bạn có thể cập nhật thông tin danh mục</p>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<i class="fa fa-edit me-1"></i> Cập nhật thông tin danh mục #${cate.categoryid}
		</div>
		<div class="admin-panel-body">
			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2 mb-3"><i class="fa fa-exclamation-triangle me-1"></i> ${error}</div>
			</c:if>
			<form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="categoryid" value="${cate.categoryid}">

				<div class="mb-3">
					<label for="categoryname" class="form-label fw-semibold">Tên danh mục (Category name):</label>
					<input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" class="form-control" required>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold d-block">Hình ảnh hiện tại:</label>
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

				<div class="mb-3">
					<label for="images" class="form-label fw-semibold">Link ảnh mới (Images URL):</label>
					<input type="text" id="images" name="images" value="${cate.images}" class="form-control">
				</div>

				<div class="mb-3">
					<label for="images1" class="form-label fw-semibold">Hoặc tải ảnh thay thế từ máy tính:</label>
					<input type="file" id="images1" name="images1" class="form-control">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold d-block">Trạng thái (Status):</label>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="status" id="statusActive" value="1" ${cate.status == 1 ? "checked" : ""}>
						<label class="form-check-label" for="statusActive">Hoạt động</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="status" id="statusLocked" value="0" ${cate.status != 1 ? "checked" : ""}>
						<label class="form-check-label" for="statusLocked">Khóa</label>
					</div>
				</div>

				<div class="mt-4 pt-2 border-top">
					<button type="submit" class="btn btn-warning px-4 me-2">
						<i class="fa fa-save me-1"></i> Cập nhật thay đổi
					</button>
					<a href="<c:url value="/admin/categories"/>" class="btn btn-secondary px-3">
						Hủy bỏ
					</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
