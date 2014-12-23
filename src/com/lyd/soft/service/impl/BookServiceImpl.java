package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Book;
import com.lyd.soft.service.IBookService;

@Service
public class BookServiceImpl extends BaseServiceImpl<Book> implements IBookService {

	@Override
	public Serializable doAdd(Book entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Book entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Book entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Book> toList() throws Exception {
		List<Book> list = findByPage("Book", new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Book findById(Integer id) throws Exception {
		return getUnique("Book", new String[]{"id"}, new String[]{id.toString()});
	}
	
}
