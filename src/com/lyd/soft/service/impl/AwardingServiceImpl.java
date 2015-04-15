package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lyd.soft.entity.Awarding;
import com.lyd.soft.entity.Book;
import com.lyd.soft.service.IAwardingService;
import com.lyd.soft.util.BeanUtils;

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
		List<Awarding> list = findByPage("Awarding", new String[]{}, new String[]{}, new String[]{}, new String[]{});
		return list;
	}

	@Override
	public Awarding findById(Integer id) throws Exception {
		return getUnique("Awarding", new String[]{"id"}, new String[]{id.toString()});
	}

	@Override
	public List<Awarding> findByTeaId(String teacherId, String[] params)
			throws Exception {
		List<Awarding> list = null;
		if(BeanUtils.isBlank(params[0])){
			list = findByPage("Awarding", new String[]{"teacher", "isDelete"}, new String[]{teacherId, "0"}, new String[]{"createDate"}, new String[]{params[1]});			
		}else{
			list = findByPage("Awarding", new String[]{"teacher", "type", "isDelete"}, new String[]{teacherId, params[0], "0"}, new String[]{"createDate"}, new String[]{params[1]});			
		}
		return list;
	}

}
