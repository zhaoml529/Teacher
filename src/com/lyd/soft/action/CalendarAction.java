package com.lyd.soft.action;

import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lyd.soft.entity.Calendar;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.service.ICalendarService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.DateUtils;
import com.lyd.soft.util.StringUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 日程控制类
 * @author LYD
 *
 */

@Controller
@RequestMapping(value = "/calendarAction")
public class CalendarAction {

	private static final Logger logger = Logger.getLogger(CalendarAction.class);
	
	@Autowired
	private ICalendarService calendarService;
	
	@RequestMapping(value = "/toCalendar")
	public String toCalendar(){
		return "calendar/calendar";
	}
	
	@RequestMapping(value = "/listCalendar")
	@ResponseBody
	public List<Calendar> listCalendar(
			@RequestParam("start") String strat,
			@RequestParam("end") String end,
			HttpSession session) throws Exception {
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		String teaId = teacher.getTeacherId();
		List<Calendar> list = new ArrayList<Calendar>();
		if(!StringUtils.isBlank(teaId)){
			list = this.calendarService.findByDateRange(teaId, strat, end);
		}else{
			logger.error("teaId为空！");
		}
		return list;
	}
	
	@RequestMapping(value = "/getCalendar")
	@ResponseBody
	public Calendar getCalendar(HttpServletRequest request) throws Exception{
		Calendar calendar = new Calendar();
		String id = request.getParameter("id");
		if(!StringUtils.isBlank(id)){
			calendar = this.calendarService.findById(id);
		}else{
			calendar.setId(0);
		}
		return calendar;
	}
	
	@RequestMapping(value = "/updateCalendar")
	@ResponseBody
	public Calendar updateCalendar(HttpServletRequest request, HttpSession session) throws Exception{
		Calendar calendar = new Calendar();
		String id = request.getParameter("id");
		String title = request.getParameter("title"); 
		String content = request.getParameter("content"); 
		String start = request.getParameter("beginDate");
		String end = request.getParameter("endDate");
		String remark = request.getParameter("remark");
		String create_date = request.getParameter("createDate");
		Date startDate = DateUtils.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtils.StringToDate(end, "yyyy-MM-dd HH:mm");
		Date createDate = DateUtils.StringToDate(create_date, "yyyy-MM-dd HH:mm");
		Boolean allDay = false;
		if(DateUtils.diffDate(endDate, startDate) >= 24){ //大于1天
			allDay = true;
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		calendar.setTeacher(teacher);
		calendar.setTitle(title);
		calendar.setContent(content);
		calendar.setBeginDate(startDate);
		calendar.setEndDate(endDate);
		calendar.setRemark(remark);
		calendar.setAllDay(allDay);
		calendar.setCreateDate(createDate);
		calendar.setUpdateDate(new Date());
		calendar.setIsDelete(0);
		
		if(!StringUtils.isBlank(id)){
			calendar.setId(new Integer(id));
			this.calendarService.doUpdate(calendar);
		}else{
			calendar.setId(0);
		}
		return calendar;
	}
	
	@RequestMapping(value = "/addCalendar")
	@ResponseBody
	public Calendar addCalendar(HttpServletRequest request, HttpSession session) throws Exception{
		Calendar calendar = new Calendar();
		String title = request.getParameter("title"); 
		String content = request.getParameter("content"); 
		String start = request.getParameter("beginDate");
		String end = request.getParameter("endDate");
		String remark = request.getParameter("remark");
		Boolean allDay = false;
		Date startDate = DateUtils.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtils.StringToDate(end, "yyyy-MM-dd HH:mm");
		if(DateUtils.diffDate(endDate, startDate) >= 24){ //大于1天
			allDay = true;
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		calendar.setTeacher(teacher);
		calendar.setTitle(title);
		calendar.setContent(content);
		calendar.setBeginDate(startDate);
		calendar.setEndDate(endDate);
		calendar.setRemark(remark);
		calendar.setAllDay(allDay);
		calendar.setCreateDate(new Date());
		calendar.setIsDelete(0);
		Serializable id = this.calendarService.doAdd(calendar);
		if(!BeanUtils.isBlank(id)){
			calendar.setId((int)id);
		}else{
			calendar.setId(0);
		}
		return calendar;
	}
	
	@RequestMapping(value = "/deleteCalendar")
	public void deleteCalendar(HttpServletRequest request, HttpServletResponse response) throws Exception{
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		if(!StringUtils.isBlank(id)){
			this.calendarService.doDelete(new Calendar(new Integer(id)));
			out.print("success");
		}else{
			out.print("fail");
		}
		out.flush();
		out.close();
	}
	
	@RequestMapping(value = "/dropOrResizeCalendar")
	@ResponseBody
	public Calendar dropCalendar(HttpServletRequest request) throws Exception{
		Calendar calendar = new Calendar();
		String id = request.getParameter("id");
		String start = request.getParameter("beginDate");
		String end = request.getParameter("endDate");
		Date startDate = DateUtils.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtils.StringToDate(end, "yyyy-MM-dd HH:mm");
		Boolean allDay = false;
		if(DateUtils.diffDate(endDate, startDate) >= 24){ //大于1天
			allDay = true;
		}
		if(!StringUtils.isBlank(id)){
			calendar = this.calendarService.findById(id);
			calendar.setAllDay(allDay);
			calendar.setBeginDate(startDate);
			calendar.setEndDate(endDate);
			this.calendarService.doUpdate(calendar);
		}else{
			calendar.setId(0);
		}
		return calendar;
	}
}
