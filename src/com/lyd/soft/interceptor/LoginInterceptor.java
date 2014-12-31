package com.lyd.soft.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.UserUtils;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		System.out.println(request.getServletPath()+" -------------------------"+request.getParameterMap().size());
		Teacher user = UserUtils.getUserFromSession(session);
		if(!BeanUtils.isBlank(user)){
			return true;
		}
		response.sendRedirect(request.getContextPath() + "/loginAction/login_view");
		return false;
	}

}
