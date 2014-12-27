package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.News;

public interface INewsService {
	public Serializable doAdd(News entity) throws Exception;
	
	public void doUpdate(News entity) throws Exception;
	
	public void doDelete(News entity) throws Exception;
	
	public List<News> toList() throws Exception;
	
	public  News findById(Integer id) throws Exception;
}
