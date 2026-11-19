<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<header class="navbar navbar-expand navbar-light bg-white border-bottom shadow-sm px-4 py-3">
    <div class="container-fluid p-0 d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center gap-3">
            <span class="fs-5 fw-bold text-primary">
                <i class="fa fa-tachometer-alt me-2"></i> Bảng điều khiển Quản trị viên
            </span>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="text-end d-none d-md-block">
                <div class="fw-semibold text-dark">
                    ${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}
                </div>
                <div class="badge bg-danger">
                    <c:choose>
                        <c:when test="${sessionScope.account.roleid == 1}">Super Admin</c:when>
                        <c:otherwise>Manager</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <a href="${ctx}/home" class="btn btn-outline-primary btn-sm" target="_blank" title="Xem trang chủ">
                <i class="fa fa-external-link-alt me-1"></i> Trang chủ
            </a>
            <a href="${ctx}/logout" class="btn btn-danger btn-sm" title="Đăng xuất">
                <i class="fa fa-sign-out-alt me-1"></i> Đăng xuất
            </a>
        </div>
    </div>
</header>
