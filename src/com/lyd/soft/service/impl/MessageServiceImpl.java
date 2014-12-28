package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Message;
import com.lyd.soft.service.IMessageService;
import com.lyd.soft.util.BeanUtils;

@Service
public class MessageServiceImpl extends BaseServiceImpl<Message> implements
		IMessageService {
	//此处也需要加入事务，否则不会提交
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Message entity) throws Exception {
		return add(entity);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Message entity) throws Exception {
		update(entity);

	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Message entity) throws Exception {
		delete(entity);

	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Message> toList(String teacherId) throws Exception {
		List<Message> list = findByPage("Message", new String[]{"toUser"}, new String[]{teacherId}, new String[]{"createDate"}, new String[]{"DESC"});
		if(BeanUtils.isBlank(list)){
			return null;
		}else{
			return list;
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Message findById(Integer id) throws Exception {
		Message msg = getBean(Message.class, id);
		if(BeanUtils.isBlank(msg)){
			return null;
		}else{
			return msg;
		}
	}

}
