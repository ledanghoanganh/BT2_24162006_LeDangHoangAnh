<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác thực mã OTP đổi Email - VideoHub</title>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow border-0 rounded-3">
                <div class="card-body p-4 p-md-5 text-center">
                    <div class="mb-4">
                        <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle mb-3" style="width: 70px; height: 70px;">
                            <i class="fa fa-envelope-open-text fs-2"></i>
                        </div>
                        <h4 class="fw-bold mb-1">Xác thực Email Mới</h4>
                        <p class="text-muted small">
                            Hệ thống đã gửi mã OTP 6 số đến địa chỉ:<br>
                            <strong class="text-primary fs-6">${newEmail}</strong>
                        </p>
                    </div>

                    <!-- Thông báo -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show small text-start" role="alert">
                            <i class="fa fa-check-circle me-1"></i> ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show small text-start" role="alert">
                            <i class="fa fa-exclamation-circle me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Form nhập OTP -->
                    <form action="${ctx}/profile/verify-otp" method="post" class="mb-3">
                        <div class="mb-3">
                            <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold fs-3 letter-spacing"
                                   maxlength="6" placeholder="000000" autofocus required
                                   style="letter-spacing: 8px;">
                            <div class="form-text small text-muted mt-2">
                                <i class="fa fa-clock me-1"></i> Mã OTP có hiệu lực trong 5 phút
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                            <i class="fa fa-check-circle me-1"></i> Xác nhận & Hoàn tất
                        </button>
                    </form>

                    <!-- Nút gửi lại mã & Hủy -->
                    <div class="d-flex justify-content-between align-items-center small border-top pt-3">
                        <form action="${ctx}/profile/verify-otp" method="post" class="d-inline">
                            <input type="hidden" name="action" value="resend">
                            <button type="submit" class="btn btn-link p-0 text-decoration-none text-primary">
                                <i class="fa fa-redo me-1"></i> Gửi lại mã OTP
                            </button>
                        </form>
                        <a href="${ctx}/profile" class="text-muted text-decoration-none">
                            <i class="fa fa-times me-1"></i> Hủy thay đổi
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
