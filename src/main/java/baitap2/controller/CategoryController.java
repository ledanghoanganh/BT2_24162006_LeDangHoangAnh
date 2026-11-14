package baitap2.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import baitap2.config.Constant;
import baitap2.entity.Category;
import baitap2.service.ICategoryService;
import baitap2.service.impl.CategoryServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/list", "/admin/category/add", "/admin/category/insert",
		"/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ICategoryService cateService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String url = req.getRequestURI();

		if (url.contains("/admin/categories") || url.contains("/admin/category/list")) {
			List<Category> list = cateService.findAll();
			req.setAttribute("listcate", list);
			req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/add")) {
			req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/edit")) {
			String idParam = req.getParameter("id");
			if (idParam != null && !idParam.isEmpty()) {
				int id = Integer.parseInt(idParam);
				Category category = cateService.findById(id);
				req.setAttribute("cate", category);
			}
			req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
		} else if (url.contains("/admin/category/delete")) {
			String idParam = req.getParameter("id");
			if (idParam != null && !idParam.isEmpty()) {
				int id = Integer.parseInt(idParam);
				try {
					cateService.delete(id);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			resp.sendRedirect(req.getContextPath() + "/admin/categories");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String url = req.getRequestURI();

		if (url.contains("/admin/category/insert")) {
			String categoryname = req.getParameter("categoryname");
			String statusStr = req.getParameter("status");
			int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
			String images = req.getParameter("images");

			Category category = new Category();
			category.setCategoryname(categoryname);
			category.setStatus(status);

			String fname = "";
			String uploadPath = Constant.UPLOAD_DIRECTORY;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			try {
				Part part = req.getPart("images1");
				if (part != null && part.getSize() > 0) {
					String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					int index = filename.lastIndexOf(".");
					String ext = (index > 0) ? filename.substring(index + 1) : "png";
					fname = System.currentTimeMillis() + "." + ext;
					part.write(uploadPath + File.separator + fname);
					category.setImages(fname);
				} else if (images != null && !images.trim().isEmpty()) {
					category.setImages(images.trim());
				} else {
					category.setImages("avatar.png");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			cateService.insert(category);
			resp.sendRedirect(req.getContextPath() + "/admin/categories");
		} else if (url.contains("/admin/category/update")) {
			int categoryid = Integer.parseInt(req.getParameter("categoryid"));
			String categoryname = req.getParameter("categoryname");
			String statusStr = req.getParameter("status");
			int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
			String images = req.getParameter("images");

			Category category = cateService.findById(categoryid);
			if (category == null) {
				category = new Category();
				category.setCategoryid(categoryid);
			}

			String fileold = (category.getImages() != null) ? category.getImages() : "avatar.png";
			category.setCategoryname(categoryname);
			category.setStatus(status);

			String fname = "";
			String uploadPath = Constant.UPLOAD_DIRECTORY;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			try {
				Part part = req.getPart("images1");
				if (part != null && part.getSize() > 0) {
					if (fileold != null && !fileold.startsWith("https")) {
						deleteFile(uploadPath + File.separator + fileold);
					}
					String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					int index = filename.lastIndexOf(".");
					String ext = (index > 0) ? filename.substring(index + 1) : "png";
					fname = System.currentTimeMillis() + "." + ext;
					part.write(uploadPath + File.separator + fname);
					category.setImages(fname);
				} else if (images != null && !images.trim().isEmpty()) {
					category.setImages(images.trim());
				} else {
					category.setImages(fileold);
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			cateService.update(category);
			resp.sendRedirect(req.getContextPath() + "/admin/categories");
		}
	}

	public static void deleteFile(String filePath) {
		try {
			Path path = Paths.get(filePath);
			Files.deleteIfExists(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
