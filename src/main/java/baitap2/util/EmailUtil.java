package baitap2.util;

import java.util.Properties;

import baitap2.config.EmailConfig;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    public static boolean sendEmail(String toEmail, String subject, String bodyContent) {
        System.out.println("==================================================");
        System.out.println("[EMAIL SENDER] Gửi tới: " + toEmail);
        System.out.println("[EMAIL SENDER] Tiêu đề: " + subject);
        System.out.println("[EMAIL SENDER] Nội dung: \n" + bodyContent);
        System.out.println("==================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", EmailConfig.SMTP_HOST);
        props.put("mail.smtp.port", EmailConfig.SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        props.put("mail.smtp.ssl.trust", EmailConfig.SMTP_HOST);

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EmailConfig.FROM_EMAIL, EmailConfig.PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EmailConfig.FROM_EMAIL, EmailConfig.SENDER_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(bodyContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("[EMAIL SENDER] Đã gửi email thành công qua máy chủ " + EmailConfig.SMTP_HOST + "!");
            return true;
        } catch (Exception e) {
            System.err.println("[EMAIL SENDER] Không gửi được qua SMTP: " + e.getMessage());
            e.printStackTrace();
            System.err.println("[EMAIL SENDER] Bạn vẫn có thể xem mã OTP ở Console Eclipse phía trên để test!");
            return false;
        }
    }
}
