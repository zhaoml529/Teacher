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
 * 著作情况表
 * @author LYD
 *
 */

/**
 * @author ZML
 *
 */
@Entity
@Table(name = "T_BOOK")
public class Book implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4775184137333229777L;

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", unique = true)
	private Integer id;	
	
	@OneToOne
	@JoinColumn(name="TEACHER_ID")
	private Teacher teacher;	
	
	@Column(name = "TITLE")
	@NotBlank(message = "{book.title.not.empty}")
	private String title;			//著作名称
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "PUBLISH_DATE")
	@NotNull(message="{book.publish.date.not.empty}")
	private Date publishDate;		//出版时间
	
	@Column(name = "STYLE")
	@NotBlank(message = "{book.style.not.empty}")
	private String style;			//类别
	
	@Column(name = "WORD_COUNT")
	@NotNull(message="{book.word.count.not.empty}")
	private Float wordCount;		//字数
	
	@Column(name = "IS_EDITOR")
	@NotNull(message="{book.isEditor.not.empty}")
	private Integer isEditor;		//是否主编
	
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
	private Integer isDelete;		//删除

	public Book(){
		
	}
	
	public Book(Integer id){
		this.id = id;
	}
	
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

	public Date getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public Float getWordCount() {
		return wordCount;
	}

	public void setWordCount(Float wordCount) {
		this.wordCount = wordCount;
	}

	public Integer getIsEditor() {
		return isEditor;
	}

	public void setIsEditor(Integer isEditor) {
		this.isEditor = isEditor;
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
