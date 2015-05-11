package com.lyd.soft.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lyd.soft.entity.TeacherArchive;
import com.lyd.soft.service.IStatisticsService;
import com.lyd.soft.service.ITeacherArchiveService;
import com.lyd.soft.util.DateUtils;

@Controller
@RequestMapping(value = "/statisticsAction")
public class StatisticsAction {

	@Autowired
	private ITeacherArchiveService teacherArchiveService;
	
	@Autowired
	private IStatisticsService statisticsService;
	
	@RequestMapping(value = "/toStatistics")
	public String toStatistics(@RequestParam(value = "status", required = false) String status, Model model, HttpSession session) throws Exception{
		Integer bachelorCount = 0;	//学士
		Integer masterCount = 0;	//硕士
		Integer doctorCount = 0;	//博士
		Integer otherCount = 0;		//其他
		
		Integer js_count = 0;		//教授
		Integer fjs_count = 0;		//副教授
		Integer jiangs_count = 0;	//讲师
		Integer zljs_count = 0;		//助理讲师
		
		Integer level1 = 0;
		Integer level2 = 0;
		Integer level3 = 0;
		Integer level4 = 0;
		Integer level5 = 0;
		Integer level6 = 0;
		Map<String, Integer> technicalMap = new HashMap<String, Integer>();
		Map<String, Integer> degreeMap = new HashMap<String, Integer>();
		Map<String, Integer> levelMap = new HashMap<String, Integer>();
		
		Map<String, Integer> subjectTeachingMap = new HashMap<String, Integer>(5);
		Map<String, Integer> paperTeachingMap = new HashMap<String, Integer>(5);
		Map<String, Integer> bookTeachingMap = new HashMap<String, Integer>(5);
		Map<String, Integer> awardTeachingMap = new HashMap<String, Integer>(5);
		
		Map<String, Integer> subjectScienceMap = new HashMap<String, Integer>(5);
		Map<String, Integer> paperScienceMap = new HashMap<String, Integer>(5);
		Map<String, Integer> bookScienceMap = new HashMap<String, Integer>(5);
		Map<String, Integer> awardScienceMap = new HashMap<String, Integer>(5);
		
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
			};
			
			if("教授".equals(ta.getTechnicalPosition())){
				js_count++;
			}else if("副教授".equals(ta.getTechnicalPosition())){
				fjs_count++;
			}else if("讲师".equals(ta.getTechnicalPosition())){
				jiangs_count++;
			}else{
				zljs_count++;
			};
			
			if("一级甲等".equals(ta.getMandarinLevel())){
				level1++;
			}else if("一级乙等".equals(ta.getMandarinLevel())){
				level2++;
			}else if("二级甲等".equals(ta.getMandarinLevel())){
				level3++;
			}else if("二级乙等".equals(ta.getMandarinLevel())){
				level4++;
			}else if("三级甲等".equals(ta.getMandarinLevel())){
				level5++;
			}else{
				level6++;
			}
		}
		
		degreeMap.put("学士", bachelorCount);
		degreeMap.put("硕士", masterCount);
		degreeMap.put("博士", doctorCount);
		degreeMap.put("其他", otherCount);
		
		technicalMap.put("教授", js_count);
		technicalMap.put("副教授", fjs_count);
		technicalMap.put("讲师", jiangs_count);
		technicalMap.put("助理讲师", zljs_count);
		
		levelMap.put("一级甲等", level1);
		levelMap.put("一级乙等", level2);
		levelMap.put("二级甲等", level3);
		levelMap.put("二级乙等", level4);
		levelMap.put("三级甲等", level5);
		levelMap.put("三级乙等", level6);
		Integer year = DateUtils.getYear(new Date());
		for(Integer i= year;i>year-5;i--){
			Integer subjectTeachingCount = this.statisticsService.getSubjectCountByYEAR("teaching", i.toString());
			Integer paperTeachingCount = this.statisticsService.getPaperCountByYEAR("teaching", i.toString());
			Integer bookTeachingCount = this.statisticsService.getBookCountByYEAR("teaching", i.toString());
			Integer awardTeachingCount = this.statisticsService.getAwardCountByYEAR("teaching", i.toString());
			
			subjectTeachingMap.put(i.toString(), subjectTeachingCount);
			paperTeachingMap.put(i.toString(), paperTeachingCount);
			bookTeachingMap.put(i.toString(), bookTeachingCount);
			awardTeachingMap.put(i.toString(), awardTeachingCount);
			
			Integer subjectScienceCount = this.statisticsService.getSubjectCountByYEAR("science", i.toString());
			Integer paperScienceCount = this.statisticsService.getPaperCountByYEAR("science", i.toString());
			Integer bookScienceCount = this.statisticsService.getBookCountByYEAR("science", i.toString());
			Integer awardScienceCount = this.statisticsService.getAwardCountByYEAR("science", i.toString());
			
			subjectScienceMap.put(i.toString(), subjectScienceCount);
			paperScienceMap.put(i.toString(), paperScienceCount);
			bookScienceMap.put(i.toString(), bookScienceCount);
			awardScienceMap.put(i.toString(), awardScienceCount);
		}
		
		
		model.addAttribute("degreeMap", degreeMap);
		model.addAttribute("technicalMap", technicalMap);
		model.addAttribute("levelMap", levelMap);
		
		model.addAttribute("subjectTeachingMap", subjectTeachingMap);
		model.addAttribute("paperTeachingMap", paperTeachingMap);
		model.addAttribute("bookTeachingMap", bookTeachingMap);
		model.addAttribute("awardTeachingMap", awardTeachingMap);
		
		model.addAttribute("subjectScienceMap", subjectScienceMap);
		model.addAttribute("paperScienceMap", paperScienceMap);
		model.addAttribute("bookScienceMap", bookScienceMap);
		model.addAttribute("awardScienceMap", awardScienceMap);
		
		return "statistics/statistics";
	}
}
