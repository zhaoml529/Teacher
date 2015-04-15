package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Paper;
import com.lyd.soft.service.IPaperService;

@Service
public class PaperServiceImpl extends BaseServiceImpl<Paper> implements
		IPaperService {

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Paper entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Paper entity) throws Exception {
		update(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Paper entity) throws Exception {
		delete(entity);
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Paper> toList() throws Exception {
		List<Paper> list = findByPage("Paper", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Paper findById(Integer id) throws Exception {
		return getUnique("Paper", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Paper> findByTeaId(String teacherId, String orderBy) throws Exception {
		List<Paper> list = findByPage("Paper", new String[]{"teacher","isDelete"}, new String[]{teacherId, "0"}, new String[]{"createDate"}, new String[]{orderBy});
		return list;
	}

}
