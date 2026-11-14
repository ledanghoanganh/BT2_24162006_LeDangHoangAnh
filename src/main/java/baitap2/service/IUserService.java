package baitap2.service;

import java.util.List;

import baitap2.entity.User;

public interface IUserService {
	User login(String username, String password);

	User get(String username);

	User findById(int id);

	void insert(User user);

	void update(User user);

	void delete(int id) throws Exception;

	List<User> findAll();

	boolean register(String username, String password, String email, String fullname, String phone);

	boolean checkExistEmail(String email);

	boolean checkExistUsername(String username);

	boolean checkExistPhone(String phone);
}
