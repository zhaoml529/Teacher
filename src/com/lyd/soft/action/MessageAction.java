package com.lyd.soft.action;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lyd.soft.entity.Message;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.service.IMessageService;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping("/messageAction")
public class MessageAction {

	private IMessageService messageService;
	
	@RequestMapping(value = "/toList")
	public String toList(HttpSession session, Model model) throws Exception{
		Teacher user = UserUtils.getUserFromSession(session);
		List<Message> list = this.messageService.toList(user.getTeacherId());
		model.addAttribute("messageList", list);
		return "message/list_message";
		
	}
}
