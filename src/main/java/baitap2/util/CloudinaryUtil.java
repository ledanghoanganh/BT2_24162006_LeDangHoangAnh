package baitap2.util;

import java.io.InputStream;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import baitap2.config.CloudinaryConfig;
import jakarta.servlet.http.Part;

public class CloudinaryUtil {

	/**
	 * Upload ảnh avatar từ Jakarta Servlet Part lên Cloudinary
	 * 
	 * @param part Part nhận được từ HttpServletRequest.getPart("avatarFile")
	 * @return URL an toàn (HTTPS secure_url) của ảnh trên Cloudinary, hoặc null nếu
	 *         không upload
	 */
	public static String uploadAvatar(Part part) {
		if (part == null || part.getSize() <= 0) {
			return null;
		}

		// Kiểm tra loại nội dung file (chỉ cho phép các định dạng ảnh phổ biến)
		String contentType = part.getContentType();
		if (contentType == null || !contentType.startsWith("image/")) {
			throw new IllegalArgumentException("File tải lên phải là định dạng hình ảnh (JPG, PNG, GIF, WEBP)!");
		}

		// Giới hạn dung lượng tối đa 5MB cho ảnh avatar
		if (part.getSize() > 5 * 1024 * 1024) {
			throw new IllegalArgumentException("Dung lượng file ảnh đại diện không được vượt quá 5MB!");
		}

		try (InputStream is = part.getInputStream()) {
			byte[] fileBytes = is.readAllBytes();
			Cloudinary cloudinary = CloudinaryConfig.getInstance();

			// Cấu hình thư mục lưu trữ trên Cloudinary và tự động tạo tên file ngẫu nhiên
			@SuppressWarnings("unchecked")
			Map<String, Object> uploadResult = (Map<String, Object>) cloudinary.uploader().upload(fileBytes,
					ObjectUtils.asMap("folder", "banhang/avatars", "resource_type", "image", "overwrite", true));

			// Lấy secure_url dạng https://res.cloudinary.com/...
			String secureUrl = (String) uploadResult.get("secure_url");
			System.out.println("[CLOUDINARY] Upload thành công! URL: " + secureUrl);
			return secureUrl;
		} catch (Exception e) {
			System.err.println("[CLOUDINARY] Lỗi upload ảnh: " + e.getMessage());
			e.printStackTrace();
			throw new RuntimeException("Không thể tải ảnh lên Cloudinary: " + e.getMessage(), e);
		}
	}
}
