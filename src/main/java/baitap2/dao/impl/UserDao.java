package baitap2.dao.impl;

import java.util.List;

import baitap2.config.JPAConfig;
import baitap2.dao.IUserDao;
import baitap2.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

public class UserDao implements IUserDao {

	@Override
	public User get(String username) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT u FROM User u WHERE u.username = :username";
			TypedQuery<User> query = enma.createQuery(jpql, User.class);
			query.setParameter("username", username);
			List<User> list = query.getResultList();
			if (list == null || list.isEmpty()) {
				return null;
			}
			return list.get(0);
		} finally {
			enma.close();
		}
	}

	@Override
	public User findById(int id) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			return enma.find(User.class, id);
		} finally {
			enma.close();
		}
	}

	@Override
	public void insert(User user) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.persist(user);
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
	public void update(User user) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.merge(user);
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
	public void delete(int id) throws Exception {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			User user = enma.find(User.class, id);
			if (user != null) {
				enma.remove(user);
			} else {
				throw new Exception("Không tìm thấy");
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
	public List<User> findAll() {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);
			return query.getResultList();
		} finally {
			enma.close();
		}
	}

	@Override
	public boolean checkExistEmail(String email) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT count(u) FROM User u WHERE u.email = :email";
			Query query = enma.createQuery(jpql);
			query.setParameter("email", email);
			Long count = (Long) query.getSingleResult();
			return count != null && count > 0;
		} finally {
			enma.close();
		}
	}

	@Override
	public boolean checkExistUsername(String username) {
		return get(username) != null;
	}

	@Override
	public boolean checkExistPhone(String phone) {
		EntityManager enma = JPAConfig.getEntityManager();
		try {
			String jpql = "SELECT count(u) FROM User u WHERE u.phone = :phone";
			Query query = enma.createQuery(jpql);
			query.setParameter("phone", phone);
			Long count = (Long) query.getSingleResult();
			return count != null && count > 0;
		} finally {
			enma.close();
		}
	}
}
