<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kênh Video - VideoHub</title>
<style>
.video-card {
	transition: transform 0.2s, box-shadow 0.2s;
	border-radius: 8px;
	overflow: hidden;
}
.video-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12) !important;
}
.video-thumb {
	height: 180px;
	width: 100%;
	object-fit: cover;
}
.video-title-link {
	color: #212529;
	font-weight: 600;
	font-size: 15px;
	text-decoration: none;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	height: 40px;
	line-height: 1.3;
}
.video-title-link:hover {
	color: #0d6efd;
}
</style>
</head>
<body>
<div class="container py-4">

	<!-- Header Kênh Video -->
	<div class="card shadow-sm border-0 mb-4">
		<div class="card-body p-4 d-flex flex-wrap justify-content-between align-items-center gap-3">
			<div>
				<h3 class="fw-bold mb-1 d-flex align-items-center gap-2 text-dark">
					<i class="fa fa-play-circle text-danger"></i> Kênh Video: <span class="text-primary">${not empty owner ? owner.fullname : 'Người dùng'}</span>
				</h3>
				<p class="text-muted mb-0 small">
					Tổng số: <strong>${totalVideos}</strong> videos (Phân trang 6 video/trang)
				</p>
			</div>
			<div class="d-flex align-items-center gap-2">
				<c:choose>
					<c:when test="${not empty sessionScope.account}">
						<a href="<c:url value='/video/upload'/>" class="btn btn-success">
							<i class="fa fa-upload me-1"></i> Upload Video Mới
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/login'/>" class="btn btn-warning">
							<i class="fa fa-sign-in-alt me-1"></i> Đăng nhập để Upload Video
						</a>
					</c:otherwise>
				</c:choose>
				<a href="<c:url value='/home'/>" class="btn btn-outline-secondary">
					<i class="fa fa-arrow-left me-1"></i> Về Trang chủ
				</a>
			</div>
		</div>
	</div>

	<!-- NẾU CHƯA CÓ VIDEO NÀO -->
	<c:if test="${empty videoList}">
		<div class="card shadow-sm border-0 text-center py-5">
			<div class="card-body">
				<i class="fa fa-video fa-4x text-muted mb-3 d-block"></i>
				<h4 class="fw-bold text-secondary">Bạn chưa có video nào</h4>
				<p class="text-muted mb-4">Hãy tải lên video đầu tiên của bạn để chia sẻ đến mọi người!</p>
				<c:if test="${not empty sessionScope.account}">
					<a href="<c:url value='/video/upload'/>" class="btn btn-success px-4 py-2">
						<i class="fa fa-upload me-1"></i> Tải lên Video ngay bây giờ
					</a>
				</c:if>
			</div>
		</div>
	</c:if>

	<!-- LƯỚI 6 VIDEO MỖI TRANG -->
	<c:if test="${not empty videoList}">
		<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
			<c:forEach items="${videoList}" var="vid">
				<div class="col">
					<div class="card h-100 shadow-sm border-0 video-card">
						<a href="<c:url value='/video/detail?id=${vid.videoId}'/>">
							<c:choose>
								<c:when test="${vid.poster.startsWith('http')}">
									<img src="${vid.poster}" class="video-thumb" alt="${vid.title}">
								</c:when>
								<c:otherwise>
									<img src="<c:url value='/image?fname=${vid.poster}'/>" class="video-thumb" alt="${vid.title}">
								</c:otherwise>
							</c:choose>
						</a>
						<div class="card-body d-flex flex-column p-3">
							<a href="<c:url value='/video/detail?id=${vid.videoId}'/>" class="video-title-link mb-2" title="${vid.title}">
								${vid.title}
							</a>
							<p class="small text-muted mb-3" style="height: 38px; overflow: hidden; line-height: 1.4;">
								${vid.description}
							</p>
							<div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
								<span class="small text-muted"><i class="fa fa-eye me-1"></i> ${vid.views} lượt xem</span>
								<div class="d-flex align-items-center gap-1">
									<a href="<c:url value='/video/detail?id=${vid.videoId}'/>" class="btn btn-sm btn-danger px-3">
										<i class="fa fa-play me-1"></i> Xem
									</a>
									<c:if test="${not empty sessionScope.account && ((not empty vid.user && sessionScope.account.id == vid.user.id) || sessionScope.account.roleid == 1)}">
										<a href="<c:url value='/video/edit?id=${vid.videoId}'/>" class="btn btn-sm btn-outline-warning" title="Chỉnh sửa video">
											<i class="fa fa-edit"></i>
										</a>
										<a href="<c:url value='/video/delete?id=${vid.videoId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn xóa video này?');" title="Xóa video">
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

	<!-- THANH PHÂN TRANG BOOTSTRAP 5 -->
	<c:if test="${totalPages > 1}">
		<nav aria-label="Phân trang video" class="mt-4">
			<ul class="pagination justify-content-center">
				<c:if test="${currentPage > 1}">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/video?userId=${targetUserId}&page=${currentPage - 1}'/>">
							&laquo; Trang trước
						</a>
					</li>
				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="i">
					<li class="page-item ${currentPage == i ? 'active' : ''}">
						<a class="page-link" href="<c:url value='/video?userId=${targetUserId}&page=${i}'/>">${i}</a>
					</li>
				</c:forEach>

				<c:if test="${currentPage < totalPages}">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/video?userId=${targetUserId}&page=${currentPage + 1}'/>">
							Trang sau &raquo;
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</c:if>

</div>
</body>
</html>
