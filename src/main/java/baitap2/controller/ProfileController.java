package baitap2.controller;

import java.io.IOException;

import baitap2.dto.PendingProfileUpdate;
import baitap2.entity.User;
import baitap2.service.IUserService;
import baitap2.service.impl.UserServiceImpl;
import baitap2.util.CloudinaryUtil;
import baitap2.util.EmailUtil;
import baitap2.util.OtpUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB: Bộ nhớ đệm tạm
        maxFileSize = 1024 * 1024 * 5,       // 5MB: Kích thước tối đa của 1 file ảnh
        maxRequestSize = 1024 * 1024 * 10    // 10MB: Tổng kích thước request
)
@WebServlet(urlPatterns = { "/profile", "/profile/update", "/profile/verify-otp" })
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        // 1. Kiểm tra đăng nhập
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();

        // 2. Điều hướng trang xác thực OTP đổi email
        if ("/profile/verify-otp".equals(path)) {
            PendingProfileUpdate pending = (PendingProfileUpdate) session.getAttribute("PENDING_PROFILE_UPDATE");
            if (pending == null) {
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }
            req.setAttribute("newEmail", pending.getNewEmail());
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // 3. Hiển thị trang Profile mặc định
        // Luôn load dữ liệu mới nhất từ DB để tránh thông tin cũ trong session
        User latestUser = userService.findById(currentUser.getId());
        if (latestUser != null) {
            session.setAttribute("account", latestUser);
            req.setAttribute("user", latestUser);
        } else {
            req.setAttribute("user", currentUser);
        }
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();

        if ("/profile/update".equals(path)) {
            handleProfileUpdate(req, resp, session, currentUser);
        } else if ("/profile/verify-otp".equals(path)) {
            handleOtpVerification(req, resp, session, currentUser);
        }
    }

    /**
     * Xử lý gửi Form Profile: Họ tên, Số điện thoại, Email mới, Upload Avatar Cloudinary
     */
    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User currentUser)
            throws ServletException, IOException {
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        // Trim dữ liệu
        fullname = (fullname != null) ? fullname.trim() : "";
        phone = (phone != null) ? phone.trim() : "";
        email = (email != null) ? email.trim() : "";

        // Validate cơ bản
        if (fullname.isEmpty()) {
            req.setAttribute("error", "Họ và tên không được để trống!");
            forwardToProfile(req, resp, currentUser);
            return;
        }

        if (email.isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            req.setAttribute("error", "Địa chỉ email không đúng định dạng!");
            forwardToProfile(req, resp, currentUser);
            return;
        }

        if (!phone.isEmpty() && !phone.matches("^0[0-9]{9}$")) {
            req.setAttribute("error", "Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0!");
            forwardToProfile(req, resp, currentUser);
            return;
        }

        // 1. Xử lý Upload file ảnh đại diện lên Cloudinary (nếu người dùng có chọn file mới)
        String uploadedAvatarUrl = currentUser.getAvatar();
        try {
            Part filePart = req.getPart("avatarFile");
            if (filePart != null && filePart.getSize() > 0) {
                String newUrl = CloudinaryUtil.uploadAvatar(filePart);
                if (newUrl != null) {
                    uploadedAvatarUrl = newUrl;
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi upload ảnh đại diện: " + e.getMessage());
            forwardToProfile(req, resp, currentUser);
            return;
        }

        // 2. Kiểm tra việc thay đổi Email
        boolean isEmailChanged = !email.equalsIgnoreCase(currentUser.getEmail());

        if (!isEmailChanged) {
            // TRƯỜNG HỢP 1: KHÔNG THAY ĐỔI EMAIL
            // Cập nhật ngay lập tức vào database
            User updatedUser = userService.updateProfile(currentUser.getId(), fullname, phone, uploadedAvatarUrl);
            session.setAttribute("account", updatedUser);
            req.setAttribute("message", "Cập nhật hồ sơ cá nhân thành công!");
            forwardToProfile(req, resp, updatedUser);
        } else {
            // TRƯỜNG HỢP 2: CÓ THAY ĐỔI EMAIL MỚI
            // Kiểm tra email mới đã bị người khác dùng chưa
            if (userService.checkExistEmailExceptUser(email, currentUser.getId())) {
                req.setAttribute("error", "Email '" + email + "' đã được sử dụng bởi một tài khoản khác!");
                forwardToProfile(req, resp, currentUser);
                return;
            }

            // Sinh mã OTP và thời gian hết hạn (5 phút)
            String otp = OtpUtil.generateOTP();
            long expireTime = System.currentTimeMillis() + (5 * 60 * 1000);

            // Lưu thông tin cập nhật tạm vào Session
            PendingProfileUpdate pending = PendingProfileUpdate.builder()
                    .userId(currentUser.getId())
                    .newFullname(fullname)
                    .newPhone(phone)
                    .newEmail(email)
                    .newAvatar(uploadedAvatarUrl)
                    .otp(otp)
                    .expireTime(expireTime)
                    .build();
            session.setAttribute("PENDING_PROFILE_UPDATE", pending);

            // Gửi OTP tới địa chỉ EMAIL MỚI
            String subject = "Mã xác thực thay đổi Email - VideoHub";
            String content = "<div style='font-family: Arial, sans-serif; line-height: 1.6; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 8px; padding: 20px;'>"
                    + "<h2 style='color: #0d6efd; text-align: center;'>Xác thực thay đổi Email</h2>"
                    + "<p>Xin chào <strong>" + fullname + "</strong>,</p>"
                    + "<p>Bạn vừa yêu cầu thay đổi địa chỉ email liên kết với tài khoản <strong>" + currentUser.getUsername() + "</strong> sang địa chỉ email này.</p>"
                    + "<div style='background-color: #f8f9fa; border-left: 4px solid #0d6efd; padding: 15px; margin: 20px 0; text-align: center;'>"
                    + "<span style='font-size: 14px; color: #6c757d;'>Mã OTP xác thực của bạn là:</span><br/>"
                    + "<span style='font-size: 32px; font-weight: bold; color: #d63384; letter-spacing: 5px;'>" + otp + "</span>"
                    + "</div>"
                    + "<p style='color: #dc3545;'><strong>Lưu ý:</strong> Mã này có hiệu lực trong vòng <strong>5 phút</strong>. Tuyệt đối không chia sẻ mã cho người khác.</p>"
                    + "<p style='font-size: 13px; color: #6c757d; border-top: 1px solid #eee; padding-top: 10px;'>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email.</p>"
                    + "</div>";

            EmailUtil.sendEmail(email, subject, content);

            // Chuyển hướng sang trang xác nhận OTP
            resp.sendRedirect(req.getContextPath() + "/profile/verify-otp");
        }
    }

    /**
     * Xử lý xác thực OTP khi cập nhật Email mới
     */
    private void handleOtpVerification(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User currentUser)
            throws ServletException, IOException {
        PendingProfileUpdate pending = (PendingProfileUpdate) session.getAttribute("PENDING_PROFILE_UPDATE");
        if (pending == null) {
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        String action = req.getParameter("action");

        // Gửi lại mã OTP
        if ("resend".equalsIgnoreCase(action)) {
            String newOtp = OtpUtil.generateOTP();
            pending.setOtp(newOtp);
            pending.setExpireTime(System.currentTimeMillis() + (5 * 60 * 1000));
            session.setAttribute("PENDING_PROFILE_UPDATE", pending);

            String subject = "Mã xác thực thay đổi Email (Gửi lại) - VideoHub";
            String content = "<p>Mã OTP mới của bạn là: <b style='font-size: 24px; color: #d63384;'>" + newOtp + "</b> (Hiệu lực 5 phút)</p>";
            EmailUtil.sendEmail(pending.getNewEmail(), subject, content);

            req.setAttribute("newEmail", pending.getNewEmail());
            req.setAttribute("message", "Đã gửi lại mã OTP thành công! Vui lòng kiểm tra hòm thư " + pending.getNewEmail());
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // Xác thực mã OTP người dùng nhập
        String enteredOtp = req.getParameter("otp");
        if (enteredOtp == null || enteredOtp.trim().isEmpty()) {
            req.setAttribute("newEmail", pending.getNewEmail());
            req.setAttribute("error", "Vui lòng nhập mã OTP!");
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra thời gian hết hạn
        if (System.currentTimeMillis() > pending.getExpireTime()) {
            req.setAttribute("newEmail", pending.getNewEmail());
            req.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng bấm 'Gửi lại mã OTP'.");
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra mã OTP
        if (pending.getOtp().equals(enteredOtp.trim())) {
            // OTP CHÍNH XÁC: Cập nhật chính thức vào database
            User updatedUser = userService.updateProfileWithEmail(
                    pending.getUserId(),
                    pending.getNewFullname(),
                    pending.getNewPhone(),
                    pending.getNewEmail(),
                    pending.getNewAvatar()
            );

            // Cập nhật lại session account và xóa pending
            session.setAttribute("account", updatedUser);
            session.removeAttribute("PENDING_PROFILE_UPDATE");

            // Chuyển hướng về trang profile kèm thông báo thành công
            session.setAttribute("flash_success", "Cập nhật Email mới và thông tin hồ sơ thành công!");
            resp.sendRedirect(req.getContextPath() + "/profile");
        } else {
            req.setAttribute("newEmail", pending.getNewEmail());
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
        }
    }

    private void forwardToProfile(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }
}
