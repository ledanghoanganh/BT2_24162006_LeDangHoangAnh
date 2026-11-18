package baitap2.service.impl;

import java.util.List;

import baitap2.dao.IVideoDao;
import baitap2.dao.impl.VideoDao;
import baitap2.entity.Video;
import baitap2.service.IVideoService;

public class VideoServiceImpl implements IVideoService {

	private IVideoDao videoDao = new VideoDao();

	@Override
	public void insert(Video video) {
		videoDao.insert(video);
	}

	@Override
	public void update(Video video) {
		videoDao.update(video);
	}

	@Override
	public void delete(String videoId) throws Exception {
		videoDao.delete(videoId);
	}

	@Override
	public Video findById(String videoId) {
		return videoDao.findById(videoId);
	}

	@Override
	public List<Video> findAll() {
		return videoDao.findAll();
	}

	@Override
	public List<Video> findTop10Latest() {
		return videoDao.findTop10Latest();
	}

	@Override
	public List<Video> findAllByUser(int userId, int page, int pageSize) {
		if (page < 1)
			page = 1;
		if (pageSize <= 0)
			pageSize = 6;
		return videoDao.findAllByUser(userId, page, pageSize);
	}

	@Override
	public int countByUser(int userId) {
		return videoDao.countByUser(userId);
	}

	@Override
	public List<Video> findAllPaging(int page, int pageSize) {
		if (page < 1)
			page = 1;
		if (pageSize <= 0)
			pageSize = 6;
		return videoDao.findAllPaging(page, pageSize);
	}

	@Override
	public int countAll() {
		return videoDao.countAll();
	}

	@Override
	public void increaseViews(String videoId) {
		videoDao.increaseViews(videoId);
	}
}
