<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ - VideoHub &amp; E-Commerce</title>
<style>
.cate-img {
	border-radius: 6px;
	object-fit: cover;
	border: 1px solid #e9ecef;
	transition: transform 0.2s, box-shadow 0.2s;
}
.cate-img:hover {
	transform: scale(1.04);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
}
.category-title-link {
	color: #0d6efd;
	font-weight: 600;
	text-decoration: none;
}
.category-title-link:hover {
	color: #0a58ca;
	text-decoration: underline;
}
.video-card {
	transition: transform 0.2s, box-shadow 0.2s;
	border-radius: 8px;
	overflow: hidden;
}
.video-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12) !important;
}
</style>
</head>
<body>
<div class="container py-3">

	<!-- 1. DANH SÁCH DANH MỤC -->
	<div class="card shadow-sm border-0 mb-4">
		<div class="card-header bg-white py-3 d-flex flex-wrap justify-content-between align-items-center gap-3">
			<h4 class="mb-0 fw-bold text-dark d-flex align-items-center gap-2">
				<i class="fa fa-list text-primary"></i> Danh sách danh mục
			</h4>

			<!-- Thanh tìm kiếm danh mục -->
			<form action="<c:url value='/home'/>" method="get" class="d-flex align-items-center gap-2">
				<div class="input-group">
					<input type="text" name="search" value="${searchKeyword}" class="form-control" placeholder="Tìm kiếm danh mục...">
					<button class="btn btn-primary" type="submit">
						<i class="fa fa-search me-1"></i> Tìm kiếm
					</button>
				</div>
				<c:if test="${sessionScope.account.roleid == 1}">
					<a href="<c:url value='/admin/category/add'/>" class="btn btn-success text-nowrap">
						<i class="fa fa-plus me-1"></i> Thêm danh mục
					</a>
				</c:if>
			</form>
		</div>

		<div class="card-body p-0">
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th class="text-center" style="width: 70px;">STT</th>
							<th class="text-center" style="width: 180px;">Hình ảnh</th>
							<th>Tên danh mục</th>
							<th class="text-center" style="width: 150px;">Trạng thái</th>
							<c:if test="${sessionScope.account.roleid == 1}">
								<th class="text-center" style="width: 160px;">Thao tác</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty listcate}">
								<c:forEach items="${listcate}" var="cate" varStatus="STT">
									<tr>
										<td class="text-center fw-bold text-muted">${STT.index + 1}</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${not empty cate.images && cate.images.startsWith('http')}">
													<c:url value="${cate.images}" var="imgUrl" />
												</c:when>
												<c:when test="${not empty cate.images}">
													<c:url value="/image?fname=${cate.images}" var="imgUrl" />
												</c:when>
												<c:otherwise>
													<c:set var="imgUrl" value="https://via.placeholder.com/140x90?text=No+Image" />
												</c:otherwise>
											</c:choose>
											<a href="<c:url value='/products?id=${cate.categoryid}&name=${cate.categoryname}'/>">
												<img height="80" width="130" src="${imgUrl}" class="cate-img" alt="${cate.categoryname}"
													onerror="this.src='https://via.placeholder.com/140x90?text=No+Image'" />
											</a>
										</td>
										<td>
											<a href="<c:url value='/products?id=${cate.categoryid}&name=${cate.categoryname}'/>" class="category-title-link fs-6">
												${cate.categoryname}
											</a>
										</td>
										<td class="text-center">
											<c:choose>
												<c:when test="${cate.status == 1}">
													<span class="badge bg-success px-3 py-2">Hoạt động</span>
												</c:when>
												<c:otherwise>
													<span class="badge bg-danger px-3 py-2">Khóa</span>
												</c:otherwise>
											</c:choose>
										</td>
										<c:if test="${sessionScope.account.roleid == 1}">
											<td class="text-center">
												<a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-warning me-1">
													<i class="fa fa-edit"></i> Sửa
												</a>
												<a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-danger"
													onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
													<i class="fa fa-trash"></i> Xóa
												</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="${sessionScope.account.roleid == 1 ? 5 : 4}" class="text-center py-5 text-muted">
										<i class="fa fa-folder-open fa-2x mb-2 text-secondary d-block"></i> Chưa có danh mục nào được tìm thấy.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 2. TOP 10 VIDEO MỚI NHẤT -->
	<div class="card shadow-sm border-0">
		<div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
			<h4 class="mb-0 fw-bold text-danger d-flex align-items-center gap-2">
				<i class="fa fa-play-circle"></i> Top 10 Video Mới Nhất
			</h4>
			<a href="<c:url value='/video'/>" class="btn btn-sm btn-outline-primary">
				<i class="fa fa-th-list me-1"></i> Xem tất cả Video của bạn
			</a>
		</div>
		<div class="card-body p-4">
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
				<c:forEach items="${latestVideos}" var="vid">
					<div class="col">
						<div class="card h-100 shadow-sm border-0 video-card">
							<a href="<c:url value='/video/detail?id=${vid.videoId}'/>" class="text-decoration-none">
								<c:choose>
									<c:when test="${not empty vid.poster && vid.poster.startsWith('http')}">
										<img src="${vid.poster}" alt="${vid.title}" style="height: 170px; width: 100%; object-fit: cover;">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/image?fname=${vid.poster}'/>" alt="${vid.title}" style="height: 170px; width: 100%; object-fit: cover;">
									</c:otherwise>
								</c:choose>
							</a>
							<div class="card-body d-flex flex-column p-3">
								<h6 class="card-title fw-bold mb-2" style="height: 42px; overflow: hidden; line-height: 1.3;">
									<a href="<c:url value='/video/detail?id=${vid.videoId}'/>" class="text-dark text-decoration-none" title="${vid.title}">
										${vid.title}
									</a>
								</h6>
								<p class="small text-muted mb-2">
									<i class="fa fa-user me-1 text-primary"></i> ${not empty vid.user ? vid.user.fullname : 'Admin'}
								</p>
								<div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
									<span class="small text-muted"><i class="fa fa-eye me-1"></i> ${vid.views} lượt xem</span>
									<a href="<c:url value='/video/detail?id=${vid.videoId}'/>" class="btn btn-sm btn-danger px-3">
										<i class="fa fa-play me-1"></i> Xem ngay
									</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

</div>
</body>
</html>
