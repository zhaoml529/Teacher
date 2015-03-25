package com.lyd.soft.action;

import java.util.Date;

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

import com.lyd.soft.entity.Message;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 教师基本档案
 * @author LYD
 */

@Controller
@RequestMapping("/teacherArchiveAction")
public class TeacherArchiveAction {
	private static final Logger logger = Logger.getLogger(TeacherArchiveAction.class);

	@Autowired
	private ITeacherArchiveService itaService;
	
	@RequestMapping(value = "/details")
	public String details(Model model,HttpSession session) throws Exception{
		Teacher teacher = UserUtils.getUserFromSession(session);
		String teacherId = teacher.getTeacherId();
		if(!BeanUtils.isBlank(teacherId)){
			TeacherArchive ta = this.itaService.findByTeaId(teacherId);
			model.addAttribute("entity", ta);
		}else{
			logger.debug("教师id为空！");
		}
		return "teacher/details_teacherArchive";
	}
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model){
		if(!model.containsAttribute("teacherArchiver")){
			model.addAttribute("teacherArchiver", new Message());
		}
		return "teacher/add_teacherArchive";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(@ModelAttribute("teacherArchive") @Valid TeacherArchive teacherArchive,
						BindingResult results,
						Model model,
						HttpSession session ) throws Exception{
		if(results.hasErrors()){
			return toAdd(model);
		}
		Teacher user = UserUtils.getUserFromSession(session);
		teacherArchive.setCreateDate(new Date());
		teacherArchive.setUpdateUser(user);
		teacherArchive.setIsDelete(0);
		this.itaService.doAdd(teacherArchive);
		return "redirect:/teacherArchiveAction/details";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("teacherArchiver")){
			if(!BeanUtils.isBlank(id)){
				TeacherArchive ta = this.itaService.findById(id.toString());
				model.addAttribute("teacherArchiver", ta);
			}else{
				logger.info("id 为空！");
			}
		}
		return "teacher/update_teacherArchive";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(@ModelAttribute("teacherArchivel") @Valid TeacherArchive teacherArchivel,
							BindingResult results,
							Model model,
							HttpSession session) throws Exception{
		if(results.hasErrors()){
			return toUpdate(teacherArchivel.getId(),model);
		}
		Teacher updateUser = UserUtils.getUserFromSession(session);
		teacherArchivel.setUpdateDate(new Date());
		teacherArchivel.setUpdateUser(updateUser);
		this.itaService.doUpdate(teacherArchivel);
		return "redirect:/teacherArchiveAction/details";
	}
}
