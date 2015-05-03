package com.lyd.soft.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Subject;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.ISubjectService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 课题
 * @author LYD
 *
 */

@Controller
@RequestMapping("/subjectAction")
public class SubjectAction {
	private static final Logger logger = Logger.getLogger(SubjectAction.class);
	
	@Autowired
	private ISubjectService subjectService;
	
	@RequestMapping(value = "/toList_page")
	public String toList(@RequestParam(value = "orderBy", required = false) String orderBy,
						@RequestParam(value = "type", required = false) String type,
						Model model,
						HttpSession session)throws Exception{
		Teacher teacher = UserUtils.getUserFromSession(session);
		String teacherId = teacher.getTeacherId();
		if(!StringUtils.isBlank(teacherId)){
			String params[] = new String[2];
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
			List<Subject> list = this.subjectService.toList(teacherId, params);
			Pagination pagination = PaginationThreadUtils.get();
			model.addAttribute("page", pagination.getPageStr());
			model.addAttribute("list", list);
		}
		return "subject/list_subject";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!BeanUtils.isBlank(id)){
			Subject sub = this.subjectService.findById(id);
			model.addAttribute("subject", sub);
		}
		return "subject/details_subject";
	}
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(@RequestParam(value = "type", required = false) String type, Model model) throws Exception {
		if(!model.containsAttribute("subject")){
			model.addAttribute("subject", new Subject());
		}
		model.addAttribute("type", type);
		return "subject/add_subject";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(@ModelAttribute("subject") @Valid Subject subject, 
						BindingResult results,
						Model model,
						RedirectAttributes redirectAttribute) throws Exception{
		if(results.hasErrors()){
			return toAdd(subject.getType(), model);
		}
		SimpleDateFormat df = new SimpleDateFormat("MMddSSS");
		String id = df.format(new Date()).toString();
		subject.setSubId(id);
		subject.setIsDelete(0);
		subject.setCreateDate(new Date());
		this.subjectService.doAdd(subject);
		redirectAttribute.addAttribute("type", subject.getType());
		redirectAttribute.addFlashAttribute(Constants.MESSAGE, "添加成功！");
		return "redirect:/subjectAction/toList_page";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("subject")){
			if(!BeanUtils.isBlank(id)){
				Subject sub = this.subjectService.findById(id);
				model.addAttribute("subject", sub);
			}else{
				logger.info("id 为空！");
			}
		}
		return "subject/update_subject";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(@ModelAttribute("subject") @Valid Subject subject,
							BindingResult results,
							HttpServletRequest request,
							Model model,
							RedirectAttributes redirectAttribute) throws Exception{
		if(results.hasErrors()){
			return toUpdate(subject.getId(), model);
		}
		subject.setUpdateDate(new Date());
		subject.setIsDelete(0);
		this.subjectService.doUpdate(subject);
		redirectAttribute.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/subjectAction/toList_page";
	}
	
	@RequestMapping(value = "/doDelete/{id}")
	public String doDelete(@PathVariable("id") Integer id, RedirectAttributes redirectAttribute) throws Exception{
		if(!BeanUtils.isBlank(id)){
			this.subjectService.doDelete(new Subject(id));
			redirectAttribute.addFlashAttribute(Constants.MESSAGE, "删除成功！");
		}else{
			logger.error("subject id is null...");
			redirectAttribute.addFlashAttribute(Constants.MESSAGE, "删除失败!");
		}
		return "redirect:/subjectAction/toList_page";
	}
}
