package com.guest.honolja.interceptor;

import java.io.PrintWriter;
import java.lang.reflect.Method;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class HonoljaInterceptor extends HandlerInterceptorAdapter{

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		System.out.println("post Handle is ...");
		
		HttpSession session = request.getSession();
		Object checked = modelAndView.getModel().get("checked");
				
		if(checked != null) {
			session.setAttribute("checked", checked);
			
			if(request.getParameter("id_keep") != null) {
				Cookie loginCookie = new Cookie("loginCookie", (String) session.getAttribute("checked"));
					loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}
			
			//response.sendRedirect("main.do");
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("pre Handle is ...");
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("checked") != null) {
			session.removeAttribute("checked");
		}
		
		
		return true;
	}
	
	
	
	
}
