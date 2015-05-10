package com.lyd.soft.action;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lyd.soft.entity.Teacher;
import com.lyd.soft.service.ITeacherService;
import com.lyd.soft.util.BeanUtils;
import com.lyd.soft.util.IPUtils;
import com.lyd.soft.util.UserUtils;

/**
 * 登录控制类
 * @author LYD
 *
 */

@Controller
@RequestMapping("/loginAction")
public class LoginAction {
	private static final Logger logger = Logger.getLogger(LoginAction.class);
	
	@Autowired
	private ITeacherService teacherService;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam("username")String name, @RequestParam("password")String passwd, HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		Teacher user = teacherService.findByName(name);
		model.addAttribute("username", name);
		if(!BeanUtils.isBlank(user)){
			if(user.getIsDelete() == 1){
				model.addAttribute("msg", "账户已停用");
				logger.info("账户停用");
				return "login";
			}else if(passwd.equals(user.getPassword())){
				UserUtils.saveUserToSession(session, user);
				String ip = IPUtils.getIpAddr(request);
				user.setIPAddress(ip);
				user.setLgoinDate(new Date());
				this.teacherService.doUpdate(user);
				return "index";
			}else{
				model.addAttribute("msg", "密码不正确");
				logger.info("密码不正确");
				return "login";
			}
		}else{
			model.addAttribute("msg", "用户名不存在");
			logger.info(name+" 用户名不存在");
			return "login";
		}
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){
		UserUtils.removeUserFromSession(session);
		return "login";
	}
	
	@RequestMapping(value = "/login_view")
	public String login_view(){
		logger.info("跳转登录页面");
		return "login";
	}
	
	@RequestMapping(value = "/main")
	public String main() {
		return "index";
	}
	
}
