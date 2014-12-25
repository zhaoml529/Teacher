package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.Calendar;

public interface ICalendarService {

	public Serializable doAdd(Calendar entity) throws Exception;
	
	public void doUpdate(Calendar entity) throws Exception;
	
	public void doDelete(Calendar entity) throws Exception;
	
	public List<Calendar> findAllList() throws Exception;
	
	public Calendar findById(String CalendarId) throws Exception;

	public List<Calendar> findByTeacherId(String teacher_id) throws Exception;
	
	public List<Calendar> findByDateRange(String teacherId, String beginDate, String endDate) throws Exception;
}
