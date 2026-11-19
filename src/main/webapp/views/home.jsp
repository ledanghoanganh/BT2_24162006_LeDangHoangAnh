<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ - Danh mục sản phẩm</title>
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

.main-container {
	padding: 25px;
}

.content-box {
	background: #ffffff;
	padding: 20px 25px;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
	vertical-align: middle !important;
}

.cate-img {
	border-radius: 4px;
	object-fit: cover;
	border: 1px solid #ddd;
	transition: transform 0.2s, box-shadow 0.2s;
}

.cate-img:hover {
	transform: scale(1.03);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.category-title-link {
	color: #0077b5;
	font-size: 16px;
	font-weight: 600;
	text-decoration: none;
	transition: color 0.2s;
}

.category-title-link:hover {
	color: #005580;
	text-decoration: underline;
}

.search-box {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}
</style>
</head>
<body>
	<!-- Khung nội dung chính -->
	<div class="container main-container">
		<div class="content-box">
			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
				<h3 style="margin: 0;">
					<i class="fa fa-list"></i> Danh sách danh mục
				</h3>

				<!-- Thanh tìm kiếm danh mục -->
				<form action="<c:url value='/home'/>" method="get"
					class="form-inline search-box" style="margin: 0;">
					<div class="input-group">
						<input type="text" name="search" value="${searchKeyword}"
							class="form-control" placeholder="Tìm kiếm danh mục...">
						<span class="input-group-btn">
							<button class="btn btn-primary" type="submit">
								<i class="fa fa-search"></i> Tìm kiếm
							</button>
						</span>
					</div>
					<!-- Nút thêm danh mục: Chỉ hiển thị cho Admin -->
					<c:if test="${sessionScope.account.roleid == 1}">
						<a href="<c:url value='/admin/category/add'/>"
							class="btn btn-success" style="margin-left: 8px;"> <i
							class="fa fa-plus"></i> Add Category
						</a>
					</c:if>
				</form>
			</div>

			<!-- Bảng danh mục sản phẩm (Bấm vào hình ảnh hoặc tên để chuyển đến trang xem sản phẩm) -->
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr class="info">
						<th style="width: 60px; text-align: center;">STT</th>
						<th style="width: 220px; text-align: center;">Images</th>
						<th>Category name</th>
						<th style="width: 140px; text-align: center;">Status</th>
						<c:if test="${sessionScope.account.roleid == 1}">
							<th style="width: 160px; text-align: center;">Action</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty listcate}">
							<c:forEach items="${listcate}" var="cate" varStatus="STT">
								<tr>
									<td style="text-align: center; font-weight: bold;">${STT.index + 1}</td>
									<td style="text-align: center;"><c:choose>
											<c:when
												test="${not empty cate.images && cate.images.startsWith('http')}">
												<c:url value="${cate.images}" var="imgUrl" />
											</c:when>
											<c:when test="${not empty cate.images}">
												<c:url value="/image?fname=${cate.images}" var="imgUrl" />
											</c:when>
											<c:otherwise>
												<c:set var="imgUrl"
													value="https://via.placeholder.com/140x100?text=No+Image" />
											</c:otherwise>
										</c:choose> <!-- Nhấp vào hình ảnh để xem sản phẩm --> <a
										href="<c:url value='/products?id=${cate.categoryid}&name=${cate.categoryname}'/>"
										title="Xem sản phẩm thuộc danh mục ${cate.categoryname}">
											<img height="100" width="140" src="${imgUrl}"
											class="cate-img"
											onerror="this.src='https://via.placeholder.com/140x100?text=No+Image'" />
									</a></td>
									<td><a
										href="<c:url value='/products?id=${cate.categoryid}&name=${cate.categoryname}'/>"
										class="category-title-link"> ${cate.categoryname} </a></td>
									<td style="text-align: center;"><c:if
											test="${cate.status == 1}">
											<span class="label label-success"
												style="font-size: 12px; padding: 5px 10px;">Hoạt động</span>
										</c:if> <c:if test="${cate.status != 1}">
											<span class="label label-danger"
												style="font-size: 12px; padding: 5px 10px;">Khóa</span>
										</c:if></td>
									<c:if test="${sessionScope.account.roleid == 1}">
										<td style="text-align: center;"><a
											href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>"
											class="btn btn-sm btn-warning"> <i class="fa fa-pencil"></i>
												Sửa
										</a> <a
											href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>"
											class="btn btn-sm btn-danger"
											onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
												<i class="fa fa-trash"></i> Xóa
										</a></td>
									</c:if>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="${sessionScope.account.roleid == 1 ? 5 : 4}"
									style="text-align: center; padding: 30px; color: #777;"><i
									class="fa fa-folder-open-o fa-2x"
									style="margin-bottom: 8px; display: block;"></i> Chưa có danh
									mục nào được tìm thấy.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<!-- SECTION: 10 VIDEO MỚI NHẤT -->
	<div class="content-box" style="margin-top: 25px;">
		<div
			style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
			<h3 style="margin: 0; color: #d9534f;">
				<i class="fa fa-play-circle"></i> Top 10 Video Mới Nhất
			</h3>
			<a href="<c:url value='/video'/>" class="btn btn-sm btn-primary">
				<i class="fa fa-th-list"></i> Xem tất cả Video của bạn (/video)
			</a>
		</div>

		<div class="row">
			<c:forEach items="${latestVideos}" var="vid">
				<div class="col-md-3 col-sm-6" style="margin-bottom: 20px;">
					<div class="thumbnail"
						style="border-radius: 6px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); height: 320px; display: flex; flex-direction: column; justify-content: space-between;">
						<a href="<c:url value='/video/detail?id=${vid.videoId}'/>"> <c:choose>
								<c:when test="${not empty vid.poster && vid.poster.startsWith('http')}">
									<img src="${vid.poster}" alt="${vid.title}"
										style="height: 160px; width: 100%; object-fit: cover; border-top-left-radius: 6px; border-top-right-radius: 6px;">
								</c:when>
								<c:otherwise>
									<img src="<c:url value='/image?fname=${vid.poster}'/>"
										alt="${vid.title}"
										style="height: 160px; width: 100%; object-fit: cover; border-top-left-radius: 6px; border-top-right-radius: 6px;">
								</c:otherwise>
							</c:choose>
						</a>
						<div class="caption" style="padding: 10px;">
							<!-- BẤM VÀO TIÊU ĐỀ ĐỂ PLAY VIDEO THEO ĐÚNG YÊU CẦU GIẢNG VIÊN -->
							<h4
								style="font-size: 14px; font-weight: bold; margin: 0 0 8px 0; height: 40px; overflow: hidden;">
								<a href="<c:url value='/video/detail?id=${vid.videoId}'/>"
									title="${vid.title}"
									style="color: #333; text-decoration: none;"> ${vid.title} </a>
							</h4>
							<p style="font-size: 12px; color: #777; margin-bottom: 5px;">
								<i class="fa fa-user"></i> Người đăng: <strong>${not empty vid.user ? vid.user.fullname : 'Admin'}</strong>
							</p>
							<p
								style="font-size: 12px; color: #888; margin: 0; display: flex; justify-content: space-between;">
								<span><i class="fa fa-eye"></i> ${vid.views} lượt xem</span> <a
									href="<c:url value='/video/detail?id=${vid.videoId}'/>"
									class="btn btn-xs btn-danger"> <i class="fa fa-play"></i>
									Xem ngay
								</a>
							</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
