package com.lyd.soft.action;

import java.util.ArrayList;
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

import com.lyd.soft.entity.Book;
import com.lyd.soft.entity.Teacher;
import com.lyd.soft.pagination.Pagination;
import com.lyd.soft.pagination.PaginationThreadUtils;
import com.lyd.soft.service.IBookService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.Constants;
import com.lyd.soft.util.StringUtils;
import com.lyd.soft.util.UserUtils;

@Controller
@RequestMapping(value = "/bookAction")
public class BookAction {

	@Autowired
	private IBookService bookService;
	
	@RequestMapping(value = "/toAdd")
	public String toAdd(@RequestParam(value = "type", required = false) String type, Model model){
		if(!model.containsAttribute("book")){
			model.addAttribute("book", new Book());
		}
		model.addAttribute("type", type);
		return "book/add_book";
	}
	
	@RequestMapping(value = "/toUpdate/{id}")
	public String toUpdate(@PathVariable("id") Integer id, Model model) throws Exception{
		if(!model.containsAttribute("book")){
			Book book = this.bookService.findById(id);
			model.addAttribute("book", book);
		}
		return "book/update_book";
	}
	
	@RequestMapping("/toList_page")
	public String toList(@RequestParam(value = "orderBy", required = false) String orderBy,
						@RequestParam(value = "type", required = false) String type,
						HttpServletRequest request, 
						HttpSession session, 
						Model model) throws Exception {
		String params[] = new String[2];
		Teacher user = UserUtils.getUserFromSession(session);
		List<Book> bookList = new ArrayList<Book>();
		if(!StringUtils.isBlank(type)){
			params[0] = type;
			model.addAttribute("type", type);
		}else{
			params[0] = null;
		}
		if(!StringUtils.isBlank(orderBy)){
			params[1] = orderBy;
		}else{
			params[1] = "DESC";
		}
		if("manager".equals(user.getRole())){
			bookList = this.bookService.findByTeaId("manager", user.getTeacherId().toString(), params);
		}else{
			bookList = this.bookService.findByTeaId("teacher", user.getTeacherId().toString(), params);
		}
		Pagination pagination = PaginationThreadUtils.get();
		model.addAttribute("page", pagination.getPageStr());
		model.addAttribute("bookList", bookList);
		return "book/list_book";
	}
	
	@RequestMapping(value = "/doAdd")
	public String doAdd(
			@ModelAttribute("book") @Valid Book book,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpServletRequest request,
			HttpSession session, 
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toAdd(book.getType(), model);
		}
		
		Teacher teacher = UserUtils.getUserFromSession(session);
		book.setDeptId(teacher.getDepartment().getId());
		book.setCreateDate(new Date());
		book.setIsDelete(0);
		this.bookService.doAdd(book);
		redirectAttributes.addAttribute("type", book.getType());
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "添加成功！");
		return "redirect:/bookAction/toList_page";
	}
	
	@RequestMapping(value = "/doUpdate")
	public String doUpdate(
			@ModelAttribute("book") @Valid Book book,BindingResult results,
			RedirectAttributes redirectAttributes, 
			HttpSession session,
			Model model) throws Exception{
		
		if(results.hasErrors()){
			return toUpdate(book.getId(), model);
		}
		
		//页面hidden bookId  createDate
		book.setIsDelete(0);
		book.setUpdateDate(new Date());
		this.bookService.doUpdate(book);
		model.addAttribute("book", book);
		redirectAttributes.addAttribute("type", book.getType());
		redirectAttributes.addFlashAttribute(Constants.MESSAGE, "修改成功！");
		return "redirect:/bookAction/toList_page";
	}
	
	@RequestMapping(value = "/details/{id}")
	public String details(@PathVariable("id") Integer id, Model model) throws Exception {
		Book book = this.bookService.findById(id);
		model.addAttribute("book", book);
		return "book/details_book";
		
	}
	
	@RequestMapping(value = "/doDelete/{type}/{id}")
	public String doDelete(@PathVariable("type") String type,
							@PathVariable("id") Integer id, 
							RedirectAttributes redirectAttributes) throws Exception{
		if(!BeanUtils.isBlank(id)){
			this.bookService.doDelete(new Book(id));
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除成功！");
		}else{
			redirectAttributes.addFlashAttribute(Constants.MESSAGE, "删除失败，id为空！");
		}
		redirectAttributes.addAttribute("type", type);
		return "redirect:/bookAction/toList_page";
	}
}
