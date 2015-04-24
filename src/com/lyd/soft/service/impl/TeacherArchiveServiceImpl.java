package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;

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
	public List<TeacherArchive> toList(String status) throws Exception {
		if(!StringUtils.isBlank(status)){
			return findByPage("TeacherArchive", new String[]{"isPass", "isDelete"}, new String[]{status, "0"}, new String[]{"updateDate"}, new String[]{"DESC"});
		}else{
			return findByPage("TeacherArchive", new String[]{"isDelete"}, new String[]{"0"}, new String[]{"updateDate"}, new String[]{"DESC"});
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findByName(String name) throws Exception {
		return getUnique("TeacherArchive", new String[]{"teacherName", "isDelete"}, new String[]{name, "0"});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findById(String id) throws Exception {
		return getUnique("TeacherArchive", new String[]{"id", "isDelete"}, new String[]{id, "0"});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public TeacherArchive findByTeaId(String teacherId) throws Exception {
		return getUnique("TeacherArchive", new String[]{"teacher.teacherId", "isDelete"}, new String[]{teacherId, "0"});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<TeacherArchive> findByDept(String dept_id, String status) throws Exception {
		return findByPage("TeacherArchive", new String[]{"teacher.department.id", "isPass", "isDelete"}, new String[]{dept_id, status, "0"}, new String[]{"updateDate"}, new String[]{"DESC"});
	}

	@Override
	public Integer getCount(String dept_id, String status) throws Exception {
		return getCount("TeacherArchive", new String[]{"teacher.department","isPass", "isDelete"}, new String[]{dept_id, status, "0"});
	}

	@Override
	public List<TeacherArchive> getAllList() throws Exception {
		return findByWhere("TeacherArchive", new String[]{"isPass", "isDelete"}, new String[]{Constants.APPROVAL_SUCCESS, "0"}, new String[]{"updateDate"}, new String[]{"DESC"});
	}
	
}
