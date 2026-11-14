package baitap2.service.impl;

import java.util.Date;
import java.util.List;

import baitap2.dao.IUserDao;
import baitap2.dao.impl.UserDao;
import baitap2.entity.User;
import baitap2.service.IUserService;

public class UserServiceImpl implements IUserService {
	IUserDao userDao = new UserDao();

	@Override
	public User login(String username, String password) {
		User user = this.get(username);
		if (user != null && password != null && password.equals(user.getPassword())) {
			return user;
		}
		return null;
	}

	@Override
	public User get(String username) {
		return userDao.get(username);
	}

	@Override
	public User findById(int id) {
		return userDao.findById(id);
	}

	@Override
	public boolean register(String username, String password, String email, String fullname, String phone) {
		if (userDao.checkExistUsername(username)) {
			return false;
		}
		Date date = new Date();
		userDao.insert(new User(email, username, fullname, password, null, 2, phone, date));
		return true;
	}

	@Override
	public boolean checkExistEmail(String email) {
		return userDao.checkExistEmail(email);
	}

	@Override
	public boolean checkExistUsername(String username) {
		return userDao.checkExistUsername(username);
	}

	@Override
	public boolean checkExistPhone(String phone) {
		return userDao.checkExistPhone(phone);
	}

	@Override
	public void insert(User user) {
		userDao.insert(user);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public void delete(int id) throws Exception {
		userDao.delete(id);
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}
}
