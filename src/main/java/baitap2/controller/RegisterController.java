package baitap2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import baitap2.config.Constant;
import baitap2.entity.User;
import baitap2.service.IUserService;
import baitap2.service.impl.UserServiceImpl;
import baitap2.util.BeanValidator;
import baitap2.util.EmailUtil;
import baitap2.util.OtpUtil;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");

		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String repassword = req.getParameter("repassword");
		String email = req.getParameter("email");
		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");

		// Backend Entity Validation
		User userCheck = new User();
		userCheck.setUsername(username != null ? username.trim() : "");
		userCheck.setPassword(password != null ? password.trim() : "");
		userCheck.setEmail(email != null ? email.trim() : "");
		userCheck.setFullname(fullname != null ? fullname.trim() : "");
		userCheck.setPhone(phone != null ? phone.trim() : "");

		String valError = BeanValidator.getFirstError(userCheck);
		if (valError != null) {
			req.setAttribute("alert", valError);
			req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
			return;
		}

		if (repassword == null || !repassword.equals(password)) {
			req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
			req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
			return;
		}

		IUserService service = new UserServiceImpl();
		if (service.checkExistEmail(email)) {
			req.setAttribute("alert", "Email đã tồn tại!");
			req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
			return;
		}
		if (service.checkExistUsername(username)) {
			req.setAttribute("alert", "Tài khoản đã tồn tại!");
			req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
			return;
		}

		// Đăng ký tài khoản (mật khẩu được hash và status = 0)
		boolean isSuccess = service.register(username, password, email, fullname, phone);
		if (isSuccess) {
			// Sinh mã OTP
			String otp = OtpUtil.generateOTP();
			long expireTime = System.currentTimeMillis() + (5 * 60 * 1000); // Hiệu lực 5 phút

			// Lưu OTP và username vào session
			HttpSession session = req.getSession(true);
			session.setAttribute("REGISTER_OTP", otp);
			session.setAttribute("REGISTER_OTP_EXPIRE", expireTime);
			session.setAttribute("REGISTER_USERNAME", username);
			session.setAttribute("REGISTER_EMAIL", email);

			// Gửi mail OTP
			String subject = "Mã xác thực kích hoạt tài khoản - Web Bán Hàng";
			String body = "<h3>Xin chào " + fullname + ",</h3>"
					+ "<p>Mã OTP kích hoạt tài khoản của bạn là: <b style='font-size:20px;color:blue;'>" + otp
					+ "</b></p>"
					+ "<p>Mã có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>";
			EmailUtil.sendEmail(email, subject, body);

			// Chuyển hướng sang trang xác thực OTP
			resp.sendRedirect(req.getContextPath() + "/verify-otp");
		} else {
			req.setAttribute("alert", "Đăng ký thất bại! Vui lòng thử lại.");
			req.getRequestDispatcher(Constant.PATH_REGISTER).forward(req, resp);
		}
	}
}
