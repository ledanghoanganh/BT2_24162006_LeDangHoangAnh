package baitap2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import baitap2.entity.User;
import baitap2.service.IUserService;
import baitap2.service.impl.UserServiceImpl;
import baitap2.util.BeanValidator;
import baitap2.config.Constant;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			resp.sendRedirect(req.getContextPath() + "/waiting");
			return;
		}

		// Check cookie
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (Constant.COOKIE_REMEMBER.equals(cookie.getName())) {
					IUserService userService = new UserServiceImpl();
					User user = userService.get(cookie.getValue());
					if (user != null && user.getStatus() == 1) {
						session = req.getSession(true);
						session.setAttribute("account", user);
						session.setAttribute("username", user.getUsername());
						resp.sendRedirect(req.getContextPath() + "/waiting");
						return;
					}
				}
			}
		}
		req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		boolean isRememberMe = false;
		String remember = req.getParameter("remember");
		if ("ok".equals(remember)) {
			isRememberMe = true;
		}

		// Backend Validation sử dụng BeanValidator trên Entity User
		User userCheck = new User();
		userCheck.setUsername(username != null ? username.trim() : "");
		userCheck.setPassword(password != null ? password.trim() : "");

		String usernameErr = BeanValidator.getPropertyError(userCheck, "username");
		if (usernameErr != null) {
			req.setAttribute("alert", usernameErr);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			return;
		}
		String passwordErr = BeanValidator.getPropertyError(userCheck, "password");
		if (passwordErr != null) {
			req.setAttribute("alert", passwordErr);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			return;
		}

		IUserService userService = new UserServiceImpl();
		User user = userService.login(username, password);
		if (user != null) {
			if (user.getStatus() == 0) {
				req.setAttribute("alert", "Tài khoản chưa được kích hoạt! Vui lòng xác thực mã OTP gửi qua email.");
				req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
				return;
			}

			HttpSession session = req.getSession(true);
			session.setAttribute("account", user);
			session.setAttribute("username", user.getUsername());
			if (isRememberMe) {
				saveRemeberMe(resp, username);
			}
			resp.sendRedirect(req.getContextPath() + "/waiting");
		} else {
			String alertMsg = "Tài khoản hoặc mật khẩu không đúng";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		}
	}

	private void saveRemeberMe(HttpServletResponse response, String username) {
		Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
		cookie.setMaxAge(30 * 60);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
}
