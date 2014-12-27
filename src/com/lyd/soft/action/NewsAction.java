package com.lyd.soft.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lyd.soft.entity.News;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.INewsService;

@Controller
@RequestMapping("/newsAction")
public class NewsAction {

	@Autowired
	private INewsService newsService;
	
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
	
}
