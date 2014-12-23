package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 教师信息表
 * @author LYD
 *
 */

@Entity
@Table(name = "T_TEACHER")
public class Teacher implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8641492872316800942L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;			

	@Column(name = "NAME")
	private String name;			//登录名称
	
	@Column(name = "PASSWORD")
	private String passWord;		//密码
	
	@Column(name = "REAL_NAME")
	private String real_name;		//真实姓名
	
	@Column(name = "SEX")
	private Integer sex;			//0.female女 1.male  男
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "BIRTHDAY")
	private Date birthday;			//出生日期
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "WORK_DATE")
	private Date workDate;			//工作时间
	
	@Column(name = "GRADUATE_SCHOOL")
	private String graSchool;		//毕业院校graduateSchool
	
	@Column(name = "EDUCATION")
	private String education;		//学历
	
	@Column(name = "DEGREE")
	private String degree;			//学位
	
	@Column(name = "PROFESSION_AREA")
	private String professionArea;	//专业领域
	
	@Column(name = "TECHNICAL_POSITION")
	private Integer technicalPosition;	//技术职务等级  1.教授 2.副教授 3.讲 师 4.助理讲师
	
	@Column(name = "IS_BACKBONE")
	private Integer isBackbone;		//是否为骨干教师
	
	@Column(name = "IS_SUBJECT_LEADER")
	private Integer isSubjectLeader;	//是否为学科带头人
	
	@ManyToOne(targetEntity = Department.class)
	@JoinColumn(name="DEPT_ID",updatable=false)
	private Department department;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm")
	@Column(name = "REG_DATE")
	private Date regDate;			//注册时间
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;		//删除
	
	
	@OneToMany(targetEntity=Teaching.class,cascade=CascadeType.ALL)
	@Fetch(FetchMode.JOIN)
	@JoinColumn(name="TEACHING_ID",updatable=false)
    private Set<Teaching> teaching = new HashSet<Teaching>();
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public Date getWorkDate() {
		return workDate;
	}
	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}
	public String getGraSchool() {
		return graSchool;
	}
	public void setGraSchool(String graSchool) {
		this.graSchool = graSchool;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getProfessionArea() {
		return professionArea;
	}
	public void setProfessionArea(String professionArea) {
		this.professionArea = professionArea;
	}
	public Integer getTechnicalPosition() {
		return technicalPosition;
	}
	public void setTechnicalPosition(Integer technicalPosition) {
		this.technicalPosition = technicalPosition;
	}
	public Integer getIsBackbone() {
		return isBackbone;
	}
	public void setIsBackbone(Integer isBackbone) {
		this.isBackbone = isBackbone;
	}
	public Integer getIsSubjectLeader() {
		return isSubjectLeader;
	}
	public void setIsSubjectLeader(Integer isSubjectLeader) {
		this.isSubjectLeader = isSubjectLeader;
	}
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
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
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public Set<Teaching> getTeaching() {
		return teaching;
	}
	public void setTeaching(Set<Teaching> teaching) {
		this.teaching = teaching;
	}
	
}
