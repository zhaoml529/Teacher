package com.lyd.soft.action;

import java.util.Date;
import java.util.List;

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
import com.lyd.soft.util.DateUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 日程控制类
 * @author LYD
 *
 */

@Controller
@RequestMapping("/calendarAction")
public class CalendarAction {

	private static final Logger logger = Logger.getLogger(CalendarAction.class);
	
	@Autowired
	private ICalendarService calendarService;
	
	
	@RequestMapping("/listCalendar")
	@ResponseBody
	public List<Calendar> listCalendar(
			@RequestParam("start") Date strat,
			@RequestParam("end") Date end,
			@RequestParam("viewName") String viewName,
			HttpSession session) throws Exception {
		
		logger.info("viewName: "+viewName);
		Teacher teacher = UserUtils.getUserFromSession(session);
		String beginDate = DateUtils.DateToString(strat, "yyyy-MM-dd HH:mm");
		String endDate = DateUtils.DateToString(end, "yyyy-MM-dd HH:mm");
		List<Calendar> list = this.calendarService.findByDateRange(teacher.getTeacherId().toString(), beginDate, endDate);
		return list;
	}
}
