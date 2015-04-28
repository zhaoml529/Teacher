package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

/**
 * 系部机构
 * @author LYD
 *
 */

@Entity
@Table(name = "T_DEPATMENT")
public class Department implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5003300946122891401L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;			

	@Column(name = "NAME")
	private String name;			//系部名称
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;		//删除
	
	@OneToMany(targetEntity=Teacher.class,cascade=CascadeType.ALL)
	@Fetch(FetchMode.JOIN)
	//updatable=false很关键，如果没有它，在级联删除的时候就会报错(反转的问题)
	@JoinColumn(name="DEPT_ID",updatable=false)
    private Set<Teacher> teacher = new HashSet<Teacher>();

	public Department(){
		
	}
	
	public Department(Integer id){
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

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Set<Teacher> getTeacher() {
		return teacher;
	}

	public void setTeacher(Set<Teacher> teacher) {
		this.teacher = teacher;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
