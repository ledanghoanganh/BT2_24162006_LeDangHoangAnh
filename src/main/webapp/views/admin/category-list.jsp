<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if
	test="${empty sessionScope.account || sessionScope.account.roleid != 1}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
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
</style>
</head>
<body>
	<div class="top-navbar">
		<div>
			<a href="<c:url value='/home'/>" style="font-size: 18px; font-weight: bold;">
				<i class="fa fa-shopping-bag"></i> Trang chủ
			</a>
			<span style="margin: 0 10px;">|</span>
			<span>Xin chào: <strong>${sessionScope.account.fullName}</strong></span>
		</div>
		<div>
			<a href="<c:url value='/logout'/>" class="btn-logout">
				<i class="fa fa-sign-out"></i> Đăng xuất
			</a>
		</div>
	</div>

	<div class="container-fluid main-container">
		<div class="content-box">
			<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
				<h3 style="margin: 0;"><i class="fa fa-list"></i> Danh sách danh mục</h3>
				<a href="<c:url value="/admin/category/add"/>" class="btn btn-primary">
					<i class="fa fa-plus"></i> Add Category
				</a>
			</div>

			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr class="info">
						<th style="width: 60px; text-align: center;">STT</th>
						<th style="width: 220px; text-align: center;">Images</th>
						<th>Category name</th>
						<th style="width: 140px; text-align: center;">Status</th>
						<th style="width: 160px; text-align: center;">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listcate}" var="cate" varStatus="STT">
						<tr>
							<td style="text-align: center; font-weight: bold;">${STT.index + 1}</td>
							<td style="text-align: center;">
								<c:choose>
									<c:when test="${not empty cate.images && cate.images.startsWith('http')}">
										<c:url value="${cate.images}" var="imgUrl" />
									</c:when>
									<c:otherwise>
										<c:url value="/image?fname=${cate.images}" var="imgUrl" />
									</c:otherwise>
								</c:choose>
								<img height="100" width="140" src="${imgUrl}" class="cate-img"
									onerror="this.src='https://via.placeholder.com/140x100?text=No+Image'" />
							</td>
							<td style="font-weight: 500;">${cate.categoryname}</td>
							<td style="text-align: center;">
								<c:if test="${cate.status == 1}">
									<span class="label label-success" style="font-size: 12px;">Hoạt động</span>
								</c:if>
								<c:if test="${cate.status != 1}">
									<span class="label label-danger" style="font-size: 12px;">Khóa</span>
								</c:if>
							</td>
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
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
