package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Subject;
import com.lyd.soft.service.ISubjectService;

@Service
public class SubjectServiceImpl extends BaseServiceImpl<Subject> implements ISubjectService {
	@Override
	public Serializable doAdd(Subject entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Subject entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Subject entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Subject> toList() throws Exception {
		List<Subject> list = findByPage("Subject", new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Subject findById(Integer id) throws Exception {
		return getUnique("Subject", new String[]{"id"}, new String[]{id.toString()});
	}

}
