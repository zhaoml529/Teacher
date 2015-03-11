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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Paper;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IPaperService;
import com.lyd.soft.util.UserUtils;

/**
 * 论文相关-待测试-无页面
 * @author lyd
 *
 */

@Controller
@RequestMapping("paperAction")
public class PaperAction {

	@Autowired
	private IPaperService paperService;
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model){
		if(!model.containsAttribute("paper")){
			model.addAttribute("paper", new Paper());
		}
		return "paper/add_paper";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		Paper paper = this.paperService.findById(id);
		model.addAttribute("paper", paper);
		return "paper/update_paper";
	}
	
	@RequestMapping("/toList_page")
	public String toList(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		if(!model.containsAttribute("paper")){
			//form 表单用
			model.addAttribute("paper", new Paper());
		}
		Teacher user = UserUtils.getUserFromSession(session);
		List<Paper> paperList = this.paperService.findByTeaId(user.getTeacherId().toString());
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("paperList", paperList);
		return "paper/paper_list";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("paper") @Valid Paper paper,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpServletRequest request,
			HttpSession session, 
			Model model) throws Exception{
		
		if(results.hasErrors()){
			model.addAttribute("paper", paper);
			return toAdd(model);
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		paper.setTeacher(teacher);
		paper.setCreateDate(new Date());
		paper.setIsDelete(0);
		this.paperService.doAdd(paper);
		redirectAttributes.addFlashAttribute("message", "添加成功！");
		return "redirect:/paperAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(
			@ModelAttribute("paper") @Valid Paper paper,BindingResult results,
			HttpSession session,
			Model model) throws Exception{
		
		if(results.hasErrors()){
			model.addAttribute("paper", paper);
			return toUpdate(paper.getId(), model);
		}
		
		//页面hidden paperId  createDate
		paper.setIsDelete(0);
		this.paperService.doUpdate(paper);
		model.addAttribute("paper", paper);
		return "paper/details_paper";
	}
	
	@RequestMapping(value = "/details/id")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Paper paper = this.paperService.findById(id);
		model.addAttribute("paper", paper);
		return "paper/details_paper";
		
	}
	
	@RequestMapping(value = "/doDelete/{id}")
	public String doDelete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) throws Exception{
		Paper paper = this.paperService.findById(id);
		this.paperService.doDelete(paper);
		redirectAttributes.addFlashAttribute("message", "删除成功！");
		return "redirect:/paperAction/toList_page";
	}
	
}
