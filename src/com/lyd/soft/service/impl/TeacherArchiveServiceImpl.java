package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.IBaseService;
import com.lyd.soft.service.ITeacherArchiveService;

@Service
public class TeacherArchiveServiceImpl extends BaseServiceImpl<TeacherArchive> implements ITeacherArchiveService {
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(TeacherArchive entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(TeacherArchive entity) throws Exception {
		update(entity);

	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(TeacherArchive entity) throws Exception {
		delete(entity);

	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<TeacherArchive> toList() throws Exception {
		return findByWhere("TeacherArchive", new String[]{}, new String[]{}, new String[]{"updateDate"}, new String[]{"DESC"});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findByName(String name) throws Exception {
		return getUnique("TeacherArchive", new String[]{"teacherName"}, new String[]{name});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findById(String id) throws Exception {
		return getUnique("TeacherArchive", new String[]{"id"}, new String[]{id});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findByTeaId(String teacherId) throws Exception {
		return getUnique("TeacherArchive", new String[]{"teacher.teacherId"}, new String[]{teacherId});
	}
	
}
