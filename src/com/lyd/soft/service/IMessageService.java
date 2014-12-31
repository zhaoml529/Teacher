package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Message;

public interface IMessageService {
	public Serializable doAdd(Message entity) throws Exception;
	
	public void doUpdate(Message entity) throws Exception;
	
	public void doDelete(Message entity) throws Exception;
	
	public List<Message> toList(String teacherId, String option) throws Exception;
	
	public Message findById(Integer id) throws Exception;
	
	public List<Message> findAll() throws Exception;
	
}
