package baitap2.service.impl;

import java.util.Date;
import java.util.List;

import baitap2.dao.IUserDao;
import baitap2.dao.impl.UserDao;
import baitap2.entity.User;
import baitap2.service.IUserService;
import baitap2.util.PasswordUtil;

public class UserServiceImpl implements IUserService {
	IUserDao userDao = new UserDao();

	@Override
	public User login(String username, String password) {
		User user = this.get(username);
		if (user != null && password != null) {
			// Kiểm tra mật khẩu bằng BCrypt (có hỗ trợ fallback plain text)
			if (PasswordUtil.checkPassword(password, user.getPassword())) {
				// Nếu trước đó là plain text, tự động băm lại mật khẩu để nâng cấp bảo mật
				if (!user.getPassword().startsWith("$2a$") && !user.getPassword().startsWith("$2b$")) {
					user.setPassword(PasswordUtil.hashPassword(password));
					userDao.update(user);
				}
				return user;
			}
		}
		return null;
	}

	@Override
	public boolean register(String username, String password, String email, String fullname, String phone) {
		if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
			return false;
		}
		Date date = new Date();
		// Mật khẩu được băm bằng BCrypt trước khi lưu vào DB
		String hashedPassword = PasswordUtil.hashPassword(password);
		// status = 0 (Chưa kích hoạt, cần xác thực OTP)
		User newUser = new User(email, username, fullname, hashedPassword, null, 2, phone, date, 0);
		userDao.insert(newUser);
		return true;
	}

	@Override
	public boolean activateUser(String username) {
		User user = userDao.get(username);
		if (user != null) {
			user.setStatus(1); // Kích hoạt tài khoản
			userDao.update(user);
			return true;
		}
		return false;
	}

	@Override
	public boolean updatePassword(String username, String newPassword) {
		User user = userDao.get(username);
		if (user != null) {
			user.setPassword(PasswordUtil.hashPassword(newPassword));
			userDao.update(user);
			return true;
		}
		return false;
	}

	@Override
	public User findByEmail(String email) {
		return userDao.findByEmail(email);
	}

	@Override
	public User findByUsernameOrEmail(String keyword) {
		return userDao.findByUsernameOrEmail(keyword);
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
