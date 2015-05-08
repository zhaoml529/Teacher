package com.lyd.soft.service;

public interface IStatisticsService {

	public Integer getSubjectCountByYEAR(String type, String date) throws Exception;
	
	public Integer getPaperCountByYEAR(String type, String date) throws Exception;

	public Integer getBookCountByYEAR(String type, String date) throws Exception;
	
	public Integer getAwardCountByYEAR(String type, String date) throws Exception;
}
