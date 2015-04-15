package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Book;
import com.lyd.soft.entity.Paper;
import com.lyd.soft.service.IBookService;
import com.lyd.soft.util.BeanUtils;

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
		List<Book> list = findByPage("Book", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Book findById(Integer id) throws Exception {
		return getUnique("Book", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	public List<Book> findByTeaId(String teacherId, String[] params)
			throws Exception {
		List<Book> list = null;
		if(BeanUtils.isBlank(params[0])){
			list = findByPage("Book", new String[]{"teacher", "isDelete"}, new String[]{teacherId, "0"}, new String[]{"createDate"}, new String[]{params[1]});			
		}else{
			list = findByPage("Book", new String[]{"teacher", "type", "isDelete"}, new String[]{teacherId, params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});			
		}
		return list;
	}
	
}
