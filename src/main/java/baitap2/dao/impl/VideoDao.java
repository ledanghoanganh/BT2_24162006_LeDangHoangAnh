package baitap2.dao.impl;

import java.util.List;

import baitap2.config.JPAConfig;
import baitap2.dao.IVideoDao;
import baitap2.entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class VideoDao implements IVideoDao {

	@Override
	public void insert(Video video) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.persist(video);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}

	@Override
	public void update(Video video) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.merge(video);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}

	@Override
	public void delete(String videoId) throws Exception {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			Video video = enma.find(Video.class, videoId);
			if (video != null) {
				enma.remove(video);
			} else {
				throw new Exception("Không tìm thấy Video có mã: " + videoId);
			}
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}

	@Override
	public Video findById(String videoId) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			return enma.find(Video.class, videoId);
		} finally {
			enma.close();
		}
	}

	@Override
	public List<Video> findAll() {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			TypedQuery<Video> query = enma.createNamedQuery("Video.findAll", Video.class);
			return query.getResultList();
		} finally {
			enma.close();
		}
	}

	@Override
	public List<Video> findTop10Latest() {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT v FROM Video v WHERE v.active = 1 ORDER BY v.createdDate DESC";
			TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
			query.setMaxResults(10); // Giới hạn đúng 10 video
			return query.getResultList();
		} finally {
			enma.close();
		}
	}

	@Override
	public List<Video> findAllByUser(int userId, int page, int pageSize) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT v FROM Video v WHERE v.user.id = :userId ORDER BY v.createdDate DESC";
			TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
			query.setParameter("userId", userId);
			query.setFirstResult((page - 1) * pageSize); // Điểm bắt đầu
			query.setMaxResults(pageSize); // Số lượng 6 video/trang
			return query.getResultList();
		} finally {
			enma.close();
		}
	}

	@Override
	public int countByUser(int userId) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT COUNT(v) FROM Video v WHERE v.user.id = :userId";
			TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
			query.setParameter("userId", userId);
			return query.getSingleResult().intValue();
		} finally {
			enma.close();
		}
	}

	@Override
	public List<Video> findAllPaging(int page, int pageSize) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT v FROM Video v ORDER BY v.createdDate DESC";
			TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
			query.setFirstResult((page - 1) * pageSize);
			query.setMaxResults(pageSize);
			return query.getResultList();
		} finally {
			enma.close();
		}
	}

	@Override
	public int countAll() {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT COUNT(v) FROM Video v";
			TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
			return query.getSingleResult().intValue();
		} finally {
			enma.close();
		}
	}

	@Override
	public void increaseViews(String videoId) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			String jpql = "UPDATE Video v SET v.views = v.views + 1 WHERE v.videoId = :videoId";
			enma.createQuery(jpql).setParameter("videoId", videoId).executeUpdate();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (trans.isActive()) {
				trans.rollback();
			}
		} finally {
			enma.close();
		}
	}
}
