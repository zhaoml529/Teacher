package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Teaching;

public interface ITeachingService {

	public Serializable doAdd(Teaching entity) throws Exception;
	
	public void doUpdate(Teaching entity) throws Exception;
	
	public void doDelete(Teaching entity) throws Exception;
	
	public List<Teaching> toList() throws Exception;
	
	public Teaching findById(Integer id) throws Exception;
	
}
