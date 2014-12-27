package com.lyd.soft.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lyd.soft.entity.News;
import com.lyd.soft.service.INewsService;

@Controller
@RequestMapping("/newsAction")
public class NewsAction {

	@Autowired
	private INewsService newsService;
	
	@RequestMapping( value = "/toList_page")
	public String toList(Model model) throws Exception {
		List<News> list = this.newsService.toList();
		model.addAttribute("newsList", list);
		return null;
	}
	
}
