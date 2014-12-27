package com.lyd.soft.pagination;

public class PaginationThreadUtils {

	private static final ThreadLocal<Pagination> pagination = new ThreadLocal<Pagination>();

	public static Pagination get() {
		return pagination.get();
	}

	public static void set(Pagination value) {
		pagination.set(value);
	}

	public static void clear() {
		pagination.remove();
	}

}
