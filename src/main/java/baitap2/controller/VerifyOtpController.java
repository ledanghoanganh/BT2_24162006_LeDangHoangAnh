package baitap2.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap2.service.IUserService;
import baitap2.service.impl.UserServiceImpl;
import baitap2.util.EmailUtil;
import baitap2.util.OtpUtil;

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("REGISTER_USERNAME") == null) {
			resp.sendRedirect(req.getContextPath() + "/register");
			return;
		}
		req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("REGISTER_USERNAME") == null) {
			resp.sendRedirect(req.getContextPath() + "/register");
			return;
		}

		String sessionOtp = (String) session.getAttribute("REGISTER_OTP");
		Long expireTime = (Long) session.getAttribute("REGISTER_OTP_EXPIRE");
		String username = (String) session.getAttribute("REGISTER_USERNAME");
		String email = (String) session.getAttribute("REGISTER_EMAIL");

		// Xử lý gửi lại OTP (Resend)
		if ("resend".equalsIgnoreCase(action)) {
			String newOtp = OtpUtil.generateOTP();
			long newExpire = System.currentTimeMillis() + (5 * 60 * 1000);
			session.setAttribute("REGISTER_OTP", newOtp);
			session.setAttribute("REGISTER_OTP_EXPIRE", newExpire);

			String subject = "Mã xác thực kích hoạt tài khoản (Gửi lại) - Web Bán Hàng";
			String body = "<p>Mã OTP mới của bạn là: <b style='font-size:20px;color:blue;'>" + newOtp + "</b></p>";
			EmailUtil.sendEmail(email, subject, body);

			req.setAttribute("message", "Đã gửi lại mã OTP tới email của bạn!");
			req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
			return;
		}

		// Xử lý xác thực OTP
		String enteredOtp = req.getParameter("otp");
		if (enteredOtp == null || enteredOtp.trim().isEmpty()) {
			req.setAttribute("error", "Vui lòng nhập mã OTP!");
			req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
			return;
		}

		if (System.currentTimeMillis() > expireTime) {
			req.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng nhấn 'Gửi lại mã'.");
			req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
			return;
		}

		if (sessionOtp.equals(enteredOtp.trim())) {
			// Kích hoạt user trong database
			IUserService userService = new UserServiceImpl();
			userService.activateUser(username);

			// Xóa các thuộc tính session tạm
			session.removeAttribute("REGISTER_OTP");
			session.removeAttribute("REGISTER_OTP_EXPIRE");
			session.removeAttribute("REGISTER_USERNAME");
			session.removeAttribute("REGISTER_EMAIL");

			req.setAttribute("alert", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		} else {
			req.setAttribute("error", "Mã OTP không chính xác!");
			req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
		}
	}
}
