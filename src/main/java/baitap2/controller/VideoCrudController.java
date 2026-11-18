package baitap2.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

import baitap2.config.Constant;
import baitap2.entity.Category;
import baitap2.entity.User;
import baitap2.entity.Video;
import baitap2.service.ICategoryService;
import baitap2.service.IVideoService;
import baitap2.service.impl.CategoryServiceImpl;
import baitap2.service.impl.VideoServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 2,           // 2MB: Bộ nhớ tạm (vượt quá 2MB sẽ ghi ra đĩa tạm tránh tràn RAM)
	maxFileSize = 1024L * 1024L * 500L,            // 500MB: Dung lượng tối đa cho 1 file video (hỗ trợ thoải mái file 210MB+)
	maxRequestSize = 1024L * 1024L * 600L          // 600MB: Tổng dung lượng tối đa cho toàn bộ Request multipart
)
@WebServlet(urlPatterns = { "/admin/videos", "/admin/video/list", "/admin/video/add", "/admin/video/insert",
		"/admin/video/edit", "/admin/video/update", "/admin/video/delete" })
public class VideoCrudController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IVideoService videoService = new VideoServiceImpl();
	private ICategoryService categoryService = new CategoryServiceImpl();

	private String getFileName(Part part) {
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf("=") + 2, content.length() - 1);
			}
		}
		return Constant.DEFAULT_FILENAME;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String url = req.getRequestURI();

		if (url.contains("/admin/videos") || url.contains("/admin/video/list")) {
			List<Video> list = videoService.findAll();
			req.setAttribute("listvideo", list);
			req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
		} else if (url.contains("/admin/video/add")) {
			List<Category> listCate = categoryService.findAll();
			req.setAttribute("categories", listCate);
			req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
		} else if (url.contains("/admin/video/edit")) {
			String id = req.getParameter("id");
			if (id != null && !id.isEmpty()) {
				Video video = videoService.findById(id);
				req.setAttribute("video", video);
				List<Category> listCate = categoryService.findAll();
				req.setAttribute("categories", listCate);
			}
			req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
		} else if (url.contains("/admin/video/delete")) {
			String id = req.getParameter("id");
			if (id != null && !id.isEmpty()) {
				try {
					videoService.delete(id);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			resp.sendRedirect(req.getContextPath() + "/admin/videos");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String url = req.getRequestURI();
		HttpSession session = req.getSession(false);
		User currentUser = null;
		if (session != null && session.getAttribute("account") != null) {
			currentUser = (User) session.getAttribute("account");
		}

		String uploadPath = Constant.UPLOAD_DIRECTORY;
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		if (url.contains("/admin/video/insert")) {
			String videoId = req.getParameter("videoId");
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			String activeStr = req.getParameter("active");
			int active = (activeStr != null) ? Integer.parseInt(activeStr) : 1;
			String categoryIdStr = req.getParameter("categoryId");
			String posterUrl = req.getParameter("posterUrl");

			Video video = new Video();
			video.setVideoId(videoId);
			video.setTitle(title);
			video.setDescription(description);
			video.setActive(active);
			video.setViews(0);
			video.setCreatedDate(new Date());

			if (currentUser != null) {
				video.setUser(currentUser);
			} else {
				// Mặc định lấy user id = 1 nếu chưa đăng nhập khi test
				User defaultUser = new User();
				defaultUser.setId(1);
				video.setUser(defaultUser);
			}

			if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
				Category cat = categoryService.findById(Integer.parseInt(categoryIdStr));
				video.setCategory(cat);
			}

			// Xử lý upload Poster (Ảnh)
			try {
				Part posterPart = req.getPart("posterFile");
				if (posterPart != null && posterPart.getSize() > 0) {
					String rawName = getFileName(posterPart);
					String ext = rawName.contains(".") ? rawName.substring(rawName.lastIndexOf(".")) : ".png";
					String posterFileName = "poster_" + System.currentTimeMillis() + ext;
					posterPart.write(uploadPath + File.separator + posterFileName);
					video.setPoster(posterFileName);
				} else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
					video.setPoster(posterUrl.trim());
				} else {
					video.setPoster("default-video.png");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			// Xử lý upload Video (.mp4)
			try {
				Part videoPart = req.getPart("videoFile");
				if (videoPart != null && videoPart.getSize() > 0) {
					String rawName = getFileName(videoPart);
					String ext = rawName.contains(".") ? rawName.substring(rawName.lastIndexOf(".")) : ".mp4";
					String videoFileName = "vid_" + System.currentTimeMillis() + ext;
					videoPart.write(uploadPath + File.separator + videoFileName);
					video.setVideoPath(videoFileName);
				} else {
					String videoPathUrl = req.getParameter("videoPathUrl");
					video.setVideoPath((videoPathUrl != null && !videoPathUrl.trim().isEmpty()) ? videoPathUrl.trim()
							: "sample.mp4");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			videoService.insert(video);
			resp.sendRedirect(req.getContextPath() + "/admin/videos");

		} else if (url.contains("/admin/video/update")) {
			String videoId = req.getParameter("videoId");
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			String activeStr = req.getParameter("active");
			int active = (activeStr != null) ? Integer.parseInt(activeStr) : 1;
			String categoryIdStr = req.getParameter("categoryId");
			String posterUrl = req.getParameter("posterUrl");

			Video video = videoService.findById(videoId);
			if (video != null) {
				video.setTitle(title);
				video.setDescription(description);
				video.setActive(active);

				if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
					Category cat = categoryService.findById(Integer.parseInt(categoryIdStr));
					video.setCategory(cat);
				}

				// Upload Poster mới nếu có
				try {
					Part posterPart = req.getPart("posterFile");
					if (posterPart != null && posterPart.getSize() > 0) {
						String rawName = getFileName(posterPart);
						String ext = rawName.contains(".") ? rawName.substring(rawName.lastIndexOf(".")) : ".png";
						String posterFileName = "poster_" + System.currentTimeMillis() + ext;
						posterPart.write(uploadPath + File.separator + posterFileName);
						video.setPoster(posterFileName);
					} else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
						video.setPoster(posterUrl.trim());
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				// Upload Video mới nếu có
				try {
					Part videoPart = req.getPart("videoFile");
					if (videoPart != null && videoPart.getSize() > 0) {
						String rawName = getFileName(videoPart);
						String ext = rawName.contains(".") ? rawName.substring(rawName.lastIndexOf(".")) : ".mp4";
						String videoFileName = "vid_" + System.currentTimeMillis() + ext;
						videoPart.write(uploadPath + File.separator + videoFileName);
						video.setVideoPath(videoFileName);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				videoService.update(video);
			}
			resp.sendRedirect(req.getContextPath() + "/admin/videos");
		}
	}
}
