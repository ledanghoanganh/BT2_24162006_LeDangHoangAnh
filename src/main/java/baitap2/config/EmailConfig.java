package baitap2.config;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class EmailConfig {

	private static final Map<String, String> ENV = new HashMap<>();

	static {
		loadEnv();
	}

	public static void loadEnv() {
		// 1. Nạp từ ClassLoader (resources: src/main/resources/.env)
		loadFromStream(EmailConfig.class.getClassLoader().getResourceAsStream(".env"), "ClassLoader (.env)");
		if (Thread.currentThread().getContextClassLoader() != null) {
			loadFromStream(Thread.currentThread().getContextClassLoader().getResourceAsStream(".env"),
					"ContextClassLoader (.env)");
		}
		loadFromStream(EmailConfig.class.getResourceAsStream("/.env"), "ResourceAsStream (/.env)");

		// 2. Kiểm tra trực tiếp file .env ở thư mục làm việc hiện tại
		File direct = new File(".env");
		if (direct.exists() && direct.isFile()) {
			loadFromFile(direct);
		}

		// 3. Tìm ngược lên các thư mục cha từ vị trí file class (hỗ trợ Tomcat / Eclipse workspace)
		try {
			File current = new File(EmailConfig.class.getProtectionDomain().getCodeSource().getLocation().toURI());
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
			System.out.println("[EmailConfig] Đã nạp cấu hình từ " + sourceDesc);
		} catch (Exception ignored) {
		}
	}

	private static void loadFromFile(File file) {
		try (InputStream is = new FileInputStream(file)) {
			parseEnv(is);
			System.out.println("[EmailConfig] Đã nạp cấu hình từ file: " + file.getAbsolutePath());
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
		// 3. Đọc từ file .env đã nạp (thử nạp lại nếu chưa có)
		if (ENV.isEmpty() || !ENV.containsKey(key)) {
			loadEnv();
		}
		val = ENV.get(key);
		if (val != null && !val.trim().isEmpty()) {
			return val.trim();
		}
		return defaultValue;
	}

	public static String getFromEmail() {
		return get("SMTP_FROM_EMAIL", "");
	}

	public static String getPassword() {
		return get("SMTP_PASSWORD", "");
	}

	public static String getSmtpHost() {
		return get("SMTP_HOST", "");
	}

	public static String getSmtpPort() {
		return get("SMTP_PORT", "587");
	}

	public static String getSenderName() {
		return get("SMTP_SENDER_NAME", "Web Bán Hàng - Xác thực");
	}

	// Tương thích ngược với các nơi gọi hằng số tĩnh
	public static String FROM_EMAIL() {
		return getFromEmail();
	}

	public static String PASSWORD() {
		return getPassword();
	}

	public static String SMTP_HOST() {
		return getSmtpHost();
	}

	public static String SMTP_PORT() {
		return getSmtpPort();
	}

	public static String SENDER_NAME() {
		return getSenderName();
	}
}
