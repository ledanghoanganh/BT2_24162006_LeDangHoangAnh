package baitap2.config;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import com.cloudinary.Cloudinary;

public class CloudinaryConfig {

	private static final Map<String, String> ENV = new HashMap<>();
	private static Cloudinary cloudinary = null;

	static {
		loadEnv();
	}

	public static void loadEnv() {
		// 1. Nạp từ ClassLoader (resources: src/main/resources/.env)
		loadFromStream(CloudinaryConfig.class.getClassLoader().getResourceAsStream(".env"), "ClassLoader (.env)");
		if (Thread.currentThread().getContextClassLoader() != null) {
			loadFromStream(Thread.currentThread().getContextClassLoader().getResourceAsStream(".env"),
					"ContextClassLoader (.env)");
		}
		loadFromStream(CloudinaryConfig.class.getResourceAsStream("/.env"), "ResourceAsStream (/.env)");

		// 2. Kiểm tra trực tiếp file .env ở thư mục làm việc hiện tại
		File direct = new File(".env");
		if (direct.exists() && direct.isFile()) {
			loadFromFile(direct);
		}

		// 3. Tìm ngược lên các thư mục cha từ vị trí file class (hỗ trợ Tomcat / Eclipse workspace)
		try {
			File current = new File(CloudinaryConfig.class.getProtectionDomain().getCodeSource().getLocation().toURI());
			for (int i = 0; i < 10 && current != null; i++) {
				File envFile = new File(current, ".env");
				if (envFile.exists() && envFile.isFile()) {
					loadFromFile(envFile);
				}

				// Tìm trong thư mục project con nếu current là workspace root
				File prjEnv = new File(current, "BT2_24162006_LeDangHoangAnh/.env");
				if (prjEnv.exists() && prjEnv.isFile()) {
					loadFromFile(prjEnv);
				}
				File prjResEnv = new File(current, "BT2_24162006_LeDangHoangAnh/src/main/resources/.env");
				if (prjResEnv.exists() && prjResEnv.isFile()) {
					loadFromFile(prjResEnv);
				}

				current = current.getParentFile();
			}
		} catch (Exception ignored) {
		}
	}

	private static void loadFromStream(InputStream is, String sourceDesc) {
		if (is == null) {
			return;
		}
		try (is) {
			parseEnv(is);
			System.out.println("[CloudinaryConfig] Đã nạp cấu hình từ " + sourceDesc);
		} catch (Exception ignored) {
		}
	}

	private static void loadFromFile(File file) {
		try (InputStream is = new FileInputStream(file)) {
			parseEnv(is);
			System.out.println("[CloudinaryConfig] Đã nạp cấu hình từ file: " + file.getAbsolutePath());
		} catch (Exception ignored) {
		}
	}

	private static void parseEnv(InputStream is) {
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
			String line;
			while ((line = reader.readLine()) != null) {
				line = line.trim();
				if (line.isEmpty() || line.startsWith("#")) {
					continue;
				}
				int eq = line.indexOf('=');
				if (eq > 0) {
					String key = line.substring(0, eq).trim();
					String val = line.substring(eq + 1).trim();
					if ((val.startsWith("\"") && val.endsWith("\"")) || (val.startsWith("'") && val.endsWith("'"))) {
						val = val.substring(1, val.length() - 1);
					}
					ENV.put(key, val);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String get(String key, String defaultValue) {
		// 1. Ưu tiên biến môi trường hệ thống
		String val = System.getenv(key);
		if (val != null && !val.trim().isEmpty()) {
			return val.trim();
		}
		// 2. Tiếp theo System Property
		val = System.getProperty(key);
		if (val != null && !val.trim().isEmpty()) {
			return val.trim();
		}
		// 3. Đọc từ file .env đã nạp
		val = ENV.get(key);
		if (val != null && !val.trim().isEmpty()) {
			return val.trim();
		}
		return defaultValue;
	}

	public static Cloudinary getInstance() {
		if (cloudinary == null) {
			// Thử nạp lại cấu hình nếu biến chưa tồn tại
			if (ENV.isEmpty() || !ENV.containsKey("CLOUDINARY_NAME")) {
				loadEnv();
			}

			String cloudName = get("CLOUDINARY_NAME", "");
			String apiKey = get("CLOUDINARY_API_KEY", "");
			String apiSecret = get("CLOUDINARY_API_SECRET", "");

			if (cloudName.isEmpty() || apiKey.isEmpty() || apiSecret.isEmpty()) {
				throw new IllegalStateException(
						"Chưa cấu hình đầy đủ CLOUDINARY_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET trong file .env!");
			}

			System.out.println("[CloudinaryConfig] Đã nạp thành công Cloudinary với cloud_name: " + cloudName);

			Map<String, String> config = new HashMap<>();
			config.put("cloud_name", cloudName);
			config.put("api_key", apiKey);
			config.put("api_secret", apiSecret);
			config.put("secure", "true"); // Luôn sử dụng giao thức HTTPS
			cloudinary = new Cloudinary(config);
		}
		return cloudinary;
	}
}
