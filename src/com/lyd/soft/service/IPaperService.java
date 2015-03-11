package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Paper;

public interface IPaperService {

	public Serializable doAdd(Paper entity) throws Exception;
	
	public void doUpdate(Paper entity) throws Exception;
	
	public void doDelete(Paper entity) throws Exception;
	
	public List<Paper> toList() throws Exception;
	
	public Paper findById(Integer id) throws Exception;

	public List<Paper> findByTeaId(String teacherId) throws Exception;
}
