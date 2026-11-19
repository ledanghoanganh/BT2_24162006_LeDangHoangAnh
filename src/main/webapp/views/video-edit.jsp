<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh Sửa Video - VideoHub</title>
</head>
<body>
<div class="container py-4" style="max-width: 800px;">
	<div class="card shadow-sm border-0">
		<div class="card-header bg-white py-3 border-bottom">
			<h4 class="fw-bold mb-1 text-primary d-flex align-items-center gap-2">
				<i class="fa fa-edit"></i> Chỉnh Sửa Video
			</h4>
			<p class="text-muted small mb-0">Cập nhật thông tin video của bạn</p>
		</div>

		<div class="card-body p-4">
			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2 mb-3"><i class="fa fa-exclamation-triangle me-1"></i> ${error}</div>
			</c:if>

			<form action="<c:url value='/video/update'/>" method="post" enctype="multipart/form-data">
				<input type="hidden" name="videoId" value="${video.videoId}">

				<div class="mb-3">
					<label class="form-label fw-semibold">Mã Video (VideoId):</label>
					<input type="text" class="form-control" value="${video.videoId}" disabled readonly>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Tiêu đề Video: <span class="text-danger">*</span></label>
					<input type="text" name="title" class="form-control" value="${video.title}" required autofocus>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Mô tả Video:</label>
					<textarea name="description" rows="3" class="form-control">${video.description}</textarea>
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold"><i class="fa fa-image me-1"></i> Ảnh bìa Poster (Thumbnail):</label>
					<c:if test="${not empty video.poster}">
						<div class="mb-2">
							<c:choose>
								<c:when test="${video.poster.startsWith('http')}">
									<img src="${video.poster}" height="90" class="rounded border" alt="Poster hiện tại">
								</c:when>
								<c:otherwise>
									<img src="<c:url value='/image?fname=${video.poster}'/>" height="90" class="rounded border" alt="Poster hiện tại">
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
					<input type="file" name="posterFile" class="form-control" accept="image/*">
					<small class="text-muted">Hoặc đổi link URL ảnh mới:</small>
					<input type="text" name="posterUrl" class="form-control mt-1" value="${video.poster}">
				</div>

				<div class="mb-3">
					<label class="form-label fw-semibold">Chuyên mục:</label>
					<select name="categoryId" class="form-select">
						<option value="">-- Chọn danh mục (Không bắt buộc) --</option>
						<c:forEach items="${categories}" var="c">
							<option value="${c.categoryid}" ${video.category != null && video.category.categoryid == c.categoryid ? 'selected' : ''}>
								${c.categoryname}
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="mt-4 pt-3 border-top d-flex gap-2">
					<button type="submit" class="btn btn-warning px-4">
						<i class="fa fa-save me-1"></i> Cập nhật thay đổi
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
