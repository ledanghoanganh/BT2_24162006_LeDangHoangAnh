package baitap2.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap2.entity.User;
import baitap2.service.IUserService;
import baitap2.service.impl.UserServiceImpl;
import baitap2.util.EmailUtil;
import baitap2.util.OtpUtil;

@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String keyword = req.getParameter("keyword"); // Username hoặc Email
		if (keyword == null || keyword.trim().isEmpty()) {
			req.setAttribute("error", "Vui lòng nhập Email hoặc Tài khoản!");
			req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
			return;
		}

		IUserService userService = new UserServiceImpl();
		User user = userService.findByUsernameOrEmail(keyword.trim());
		if (user == null) {
			req.setAttribute("error", "Không tìm thấy tài khoản tương ứng!");
			req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
			return;
		}

		// Tạo OTP và thời hạn 5 phút
		String otp = OtpUtil.generateOTP();
		long expireTime = System.currentTimeMillis() + (5 * 60 * 1000);

		HttpSession session = req.getSession(true);
		session.setAttribute("RESET_OTP", otp);
		session.setAttribute("RESET_OTP_EXPIRE", expireTime);
		session.setAttribute("RESET_USERNAME", user.getUsername());
		session.setAttribute("RESET_EMAIL", user.getEmail());

		// Gửi email
		String subject = "Mã OTP đặt lại mật khẩu - Web Bán Hàng";
		String body = "<h3>Xin chào " + user.getFullname() + ",</h3>"
				+ "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản: <b>" + user.getUsername() + "</b></p>"
				+ "<p>Mã OTP xác thực của bạn là: <b style='font-size:20px;color:red;'>" + otp + "</b></p>"
				+ "<p>Mã có hiệu lực trong 5 phút. Nếu bạn không yêu cầu, vui lòng bỏ qua thư này.</p>";
		EmailUtil.sendEmail(user.getEmail(), subject, body);

		resp.sendRedirect(req.getContextPath() + "/reset-password");
	}
}
