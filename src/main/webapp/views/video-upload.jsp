<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tải Lên Video Mới - Kênh Cá Nhân</title>
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

.top-navbar {
	background-color: #0099e6;
	color: white;
	padding: 12px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-navbar a {
	color: white;
	text-decoration: none;
}

.upload-box {
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

	<!-- Top Navbar -->
	<div class="top-navbar">
		<div>
			<a href="<c:url value='/home'/>" style="font-size: 18px; font-weight: bold;">
				<i class="fa fa-shopping-bag"></i> Trang chủ
			</a>
			<span style="margin: 0 10px;">|</span>
			<a href="<c:url value='/video'/>" style="font-size: 16px; font-weight: 500;">
				<i class="fa fa-video-camera"></i> Kênh Video (/video)
			</a>
		</div>
		<div>
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<span>Xin chào: <strong>${sessionScope.account.fullname}</strong></span>
					<a href="<c:url value='/logout'/>" class="btn btn-sm btn-danger" style="margin-left: 10px; color: white;">
						<i class="fa fa-sign-out"></i> Đăng xuất
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/login'/>" class="btn btn-sm btn-warning" style="color: white;">
						<i class="fa fa-sign-in"></i> Đăng nhập
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Form Upload cho User -->
	<div class="container upload-box">
		<div style="border-bottom: 2px solid #0099e6; padding-bottom: 12px; margin-bottom: 25px;">
			<h2 style="margin: 0; color: #0099e6; font-size: 24px; font-weight: bold;">
				<i class="fa fa-cloud-upload"></i> Tải Lên Video Mới
			</h2>
			<p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">
				Chia sẻ video của bạn lên kênh cá nhân và trang chủ hệ thống
			</p>
		</div>

		<form action="<c:url value='/video/upload'/>" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label>Tiêu đề Video: <span class="text-danger">*</span></label>
				<input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video của bạn" required autofocus>
			</div>

			<div class="form-group">
				<label>Mô tả Video:</label>
				<textarea name="description" rows="3" class="form-control" placeholder="Mô tả nội dung video"></textarea>
			</div>

			<!-- UPLOAD ẢNH BÌA POSTER -->
			<div class="form-group">
				<label><i class="fa fa-picture-o"></i> Ảnh bìa Poster (Thumbnail):</label>
				<input type="file" name="posterFile" class="form-control" accept="image/*">
				<small class="text-muted">Hoặc dán URL ảnh trực tiếp nếu không tải file từ máy:</small>
				<input type="text" name="posterUrl" class="form-control" placeholder="https://example.com/poster.jpg" style="margin-top: 4px;">
			</div>

			<!-- UPLOAD FILE VIDEO MP4 -->
			<div class="form-group" style="background-color: #f9f9f9; padding: 15px; border-radius: 4px; border: 1px dashed #0099e6;">
				<label style="color: #0077b5;"><i class="fa fa-file-video-o"></i> File Video .mp4 (Dung lượng hỗ trợ tối đa 500MB):</label>
				<input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
				<small class="text-muted">Nếu chưa có file video thực tế, bạn có thể nhập tên video mẫu (mặc định: <code>sample.mp4</code>):</small>
				<input type="text" name="videoPathUrl" class="form-control" placeholder="sample.mp4" style="margin-top: 4px;">
			</div>

			<div class="form-group">
				<label>Chủ đề / Danh mục:</label>
				<select name="categoryId" class="form-control">
					<option value="">-- Chọn danh mục (Tùy chọn) --</option>
					<c:forEach items="${categories}" var="c">
						<option value="${c.categoryid}">${c.categoryname}</option>
					</c:forEach>
				</select>
			</div>

			<div style="margin-top: 30px; display: flex; gap: 10px;">
				<button type="submit" class="btn btn-primary btn-lg" style="background-color: #0099e6; border: none; padding: 10px 25px;">
					<i class="fa fa-upload"></i> Đăng Video Ngay
				</button>
				<a href="<c:url value='/video'/>" class="btn btn-default btn-lg" style="padding: 10px 20px;">
					Hủy bỏ
				</a>
			</div>
		</form>
	</div>

</body>
</html>
