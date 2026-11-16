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

    private static void loadEnv() {
        boolean loaded = false;

        // 1. Kiểm tra trực tiếp file .env ở thư mục làm việc hiện tại
        File direct = new File(".env");
        if (direct.exists() && direct.isFile()) {
            try (InputStream is = new FileInputStream(direct)) {
                parseEnv(is);
                loaded = true;
                System.out.println("[EmailConfig] Đã nạp cấu hình từ: " + direct.getAbsolutePath());
            } catch (Exception ignored) {
            }
        }

        // 2. Tìm ngược lên các thư mục cha từ thư mục chứa class (hỗ trợ Tomcat / Eclipse)
        if (!loaded) {
            try {
                File current = new File(EmailConfig.class.getProtectionDomain().getCodeSource().getLocation().toURI());
                for (int i = 0; i < 6 && current != null; i++) {
                    File envFile = new File(current, ".env");
                    if (envFile.exists() && envFile.isFile()) {
                        try (InputStream is = new FileInputStream(envFile)) {
                            parseEnv(is);
                            loaded = true;
                            System.out.println("[EmailConfig] Đã nạp cấu hình từ: " + envFile.getAbsolutePath());
                            break;
                        } catch (Exception ignored) {
                        }
                    }
                    current = current.getParentFile();
                }
            } catch (Exception ignored) {
            }
        }

        // 3. Tìm từ ClassLoader (resources: src/main/resources/.env)
        if (!loaded) {
            try (InputStream is = EmailConfig.class.getClassLoader().getResourceAsStream(".env")) {
                if (is != null) {
                    parseEnv(is);
                    loaded = true;
                    System.out.println("[EmailConfig] Đã nạp cấu hình từ ClassLoader (.env)");
                }
            } catch (Exception ignored) {
            }
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
            return val;
        }
        // 2. Tiếp theo System Property
        val = System.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val;
        }
        // 3. Đọc từ file .env
        val = ENV.get(key);
        if (val != null && !val.trim().isEmpty()) {
            return val;
        }
        return defaultValue;
    }

    public static String getFromEmail() {
        return get("SMTP_FROM_EMAIL", "van.a.789@hc.io.vn");
    }

    public static String getPassword() {
        return get("SMTP_PASSWORD", "");
    }

    public static String getSmtpHost() {
        return get("SMTP_HOST", "smtp.tino.vn");
    }

    public static String getSmtpPort() {
        return get("SMTP_PORT", "587");
    }

    public static String getSenderName() {
        return get("SMTP_SENDER_NAME", "Web Bán Hàng - Xác thực");
    }

    // Tương thích ngược với các nơi gọi hằng số
    public static final String FROM_EMAIL = getFromEmail();
    public static final String PASSWORD = getPassword();
    public static final String SMTP_HOST = getSmtpHost();
    public static final String SMTP_PORT = getSmtpPort();
    public static final String SENDER_NAME = getSenderName();
}
