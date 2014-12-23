package com.lyd.soft.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	
	@Column(name = "COURSE")
	private String name;				//获奖名称
	
	@Column(name = "AWARD_LEVEL")
	private String awardLevel;			//级别
	
	@Column(name = "ACHIEVE_DATE")
	private String achieveDate;			//获得时间
	
	@Column(name = "AWARDS")
	private String awards;				//奖项
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;			//删除

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

	public String getAchieveDate() {
		return achieveDate;
	}

	public void setAchieveDate(String achieveDate) {
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
	
}
