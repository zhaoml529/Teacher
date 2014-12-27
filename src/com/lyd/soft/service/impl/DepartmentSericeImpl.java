package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Department;
import com.lyd.soft.service.IDepartmentService;

@Service
public class DepartmentSericeImpl extends BaseServiceImpl<Department> implements IDepartmentService {

	@Override
	public Serializable doAdd(Department entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Department entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Department entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Department> toList() throws Exception {
		List<Department> list = findByPage("Department", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Department findById(Integer id) throws Exception {
		return getUnique("Department", new String[]{"id"}, new String[]{id.toString()});
	}

}
