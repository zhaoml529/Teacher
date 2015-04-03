package com.lyd.soft.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
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
			model.addAttribute("teacherArchiver", new TeacherArchive());
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
		SimpleDateFormat df = new SimpleDateFormat("MMddSSS");
		String id = df.format(new Date()).toString();
		teacherArchive.setArchiveNumber(id);
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
	
	@RequestMapping(value = "/uploadPic", method = RequestMethod.POST)
	@ResponseBody
	public String uploadPic(@Value("#{APP_PROPERTIES['upload.uploadTempDir']}") String path,
							@RequestParam(value = "teacherPic", required = false) MultipartFile file, 
							HttpServletRequest request,
							HttpSession session) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		//文件类型
		String contentType = file.getContentType();
		if(Constants.PICTURE_TYPE.contains(contentType)){
			System.out.println(path);
			String realPath = request.getSession().getServletContext().getRealPath("/");
			SimpleDateFormat df = new SimpleDateFormat("MMddSSS");
			String timestamp = df.format(new Date()).toString();
			String photo_path = path+"/photo/"+user.getTeacherId()+"/";
			System.out.println(realPath+photo_path);
			File myFilePath = new File(realPath+photo_path);
			if (!myFilePath.exists()) {  
				myFilePath.mkdirs();
			}
			String photoName = file.getOriginalFilename();
			System.out.println(contentType);
			//文件后缀
			String appden = photoName.substring(photoName.lastIndexOf('.'));
			String fileName = timestamp+appden;
			System.out.println(realPath+photo_path+fileName);
			file.transferTo(new File(realPath+photo_path+fileName));
			return photo_path+fileName;
		}else{
			logger.error("图片格式不正确！");
			return "fail";
		}
		
		  
	}
}
