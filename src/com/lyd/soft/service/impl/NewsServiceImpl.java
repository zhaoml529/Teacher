package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.News;
import com.lyd.soft.service.INewsService;

@Service
public class NewsServiceImpl extends BaseServiceImpl<News> implements
		INewsService {

	@Override
	public Serializable doAdd(News entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(News entity) throws Exception {
		update(entity);

	}

	@Override
	public void doDelete(News entity) throws Exception {
		delete(entity);

	}

	@Override
	public List<News> toList() throws Exception {
		List<News> list = getAllList("News", new String[]{"updateDate"}, new String[]{"DESC"});
		return list;
	}

	@Override
	public News findById(Integer id) throws Exception {
		return getUnique("News", new String[]{}, new String[]{});
	}

}
