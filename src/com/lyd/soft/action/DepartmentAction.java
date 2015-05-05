package com.lyd.soft.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Department;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IDepartmentService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;

@Controller
@RequestMapping(value = "/departmentAction")
public class DepartmentAction {
	private static final Logger logger = Logger.getLogger(DepartmentAction.class);
	
	@Autowired
	private IDepartmentService departmentService;
	
	@RequestMapping(value = "/toList_page")
	public String toList (Model model) throws Exception{
		List<Department> list = this.departmentService.toList();
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("list", list);
		return "department/list_department";
	}
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model){
		if(!model.containsAttribute("department")){
			model.addAttribute("department", new Department());
		}
		return "department/add_department";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("subject")){
			if(!BeanUtils.isBlank(id)){
				Department dept = this.departmentService.findById(id);
				model.addAttribute("department", dept);
			}else{
				model.addAttribute(Constants.MESSAGE, "您所修改的数据不存在!");
				logger.error("id 为空！");
			}
		}
		return "department/update_department";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(@ModelAttribute("department") @Valid Department department, 
						BindingResult results,
						Model model,
						RedirectAttributes redirectAttribute) throws Exception{
		if(results.hasErrors()){
			return toAdd(model);
		}
		department.setIsDelete(0);
		department.setCreateDate(new Date());
		this.departmentService.doAdd(department);
		redirectAttribute.addFlashAttribute(Constants.MESSAGE, "添加成功！");
		return "redirect:/departmentAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(@ModelAttribute("department") @Valid Department department,
							BindingResult results,
							HttpServletRequest request,
							Model model,
							RedirectAttributes redirectAttribute) throws Exception{
		if(results.hasErrors()){
			return toUpdate(department.getId(), model);
		}
		this.departmentService.doUpdate(department);
		
		redirectAttribute.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/departmentAction/toList_page";
	}
	
	@RequestMapping(value = "/doDelete/{id}")
	public String doDelete(@PathVariable("id") Integer id, RedirectAttributes redirectAttribute) throws Exception{
		if(!BeanUtils.isBlank(id)){
			this.departmentService.doDelete(new Department(id));
			redirectAttribute.addFlashAttribute(Constants.MESSAGE, "删除成功！");
		}else{
			logger.error("department id is null...");
			redirectAttribute.addFlashAttribute(Constants.MESSAGE, "删除失败!");
		}
		return "redirect:/departmentAction/toList_page";
	}
}
