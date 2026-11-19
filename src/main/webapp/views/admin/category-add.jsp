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
<title>Thêm danh mục mới - Dashboard Admin</title>
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
</style>
</head>
<body>
	<div class="mb-3">
		<h1 class="page-title"><i class="fa fa-plus-circle text-danger me-2"></i>Thêm danh mục mới</h1>
		<p class="page-subtitle mb-0">Nơi bạn có thể tạo danh mục mới cho hệ thống của mình</p>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<i class="fa fa-edit me-1"></i> Biểu mẫu thêm danh mục
		</div>
		<div class="admin-panel-body">
			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2 mb-3"><i class="fa fa-exclamation-triangle me-1"></i> ${error}</div>
			</c:if>
			<form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="categoryname" class="form-label fw-semibold">Tên danh mục (Category name):</label>
					<input type="text" id="categoryname" name="categoryname" class="form-control" required placeholder="Nhập tên danh mục">
				</div>

				<div class="mb-3">
					<label for="images" class="form-label fw-semibold">Link ảnh online (Images URL):</label>
					<input type="text" id="images" name="images" class="form-control" placeholder="https://example.com/image.jpg">
				</div>

				<div class="mb-3">
					<label for="images1" class="form-label fw-semibold">Hoặc tải ảnh lên từ máy tính:</label>
					<input type="file" id="images1" name="images1" class="form-control">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold d-block">Trạng thái (Status):</label>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="status" id="statusActive" value="1" checked>
						<label class="form-check-label" for="statusActive">Hoạt động</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="status" id="statusLocked" value="0">
						<label class="form-check-label" for="statusLocked">Khóa</label>
					</div>
				</div>

				<div class="mt-4 pt-2 border-top">
					<button type="submit" class="btn btn-primary px-4 me-2">
						<i class="fa fa-check me-1"></i> Lưu danh mục
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
