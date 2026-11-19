package baitap2.entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v LEFT JOIN FETCH v.user")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"user", "category"})
public class Video implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@NotEmpty(message = "Mã Video không được để trống")
	@Size(min = 2, max = 50, message = "Mã Video từ 2 đến 50 ký tự")
	@Column(name = "VideoId", length = 50)
	private String videoId;

	@NotEmpty(message = "Tiêu đề Video không được để trống")
	@Size(min = 2, max = 500, message = "Tiêu đề Video từ 2 đến 500 ký tự")
	@Column(name = "Title", length = 500, nullable = false)
	private String title;

	@Column(name = "Description", length = 1000)
	private String description;

	@Column(name = "Poster", length = 500)
	private String poster;

	@Column(name = "VideoPath", length = 500)
	private String videoPath;

	@Column(name = "Views")
	private int views;

	@Column(name = "Active")
	private int active;

	@Column(name = "CreatedDate")
	@Builder.Default
	private Date createdDate = new Date();

	// Mối quan hệ n - 1 với User (Nhiều video thuộc 1 User)
	@ManyToOne
	@JoinColumn(name = "userId", nullable = false)
	private User user;

	// Mối quan hệ n - 1 với Category (Tùy chọn)
	@ManyToOne
	@JoinColumn(name = "CategoryId", nullable = true)
	private Category category;

	public String getVideoId() {
		return videoId;
	}

	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getVideoPath() {
		return videoPath;
	}

	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
}
