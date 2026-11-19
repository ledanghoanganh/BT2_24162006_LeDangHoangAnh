<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account || (sessionScope.account.roleid != 1 && sessionScope.account.roleid != 2)}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục - Dashboard Admin</title>
<style>
.page-title {
	color: #ff0000;
	font-size: 26px;
	font-weight: 700;
	margin-top: 0;
	margin-bottom: 4px;
}
.page-subtitle {
	color: #666666;
	font-size: 14px;
	margin-bottom: 20px;
}
.admin-panel {
	background: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 6px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.admin-panel-header {
	background-color: #f7f7f7;
	border-bottom: 1px solid #e0e0e0;
	padding: 14px 20px;
	font-weight: 600;
	color: #333333;
	font-size: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.admin-panel-body {
	padding: 20px;
}
.table-toolbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	font-size: 13px;
	color: #555555;
}
.table-toolbar select {
	height: 34px;
	padding: 4px 8px;
	border: 1px solid #cccccc;
	border-radius: 4px;
	margin-right: 5px;
}
.table-toolbar input[type="text"] {
	height: 34px;
	padding: 4px 10px;
	border: 1px solid #cccccc;
	border-radius: 4px;
	width: 220px;
}
.category-table {
	width: 100%;
	border-collapse: collapse;
}
.category-table th {
	border-top: 1px solid #eeeeee;
	border-bottom: 2px solid #dddddd;
	padding: 12px 15px;
	font-weight: 600;
	color: #333333;
	font-size: 14px;
}
.category-table td {
	border-bottom: 1px solid #eeeeee;
	padding: 14px 15px;
	vertical-align: middle;
	font-size: 14px;
	color: #444444;
}
.cate-img-circle {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	background-color: #f2f3f5;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}
.cate-img-circle img {
	max-width: 80%;
	max-height: 80%;
	object-fit: contain;
}
.action-links a {
	color: #0d6efd;
	text-decoration: none;
	font-weight: 500;
}
.action-links a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<div>
			<h1 class="page-title"><i class="fa fa-folder-open text-danger me-2"></i>Quản lý danh mục</h1>
			<p class="page-subtitle mb-0">Nơi bạn có thể quản lý danh mục của mình</p>
		</div>
		<a href="<c:url value='/admin/category/add'/>" class="btn btn-success">
			<i class="fa fa-plus me-1"></i> Thêm danh mục mới
		</a>
	</div>

	<div class="admin-panel">
		<div class="admin-panel-header">
			<span><i class="fa fa-list me-1"></i> Danh sách danh mục</span>
		</div>
		<div class="admin-panel-body">
			<!-- Toolbar -->
			<div class="table-toolbar">
				<div>
					<select>
						<option>10</option>
						<option>25</option>
						<option>50</option>
					</select>
					<span>records per page</span>
				</div>
				<div>
					<span>Search: </span>
					<input type="text" id="categorySearch" placeholder="Nhập để tìm kiếm...">
				</div>
			</div>

			<!-- Table -->
			<table class="category-table table-hover" id="categoryTable">
				<thead>
					<tr>
						<th style="width: 80px;">STT</th>
						<th style="width: 150px;">Hình ảnh</th>
						<th>Tên danh mục</th>
						<th style="width: 160px;">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty listcate}">
							<c:forEach items="${listcate}" var="cate" varStatus="STT">
								<tr>
									<td>${STT.index + 1}</td>
									<td>
										<div class="cate-img-circle">
											<c:choose>
												<c:when test="${not empty cate.images && cate.images.startsWith('http')}">
													<c:url value="${cate.images}" var="imgUrl" />
												</c:when>
												<c:when test="${not empty cate.images}">
													<c:url value="/image?fname=${cate.images}" var="imgUrl" />
												</c:when>
												<c:otherwise>
													<c:set var="imgUrl" value="https://via.placeholder.com/100?text=No+Image" />
												</c:otherwise>
											</c:choose>
											<img src="${imgUrl}" alt="${cate.categoryname}"
												onerror="this.src='https://via.placeholder.com/100?text=No+Image'" />
										</div>
									</td>
									<td style="font-weight: 500;">${cate.categoryname}</td>
									<td class="action-links">
										<a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-primary me-1">
											<i class="fa fa-pencil me-1"></i>Sửa
										</a>
										<a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-danger"
											onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
											<i class="fa fa-trash me-1"></i>Xóa
										</a>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" style="text-align: center; padding: 30px; color: #888;">
									Không tìm thấy danh mục nào.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>

	<!-- JavaScript tìm kiếm nhanh theo bảng -->
	<script>
		document.getElementById('categorySearch').addEventListener('keyup', function() {
			let filter = this.value.toLowerCase();
			let rows = document.querySelectorAll('#categoryTable tbody tr');
			rows.forEach(row => {
				let text = row.innerText.toLowerCase();
				row.style.display = text.includes(filter) ? '' : 'none';
			});
		});
	</script>
</body>
</html>
