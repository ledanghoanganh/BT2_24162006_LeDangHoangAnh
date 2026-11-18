package baitap2.controller;

import java.io.IOException;

import baitap2.entity.Video;
import baitap2.service.IVideoService;
import baitap2.service.impl.VideoServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/video/detail" })
public class VideoDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IVideoService videoService = new VideoServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		String videoId = req.getParameter("id");
		if (videoId != null && !videoId.trim().isEmpty()) {
			// 1. Tăng 1 lượt xem trực tiếp vào CSDL MySQL
			videoService.increaseViews(videoId.trim());

			// 2. Lấy dữ liệu video mới nhất từ CSDL (đã bao gồm view vừa tăng)
			Video video = videoService.findById(videoId.trim());
			if (video != null) {
				req.setAttribute("video", video);
				req.getRequestDispatcher("/views/video-detail.jsp").forward(req, resp);
				return;
			}
		}

		// Nếu không tìm thấy video thì quay về /home
		resp.sendRedirect(req.getContextPath() + "/home");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
