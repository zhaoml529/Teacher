package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Book;

public interface IBookService {
	
	public Serializable doAdd(Book entity) throws Exception;
	
	public void doUpdate(Book entity) throws Exception;
	
	public void doDelete(Book entity) throws Exception;
	
	public List<Book> toList() throws Exception;
	
	public Book findById(Integer id) throws Exception;
	
	public List<Book> findByTeaId(String role, String teacherId, String[] params) throws Exception;
}
