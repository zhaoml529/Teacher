package com.lyd.soft.service;

import java.io.Serializable;
import java.util.List;

import com.lyd.soft.entity.TeacherArchive;

public interface ITeacherArchiveService {

	public Serializable doAdd(TeacherArchive entity) throws Exception;
	
	public void doUpdate(TeacherArchive entity) throws Exception;
	
	public void doDelete(TeacherArchive entity) throws Exception;
	
	public List<TeacherArchive> toList(String status) throws Exception;
	
	public List<TeacherArchive> findByDept(String dept_id, String status) throws Exception;
	
	public TeacherArchive findByName(String name) throws Exception;
	
	public TeacherArchive findById(String id) throws Exception;
	
	public TeacherArchive findByTeaId(String teacherId) throws Exception;
	
	public Integer getCount(String dept_id, String status) throws Exception;
	
	public List<TeacherArchive> getAllList() throws Exception;
}
