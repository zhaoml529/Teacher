package com.lyd.soft.action;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lyd.soft.service.ITeacherService;

/**
 * 教师信息类
 * @author LYD
 *
 */

@Controller
@RequestMapping("/teacherAction")
public class TeacherAction {

private static final Logger logger = Logger.getLogger(LoginAction.class);
	
	@Autowired
	private ITeacherService teacherService;
	
	
}
