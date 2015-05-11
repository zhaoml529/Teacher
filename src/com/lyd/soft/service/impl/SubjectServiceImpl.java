package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Subject;
import com.lyd.soft.service.ISubjectService;
import com.lyd.soft.util.BeanUtils;

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
	public List<Subject> toList(String role, String teaId, String[] params) throws Exception {
		List<Subject> list = null;
		if(BeanUtils.isBlank(params[0])){
			if("manager".equals(role)){
				list = findByPage("Subject", new String[]{"isDelete"}, new String[]{"0"}, new String[]{"createDate"}, new String[]{params[1]});
			}else{
				list = findByPage("Subject", new String[]{"teacher.teacherId", "isDelete"}, new String[]{teaId, "0"}, new String[]{"createDate"}, new String[]{params[1]});
			}
		}else{
			if("manager".equals(role)){
				list = findByPage("Subject", new String[]{"type", "isDelete"}, new String[]{params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});
			}else{
				list = findByPage("Subject", new String[]{"teacher.teacherId", "type", "isDelete"}, new String[]{teaId, params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});
			}
		}
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Subject findById(Integer id) throws Exception {
		return getUnique("Subject", new String[]{"id"}, new String[]{id.toString()});
	}

}
