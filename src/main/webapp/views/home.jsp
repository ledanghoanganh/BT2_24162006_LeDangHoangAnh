<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account}">
	<c:redirect url="/login" />
</c:if>
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

.top-navbar .btn-logout {
	background-color: #e65100;
	padding: 5px 12px;
	border-radius: 3px;
	color: white;
	font-weight: 500;
}

.top-navbar .btn-logout:hover {
	background-color: #bf360c;
	color: white;
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
}

.search-box {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}
</style>
</head>
<body>
	<!-- Thanh điều hướng Top Navbar -->
	<div class="top-navbar">
		<div>
			<a href="<c:url value='/home'/>" style="font-size: 18px; font-weight: bold;">
				<i class="fa fa-shopping-bag"></i> Trang chủ
			</a>
			<span style="margin: 0 10px;">|</span>
			<span>Xin chào: <strong>
				<c:choose>
					<c:when test="${not empty sessionScope.account.fullname}">${sessionScope.account.fullname}</c:when>
					<c:otherwise>${sessionScope.account.username}</c:otherwise>
				</c:choose>
			</strong></span>
			<c:if test="${sessionScope.account.roleid == 1}">
				<span class="label label-danger" style="margin-left: 8px;">Admin</span>
			</c:if>
			<c:if test="${sessionScope.account.roleid == 2}">
				<span class="label label-info" style="margin-left: 8px;">Member</span>
			</c:if>
		</div>
		<div>
			<c:if test="${sessionScope.account.roleid == 1}">
				<a href="<c:url value='/admin/categories'/>" class="btn btn-sm btn-info" style="margin-right: 10px; color: white;">
					<i class="fa fa-cogs"></i> Trang Quản Trị
				</a>
			</c:if>
			<a href="<c:url value='/logout'/>" class="btn-logout">
				<i class="fa fa-sign-out"></i> Đăng xuất
			</a>
		</div>
	</div>

	<!-- Khung nội dung chính -->
	<div class="container-fluid main-container">
		<div class="content-box">
			<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
				<h3 style="margin: 0;">
					<i class="fa fa-list"></i> Danh sách danh mục
				</h3>

				<!-- Thanh tìm kiếm danh mục cho người dùng -->
				<form action="<c:url value='/home'/>" method="get" class="form-inline search-box" style="margin: 0;">
					<div class="input-group">
						<input type="text" name="search" value="${searchKeyword}" class="form-control" placeholder="Tìm kiếm danh mục...">
						<span class="input-group-btn">
							<button class="btn btn-primary" type="submit">
								<i class="fa fa-search"></i> Tìm kiếm
							</button>
						</span>
					</div>
					<!-- Nút thêm danh mục: Chỉ hiển thị cho Admin (roleid == 1) -->
					<c:if test="${sessionScope.account.roleid == 1}">
						<a href="<c:url value='/admin/category/add'/>" class="btn btn-success" style="margin-left: 8px;">
							<i class="fa fa-plus"></i> Add Category
						</a>
					</c:if>
				</form>
			</div>

			<!-- Bảng danh mục sản phẩm (Đã loại bỏ nút Sửa / Xóa đối với người dùng thường) -->
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr class="info">
						<th style="width: 60px; text-align: center;">STT</th>
						<th style="width: 220px; text-align: center;">Images</th>
						<th>Category name</th>
						<th style="width: 140px; text-align: center;">Status</th>
						<!-- Cột Action chỉ hiển thị nếu là Admin -->
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
									<td style="text-align: center;">
										<c:choose>
											<c:when test="${not empty cate.images && cate.images.startsWith('http')}">
												<c:url value="${cate.images}" var="imgUrl" />
											</c:when>
											<c:when test="${not empty cate.images}">
												<c:url value="/image?fname=${cate.images}" var="imgUrl" />
											</c:when>
											<c:otherwise>
												<c:set var="imgUrl" value="https://via.placeholder.com/140x100?text=No+Image" />
											</c:otherwise>
										</c:choose>
										<img height="100" width="140" src="${imgUrl}" class="cate-img"
											onerror="this.src='https://via.placeholder.com/140x100?text=No+Image'" />
									</td>
									<td style="font-weight: 500; font-size: 15px;">${cate.categoryname}</td>
									<td style="text-align: center;">
										<c:if test="${cate.status == 1}">
											<span class="label label-success" style="font-size: 12px; padding: 5px 10px;">Hoạt động</span>
										</c:if>
										<c:if test="${cate.status != 1}">
											<span class="label label-danger" style="font-size: 12px; padding: 5px 10px;">Khóa</span>
										</c:if>
									</td>
									<!-- Các nút CRUD: Chỉ hiển thị cho Admin -->
									<c:if test="${sessionScope.account.roleid == 1}">
										<td style="text-align: center;">
											<a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>"
												class="btn btn-sm btn-warning">
												<i class="fa fa-pencil"></i> Sửa
											</a>
											<a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>"
												class="btn btn-sm btn-danger"
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
								<td colspan="${sessionScope.account.roleid == 1 ? 5 : 4}" style="text-align: center; padding: 30px; color: #777;">
									<i class="fa fa-folder-open-o fa-2x" style="margin-bottom: 8px; display: block;"></i>
									Chưa có danh mục nào được tìm thấy.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
