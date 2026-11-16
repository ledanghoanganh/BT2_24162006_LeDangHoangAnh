package baitap2.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap2.entity.Category;
import baitap2.service.ICategoryService;
import baitap2.service.impl.CategoryServiceImpl;

@WebServlet(urlPatterns = { "/home", "/admin/home", "/manager/home" })
public class HomeController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ICategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		String uri = request.getRequestURI();
		HttpSession session = request.getSession(false);

		// Trang quản trị (/admin/home, /manager/home) yêu cầu đăng nhập
		if (uri.contains("/manager/home") || uri.contains("/admin/home")) {
			if (session == null || session.getAttribute("account") == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
		}

		String search = request.getParameter("search");
		List<Category> list;
		if (search != null && !search.trim().isEmpty()) {
			list = categoryService.searchByName(search.trim());
		} else {
			list = categoryService.findAll();
		}

		request.setAttribute("listcate", list);
		request.setAttribute("searchKeyword", search);

		if (uri.contains("/manager/home") || uri.contains("/admin/home")) {
			request.getRequestDispatcher("/views/admin/category-list.jsp").forward(request, response);
			return;
		}

		request.getRequestDispatcher("/views/home.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
