package baitap2.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap2.entity.Category;
import baitap2.service.ICategoryService;
import baitap2.service.impl.CategoryServiceImpl;

@WebServlet(urlPatterns = { "/products", "/category/products", "/product/list" })
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ICategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idParam = req.getParameter("id");
		String categoryName = req.getParameter("name");

		if (idParam != null && !idParam.isEmpty()) {
			try {
				int id = Integer.parseInt(idParam);
				Category cate = categoryService.findById(id);
				if (cate != null) {
					categoryName = cate.getCategoryname();
				}
			} catch (Exception e) {
				// Ignore
			}
		}

		if (categoryName == null || categoryName.trim().isEmpty()) {
			categoryName = "Sản phẩm";
		}

		req.setAttribute("categoryName", categoryName);
		req.getRequestDispatcher("/views/under-development.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
