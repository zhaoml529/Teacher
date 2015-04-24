package com.lyd.soft.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping(value = "/statisticsAction")
public class StatisticsAction {

	@Autowired
	private ITeacherArchiveService teacherArchiveService;
	
	@RequestMapping(value = "/toStatistics")
	public String toStatistics(@RequestParam(value = "status", required = false) String status, Model model, HttpSession session) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		Integer dept_id = user.getDepartment().getId();
		Integer bachelorCount = 0;	//学士
		Integer masterCount = 0;	//硕士
		Integer doctorCount = 0;	//博士
		Integer otherCount = 0;		//其他
		Map<String, Integer> degreeMap = new HashMap<String, Integer>();
		List<TeacherArchive> list =  this.teacherArchiveService.getAllList();
		for(TeacherArchive ta : list){
			if("学士".equals(ta.getDegree())){
				bachelorCount++;
			}else if("硕士".equals(ta.getDegree())){
				masterCount++;
			}else if("博士".equals(ta.getDegree())){
				doctorCount++;
			}else{
				otherCount++;
			}
		}
		degreeMap.put("学士", bachelorCount);
		degreeMap.put("硕士", masterCount);
		degreeMap.put("博士", doctorCount);
		degreeMap.put("其他", otherCount);
		model.addAttribute("degreeMap", degreeMap);
		return "statistics/statistics";
	}
}
