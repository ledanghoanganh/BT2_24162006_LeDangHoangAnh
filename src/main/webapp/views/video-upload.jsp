<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tải Lên Video Mới - VideoHub</title>
</head>
<body>
<div class="container py-4" style="max-width: 800px;">
	<div class="card shadow-sm border-0">
		<div class="card-header bg-white py-3 border-bottom">
			<h4 class="fw-bold mb-1 text-primary d-flex align-items-center gap-2">
				<i class="fa fa-cloud-upload"></i> Tải Lên Video Mới
			</h4>
			<p class="text-muted small mb-0">Chia sẻ video của bạn lên kênh cá nhân và trang chủ hệ thống</p>
		</div>

		<div class="card-body p-4">
			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2 mb-3"><i class="fa fa-exclamation-triangle me-1"></i> ${error}</div>
			</c:if>

			<form action="<c:url value='/video/upload'/>" method="post" enctype="multipart/form-data">
				<div class="mb-3">
					<label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
					<input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video của bạn" required autofocus>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Mô tả Video:</label>
					<textarea name="description" rows="3" class="form-control" placeholder="Mô tả nội dung video"></textarea>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold"><i class="fa fa-image me-1"></i> Ảnh bìa Poster (Thumbnail):</label>
					<input type="file" name="posterFile" class="form-control" accept="image/*">
					<small class="text-muted">Hoặc dán URL ảnh trực tiếp nếu không tải file từ máy:</small>
					<input type="text" name="posterUrl" class="form-control mt-1" placeholder="https://example.com/poster.jpg">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold"><i class="fa fa-video me-1"></i> File Video (.mp4): <span class="text-danger">*</span></label>
					<input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
					<small class="text-muted">Hoặc dán URL video mp4 trực tiếp:</small>
					<input type="text" name="videoPathUrl" class="form-control mt-1" placeholder="https://example.com/sample.mp4">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Chuyên mục:</label>
					<select name="categoryId" class="form-select">
						<option value="">-- Chọn danh mục (Không bắt buộc) --</option>
						<c:forEach items="${categories}" var="c">
							<option value="${c.categoryid}">${c.categoryname}</option>
						</c:forEach>
					</select>
				</div>

				<div class="mt-4 pt-3 border-top d-flex gap-2">
					<button type="submit" class="btn btn-success px-4">
						<i class="fa fa-upload me-1"></i> Tải lên ngay
					</button>
					<a href="<c:url value='/video'/>" class="btn btn-outline-secondary">
						Hủy bỏ
					</a>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
