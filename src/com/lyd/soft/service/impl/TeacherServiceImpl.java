package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.BeanUtils;

@Service
public class TeacherServiceImpl extends BaseServiceImpl<Teacher> implements ITeacherService {

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Teacher entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Teacher entity) throws Exception {
		update(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Teacher entity) throws Exception {
		delete(entity);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Teacher> toList() throws Exception {
		List<Teacher> list = findByPage("Teacher", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Teacher findById(String teacherId) throws Exception {
		Teacher Teacher = getBean(Teacher.class, teacherId);
		if(BeanUtils.isBlank(Teacher)){
			return null;
		}else{
			return Teacher;
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Teacher findByName(String name) throws Exception {
		Teacher Teacher = getUnique("Teacher", new String[]{"teacherName"}, new String[] {name});
		if(BeanUtils.isBlank(Teacher)){
			return null;
		}else{
			return Teacher;
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Teacher> findByDept(Integer dept_id) throws Exception {
		List<Teacher> list = findByPage("Teacher", new String[]{"department"}, new String[]{dept_id.toString()}, new String[]{}, new String[]{});
		return list;
	}

}
