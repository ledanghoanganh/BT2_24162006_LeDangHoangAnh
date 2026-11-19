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
<title>Chỉnh Sửa Video - Dashboard Admin</title>
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
	max-width: 800px;
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
		<h1 class="page-title"><i class="fa fa-pencil-square-o text-danger me-2"></i>Chỉnh Sửa Video</h1>
		<p class="page-subtitle mb-0">Cập nhật thông tin, thay đổi ảnh poster hoặc video clip</p>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<i class="fa fa-info-circle me-1"></i> Cập nhật Video: <strong>${video.videoId}</strong>
		</div>
		<div class="admin-panel-body">
			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2 mb-3"><i class="fa fa-exclamation-triangle me-1"></i> ${error}</div>
			</c:if>
			<form action="<c:url value='/admin/video/update'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="videoId" value="${video.videoId}">

				<div class="mb-3">
					<label class="form-label fw-semibold">Mã Video (Không được sửa):</label>
					<input type="text" class="form-control" value="${video.videoId}" disabled style="background-color: #eee;">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
					<input type="text" name="title" class="form-control" value="${video.title}" required>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Mô tả Video:</label>
					<textarea name="description" rows="3" class="form-control">${video.description}</textarea>
				</div>

				<!-- POSTER HIỆN TẠI & UPLOAD MỚI -->
				<div class="mb-3">
					<label class="form-label fw-semibold d-block">Ảnh Poster Thumbnail:</label>
					<div class="mb-2">
						<c:choose>
							<c:when test="${not empty video.poster && video.poster.startsWith('http')}">
								<img src="${video.poster}" style="width: 120px; height: 75px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc;">
							</c:when>
							<c:otherwise>
								<img src="<c:url value='/image?fname=${video.poster}'/>" style="width: 120px; height: 75px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc;">
							</c:otherwise>
						</c:choose>
					</div>
					<input type="file" name="posterFile" class="form-control" accept="image/*">
					<div class="form-text">Hoặc đổi URL ảnh online:</div>
					<input type="text" name="posterUrl" class="form-control mt-1" value="${video.poster}">
				</div>

				<!-- FILE VIDEO MULTIPART -->
				<div class="mb-3">
					<label class="form-label fw-semibold">File Video .mp4 (Đang dùng: <code>${video.videoPath}</code>):</label>
					<input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
					<div class="form-text">Tải lên video mới nếu muốn thay thế video hiện tại.</div>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Danh mục (Category):</label>
					<select name="categoryId" class="form-select">
						<option value="">-- Chọn danh mục --</option>
						<c:forEach items="${categories}" var="c">
							<option value="${c.categoryid}" ${video.category.categoryid == c.categoryid ? 'selected' : ''}>${c.categoryname}</option>
						</c:forEach>
					</select>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Trạng thái:</label>
					<select name="active" class="form-select">
						<option value="1" ${video.active == 1 ? 'selected' : ''}>Hoạt động (Active)</option>
						<option value="0" ${video.active == 0 ? 'selected' : ''}>Tạm khóa (Inactive)</option>
					</select>
				</div>

				<div class="mt-4 pt-2 border-top">
					<button type="submit" class="btn btn-warning px-4 me-2">
						<i class="fa fa-save me-1"></i> Cập nhật Video
					</button>
					<a href="<c:url value='/admin/videos'/>" class="btn btn-secondary px-3">
						Hủy bỏ
					</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
