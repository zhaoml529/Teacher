package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Book;
import com.lyd.soft.service.IBookService;
import com.lyd.soft.util.BeanUtils;

@Service
public class BookServiceImpl extends BaseServiceImpl<Book> implements IBookService {

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Book entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Book entity) throws Exception {
		update(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Book entity) throws Exception {
		delete(entity);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Book> toList() throws Exception {
		List<Book> list = findByPage("Book", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Book findById(Integer id) throws Exception {
		return getUnique("Book", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Book> findByTeaId(String role, String teacherId, String[] params)
			throws Exception {
		List<Book> list = null;
		if(BeanUtils.isBlank(params[0])){
			if("manager".equals(role)){
				list = findByPage("Book", new String[]{"isDelete"}, new String[]{"0"}, new String[]{"createDate"}, new String[]{params[1]});
			}else{
				list = findByPage("Book", new String[]{"teacher.teacherId", "isDelete"}, new String[]{teacherId, "0"}, new String[]{"createDate"}, new String[]{params[1]});			
			}
		}else{
			if("manager".equals(role)){
				list = findByPage("Book", new String[]{"type", "isDelete"}, new String[]{params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});
			}else{
				list = findByPage("Book", new String[]{"teacher.teacherId", "type", "isDelete"}, new String[]{teacherId, params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});			
			}
		}
		return list;
	}
	
}
