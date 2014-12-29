package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.News;
import com.lyd.soft.service.INewsService;

@Service
public class NewsServiceImpl extends BaseServiceImpl<News> implements
		INewsService {

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(News entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(News entity) throws Exception {
		update(entity);

	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(News entity) throws Exception {
		delete(entity);

	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<News> toList() throws Exception {
		List<News> list = findByPage("News", new String[]{"isDelete"}, new String[]{"0"}, new String[]{"updateDate"}, new String[]{"DESC"});
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public News findById(Integer id) throws Exception {
		return getBean(News.class, id);
	}

}
