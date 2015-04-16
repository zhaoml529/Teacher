package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 获奖情况表
 * @author LYD
 *
 */

@Entity
@Table(name = "T_AWARDING")
public class Awarding implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5281503695673848325L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;		
	
	@OneToOne
	@JoinColumn(name="TEACHER_ID")
	private Teacher teacher;	
	
	@Column(name = "COURSE")
	@NotBlank(message = "{award.name.not.empty}")
	private String name;				//获奖名称
	
	@Column(name = "AWARD_LEVEL")
	@NotBlank(message = "{award.level.not.empty}")
	private String awardLevel;			//级别
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "ACHIEVE_DATE")
	@NotNull(message="{award.achieve.date.not.empty}")
	private Date achieveDate;			//获得时间
	
	@Column(name = "AWARDS")
	@NotBlank(message = "{award.awards.not.empty}")
	private String awards;				//奖项
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "CREATE_DATE")
	private Date createDate;		//创建时间
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "UPDATE_DATE")
	private Date updateDate;		//修改时间
	
	@Column(name = "REMARK")
	private String remark;					//备注
	
	@Column(name = "TYPE")
	private String type;			//类型 science：科学研究， teaching：教学研究
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;			//删除

	public Awarding(){
		
	}
	
	public Awarding(Integer id){
		this.id = id;
	}
	
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

	public String getAwardLevel() {
		return awardLevel;
	}

	public void setAwardLevel(String awardLevel) {
		this.awardLevel = awardLevel;
	}

	public Date getAchieveDate() {
		return achieveDate;
	}

	public void setAchieveDate(Date achieveDate) {
		this.achieveDate = achieveDate;
	}

	public String getAwards() {
		return awards;
	}

	public void setAwards(String awards) {
		this.awards = awards;
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

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
