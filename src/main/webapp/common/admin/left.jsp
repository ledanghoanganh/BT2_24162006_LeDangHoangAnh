<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<div class="admin-sidebar d-flex flex-column flex-shrink-0 p-3 text-white bg-dark shadow" style="width: 260px; min-height: 100vh;">
    <a href="${ctx}/admin/categories" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none px-2">
        <i class="fa fa-shield-alt fs-2 text-warning me-2"></i>
        <span class="fs-5 fw-bold">Admin Portal</span>
    </a>
    <hr class="border-secondary my-3">
    
    <div class="px-2 mb-3 d-flex align-items-center gap-2">
        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
            ${not empty sessionScope.account.fullname ? fn:substring(sessionScope.account.fullname, 0, 1) : 'A'}
        </div>
        <div class="overflow-hidden">
            <div class="fw-semibold text-truncate" style="max-width: 170px;">
                ${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}
            </div>
            <div class="small text-success"><i class="fa fa-circle fs-6 me-1"></i>Đang trực tuyến</div>
        </div>
    </div>
    <hr class="border-secondary my-2">

    <ul class="nav nav-pills flex-column mb-auto gap-1">
        <li class="nav-item">
            <a href="${ctx}/admin/categories" class="nav-link text-white ${fn:contains(pageContext.request.requestURI, 'categories') or fn:contains(pageContext.request.requestURI, 'category') ? 'active bg-primary' : ''}">
                <i class="fa fa-folder-open me-2"></i> Quản lý Danh mục
            </a>
        </li>
        <li class="nav-item">
            <a href="${ctx}/admin/category/add" class="nav-link text-white-50 ps-4">
                <i class="fa fa-plus-circle me-2 text-success"></i> Thêm danh mục mới
            </a>
        </li>
        <li class="nav-item mt-2">
            <a href="${ctx}/admin/videos" class="nav-link text-white ${fn:contains(pageContext.request.requestURI, 'video') ? 'active bg-primary' : ''}">
                <i class="fa fa-video me-2"></i> Quản lý Video
            </a>
        </li>
        <li class="nav-item">
            <a href="${ctx}/admin/video/add" class="nav-link text-white-50 ps-4">
                <i class="fa fa-cloud-upload-alt me-2 text-info"></i> Thêm video mới
            </a>
        </li>
        <li class="nav-item mt-2">
            <a href="${ctx}/admin/products" class="nav-link text-white-50">
                <i class="fa fa-box me-2"></i> Quản lý Sản phẩm
            </a>
        </li>
        <c:if test="${sessionScope.account.roleid == 1}">
            <li class="nav-item">
                <a href="${ctx}/admin/users" class="nav-link text-white-50">
                    <i class="fa fa-users me-2"></i> Quản lý Người dùng
                </a>
            </li>
        </c:if>
        
        <li class="nav-item mt-4 pt-3 border-top border-secondary">
            <a href="${ctx}/home" class="nav-link text-warning" target="_blank">
                <i class="fa fa-external-link-alt me-2"></i> Xem Trang chủ Web
            </a>
        </li>
        <li class="nav-item">
            <a href="${ctx}/logout" class="nav-link text-danger">
                <i class="fa fa-sign-out-alt me-2"></i> Đăng xuất
            </a>
        </li>
    </ul>

    <hr class="border-secondary my-3">
    <div class="small text-muted px-2">
        <div>Hệ thống QL Video &amp; Bán Hàng</div>
        <div>Sitemesh 3 &amp; Bootstrap 5</div>
    </div>
</div>
