package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.BeanUtils;

@Service
public class TeacherServiceImpl extends BaseServiceImpl<Teacher> implements ITeacherService {

	@Override
	public Serializable doAdd(Teacher entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Teacher entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Teacher entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Teacher> toList() throws Exception {
		List<Teacher> list = findByPage("Teacher", new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Teacher findById(Integer id) throws Exception {
		return getUnique("Teacher", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	public Teacher findByName(String name) throws Exception {
		Teacher teacher = getUnique("Teacher", new String[]{"name"}, new String[] {name});
		if(BeanUtils.isBlank(teacher)){
			return null;
		}else{
			return teacher;
		}
	}

	@Override
	public List<Teacher> findByDept(Integer dept_id) throws Exception {
		List<Teacher> list = findByPage("Teacher", new String[]{"department"}, new String[]{dept_id.toString()});
		return list;
	}

}
