<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account || sessionScope.account.roleid != 1}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm danh mục mới</title>
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

.box-form {
	max-width: 600px;
	margin: 50px auto;
	background: #ffffff;
	padding: 30px;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.box-form h2 {
	margin-top: 0;
	margin-bottom: 25px;
	font-size: 22px;
	color: #333;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="box-form">
			<h2><i class="fa fa-plus-circle"></i> Thêm danh mục mới</h2>

			<form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="categoryname">Category name:</label>
					<input type="text" id="categoryname" name="categoryname" class="form-control" required>
				</div>

				<div class="form-group">
					<label for="images">Link images:</label>
					<input type="text" id="images" name="images" class="form-control" placeholder="https://example.com/image.jpg">
				</div>

				<div class="form-group">
					<label for="images1">Upload images:</label>
					<input type="file" id="images1" name="images1" class="form-control">
				</div>

				<div class="form-group">
					<label>Status:</label><br>
					<label class="radio-inline">
						<input type="radio" id="ston" name="status" value="1" checked> Hoạt động
					</label>
					<label class="radio-inline">
						<input type="radio" id="stoff" name="status" value="0"> Khóa
					</label>
				</div>

				<div style="margin-top: 25px;">
					<input type="submit" value="Insert" class="btn btn-primary" style="min-width: 100px;">
					<a href="<c:url value='/admin/categories'/>" class="btn btn-default" style="margin-left: 10px;">Hủy / Quay lại</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
