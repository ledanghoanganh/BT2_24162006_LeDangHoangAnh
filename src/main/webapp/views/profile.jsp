<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân - VideoHub</title>
</head>
<body>
<div class="container py-4">
    <!-- Tiêu đề trang -->
    <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-3">
        <div>
            <h3 class="fw-bold text-primary mb-1">
                <i class="fa fa-id-card me-2"></i> Hồ sơ cá nhân
            </h3>
            <p class="text-muted mb-0">Quản lý và cập nhật thông tin tài khoản của bạn</p>
        </div>
        <div>
            <a href="${ctx}/home" class="btn btn-outline-secondary">
                <i class="fa fa-arrow-left me-1"></i> Về trang chủ
            </a>
        </div>
    </div>

    <!-- Thông báo Alert -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.flash_success}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${sessionScope.flash_success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="flash_success" scope="session"/>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa fa-exclamation-triangle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- CỘT TRÁI: Thẻ Avatar và Tóm tắt thông tin -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 text-center p-4">
                <div class="position-relative d-inline-block mx-auto mb-3">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img id="avatarPreview" src="${user.avatar}" alt="Avatar"
                                 class="rounded-circle img-thumbnail shadow"
                                 style="width: 150px; height: 150px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img id="avatarPreview" src="https://via.placeholder.com/150?text=Avatar" alt="Avatar"
                                 class="rounded-circle img-thumbnail shadow"
                                 style="width: 150px; height: 150px; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                    <span class="position-absolute bottom-0 end-0 bg-primary text-white p-2 rounded-circle shadow-sm"
                          title="Lưu trữ trên Cloudinary" style="font-size: 12px;">
                        <i class="fa fa-cloud"></i>
                    </span>
                </div>

                <h5 class="fw-bold mb-1">${not empty user.fullname ? user.fullname : user.username}</h5>
                <p class="text-muted small mb-2">@${user.username}</p>

                <div class="mb-3">
                    <c:choose>
                        <c:when test="${user.roleid == 1}">
                            <span class="badge bg-danger fs-6 px-3 py-1">Quản trị viên (Admin)</span>
                        </c:when>
                        <c:when test="${user.roleid == 2}">
                            <span class="badge bg-warning text-dark fs-6 px-3 py-1">Quản lý (Manager)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-success fs-6 px-3 py-1">Thành viên (User)</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <ul class="list-group list-group-flush text-start small mt-2">
                    <li class="list-group-item d-flex justify-content-between px-0">
                        <span class="text-muted"><i class="fa fa-calendar me-2"></i> Ngày đăng ký:</span>
                        <strong class="text-dark">
                            <fmt:formatDate value="${user.createddate}" pattern="dd/MM/yyyy HH:mm"/>
                        </strong>
                    </li>
                    <li class="list-group-item d-flex justify-content-between px-0">
                        <span class="text-muted"><i class="fa fa-shield-alt me-2"></i> Trạng thái:</span>
                        <span class="text-success fw-bold"><i class="fa fa-check-circle"></i> Đang hoạt động</span>
                    </li>
                </ul>
            </div>
        </div>

        <!-- CỘT PHẢI: Form Cập nhật Thông tin -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="card-title fw-bold text-dark mb-0">
                        <i class="fa fa-edit me-2 text-primary"></i> Chỉnh sửa thông tin cá nhân
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${ctx}/profile/update" method="post" enctype="multipart/form-data">
                        <!-- Tên đăng nhập (Chỉ xem) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted">Tên đăng nhập (Username)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa fa-user"></i></span>
                                <input type="text" class="form-control bg-light" value="${user.username}" readonly>
                            </div>
                            <small class="text-muted">Tên đăng nhập là cố định và không thể thay đổi.</small>
                        </div>

                        <!-- Họ và tên -->
                        <div class="mb-3">
                            <label for="fullname" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-address-card"></i></span>
                                <input type="text" id="fullname" name="fullname" class="form-control"
                                       value="${user.fullname}" required placeholder="Nhập họ và tên đầy đủ">
                            </div>
                        </div>

                        <!-- Số điện thoại -->
                        <div class="mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-phone"></i></span>
                                <input type="text" id="phone" name="phone" class="form-control"
                                       value="${user.phone}" placeholder="Ví dụ: 0912345678">
                            </div>
                        </div>

                        <!-- Email (Có thông báo xác thực OTP nếu thay đổi) -->
                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                Địa chỉ Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                                <input type="email" id="email" name="email" class="form-control"
                                       value="${user.email}" required placeholder="example@gmail.com">
                            </div>
                            <div class="form-text text-warning mt-1">
                                <i class="fa fa-info-circle me-1"></i>
                                <strong>Lưu ý:</strong> Nếu bạn thay đổi Email, hệ thống sẽ gửi mã <strong>OTP xác thực 6 số</strong> đến email mới để hoàn tất việc cập nhật.
                            </div>
                        </div>

                        <!-- Tải ảnh đại diện (Cloudinary Upload) -->
                        <div class="mb-4">
                            <label for="avatarFile" class="form-label fw-semibold">
                                Thay đổi Ảnh đại diện (Tải lên Cloudinary)
                            </label>
                            <input class="form-control" type="file" id="avatarFile" name="avatarFile"
                                   accept="image/*" onchange="previewImage(event)">
                            <div class="form-text text-muted">
                                Hỗ trợ: JPG, PNG, GIF, WEBP (tối đa 5MB). Ảnh sẽ được lưu trữ an toàn trên CDN Cloudinary.
                            </div>
                        </div>

                        <!-- Các nút thao tác -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                <i class="fa fa-save me-1"></i> Lưu thay đổi
                            </button>
                            <a href="${ctx}/profile" class="btn btn-light border px-4">
                                <i class="fa fa-undo me-1"></i> Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript xem trước ảnh trực tiếp trước khi upload -->
<script>
    function previewImage(event) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
