<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${video.title} - VideoHub</title>
<style>
.player-container {
	background: #000;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
}
video {
	width: 100%;
	max-height: 520px;
	display: block;
	outline: none;
}
.author-avatar {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	background-color: #0d6efd;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
<div class="container py-4" style="max-width: 980px;">

	<!-- TRÌNH PHÁT VIDEO HTML5 -->
	<div class="player-container mb-4">
		<c:choose>
			<c:when test="${not empty video.videoPath and not video.videoPath.startsWith('http')}">
				<video controls autoplay poster="<c:url value='/image?fname=${video.poster}'/>">
					<source src="<c:url value='/video/stream?fname=${video.videoPath}'/>" type="video/mp4">
					Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
				</video>
			</c:when>
			<c:otherwise>
				<video controls autoplay poster="${video.poster}">
					<source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
					Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
				</video>
			</c:otherwise>
		</c:choose>
	</div>

	<!-- THÔNG TIN CHI TIẾT VIDEO -->
	<div class="card shadow-sm border-0 mb-4">
		<div class="card-body p-4">
			<h3 class="fw-bold text-dark mb-3">${video.title}</h3>

			<div class="d-flex flex-wrap justify-content-between align-items-center pb-3 mb-3 border-bottom gap-2">
				<div class="d-flex align-items-center gap-3 text-muted small">
					<span><i class="fa fa-eye me-1 text-primary"></i> <strong>${video.views}</strong> lượt xem</span>
					<span><i class="fa fa-calendar me-1 text-primary"></i> Ngày đăng: <strong>${video.createdDate}</strong></span>
				</div>
				<div>
					<c:if test="${not empty video.user}">
						<a href="<c:url value='/video?userId=${video.user.id}'/>" class="btn btn-outline-primary btn-sm">
							<i class="fa fa-th me-1"></i> Video của ${video.user.fullname}
						</a>
					</c:if>
				</div>
			</div>

			<div class="d-flex align-items-center mb-3">
				<div class="author-avatar me-3">
					${not empty video.user and not empty video.user.fullname ? video.user.fullname.substring(0, 1) : 'U'}
				</div>
				<div>
					<h6 class="mb-0 fw-bold">${not empty video.user ? video.user.fullname : 'Admin'}</h6>
					<small class="text-muted">${not empty video.user ? video.user.email : ''}</small>
				</div>
			</div>

			<div class="p-3 bg-light rounded-3">
				<h6 class="fw-bold mb-2">Mô tả video:</h6>
				<p class="mb-0 text-secondary" style="white-space: pre-line;">${not empty video.description ? video.description : 'Không có mô tả cho video này.'}</p>
			</div>

			<div class="mt-4 pt-2 border-top d-flex justify-content-between">
				<a href="<c:url value='/video'/>" class="btn btn-outline-secondary">
					<i class="fa fa-arrow-left me-1"></i> Quay lại kênh video
				</a>
				<a href="<c:url value='/home'/>" class="btn btn-primary">
					<i class="fa fa-home me-1"></i> Về Trang chủ
				</a>
			</div>
		</div>
	</div>

</div>
</body>
</html>
