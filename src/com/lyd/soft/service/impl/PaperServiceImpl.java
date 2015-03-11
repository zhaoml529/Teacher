package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Paper;
import com.lyd.soft.service.IPaperService;

@Service
public class PaperServiceImpl extends BaseServiceImpl<Paper> implements
		IPaperService {

	@Override
	public Serializable doAdd(Paper entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Paper entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Paper entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Paper> toList() throws Exception {
		List<Paper> list = findByPage("Paper", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Paper findById(Integer id) throws Exception {
		return getUnique("Paper", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	public List<Paper> findByTeaId(String teacherId) throws Exception {
		List<Paper> list = findByPage("Paper", new String[]{"teacher","isDelete"}, new String[]{teacherId, "0"}, new String[]{"createDate"}, new String[]{"DESC"});
		return list;
	}

}
