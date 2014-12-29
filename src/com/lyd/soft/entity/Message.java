package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 站内信
 * @author LYD
 *
 */

@Entity
@Table(name = "T_MESSAGE")
public class Message implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6718738304520426910L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;	
	
	@Column(name = "TITLE", nullable = false)
	@NotEmpty(message="{message.title.not.empty}")
	private String title;			//标题
	
	@Column(name = "CONTENT")
	@NotEmpty(message="{message.content.not.empty}")
	private String content;			//内容
	
	@Column(name = "FROM_USER_ID")
	private String fromUser;		//来自谁
	
	@Column(name = "TO_USER_ID")
	@NotEmpty(message="{message.toUser.not.empty}")
	private String toUser;			//发给谁
	
	@Column(name = "REVIEW")
	private Integer review;			//1.已读 0.未读
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "CREATE_DATE")
	private Date createDate;		//创建时间
	
	@Column(name = "IS_DELETE")
	private Integer isDelete;		//删除

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public Integer getReview() {
		return review;
	}

	public void setReview(Integer review) {
		this.review = review;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
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
