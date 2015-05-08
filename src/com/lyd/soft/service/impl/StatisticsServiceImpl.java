package com.lyd.soft.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lyd.soft.dao.IJdbcDao;
import com.lyd.soft.service.IStatisticsService;

@Service
public class StatisticsServiceImpl implements  IStatisticsService{

	@Autowired
	private IJdbcDao jdbcDao;
	
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Integer getSubjectCountByYEAR(String type, String date)
			throws Exception {
		String sql = "select count(*) as teaching from t_subject where type=:type and is_delete=0 and date_format(create_date, '%Y')=:date";
		Map<String, Object> paramMap = new HashMap<String, Object>();  
	    paramMap.put("type", type);  
	    paramMap.put("date", date);  
		Integer count = jdbcDao.getCount(sql, paramMap);
		return count;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Integer getPaperCountByYEAR(String type, String date)
			throws Exception {
		String sql = "select count(*) as teaching from t_paper where type=:type and is_delete=0 and date_format(create_date, '%Y')=:date";
		Map<String, Object> paramMap = new HashMap<String, Object>();  
	    paramMap.put("type", type);  
	    paramMap.put("date", date);  
		Integer count = jdbcDao.getCount(sql, paramMap);
		return count;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Integer getBookCountByYEAR(String type, String date)
			throws Exception {
		String sql = "select count(*) as teaching from t_book where type=:type and is_delete=0 and date_format(create_date, '%Y')=:date";
		Map<String, Object> paramMap = new HashMap<String, Object>();  
	    paramMap.put("type", type);  
	    paramMap.put("date", date);  
		Integer count = jdbcDao.getCount(sql, paramMap);
		return count;
	}

	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED, readOnly=true)
	public Integer getAwardCountByYEAR(String type, String date)
			throws Exception {
		String sql = "select count(*) as teaching from t_awarding where type=:type and is_delete=0 and date_format(create_date, '%Y')=:date";
		Map<String, Object> paramMap = new HashMap<String, Object>();  
	    paramMap.put("type", type);  
	    paramMap.put("date", date);  
		Integer count = jdbcDao.getCount(sql, paramMap);
		return count;
	}

}
