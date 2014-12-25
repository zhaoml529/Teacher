package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<T> {
	
	public List<T> getAllList(String tableSimpleName) throws Exception;
	 
	public T getUnique(String tableSimpleName,String[] columns,String[] values) throws Exception;
	 
	public List<T> findByWhere(String tableSimpleName,String[] columns,String[] values) throws Exception;
	 
	public List<T> getCount(String tableSimpleName) throws Exception;
	 
	public Serializable add(T bean) throws Exception;
	 
	public void saveOrUpdate(T bean) throws Exception;
	
	public void delete(T bean) throws Exception;
	
	public void update(T bean) throws Exception;
	 
	public T getBean(final Class<T> obj,final Serializable id) throws Exception;
	 
	public List<T> findByPage(String tableSimpleName,String[] columns,String[] values) throws Exception;
	
	public List<T> getRangeDate(String tableSimpleName,String[] columns,String[] values) throws Exception;
}
