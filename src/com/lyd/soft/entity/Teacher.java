package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "T_TEACHER")
public class Teacher implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1074047317515563016L;

	@Id
	@Column(name = "TEACHER_ID", unique = true, nullable = false )
	private String teacherId;			//教师编号
	
	@Column(name = "TEACHER_NAME")
	private String teacherName;			//教师姓名
	
	@Column(name = "PASSWORD")
	private String password;			//登录密码
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm")
	@Column(name = "REG_DATE")
	private Date regDate;				//注册时间
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm")
	@Column(name = "LOGIN_DATE")
	private Date lgoinDate;				//上次登录时间-下拉显示慢慢的隐藏
	
	@Column(name = "IPAddress")
	private String IPAddress;			//上次登录IP
	
	
	@ManyToOne(targetEntity = Department.class)
	@JoinColumn(name="DEPT_ID",updatable=false)
	private Department department;
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;			//删除
    
	public Teacher(){
		
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getLgoinDate() {
		return lgoinDate;
	}

	public void setLgoinDate(Date lgoinDate) {
		this.lgoinDate = lgoinDate;
	}

	public String getIPAddress() {
		return IPAddress;
	}

	public void setIPAddress(String iPAddress) {
		IPAddress = iPAddress;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
