package com.lyd.soft.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * 针对系统中有一些是 @ResponseBody 操作时，返回执行状态。
 * @author lyd
 *
 */
public class SysMsg implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9206521748989636513L;
	private Boolean flag; //1.成功 2.失败
	private String content;
	private Object obj;
	private List<Object> objList;
	private Date date;
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public List<Object> getObjList() {
		return objList;
	}
	public void setObjList(List<Object> objList) {
		this.objList = objList;
	}
	
}
