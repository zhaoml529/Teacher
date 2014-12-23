package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Subject;

public interface ISubjectService {

	public Serializable doAdd(Subject entity) throws Exception;
	
	public void doUpdate(Subject entity) throws Exception;
	
	public void doDelete(Subject entity) throws Exception;
	
	public List<Subject> toList() throws Exception;
	
	public Subject findById(Integer id) throws Exception;
}
