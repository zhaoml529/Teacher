package com.lyd.soft.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

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

	@OneToOne
	@JoinColumn(name="TEACHER_ID")
	@NotEmpty(message="{teachering.teacher.not.empty}")
	private Teacher teacher;			
	
	@Column(name = "SCHOOL_YEAR")
	@NotEmpty(message="{teachering.schoolYear.not.empty}")
	private String schoolYear;			//学年
	
	@Column(name = "COURSE")
	@NotEmpty(message="{teachering.teacher.not.empty}")
	private String course;				//所教课程
	
	@Column(name = "PERIOD")
	@NotEmpty(message="{teachering.period.not.empty}")
	private String period;				//课时
	
	@Column(name = "REMINDER")
	private String reminder;			//其他教学科研说明

	@Column(name = "IS_DELETE")
	private Integer isDelete;			//删除
	
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
