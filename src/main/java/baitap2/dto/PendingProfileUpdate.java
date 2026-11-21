package baitap2.dto;

import lombok.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PendingProfileUpdate implements Serializable {
    private static final long serialVersionUID = 1L;
    private int userId;
    private String newFullname;
    private String newPhone;
    private String newEmail;
    private String newAvatar; // URL ảnh đã upload lên Cloudinary (nếu có)
    private String otp;
    private long expireTime;  // Thời điểm hết hạn tính bằng milliseconds
}