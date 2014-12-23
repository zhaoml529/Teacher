package com.lyd.soft.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 授课情况表
 * @author LYD
 *
 */

@Entity
@Table(name = "T_TEACHING")
public class Teaching implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7837033325403765166L;

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;		

	@Column(name = "SCHOOL_YEAR")
	private String schoolYear;			//学年
	
	@Column(name = "COURSE")
	private String course;				//所教课程
	
	@Column(name = "PERIOD")
	private String period;				//课时
	
	@Column(name = "REMINDER")
	private String reminder;			//其他教学科研说明

	@ManyToOne(targetEntity = Teacher.class)
	@JoinColumn(name="TEACHING_ID",updatable=false)
	private Teacher teacher;
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;		//删除
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSchoolYear() {
		return schoolYear;
	}

	public void setSchoolYear(String schoolYear) {
		this.schoolYear = schoolYear;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getReminder() {
		return reminder;
	}

	public void setReminder(String reminder) {
		this.reminder = reminder;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	
}
