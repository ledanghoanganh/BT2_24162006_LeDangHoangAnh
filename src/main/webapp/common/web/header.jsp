<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm" style="background-color: #0d6efd;">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${ctx}/home">
            <i class="fa fa-play-circle fs-3 text-warning"></i>
            <span>VideoHub</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarWeb" aria-controls="navbarWeb" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarWeb">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-semibold" href="${ctx}/home">
                        <i class="fa fa-home me-1"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-semibold" href="${ctx}/video">
                        <i class="fa fa-video me-1"></i> Kênh Video
                    </a>
                </li>
                <c:if test="${not empty sessionScope.account && (sessionScope.account.roleid == 1 || sessionScope.account.roleid == 2)}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-bold" href="${ctx}/admin/categories">
                            <i class="fa fa-cogs me-1"></i> Quản trị Admin
                        </a>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle d-flex align-items-center gap-2" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-user-circle fs-5"></i>
                                <span>${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li>
                                    <div class="dropdown-header">
                                        <strong>${sessionScope.account.username}</strong>
                                        <div class="small text-muted">${sessionScope.account.email}</div>
                                    </div>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${ctx}/video">
                                        <i class="fa fa-film me-2 text-primary"></i> Video của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${ctx}/video/upload">
                                        <i class="fa fa-upload me-2 text-success"></i> Upload Video mới
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${ctx}/logout">
                                        <i class="fa fa-sign-out-alt me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/login" class="btn btn-warning fw-semibold">
                            <i class="fa fa-sign-in-alt me-1"></i> Đăng nhập
                        </a>
                        <a href="${ctx}/register" class="btn btn-outline-light">
                            <i class="fa fa-user-plus me-1"></i> Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
