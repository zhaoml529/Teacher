package com.lyd.soft.action;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lyd.soft.entity.Message;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IMessageService;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping("/messageAction")
public class MessageAction {

	@Autowired
	private IMessageService messageService;
	
	@RequestMapping(value = "/toList_page")
	public String toList(HttpSession session, Model model) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		List<Message> list = this.messageService.toList(user.getTeacherId());
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("messageList", list);
		return "message/list_message";
		
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Message msg = this.messageService.findById(id);
		model.addAttribute("msg", msg);
		return "message/details_message";
	}
	
}
