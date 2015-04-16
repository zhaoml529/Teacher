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

import com.lyd.soft.entity.Awarding;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IAwardingService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping(value = "awardAction")
public class AwardingAction {

	@Autowired
	private IAwardingService awardService;
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(@RequestParam(value = "type", required = false) String type, Model model){
		if(!model.containsAttribute("award")){
			model.addAttribute("award", new Awarding());
		}
		model.addAttribute("type", type);
		return "award/add_award";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("award")){
			Awarding award = this.awardService.findById(id);
			model.addAttribute("award", award);
		}
		return "award/update_award";
	}
	
	@RequestMapping("/toList_page")
	public String toList(@RequestParam(value = "orderBy", required = false) String orderBy,
						@RequestParam(value = "type", required = false) String type,
						HttpServletRequest request, 
						HttpSession session, 
						Model model) throws Exception {
		String params[] = new String[2];
		Teacher user = UserUtils.getUserFromSession(session);
		List<Awarding> awardList = new ArrayList<Awarding>();
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
		awardList = this.awardService.findByTeaId(user.getTeacherId().toString(), params);
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("awardList", awardList);
		return "award/list_award";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("award") @Valid Awarding award,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpServletRequest request,
			HttpSession session, 
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toAdd(award.getType(), model);
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		award.setTeacher(teacher);
		award.setCreateDate(new Date());
		award.setIsDelete(0);
		this.awardService.doAdd(award);
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "添加成功！");
		return "redirect:/awardAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(
			@ModelAttribute("award") @Valid Awarding award,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpSession session,
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toUpdate(award.getId(), model);
		}
		
		//页面hidden bookId  createDate
		award.setIsDelete(0);
		award.setUpdateDate(new Date());
		this.awardService.doUpdate(award);
		model.addAttribute("award", award);
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/awardAction/toList_page";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Awarding award = this.awardService.findById(id);
		model.addAttribute("award", award);
		return "award/details_award";
		
	}
	
	@RequestMapping(value = "/doDelete/{type}/{id}")
	public String doDelete(@PathVariable("type") String type,
							@PathVariable("id") Integer id,
							RedirectAttributes redirectAttributes) throws Exception{
		if(!BeanUtils.isBlank(id)){
			this.awardService.doDelete(new Awarding(id));
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除成功！");
		}else{
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除失败，id为空！");
		}
		return "redirect:/awardAction/toList_page?type="+type;
	}
}
