package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Teaching;
import com.lyd.soft.service.ITeachingService;

@Service
public class TeachingServiceImpl extends BaseServiceImpl<Teaching> implements ITeachingService {
	@Override
	public Serializable doAdd(Teaching entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Teaching entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Teaching entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Teaching> toList() throws Exception {
		List<Teaching> list = findByPage("Teaching", new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Teaching findById(Integer id) throws Exception {
		return getUnique("Teaching", new String[]{"id"}, new String[]{id.toString()});
	}
}
