package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Department;

public interface IDepartmentService {
	
	public Serializable doAdd(Department entity) throws Exception;
	
	public void doUpdate(Department entity) throws Exception;
	
	public void doDelete(Department entity) throws Exception;
	
	public List<Department> toList() throws Exception;
	
	public Department findById(Integer id) throws Exception;
}
