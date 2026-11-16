package baitap2.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/admin/dashboard", "/admin/products", "/admin/users", "/admin/under-development" })
public class AdminFeatureController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String title = "Tính năng đang được phát triển";
		String activeMenu = "dashboard";

		if (uri.contains("/admin/products")) {
			title = "Quản lý sản phẩm";
			activeMenu = "products";
		} else if (uri.contains("/admin/users")) {
			title = "Quản lý tài khoản";
			activeMenu = "users";
		} else if (uri.contains("/admin/dashboard")) {
			title = "Dashboard - Bảng điều khiển";
			activeMenu = "dashboard";
		}

		req.setAttribute("featureTitle", title);
		req.setAttribute("activeMenu", activeMenu);
		req.getRequestDispatcher("/views/admin/under-development.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
