package com.lyd.soft.action;

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

import com.lyd.soft.entity.Message;
import com.lyd.soft.entity.News;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.INewsService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping("/newsAction")
public class NewsAction {
	private static final Logger logger = Logger.getLogger(NewsAction.class);
	
	@Autowired
	private INewsService newsService;
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model){
		if(!model.containsAttribute("news")){
			model.addAttribute("news", new Message());
		}
        return "news/add_news";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception {
		if(!model.containsAttribute("news")){
			if(!BeanUtils.isBlank(id)){
				News news = this.newsService.findById(id);
				model.addAttribute("news", news);
			}else{
				logger.error("newsId为空！");
			}
		}
		
		return "news/update_news";
	}
	
	@RequestMapping("/toList_page")
	public String toList(HttpServletRequest request, Model model) throws Exception {
		String pageNum = request.getParameter("pageNum");
		String testName = request.getParameter("newName");
		System.out.println(pageNum+" ----------------- "+testName);
		List<News> list = this.newsService.toList();
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("newsList", list);
		return "news/list_news";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("news") @Valid News news, BindingResult results,
			HttpSession session, 
			Model model) throws Exception{
		if(results.hasErrors()){
			model.addAttribute("news", news);
			return toAdd(model);
		}
		
		Teacher user = UserUtils.getUserFromSession(session);
		news.setCreateDate(new Date());
		news.setUpdateDate(new Date());
		news.setTeacher(user);
		news.setView(0);
		news.setIsDelete(0);
		this.newsService.doAdd(news);
		
		return "redirect:/newsAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(
			@ModelAttribute("news") @Valid News news, BindingResult results,
			HttpSession session,
			Model model) throws Exception {
		Integer id = news.getId();
		if(results.hasErrors()){
			model.addAttribute("news", news);
			return toUpdate(id, model);
		}
		
		if(!BeanUtils.isBlank(id)){
			News newsInfo = this.newsService.findById(id);
			newsInfo.setTitle(news.getTitle());
			newsInfo.setContent(news.getContent());
			newsInfo.setUpdateDate(new Date());
			this.newsService.doUpdate(newsInfo);
			model.addAttribute("news", newsInfo);
		}else{
			logger.error("所修改的新闻id不存在！");
		}	
		return "news/details_news";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		if(!BeanUtils.isBlank(id)){
			News news = this.newsService.findById(id);
			Integer view = news.getView();
			news.setView(view+1);
			this.newsService.doUpdate(news);
			model.addAttribute("news", news);
		}else{
			logger.error("newsId 为空！");
		}
		return "news/details_news";
	}
	
	@RequestMapping(value = "/doDelete/{id}")
	public String doDelete(@PathVariable("id") Integer id, Model model) throws Exception {
		if(!BeanUtils.isBlank(id)){
			News news = this.newsService.findById(id);
			this.newsService.doDelete(news);
		}else{
			logger.error("newsId 为空！");
		}
		return "redirect:/newsAction/toList_page";
	}
	
}
