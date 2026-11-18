package baitap2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import baitap2.config.Constant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;

@WebServlet(urlPatterns = { "/video/stream" }) // ?fname=abc.mp4
public class VideoStreamController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("fname");
		if (fileName != null && !fileName.trim().isEmpty()) {
			File file = new File(Constant.UPLOAD_DIRECTORY + File.separator + fileName);
			if (file.exists()) {
				resp.setContentType("video/mp4");
				resp.setContentLengthLong(file.length());
				resp.setHeader("Accept-Ranges", "bytes");

				try (FileInputStream fis = new FileInputStream(file)) {
					IOUtils.copy(fis, resp.getOutputStream());
				}
				return;
			}
		}
		resp.sendError(HttpServletResponse.SC_NOT_FOUND);
	}
}
