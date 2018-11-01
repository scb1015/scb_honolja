package com.guest.honolja.message;

import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.guest.honolja.member.MemberDTO;


@Controller
public class MsgController {
	
	@Autowired
	MsgDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(MsgController.class);
	
	@RequestMapping("/msg_send.do")
	public ModelAndView msg_send(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		String login = (String)session.getAttribute("checked");
		
		if ( login == null || login == "") {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='login_popup.do';</script>");
			out.flush();
		}
		
		String userid = request.getParameter("userid");
		String receiver = request.getParameter("receiver");
		ModelAndView mav = new ModelAndView();
		mav.addObject("userid", userid);
		mav.addObject("receiver", receiver);
		mav.setViewName("/message/msg_send");
		return mav;
	}//메세지 발송 화면
	
	@RequestMapping("/msg_resend.do")
	public ModelAndView msg_resend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String userid = request.getParameter("userid");
		String receiver = request.getParameter("receiver");
		mav.addObject("userid", userid);
		mav.addObject("receiver",receiver);
		mav.setViewName("/message/msg_resend");
		return mav;
	}//답장 화면
	
	@RequestMapping("/msg_boxR.do")
	public ModelAndView msg_boxR(HttpSession session, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");
		String u_id = session.getAttribute("checked").toString();

		if ( u_id == null || u_id == "") {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='main.do';</script>");
			out.flush();
		}
		
		ModelAndView mav = new ModelAndView();
		List<MsgDTO> listR = dao.db_selectR(u_id);
		
		int cnt = dao.db_msgcheck(u_id);

		mav.addObject("listR", listR);
		mav.addObject("cnt", cnt);
		mav.setViewName("/message/msg_boxR");
		return mav;
	}//받은 쪽지함
	
	@RequestMapping("/msg_boxS.do")
	public ModelAndView msg_boxS(HttpSession session, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=UTF-8");

		String u_id = (String)session.getAttribute("checked");

		ModelAndView mav = new ModelAndView();
		List<MsgDTO> listS = dao.db_selectS(u_id);
		
		mav.addObject("listS", listS);
		mav.setViewName("message/msg_boxS");
		return mav;
	}//보낸 쪽지함
	
	@RequestMapping(value="/msg_insert.do", method=RequestMethod.POST)
	public String msg_send(MsgDTO dto) {
		dao.db_insert(dto);
		return "redirect:/notice.do";
	}//메세지 보내기

	@ResponseBody
	@RequestMapping(value="/msg_insertA.do", method=RequestMethod.POST)
	public String msg_asend(MsgDTO dto) {
		dao.db_insert(dto);
		String result = "success";

		return result;
	}//메세지 보내기
	
	@RequestMapping("/msg_detailS.do")
	public ModelAndView msg_detailS(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		MsgDTO dto = new MsgDTO();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		dto = dao.db_detail(idx);
		
		mav.addObject("dto", dto);
		mav.setViewName("/message/msg_detailS");
		return mav;
	}//보낸 메세지 상세
	
	@RequestMapping("/msg_detailR.do")
	public ModelAndView msg_detailR(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		MsgDTO dto = new MsgDTO();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		dto.setM_no(idx);
		dao.db_check(idx);
		dto = dao.db_detail(idx);
		
		mav.addObject("dto", dto);
		mav.setViewName("/message/msg_detailR");
		return mav;
	}//받은 메세지 상세
	

	@RequestMapping(value="/msg_deleteS.do", method=RequestMethod.POST)
	public String msg_deleteS(@RequestParam("n_ck") int[] n_ck, HttpServletRequest request) throws Exception {
		MsgDTO dto = new MsgDTO();
		dto.setUserid(request.getParameter("userid"));
		
		for (int ck_no : n_ck) {
			dao.db_deleteS(ck_no);
		}
		
		return "redirect:/msg_boxS.do?userid="+dto.getUserid();
	}//보낸 메세지 삭제
	
	
	@RequestMapping(value="/msg_deleteR.do", method=RequestMethod.POST)
	public String msg_deleteR(@RequestParam("n_ck") int[] n_ck, HttpServletRequest request) throws Exception {
		MsgDTO dto = new MsgDTO();
		dto.setUserid(request.getParameter("userid"));
		
		for (int ck_no : n_ck) {
			dao.db_deleteR(ck_no);
		}
		
		return "redirect:/msg_boxR.do?userid="+dto.getUserid();
	}//받은 메세지 삭제
	
	@RequestMapping("/msg_cancel.do")
	public String msg_cancel(HttpServletRequest request) throws Exception {
		MsgDTO dto = new MsgDTO();
		
		dto.setM_no(Integer.parseInt(request.getParameter("m_no")));
		dto.setM_check(request.getParameter("m_check"));
		dto.setUserid(request.getParameter("userid"));
		
		if (dto.getM_check().equals("false")) {
			dao.db_cancel(dto);
		}//check가 false면 삭제 
		
		return "redirect:/msg_boxS.do?userid="+dto.getUserid();
	}//발송 취소
	
	
	
}//Controller end
