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

@WebServlet(urlPatterns = "/reset-password")
public class ResetPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("RESET_USERNAME") == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}
		req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("RESET_USERNAME") == null) {
			resp.sendRedirect(req.getContextPath() + "/forgot-password");
			return;
		}

		String sessionOtp = (String) session.getAttribute("RESET_OTP");
		Long expireTime = (Long) session.getAttribute("RESET_OTP_EXPIRE");
		String username = (String) session.getAttribute("RESET_USERNAME");

		String enteredOtp = req.getParameter("otp");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");

		if (enteredOtp == null || newPassword == null || confirmPassword == null) {
			req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		if (System.currentTimeMillis() > expireTime) {
			req.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng yêu cầu lại mã mới.");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		if (!sessionOtp.equals(enteredOtp.trim())) {
			req.setAttribute("error", "Mã OTP không chính xác!");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		if (!newPassword.equals(confirmPassword)) {
			req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
			req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
			return;
		}

		// Đổi mật khẩu thành công (tự động hash bằng BCrypt trong service)
		IUserService userService = new UserServiceImpl();
		userService.updatePassword(username, newPassword);

		// Dọn dẹp session
		session.removeAttribute("RESET_OTP");
		session.removeAttribute("RESET_OTP_EXPIRE");
		session.removeAttribute("RESET_USERNAME");
		session.removeAttribute("RESET_EMAIL");

		req.setAttribute("alert", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
		req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
	}
}
