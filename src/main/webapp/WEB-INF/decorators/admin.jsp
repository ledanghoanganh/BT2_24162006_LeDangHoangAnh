<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - <sitemesh:write property="title"/></title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6.5.1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            background-color: #f4f6f9;
        }
        .admin-main-wrapper {
            display: flex;
            min-height: 100vh;
        }
        .admin-content-pane {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
            background-color: #f8f9fa;
        }
        .admin-body-area {
            flex: 1;
            padding: 24px;
        }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <div class="admin-main-wrapper">
        <!-- Sidebar -->
        <%@ include file="/common/admin/left.jsp" %>

        <!-- Content Pane -->
        <div class="admin-content-pane">
            <%@ include file="/common/admin/header.jsp" %>
            <div class="admin-body-area">
                <sitemesh:write property="body"/>
            </div>
            <%@ include file="/common/admin/footer.jsp" %>
        </div>
    </div>

    <!-- Bootstrap 5.3.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
