package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Awarding;
import com.lyd.soft.service.IAwardingService;

@Service
public class AwardingServiceImpl extends BaseServiceImpl<Awarding> implements IAwardingService {

	@Override
	public Serializable doAdd(Awarding entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Awarding entity) throws Exception {
		update(entity);
	}

	@Override
	public void doDelete(Awarding entity) throws Exception {
		delete(entity);
	}

	@Override
	public List<Awarding> toList() throws Exception {
		List<Awarding> list = findByPage("Awarding", new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Awarding findById(Integer id) throws Exception {
		return getUnique("Awarding", new String[]{"id"}, new String[]{id.toString()});
	}

}
