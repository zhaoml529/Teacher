package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Subject;
import com.lyd.soft.service.ISubjectService;

@Service
public class SubjectServiceImpl extends BaseServiceImpl<Subject> implements ISubjectService {
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Subject entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Subject entity) throws Exception {
		update(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Subject entity) throws Exception {
		delete(entity);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Subject> toList(String teaId, String orderBy) throws Exception {
		List<Subject> list = findByPage("Subject", new String[]{"teacher.teacherId","isDelete"}, new String[]{teaId, "0"}, new String[]{"createDate"}, new String[]{"DESC"});
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Subject findById(Integer id) throws Exception {
		return getUnique("Subject", new String[]{"id"}, new String[]{id.toString()});
	}

}
