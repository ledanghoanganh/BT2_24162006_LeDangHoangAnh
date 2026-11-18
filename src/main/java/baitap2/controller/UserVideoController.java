package baitap2.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import baitap2.config.Constant;
import baitap2.entity.Category;
import baitap2.entity.User;
import baitap2.entity.Video;
import baitap2.service.ICategoryService;
import baitap2.service.IUserService;
import baitap2.service.IVideoService;
import baitap2.service.impl.CategoryServiceImpl;
import baitap2.service.impl.UserServiceImpl;
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
	fileSizeThreshold = 1024 * 1024 * 2,           // 2MB: Bộ nhớ tạm (vượt quá 2MB sẽ ghi ra đĩa tạm)
	maxFileSize = 1024L * 1024L * 500L,            // 500MB: Dung lượng tối đa cho 1 file video
	maxRequestSize = 1024L * 1024L * 600L          // 600MB: Tổng dung lượng tối đa cho Request multipart
)
@WebServlet(urlPatterns = { "/video", "/video/upload", "/video/delete", "/video/edit", "/video/update" })
public class UserVideoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IVideoService videoService = new VideoServiceImpl();
	private IUserService userService = new UserServiceImpl();
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
		HttpSession session = req.getSession(false);
		User loggedInUser = null;
		if (session != null && session.getAttribute("account") != null) {
			loggedInUser = (User) session.getAttribute("account");
		}

		// 1. Chức năng mở form upload video cho User
		if (url.contains("/video/upload")) {
			if (loggedInUser == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}
			List<Category> listCate = categoryService.findAll();
			req.setAttribute("categories", listCate);
			req.getRequestDispatcher("/views/video-upload.jsp").forward(req, resp);
			return;
		}

		// 2. Chức năng mở form chỉnh sửa video cho User
		if (url.contains("/video/edit")) {
			if (loggedInUser == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}
			String videoId = req.getParameter("id");
			if (videoId != null && !videoId.trim().isEmpty()) {
				Video video = videoService.findById(videoId.trim());
				// Chỉ cho phép sửa nếu video thuộc về chính User đang đăng nhập hoặc là Admin
				if (video != null && ((video.getUser() != null && video.getUser().getId() == loggedInUser.getId()) || loggedInUser.getRoleid() == 1)) {
					List<Category> listCate = categoryService.findAll();
					req.setAttribute("video", video);
					req.setAttribute("categories", listCate);
					req.getRequestDispatcher("/views/video-edit.jsp").forward(req, resp);
					return;
				}
			}
			resp.sendRedirect(req.getContextPath() + "/video");
			return;
		}

		// 3. Chức năng xóa video do chính User đăng
		if (url.contains("/video/delete")) {
			if (loggedInUser == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}
			String videoId = req.getParameter("id");
			if (videoId != null && !videoId.trim().isEmpty()) {
				Video video = videoService.findById(videoId.trim());
				// Chỉ cho phép xóa nếu là chủ sở hữu video hoặc là Admin
				if (video != null && ((video.getUser() != null && video.getUser().getId() == loggedInUser.getId()) || loggedInUser.getRoleid() == 1)) {
					try {
						videoService.delete(videoId.trim());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			resp.sendRedirect(req.getContextPath() + "/video");
			return;
		}

		// 4. Chức năng hiển thị danh sách video phân trang 6sp/trang
		int page = 1;
		int pageSize = 6;
		String pageStr = req.getParameter("page");
		if (pageStr != null && !pageStr.trim().isEmpty()) {
			try {
				page = Integer.parseInt(pageStr.trim());
				if (page < 1) page = 1;
			} catch (NumberFormatException e) {
				page = 1;
			}
		}

		// Xác định User cần xem video:
		int targetUserId = 1;
		String userIdParam = req.getParameter("userId");
		if (userIdParam != null && !userIdParam.trim().isEmpty()) {
			try {
				targetUserId = Integer.parseInt(userIdParam.trim());
			} catch (Exception e) {
				targetUserId = 1;
			}
		} else if (loggedInUser != null) {
			targetUserId = loggedInUser.getId();
		}

		User owner = userService.findById(targetUserId);
		if (owner == null) {
			owner = loggedInUser;
		}

		List<Video> videoList = videoService.findAllByUser(targetUserId, page, pageSize);
		int totalVideos = videoService.countByUser(targetUserId);
		int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
		if (totalPages == 0) totalPages = 1;

		req.setAttribute("videoList", videoList);
		req.setAttribute("currentPage", page);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("totalPages", totalPages);
		req.setAttribute("totalVideos", totalVideos);
		req.setAttribute("owner", owner);
		req.setAttribute("targetUserId", targetUserId);

		req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String url = req.getRequestURI();
		HttpSession session = req.getSession(false);
		User loggedInUser = null;
		if (session != null && session.getAttribute("account") != null) {
			loggedInUser = (User) session.getAttribute("account");
		}

		if (loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String uploadPath = Constant.UPLOAD_DIRECTORY;
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		// Xử lý lưu Video khi User bấm Upload mới
		if (url.contains("/video/upload")) {
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			String categoryIdStr = req.getParameter("categoryId");
			String posterUrl = req.getParameter("posterUrl");
			String videoId = req.getParameter("videoId");

			if (videoId == null || videoId.trim().isEmpty()) {
				videoId = "VID" + (System.currentTimeMillis() % 1000000);
			} else {
				videoId = videoId.trim();
			}

			Video video = new Video();
			video.setVideoId(videoId);
			video.setTitle(title);
			video.setDescription(description);
			video.setActive(1); // Mặc định hoạt động
			video.setViews(0);
			video.setCreatedDate(new Date());
			video.setUser(loggedInUser); // Gán cho chính User đang đăng nhập

			if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
				try {
					Category cat = categoryService.findById(Integer.parseInt(categoryIdStr.trim()));
					video.setCategory(cat);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			// 1. Upload Poster
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
					video.setPoster("https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			// 2. Upload Video file
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
					video.setVideoPath((videoPathUrl != null && !videoPathUrl.trim().isEmpty()) ? videoPathUrl.trim() : "sample.mp4");
				}
			} catch (FileNotFoundException fne) {
				fne.printStackTrace();
			}

			videoService.insert(video);
			resp.sendRedirect(req.getContextPath() + "/video");
			return;
		}

		// Xử lý CẬP NHẬT VIDEO khi User bấm Chỉnh sửa
		if (url.contains("/video/update")) {
			String videoId = req.getParameter("videoId");
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			String categoryIdStr = req.getParameter("categoryId");
			String posterUrl = req.getParameter("posterUrl");

			if (videoId != null && !videoId.trim().isEmpty()) {
				Video video = videoService.findById(videoId.trim());
				// Chỉ cho phép cập nhật nếu là chủ sở hữu video hoặc là Admin
				if (video != null && ((video.getUser() != null && video.getUser().getId() == loggedInUser.getId()) || loggedInUser.getRoleid() == 1)) {
					video.setTitle(title);
					video.setDescription(description);
					// Giữ nguyên active và views, user không can thiệp trạng thái

					if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
						try {
							Category cat = categoryService.findById(Integer.parseInt(categoryIdStr.trim()));
							video.setCategory(cat);
						} catch (Exception e) {
							e.printStackTrace();
						}
					} else {
						video.setCategory(null);
					}

					// 1. Upload Poster mới nếu có chọn file
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

					// 2. Upload Video mới nếu có chọn file
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
			}
			resp.sendRedirect(req.getContextPath() + "/video");
			return;
		}

		doGet(req, resp);
	}
}
