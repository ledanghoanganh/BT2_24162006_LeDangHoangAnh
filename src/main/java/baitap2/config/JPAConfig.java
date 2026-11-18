package baitap2.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {
	// Khởi tạo Singleton: Duy nhất 1 EntityManagerFactory trong suốt vòng đời ứng dụng
	private static final EntityManagerFactory factory;

	static {
		try {
			factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
		} catch (Throwable ex) {
			System.err.println("Lỗi khởi tạo EntityManagerFactory: " + ex.getMessage());
			ex.printStackTrace();
			throw new ExceptionInInitializerError(ex);
		}
	}

	public static EntityManager getEntityManager() {
		return factory.createEntityManager();
	}

	public static void close() {
		if (factory != null && factory.isOpen()) {
			factory.close();
		}
	}
}
