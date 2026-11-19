package baitap2.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"videos", "password"})
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@NotEmpty(message = "Email không được để trống")
	@Email(message = "Email không đúng định dạng")
	@Column(name = "email", length = 255)
	private String email;

	@NotEmpty(message = "Tên đăng nhập không được để trống")
	@Size(min = 3, max = 50, message = "Tên đăng nhập từ 3 đến 50 ký tự")
	@Column(name = "username", length = 255, nullable = false, unique = true)
	private String username;

	@NotEmpty(message = "Họ và tên không được để trống")
	@Size(min = 2, max = 100, message = "Họ và tên từ 2 đến 100 ký tự")
	@Column(name = "fullname", length = 255)
	private String fullname;

	@NotEmpty(message = "Mật khẩu không được để trống")
	@Size(min = 6, message = "Mật khẩu phải từ 6 ký tự trở lên")
	@Column(name = "password", length = 255, nullable = false)
	private String password;

	@Column(name = "avatar", length = 255)
	private String avatar;

	@Column(name = "roleid")
	private int roleid;

	@Pattern(regexp = "^(0[0-9]{9})?$", message = "Số điện thoại không hợp lệ (10 chữ số bắt đầu bằng số 0)")
	@Column(name = "phone", length = 50)
	private String phone;

	@Column(name = "createddate")
	private Date createddate;

	@Column(name = "status")
	private int status;

	@OneToMany(mappedBy = "user")
	@Builder.Default
	private List<Video> videos = new ArrayList<>();

	// Convenience constructors
	public User(String email, String username, String fullname, String password, String avatar, int roleid,
			String phone, Date createddate, int status) {
		this.email = email;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.avatar = avatar;
		this.roleid = roleid;
		this.phone = phone;
		this.createddate = createddate;
		this.status = status;
	}

	public User(int id, String email, String username, String fullname, String password, String avatar, int roleid,
			String phone, Date createddate, int status) {
		this.id = id;
		this.email = email;
		this.username = username;
		this.fullname = fullname;
		this.password = password;
		this.avatar = avatar;
		this.roleid = roleid;
		this.phone = phone;
		this.createddate = createddate;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public int getRoleid() {
		return roleid;
	}

	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getCreateddate() {
		return createddate;
	}

	public void setCreateddate(Date createddate) {
		this.createddate = createddate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<Video> getVideos() {
		return videos;
	}

	public void setVideos(List<Video> videos) {
		this.videos = videos;
	}
}
