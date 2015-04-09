package com.lyd.soft.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.SysMsg;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
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
			model.addAttribute("teacherArchive", ta);
		}else{
			logger.debug("教师id为空！");
		}
		return "teacher/details_teacherArchive";
	}
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model){
		if(!model.containsAttribute("teacherArchive")){
			model.addAttribute("teacherArchive", new TeacherArchive());
		}
		return "teacher/add_teacherArchive";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(@ModelAttribute("teacherArchive") @Valid TeacherArchive teacherArchive,
						BindingResult results,
						Model model,
						HttpServletRequest request,
						HttpSession session ) throws Exception{
		if(results.hasErrors()){
			return toAdd(model);
		}
		Teacher user = UserUtils.getUserFromSession(session);
		SimpleDateFormat df = new SimpleDateFormat("MMddSSS");
		String id = df.format(new Date()).toString();
		teacherArchive.setArchiveNumber(id);
		teacherArchive.setIsPass(Constants.WAITING_FOR_APPROVAL);
		teacherArchive.setCreateDate(new Date());
		teacherArchive.setUpdateUser(user);
		teacherArchive.setIsDelete(0);
		String teacherPic = request.getParameter("pictureUrl");
		teacherArchive.setTeacherPic(teacherPic);
		this.itaService.doAdd(teacherArchive);
		return "redirect:/teacherArchiveAction/details";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("teacherArchive")){
			if(!BeanUtils.isBlank(id)){
				TeacherArchive ta = this.itaService.findById(id.toString());
				model.addAttribute("teacherArchive", ta);
			}else{
				logger.info("id 为空！");
			}
		}
		return "teacher/update_teacherArchive";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(@ModelAttribute("teacherArchive") @Valid TeacherArchive teacherArchive,
							BindingResult results,
							Model model,
							HttpServletRequest request,
							HttpSession session) throws Exception{
		if(results.hasErrors()){
			return toUpdate(teacherArchive.getId(),model);
		}
		Teacher updateUser = UserUtils.getUserFromSession(session);
		teacherArchive.setUpdateDate(new Date());
		teacherArchive.setUpdateUser(updateUser);
		teacherArchive.setIsPass(Constants.WAITING_FOR_APPROVAL);
		teacherArchive.setIsDelete(0);
		String teacherPic = request.getParameter("pictureUrl");
		teacherArchive.setTeacherPic(teacherPic);
		this.itaService.doUpdate(teacherArchive);
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
			String realPath = request.getSession().getServletContext().getRealPath("/");
			SimpleDateFormat df = new SimpleDateFormat("MMddSSS");
			String timestamp = df.format(new Date()).toString();
			String photo_path = path+"/photo/"+user.getTeacherId()+"/";
			File myFilePath = new File(realPath+photo_path);
			if (!myFilePath.exists()) {  
				myFilePath.mkdirs();
			}
			String photoName = file.getOriginalFilename();
			//文件后缀
			String appden = photoName.substring(photoName.lastIndexOf('.'));
			String fileName = timestamp+appden;
			file.transferTo(new File(realPath+photo_path+fileName));
			return photo_path+fileName;
		}else{
			logger.error("图片格式不正确！");
			return "fail";
		}
	}
	
	/**
	 * 系部管理员查看待审批的个人档案
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toApprovalList_page")
	public String toApprovalList(@RequestParam(value="status", required=false) String status, Model model, HttpSession session) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		Integer dept_id = user.getDepartment().getId();
		List<TeacherArchive> list = new ArrayList<TeacherArchive>();
		if(!BeanUtils.isBlank(dept_id)){
			if(StringUtils.isBlank(status)){
				list = this.itaService.findByDept(dept_id.toString(),Constants.PENDING);
			}else{
				list = this.itaService.findByDept(dept_id.toString(),status);
			}
			Pagination pagination = PaginationThreadUtils.get();
			model.addAttribute("page", pagination.getPageStr());
			model.addAttribute("list", list);
		}
		return "/teacher/list_approval";
	}
	
	
	/**
	 * 系部管理员跳转审核个人档案页面
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/doApproval/{id}")
	public String doApproval(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!BeanUtils.isBlank(id)){
			TeacherArchive ta = this.itaService.findById(id.toString());
			model.addAttribute("teacherArchive", ta);
		}else{
			logger.error("The teacherArchive id is empty!");
		}
		return "/teacher/approval_teacherArchive";
	}
	
	@RequestMapping(value = "/approval/{id}/{flag}")
	public String approval(@PathVariable("id") Integer id, @PathVariable("flag") Boolean flag, Model model) throws Exception{
		if(!BeanUtils.isBlank(id)){
			TeacherArchive ta = this.itaService.findById(id.toString());
			if(flag){
				ta.setIsPass(Constants.APPROVAL_SUCCESS);
			}else{
				ta.setIsPass(Constants.APPROVAL_FAILED);
			}
			this.itaService.doUpdate(ta);
		}else{
			logger.error("The teacherArchive id is empty!");
		}
		return "redirect:/teacherArchiveAction/toApprovalList_page";
	}
	/**
	 * 申请审批-ajax版本
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toApproval_ajax/{id}")
	@ResponseBody
	public SysMsg toApprovalTest(@PathVariable("id") Integer id, Model model)throws Exception{
		SysMsg msg = new SysMsg();
		if(!BeanUtils.isBlank(id)){
			TeacherArchive ta = this.itaService.findById(id.toString());
			if(ta == null){
				msg.setFlag(false);
				msg.setContent("您所修改的内容不存在！");
			}else{
				ta.setIsPass(Constants.PENDING);
				this.itaService.doUpdate(ta);
				msg.setFlag(true);
			}
		}else{
			msg.setFlag(false);
			msg.setContent("档案ID为空，不能修改！");
		}
		return msg;
	}
	
	/**
	 * 申请审批
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toApproval/{id}")
	public String toApproval(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttribute) throws Exception{
		if(!BeanUtils.isBlank(id)){
			TeacherArchive ta = this.itaService.findById(id.toString());
			ta.setIsPass(Constants.PENDING);
			this.itaService.doUpdate(ta);
			redirectAttribute.addFlashAttribute(Constants.MESSAGE, "申请审批成功！请等待系部管理员审核...");
		}
		return "redirect:/teacherArchiveAction/details";
	}
}
