package com.lyd.soft.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	/**
	 * 列表页
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toList_page", method = RequestMethod.GET)
	public String toList(HttpServletRequest request, HttpSession session, Model model) throws Exception{
		if(!model.containsAttribute("message")){
			model.addAttribute("message", new Message());
		}
		String orderBy = request.getParameter("orderBy");
		String option = "DESC";
		if(!BeanUtils.isBlank(orderBy)){
			option = orderBy;
		}
		Teacher user = UserUtils.getUserFromSession(session);
		List<Message> list = this.messageService.toList(user.getTeacherId(), option);
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("messageList", list);
		return "message/list_message";
		
	}
	
	/**
	 * 到添加页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(Model model) {
		if(!model.containsAttribute("message")){
			model.addAttribute("message", new Message());
		}
        return "message/add_message";
	}
	
	/**
	 * 查看站内信
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Message message = this.messageService.findById(id);
		message.setReview(1);
		this.messageService.doUpdate(message);
		model.addAttribute("msg", message);
		return "message/details_message";
	}
	
	/**
	 * 写信
	 * @param message
	 * @param results
	 * @param messageId
	 * @param redirectAttributes
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
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
	
	/**
	 * 删除所选
	 * @param ids
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delSelect")
	public String delSelect(@RequestParam("checkAll") Integer[] ids, Model model) throws Exception{
		if(!BeanUtils.isBlank(ids)){
			for(int i=0;i<ids.length;i++){
				Message message = this.messageService.findById(ids[i]);
				if(!BeanUtils.isBlank(message)){
					this.messageService.doDelete(message);
				}
			}
		}
		return "redirect:/messageAction/toList_page";
	}
	
	/**
	 * 标记为已读
	 * @param ids
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setReviewYES")
	public String setReviewYES(@RequestParam("checkAll") Integer[] ids, Model model) throws Exception {
		if(!BeanUtils.isBlank(ids)){
			for(int i=0;i<ids.length;i++){
				Message message = this.messageService.findById(ids[i]);
				if(!BeanUtils.isBlank(message)){
					message.setReview(1);
					this.messageService.doUpdate(message);
				}
			}
		}
		return "redirect:/messageAction/toList_page";
	}

	/**
	 * 标记为未读
	 * @param ids
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setReviewNO")
	public String setReviewNO(@RequestParam("checkAll") Integer[] ids, Model model) throws Exception {
		if(!BeanUtils.isBlank(ids)){
			for(int i=0;i<ids.length;i++){
				Message message = this.messageService.findById(ids[i]);
				if(!BeanUtils.isBlank(message)){
					message.setReview(0);
					this.messageService.doUpdate(message);
				}
			}
		}
		return "redirect:/messageAction/toList_page";
	}
	
	/**
	 * 全部标记为已读
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setReviewALL")
	public String setReviewALL() throws Exception {
		List<Message> message = this.messageService.findAll();
		for(Message msg : message){
			msg.setReview(1);
			this.messageService.doUpdate(msg);
		}
		return "redirect:/messageAction/toList_page";
	}
	
	/**
	 * 未读信息数量
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCount")
	@ResponseBody
	public Map<String, Integer> getMessageCount(HttpSession session) throws Exception {
		Teacher user = UserUtils.getUserFromSession(session);
		Integer count = this.messageService.getMessageCount(user.getTeacherId());
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("count", count);
		return map;
	}
}
