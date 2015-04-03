package com.lyd.soft.util;


import javax.servlet.http.HttpSession;

import com.lyd.soft.entity.Teacher;


/**
 * 用户工具
 * @author LYD
 */
public class UserUtils {

    /**
     * 设置用户到session
     *
     * @param session
     * @param user
     */
    public static void saveUserToSession(HttpSession session, Teacher user) {
        session.setAttribute(Constants.USER, user);
        session.setAttribute(Constants.USER_ID, user.getTeacherId());
    }

    /**
     * 从Session获取当前用户信息
     *
     * @param session
     * @return
     */
    public static Teacher getUserFromSession(HttpSession session) {
        Object attribute = session.getAttribute(Constants.USER);
        return attribute == null ? null : (Teacher) attribute;
    }

    /**
     * 从Session移除当前用户信息
     * @param session
     */
    public static void removeUserFromSession(HttpSession session) {
    	session.removeAttribute(Constants.USER);
    }
}
