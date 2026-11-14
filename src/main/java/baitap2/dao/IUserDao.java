package baitap2.dao;

import java.util.List;

import baitap2.entity.User;

public interface IUserDao {
	User get(String username);

	User findById(int id);

	void insert(User user);

	void update(User user);

	void delete(int id) throws Exception;

	List<User> findAll();

	boolean checkExistEmail(String email);

	boolean checkExistUsername(String username);

	boolean checkExistPhone(String phone);
}
