package com.lyd.soft.action;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.BeanUtils;

/**
 * 教师信息类
 * @author LYD
 *
 */

@Controller
@RequestMapping("/teacherAction")
public class TeacherAction {

private static final Logger logger = Logger.getLogger(TeacherAction.class);
	
	@Autowired
	private ITeacherService teacherService;
	
	@RequestMapping("/{dept_id}/toList_page")
	public String toList(@PathVariable("dept_id") Integer dept_id , Model model) throws Exception{
		if(!BeanUtils.isBlank(dept_id)){
			List<Teacher> list = this.teacherService.findByDept(dept_id);
			Pagination pagination = PaginationThreadUtils.get();
			model.addAttribute("page", pagination.getPageStr());
			model.addAttribute("list", list);
		}else{
			logger.error("dept_id 为空！");
		}
		return "teacher/list_teacher";
	}
	
}
