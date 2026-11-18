package baitap2.dao;

import java.util.List;
import baitap2.entity.Video;

public interface IVideoDao {
	void insert(Video video);

	void update(Video video);

	void delete(String videoId) throws Exception;

	Video findById(String videoId);

	List<Video> findAll();

	List<Video> findTop10Latest();

	List<Video> findAllByUser(int userId, int page, int pageSize);

	int countByUser(int userId);

	List<Video> findAllPaging(int page, int pageSize);

	int countAll();

	void increaseViews(String videoId);
}
