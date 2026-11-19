package baitap2.util;

import java.util.Set;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

public class BeanValidator {

	private static final ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
	private static final Validator validator = factory.getValidator();

	public static Validator getValidator() {
		return validator;
	}

	public static <T> Set<ConstraintViolation<T>> validate(T object) {
		return validator.validate(object);
	}

	public static <T> String getFirstError(T object) {
		Set<ConstraintViolation<T>> violations = validator.validate(object);
		if (violations != null && !violations.isEmpty()) {
			return violations.iterator().next().getMessage();
		}
		return null;
	}

	public static <T> String getPropertyError(T object, String propertyName) {
		Set<ConstraintViolation<T>> violations = validator.validateProperty(object, propertyName);
		if (violations != null && !violations.isEmpty()) {
			return violations.iterator().next().getMessage();
		}
		return null;
	}
}
