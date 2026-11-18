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
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "VideoId", length = 50)
	private String videoId;

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
	private Date createdDate = new Date();

	// Mối quan hệ n - 1 với User (Nhiều video thuộc 1 User)
	@ManyToOne
	@JoinColumn(name = "userId", nullable = false)
	private User user;

	// Mối quan hệ n - 1 với Category (Tùy chọn)
	@ManyToOne
	@JoinColumn(name = "CategoryId", nullable = true)
	private Category category;

	// Constructors
	public Video() {
	}

	public Video(String videoId, String title, String description, String poster, String videoPath, int views,
			int active, Date createdDate, User user, Category category) {
		this.videoId = videoId;
		this.title = title;
		this.description = description;
		this.poster = poster;
		this.videoPath = videoPath;
		this.views = views;
		this.active = active;
		this.createdDate = (createdDate != null) ? createdDate : new Date();
		this.user = user;
		this.category = category;
	}

	// Getters and Setters
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
