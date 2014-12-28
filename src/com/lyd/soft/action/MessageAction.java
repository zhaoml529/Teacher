package com.lyd.soft.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lyd.soft.entity.Message;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IMessageService;
import com.lyd.soft.util.BeanUtils;
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
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		if(!model.containsAttribute("message")){
			model.addAttribute("message", new Message());
		}
        return "message/add_message";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Message message = this.messageService.findById(id);
		message.setReview(1);
		this.messageService.doUpdate(message);
		model.addAttribute("msg", message);
		return "message/details_message";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("message") @Valid Message message,BindingResult results,
			@RequestParam("messageId") Integer messageId,
			RedirectAttributes redirectAttributes, 
			HttpServletRequest request,
			HttpSession session, 
			Model model) throws Exception{
		
		if(results.hasErrors()){
			model.addAttribute("message", message);
			if(BeanUtils.isBlank(messageId)){
				return "message/add_message";
			}else{
				return details(messageId, model);
			}
//        	return "redirect:/messageAction/toList_page";
		}
		
		Teacher user = UserUtils.getUserFromSession(session);
		
		message.setFromUser(user.getTeacherId());
		message.setReview(0);
		message.setCreateDate(new Date());
		message.setIsDelete(0);
		this.messageService.doAdd(message);
		
		return "redirect:/messageAction/toList_page";
	}

}
