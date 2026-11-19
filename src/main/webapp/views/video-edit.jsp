<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh Sửa Video - Kênh Cá Nhân</title>
<!-- Bootstrap 3.4.1 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Font Awesome 4.7.0 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	background-color: #f5f5f5;
	font-family: Arial, sans-serif;
}

.edit-box {
	background: #ffffff;
	padding: 30px 35px;
	border-radius: 6px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-top: 30px;
	max-width: 750px;
}
</style>
</head>
<body>

	<!-- Form Chỉnh Sửa Video cho User -->
	<div class="container edit-box">
		<div style="border-bottom: 2px solid #0099e6; padding-bottom: 12px; margin-bottom: 25px;">
			<h2 style="margin: 0; color: #0099e6; font-size: 24px; font-weight: bold;">
				<i class="fa fa-pencil-square-o"></i> Chỉnh Sửa Video
			</h2>
			<p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">
				Cập nhật tiêu đề, mô tả hoặc thay đổi ảnh bìa, file video của bạn
			</p>
		</div>

		<c:if test="${not empty error}">
			<div class="alert alert-danger">${error}</div>
		</c:if>
		<form action="<c:url value='/video/update'/>" method="post" enctype="multipart/form-data">
			<!-- VideoId ẩn (User không can thiệp mã ID) -->
			<input type="hidden" name="videoId" value="${video.videoId}">

			<div class="form-group">
				<label>Tiêu đề Video: <span class="text-danger">*</span></label>
				<input type="text" name="title" class="form-control" value="${video.title}" required autofocus>
			</div>

			<div class="form-group">
				<label>Mô tả Video:</label>
				<textarea name="description" rows="3" class="form-control" placeholder="Nhập mô tả nội dung video">${video.description}</textarea>
			</div>

			<!-- POSTER HIỆN TẠI & UPLOAD MỚI -->
			<div class="form-group">
				<label><i class="fa fa-picture-o"></i> Ảnh bìa Poster (Thumbnail):</label>
				<div style="margin-bottom: 10px;">
					<c:choose>
						<c:when test="${video.poster.startsWith('http')}">
							<img src="${video.poster}" style="width: 140px; height: 85px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc;">
						</c:when>
						<c:otherwise>
							<img src="<c:url value='/image?fname=${video.poster}'/>" style="width: 140px; height: 85px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc;">
						</c:otherwise>
					</c:choose>
				</div>
				<input type="file" name="posterFile" class="form-control" accept="image/*">
				<small class="text-muted">Hoặc đổi URL ảnh online trực tiếp:</small>
				<input type="text" name="posterUrl" class="form-control" value="${video.poster}" style="margin-top: 4px;">
			</div>

			<!-- FILE VIDEO MP4 -->
			<div class="form-group" style="background-color: #f9f9f9; padding: 15px; border-radius: 4px; border: 1px dashed #0099e6;">
				<label style="color: #0077b5;">
					<i class="fa fa-file-video-o"></i> File Video .mp4 (Đang dùng: <code>${video.videoPath}</code>):
				</label>
				<input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
				<small class="text-muted">Chỉ chọn file mới nếu bạn muốn thay thế video hiện tại (Hỗ trợ dung lượng tới 500MB).</small>
			</div>

			<!-- CHỦ ĐỀ / DANH MỤC -->
			<div class="form-group">
				<label>Chủ đề / Danh mục:</label>
				<select name="categoryId" class="form-control">
					<option value="">-- Chọn danh mục (Tùy chọn) --</option>
					<c:forEach items="${categories}" var="c">
						<option value="${c.categoryid}" ${video.category.categoryid == c.categoryid ? 'selected' : ''}>
							${c.categoryname}
						</option>
					</c:forEach>
				</select>
			</div>

			<!-- (Trường Trạng thái Active và VideoId đã được loại bỏ theo yêu cầu: Admin quản lý) -->

			<div style="margin-top: 30px; display: flex; gap: 10px;">
				<button type="submit" class="btn btn-primary btn-lg" style="background-color: #0099e6; border: none; padding: 10px 25px;">
					<i class="fa fa-save"></i> Cập nhật Video
				</button>
				<a href="<c:url value='/video'/>" class="btn btn-default btn-lg" style="padding: 10px 20px;">
					Hủy bỏ
				</a>
			</div>
		</form>
	</div>

</body>
</html>
