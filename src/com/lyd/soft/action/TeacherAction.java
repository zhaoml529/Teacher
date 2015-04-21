package com.lyd.soft.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 教师信息类
 * @author LYD
 *
 */

@Controller
@RequestMapping("/teacherAction")
public class TeacherAction {

	
	@Autowired
	private ITeacherService teacherService;
	
	@RequestMapping("/toList_page")
	public String toList(@RequestParam("dept_id") Integer dept_id , Model model) throws Exception{
		
		if(BeanUtils.isBlank(dept_id)){
			dept_id = 1;
		}else{
			List<Teacher> list = this.teacherService.findByDept(dept_id);
			Pagination pagination = PaginationThreadUtils.get();
			model.addAttribute("page", pagination.getPageStr());
			model.addAttribute("list", list);
		}
		return "teacher/list_teacher";
	}
	
	@RequestMapping(value = "/details")
	public String details(HttpSession session, Model model) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		Teacher teacher = this.teacherService.findById(user.getTeacherId());
		model.addAttribute("teacher", teacher);
		return "teacher/details_teacher";
	}
	
	@RequestMapping(value = "/searchTeacher")
	@ResponseBody
	public List<Teacher> getTeacherList(HttpServletRequest request) throws Exception{
		String teacherName = request.getParameter("teacherName");
		List<Teacher> list = this.teacherService.searchByName(teacherName);
		return list;
	}
}
