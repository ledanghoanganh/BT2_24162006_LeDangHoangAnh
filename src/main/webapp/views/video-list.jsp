<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kênh Video - Danh sách Video của User</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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

.content-box {
	background: #fff;
	padding: 25px;
	border-radius: 6px;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

.video-card {
	background: #fff;
	border-radius: 6px;
	border: 1px solid #e0e0e0;
	transition: transform 0.2s, box-shadow 0.2s;
	height: 350px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.video-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
}

.video-thumb {
	height: 180px;
	width: 100%;
	object-fit: cover;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.video-title-link {
	color: #1a0dab;
	font-weight: bold;
	font-size: 15px;
	text-decoration: none;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	height: 42px;
}

.video-title-link:hover {
	color: #d9534f;
	text-decoration: underline;
}
</style>
</head>
<body>

	<div class="top-navbar">
		<div>
			<a href="<c:url value='/home'/>"
				style="font-size: 18px; font-weight: bold;"> <i
				class="fa fa-shopping-bag"></i> Trang chủ
			</a> <span style="margin: 0 10px;">|</span> <a
				href="<c:url value='/video'/>"
				style="font-size: 16px; font-weight: 500;"> <i
				class="fa fa-video-camera"></i> Kênh Video (/video)
			</a>
		</div>
		<div>
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<span>Xin chào: <strong>${sessionScope.account.fullname}</strong></span>
					<a href="<c:url value='/logout'/>" class="btn btn-sm btn-danger"
						style="margin-left: 10px; color: white;"> <i
						class="fa fa-sign-out"></i> Đăng xuất
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/login'/>" class="btn btn-sm btn-warning"
						style="color: white;"> <i class="fa fa-sign-in"></i> Đăng nhập
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="container content-box">
		<div
			style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 20px;">
			<div>
				<h3 style="margin: 0; color: #0077b5;">
					<i class="fa fa-youtube-play"></i> Danh sách Video của User: <span
						style="color: #d9534f;">${owner.fullname}</span>
				</h3>
				<p style="margin: 5px 0 0 0; color: #777;">
					Tổng cộng <strong>${totalVideos}</strong> videos (Phân trang 6 video/trang)
				</p>
			</div>
			<div>
				<!-- NÚT UPLOAD VIDEO CHO MỌI USER ĐÃ ĐĂNG NHẬP -->
				<c:choose>
					<c:when test="${not empty sessionScope.account}">
						<a href="<c:url value='/video/upload'/>" class="btn btn-success">
							<i class="fa fa-cloud-upload"></i> Upload Video Mới
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/login'/>" class="btn btn-warning">
							<i class="fa fa-sign-in"></i> Đăng nhập để Upload Video
						</a>
					</c:otherwise>
				</c:choose>
				<a href="<c:url value='/home'/>" class="btn btn-default"
					style="margin-left: 5px;"> <i class="fa fa-arrow-left"></i> Về
					Trang chủ
				</a>
			</div>
		</div>

		<!-- NẾU CHƯA CÓ VIDEO NÀO -->
		<c:if test="${empty videoList}">
			<div class="text-center" style="padding: 60px 20px; background-color: #fafafa; border-radius: 6px; border: 1px dashed #ddd; margin: 20px 0;">
				<i class="fa fa-video-camera fa-4x" style="color: #bbb; margin-bottom: 15px;"></i>
				<h3 style="color: #555; margin-bottom: 10px;">Bạn chưa có video nào</h3>
				<p style="color: #888; font-size: 15px; margin-bottom: 20px;">
					Hãy chia sẻ video đầu tiên của bạn đến với mọi người ngay hôm nay!
				</p>
				<c:if test="${not empty sessionScope.account}">
					<a href="<c:url value='/video/upload'/>" class="btn btn-success btn-lg">
						<i class="fa fa-cloud-upload"></i> Tải lên Video ngay bây giờ
					</a>
				</c:if>
			</div>
		</c:if>

		<!-- LƯỚI 6 VIDEO MỖI TRANG -->
		<c:if test="${not empty videoList}">
			<div class="row">
				<c:forEach items="${videoList}" var="vid">
					<div class="col-md-4 col-sm-6" style="margin-bottom: 25px;">
						<div class="video-card">
							<a href="<c:url value='/video/detail?id=${vid.videoId}'/>"> <c:choose>
									<c:when test="${vid.poster.startsWith('http')}">
										<img src="${vid.poster}" class="video-thumb" alt="${vid.title}">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/image?fname=${vid.poster}'/>"
											class="video-thumb" alt="${vid.title}">
									</c:otherwise>
								</c:choose>
							</a>
							<div
								style="padding: 12px; display: flex; flex-direction: column; justify-content: space-between; height: 170px;">
								<div>
									<!-- BẤM VÀO TIÊU ĐỀ ĐỂ PLAY VIDEO THEO ĐÚNG YÊU CẦU GIẢNG VIÊN -->
									<a href="<c:url value='/video/detail?id=${vid.videoId}'/>"
										class="video-title-link" title="${vid.title}"> ${vid.title}
									</a>
									<p
										style="font-size: 13px; color: #666; margin-top: 8px; height: 38px; overflow: hidden;">
										${vid.description}</p>
								</div>
								<div
									style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #f0f0f0; padding-top: 8px;">
									<span style="font-size: 12px; color: #888;"> <i
										class="fa fa-eye"></i> ${vid.views} lượt xem
									</span>
									<div>
										<a href="<c:url value='/video/detail?id=${vid.videoId}'/>"
											class="btn btn-sm btn-danger"> <i class="fa fa-play"></i>
											Xem video
										</a>
										<!-- NÚT SỬA & XÓA CHO CHỦ SỞ HỮU VIDEO HOẶC ADMIN -->
										<c:if test="${not empty sessionScope.account && ((not empty vid.user && sessionScope.account.id == vid.user.id) || sessionScope.account.roleid == 1)}">
											<a href="<c:url value='/video/edit?id=${vid.videoId}'/>" class="btn btn-sm btn-default" style="color: #f0ad4e; margin-left: 4px;" title="Chỉnh sửa video">
												<i class="fa fa-pencil"></i>
											</a>
											<a href="<c:url value='/video/delete?id=${vid.videoId}'/>" class="btn btn-sm btn-default" style="color: #d9534f; margin-left: 4px;" onclick="return confirm('Bạn chắc chắn muốn xóa video này?');" title="Xóa video của bạn">
												<i class="fa fa-trash"></i>
											</a>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		<!-- THANH PHÂN TRANG BOOTSTRAP PAGINATION -->
		<c:if test="${totalPages > 1}">
			<div class="text-center" style="margin-top: 20px;">
				<ul class="pagination pagination-lg">
					<!-- Nút Previous -->
					<c:if test="${currentPage > 1}">
						<li><a
							href="<c:url value='/video?userId=${targetUserId}&page=${currentPage - 1}'/>"
							aria-label="Previous"> <span aria-hidden="true">&laquo;
									Trang trước</span>
						</a></li>
					</c:if>

					<!-- Các số trang -->
					<c:forEach begin="1" end="${totalPages}" var="i">
						<li class="${currentPage == i ? 'active' : ''}"><a
							href="<c:url value='/video?userId=${targetUserId}&page=${i}'/>">${i}</a>
						</li>
					</c:forEach>

					<!-- Nút Next -->
					<c:if test="${currentPage < totalPages}">
						<li><a
							href="<c:url value='/video?userId=${targetUserId}&page=${currentPage + 1}'/>"
							aria-label="Next"> <span aria-hidden="true">Trang
									sau &raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</div>
		</c:if>

	</div>
</body>
</html>
