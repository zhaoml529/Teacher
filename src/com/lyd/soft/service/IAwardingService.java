package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Awarding;

public interface IAwardingService {
	public Serializable doAdd(Awarding entity) throws Exception;
	
	public void doUpdate(Awarding entity) throws Exception;
	
	public void doDelete(Awarding entity) throws Exception;
	
	public List<Awarding> toList() throws Exception;
	
	public Awarding findById(Integer id) throws Exception;
	
	public List<Awarding> findByTeaId(String role, String teacherId, String[] params) throws Exception;
}
