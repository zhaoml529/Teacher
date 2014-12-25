package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Awarding;
import com.lyd.soft.entity.Message;
import com.lyd.soft.service.IMessageService;
import com.lyd.soft.util.BeanUtils;

public class MessageServiceImpl extends BaseServiceImpl<Message> implements
		IMessageService {

	@Override
	public Serializable doAdd(Message entity) throws Exception {
		return add(entity);
	}

	@Override
	public void doUpdate(Message entity) throws Exception {
		update(entity);

	}

	@Override
	public void doDelete(Message entity) throws Exception {
		delete(entity);

	}

	@Override
	public List<Message> toList(String teacherId) throws Exception {
		List<Message> list = findByPage("Message", new String[]{"toUser"}, new String[]{teacherId});
		if(BeanUtils.isBlank(list)){
			return null;
		}else{
			return list;
		}
	}

	@Override
	public Message findById(Integer id) throws Exception {
		return getUnique("Message", new String[]{"id"}, new String[]{id.toString()});
	}

}
