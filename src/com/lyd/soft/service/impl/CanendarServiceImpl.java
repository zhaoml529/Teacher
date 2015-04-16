package com.lyd.soft.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.entity.Calendar;
import com.lyd.soft.service.ICalendarService;
import com.lyd.soft.util.BeanUtils;

@Service
public class CanendarServiceImpl extends BaseServiceImpl<Calendar> implements
		ICalendarService {

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Serializable doAdd(Calendar entity) throws Exception {
		return add(entity);
		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doUpdate(Calendar entity) throws Exception {
		update(entity);

	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void doDelete(Calendar entity) throws Exception {
		delete(entity);
		
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Calendar> findAllList() throws Exception {
		List<Calendar> list = getAllList("Calendar", new String[]{}, new String[]{});
		return list;
	}


	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Calendar findById(String id) throws Exception {
		Calendar calendar = getUnique("Calendar", new String[]{"id"}, new String[] {id});
		if(BeanUtils.isBlank(calendar)){
			return null;
		}else{
			return calendar;
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Calendar> findByTeacherId(String teacher_id) throws Exception {
		List<Calendar> list = findByWhere("Calendar", new String[]{"teacher"}, new String[]{teacher_id}, new String[]{}, new String[]{});
		if(BeanUtils.isBlank(list)){
			return null;
		}else{
			return list;
		}
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public List<Calendar> findByDateRange(String teacherId, String beginDate, String endDate)
			throws Exception {
		List<Calendar> list = getRangeDate("Calendar", new String[]{"teacher", "beginDate"}, new String[]{teacherId, beginDate, endDate});
		if(BeanUtils.isBlank(list)){
			return null;
		}else{
			return list;
		}
	}
	
}
