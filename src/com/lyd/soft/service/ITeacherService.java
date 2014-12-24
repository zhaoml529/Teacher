package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Teacher;


public interface ITeacherService {
	
	public Serializable doAdd(Teacher entity) throws Exception;
	
	public void doUpdate(Teacher entity) throws Exception;
	
	public void doDelete(Teacher entity) throws Exception;
	
	public List<Teacher> toList() throws Exception;
	
	public List<Teacher> findByDept(Integer dept_id) throws Exception;
	
	public Teacher findByName(String name) throws Exception;
	
	public Teacher findById(String teacherId) throws Exception;
}
