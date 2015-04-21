package com.lyd.soft.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Department;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IDepartmentService;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
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
	
	@Autowired
	private IDepartmentService departmentService;
	
	@RequestMapping("/toList_page")
	public String toList(@RequestParam(value = "dept_id", required = false) String dept_id , 
						@RequestParam(value = "orderBy", required = false) String orderBy,
						Model model) throws Exception{
		
		String params[] = new String[2];
		if(!StringUtils.isBlank(dept_id)){
			params[0] = dept_id;
			model.addAttribute("dept_id", dept_id);
		}else{
			params[0] = null;
		}
		if(!StringUtils.isBlank(orderBy)){
			params[1] = orderBy;
		}else{
			params[1] = "DESC";
		}
		List<Teacher> list = this.teacherService.findByDept(dept_id, params);
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("list", list);
		return "teacher/list_teacher";
	}
	
	@RequestMapping(value = "/details")
	public String details(HttpSession session, Model model) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		Teacher teacher = this.teacherService.findById(user.getTeacherId());
		model.addAttribute("teacher", teacher);
		return "teacher/details_teacher";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") String id, Model model) throws Exception{
		if(!model.containsAttribute("teacher")){
			if(!StringUtils.isBlank(id)){
				Teacher user = this.teacherService.findById(id);
				model.addAttribute("teacher", user);
			}else{
				model.addAttribute(Constants.MESSAGE, "此用户不存在！");
			}
		}
		List<Department> deptList = this.departmentService.getAll();
		model.addAttribute("deptList", deptList);
		return "teacher/update_teacher";
	}
	@RequestMapping(value ="/doUpdate")
	public String doUpdate(@ModelAttribute("teacher") @Valid Teacher teacher, 
						   BindingResult results, 
						   Model model,
						   HttpSession session,
						   RedirectAttributes redirectAttributes) throws Exception{
		if(results.hasErrors()){
			toUpdate(teacher.getTeacherId(), model);
		}
		Teacher user = UserUtils.getUserFromSession(session);
		teacher.setUpdateDate(new Date());
		this.teacherService.doUpdate(teacher);
		if("admin".equals(user.getDepartment().getName())){
			//待测试,toList_page是否能获取到dept_id
			redirectAttributes.addFlashAttribute("dept_id", user.getDepartment().getId());
		}
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/teacherAction/toList_page";
	}
	
	@RequestMapping(value = "/stopAccount/{id}")
	public String stopAccount(@PathVariable("id") String id) throws Exception{
		Teacher teacher = this.teacherService.findById(id);
		teacher.setIsDelete(1);
		//加入dept_id 待测试
		return "redirect:/teacherAction/toList_page";
	}
	
	@RequestMapping(value = "/searchTeacher")
	@ResponseBody
	public List<Teacher> getTeacherList(HttpServletRequest request) throws Exception{
		String teacherName = request.getParameter("teacherName");
		List<Teacher> list = this.teacherService.searchByName(teacherName);
		return list;
	}
}
