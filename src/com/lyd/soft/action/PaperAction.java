package com.lyd.soft.action;

import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Paper;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IPaperService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 论文相关-待测试-无页面
 * @author lyd
 *
 */

@Controller
@RequestMapping("/paperAction")
public class PaperAction {

	@Autowired
	private IPaperService paperService;
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(@RequestParam(value = "type", required = false) String type, Model model){
		if(!model.containsAttribute("paper")){
			model.addAttribute("paper", new Paper());
		}
		model.addAttribute("type", type);
		return "paper/add_paper";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("paper")){
			Paper paper = this.paperService.findById(id);
			model.addAttribute("paper", paper);
		}
		return "paper/update_paper";
	}
	
	@RequestMapping("/toList_page")
	public String toList(@RequestParam(value = "orderBy", required = false) String orderBy,
						@RequestParam(value = "type", required = false) String type,
						HttpServletRequest request, 
						HttpSession session, 
						Model model) throws Exception {
		
		String params[] = new String[2];
		Teacher user = UserUtils.getUserFromSession(session);
		List<Paper> paperList = new ArrayList<Paper>();
		if(!StringUtils.isBlank(type)){
			params[0] = type;
			model.addAttribute("type", type);
		}else{
			params[0] = null;
		}
		if(!StringUtils.isBlank(orderBy)){
			params[1] = orderBy;
		}else{
			params[1] = "DESC";
		}
		paperList = this.paperService.findByTeaId(user.getTeacherId().toString(), params);
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("paperList", paperList);
		return "paper/list_paper";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("paper") @Valid Paper paper,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpServletRequest request,
			HttpSession session, 
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toAdd(paper.getType(), model);
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		paper.setTeacher(teacher);
		paper.setCreateDate(new Date());
		paper.setIsDelete(0);
		this.paperService.doAdd(paper);
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "添加成功！");
		return "redirect:/paperAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(
			@ModelAttribute("paper") @Valid Paper paper,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpSession session,
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toUpdate(paper.getId(), model);
		}
		
		//页面hidden paperId  createDate
		paper.setIsDelete(0);
		paper.setUpdateDate(new Date());
		this.paperService.doUpdate(paper);
		model.addAttribute("paper", paper);
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/paperAction/toList_page";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Paper paper = this.paperService.findById(id);
		model.addAttribute("paper", paper);
		return "paper/details_paper";
		
	}
	
	@RequestMapping(value = "/doDelete/{id}")
	public String doDelete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) throws Exception{
		if(!BeanUtils.isBlank(id)){
			this.paperService.doDelete(new Paper(id));
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除成功！");
		}else{
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除失败，id为空！");
		}
		return "redirect:/paperAction/toList_page";
	}
	
}
