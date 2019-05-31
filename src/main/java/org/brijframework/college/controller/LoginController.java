package org.brijframework.college.controller;

import javax.servlet.http.HttpServletRequest;

import org.brijframework.college.model.util.PasswordEncoder;
import org.brijframework.college.service.CountryService;
import org.brijframework.college.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class LoginController 
{
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private UserService userService;
	@Autowired
	private CountryService countryService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginWelcome(ModelMap model) 
	{
		return "login";
	}

	@RequestMapping(value = "/loginfailed", method = RequestMethod.GET)
	public String loginFailed(HttpServletRequest request, ModelMap model) 
	{
		if (request.getParameter("j_username") != null)
			logger.info("Login attempt failed for user: "+ request.getParameter("j_username"));
		return "login";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap model, HttpServletRequest request) 
	{
		request.getSession().invalidate();
		return "login";
	}
	
}
