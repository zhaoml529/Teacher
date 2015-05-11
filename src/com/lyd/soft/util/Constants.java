package com.lyd.soft.util;


/**
 * <p>User: Zhang Kaitao
 * <p>Date: 14-2-15
 * <p>Version: 1.0
 */
public class Constants {
	
	/***************** system *****************/
	public static final String PICTURE_TYPE = "image/jpeg,image/jpg,image/bmp,image/gif,image/png,image/pjpeg,image/x-png";
	public static final String MESSAGE = "message";
	public static final String DB_NAME = "mysql";
	
	/***************** session key *****************/
    public static final String USER = "user";
    public static final String USER_ID = "user_id";
    public static final String DEPT_ID = "dept_id";
    public static final String ROLE = "role";
    
	/***************** default password (123456) *****************/
	public static final String DEFAULT_PASSWORD = "14e1b600b1fd579f47433b88e8d85291";
	
	/***************** approval status *****************/
	/**
	 * 正在审批
	 */
	public static final String PENDING = "PENDING";
	/**
	 * 待审批
	 */
	public static final String WAITING_FOR_APPROVAL = "WAITING_FOR_APPROVAL";
	/**
	 * 审批成功
	 */
	public static final String APPROVAL_SUCCESS = "APPROVAL_SUCCESS";
	/**
	 * 审批失败
	 */
	public static final String APPROVAL_FAILED = "APPROVAL_FAILED";

}
