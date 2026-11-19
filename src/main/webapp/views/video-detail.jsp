
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${video.title}- Xem Video</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	background-color: #f8f9fa;
	font-family: Arial, sans-serif;
}

.player-container {
	background: #000;
	border-radius: 8px;
	overflow: hidden;
	margin-bottom: 20px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

video {
	width: 100%;
	max-height: 540px;
	display: block;
	outline: none;
}

.video-info-box {
	background: #fff;
	padding: 25px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}
</style>
</head>
<body>

	<div class="container" style="margin-top: 15px; max-width: 960px;">
		<!-- KHUNG TRÌNH PHÁT VIDEO HTML5 -->
		<div class="player-container">
			<c:choose>
				<%-- Trường hợp file video upload (.mp4) --%>
				<c:when
					test="${not empty video.videoPath and not video.videoPath.startsWith('http')}">
					<video controls autoplay
						poster="<c:url value='/image?fname=${video.poster}'/>">
						<source
							src="<c:url value='/video/stream?fname=${video.videoPath}'/>"
							type="video/mp4">
						Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
					</video>
				</c:when>
				<%-- Trường hợp link video online hoặc placeholder --%>
				<c:otherwise>
					<video controls autoplay poster="${video.poster}">
						<source
							src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
							type="video/mp4">
						Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
					</video>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- KHUNG THÔNG TIN CHI TIẾT VIDEO -->
		<div class="video-info-box">
			<h2
				style="font-weight: bold; margin-top: 0; color: #222; font-size: 24px;">
				${video.title}</h2>
			<div
				style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 12px; margin-bottom: 15px;">
				<div>
					<span style="font-size: 14px; color: #666; margin-right: 15px;">
						<i class="fa fa-eye"></i> <strong>${video.views}</strong> lượt xem
					</span> <span style="font-size: 14px; color: #666;"> <i
						class="fa fa-calendar"></i> Ngày đăng: <strong>${video.createdDate}</strong>
					</span>
				</div>
				<div>
					<c:if test="${not empty video.user}">
						<a href="<c:url value='/video?userId=${video.user.id}'/>"
							class="btn btn-info btn-sm"> <i class="fa fa-th"></i> Xem thêm
							video của ${video.user.fullname}
						</a>
					</c:if>
				</div>
			</div>

			<div style="display: flex; align-items: center; margin-bottom: 15px;">
				<div
					style="width: 48px; height: 48px; border-radius: 50%; background-color: #0099e6; color: white; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: bold; margin-right: 12px;">
					${not empty video.user and not empty video.user.fullname ? video.user.fullname.substring(0, 1) : 'U'}</div>
				<div>
					<h4 style="margin: 0; font-weight: bold;">${not empty video.user ? video.user.fullname : 'Tác giả ẩn danh'}</h4>
					<small style="color: #777;">Tác giả video
						(@${not empty video.user ? video.user.username : 'user'})</small>
				</div>
			</div>

			<div class="panel panel-default" style="margin-top: 15px;">
				<div class="panel-heading" style="font-weight: bold;">Mô tả
					nội dung</div>
				<div class="panel-body"
					style="font-size: 15px; line-height: 1.6; color: #444;">
					<c:choose>
						<c:when test="${not empty video.description}">
							${video.description}
						</c:when>
						<c:otherwise>
							<em>Chưa có mô tả chi tiết cho video này.</em>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
