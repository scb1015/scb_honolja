package com.guest.honolja.notice;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class NoticeController {
	
	@Autowired
	NoticeDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping("/notice_insert.do")
	public String notice_writeView() {
		return "/notice/notice_insert";
	}//
	
	@RequestMapping("/notice.do")
	public ModelAndView notice_view(HttpServletRequest request, NoticeDTO dto , HttpSession session) { //select +
		ModelAndView mav = new ModelAndView();
		
		String u_id = (String)session.getAttribute("checked");
		String u_member = dao.db_selectM(u_id);
		
		int pageNUM = 1; //Ntotal 
		int start=1, end=1, temp=1, startpage=1, endpage=1, pagecount=1; //pagecount 
		String pnum="0", returnpage="";
		String skey="", sval="";
		int reversecnt= 0; // 테스트
		
		skey=request.getParameter("keyfield");
		sval=request.getParameter("keyword");
		
		if (skey=="" || skey==null || sval=="" || sval==null) { skey="n_title"; sval=""; returnpage=""; }
		returnpage="&keyfield="+skey+"&keyword="+sval;
		
		pnum=request.getParameter("pageNum");
		if(pnum==null || pnum=="") { pageNUM=1; }
		else { pageNUM = Integer.parseInt(pnum);}
		
		dto.setSkey(skey);
		dto.setSval(sval);
		
		//total
		int cnt = dao.db_count(skey, sval);
		
		if ( cnt%5==0 ) {pagecount=cnt/5;}
		else {pagecount=(cnt/5)+1;}
		
		start=((pageNUM-1)*5)+1;
		end=pageNUM*5;
		reversecnt = cnt-(start-1);

		temp=(pageNUM-1)%5;
		startpage=pageNUM-temp;
		endpage=startpage+4;

		if (endpage>pagecount) {endpage=pagecount;}
		
		List<NoticeDTO> list = dao.db_select(start, end, skey, sval);
		mav.addObject("u_member", u_member);
		mav.addObject("dto", list);
		mav.addObject("cnt", cnt);
		mav.addObject("reversecnt", reversecnt);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("pagecount", pagecount);
		mav.addObject("pageNUM", pageNUM);
		mav.addObject("returnpage", returnpage);
		mav.addObject("skey", skey);
		mav.addObject("sval", sval);
		mav.setViewName("/notice/notice");
		return mav;
	}//view end 

	@RequestMapping(value="/notice_insert.do", method=RequestMethod.POST)
	public String notice_insert(NoticeDTO dto) { 
		dto.setN_viewcnt(0);
		dto.setU_id("admin");
		
		if(dto.getN_fix() == null) {
			dto.setN_fix("N");
		}
		
		dao.db_insert(dto);
		return "redirect:/notice.do";
	}//insert end 
	
	@RequestMapping("/notice_detail.do")
	public ModelAndView notice_detail(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String u_id = (String)session.getAttribute("checked");
		String u_member = dao.db_selectM(u_id);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		NoticeDTO dto = dao.db_detail(idx);
		mav.addObject("dto", dto);
		mav.addObject("u_member", u_member);
		dto.setN_viewcnt(dto.getN_viewcnt()+1);
		dao.db_cnt(dto);
		
		mav.setViewName("/notice/notice_detail");
		return mav;
	}//공지글 상세
	
	@RequestMapping("/notice_delete.do")
	public String notice_delete(HttpServletRequest request) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		dao.db_delete(idx);
		return "redirect:/notice.do";
	}//삭제
	
	@RequestMapping("/notice_preEdit.do")
	public ModelAndView notice_preEdit(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int idx = Integer.parseInt(request.getParameter("idx"));
		NoticeDTO dto = dao.db_preEdit(idx);
		mav.addObject("dto", dto);
		mav.setViewName("/notice/notice_preEdit");
		return mav;
	}//수정화면
	
	@RequestMapping("/notice_edit.do")
	public String notice_edit(NoticeDTO dto) {
		dto.setU_id("admin");
		if(dto.getN_fix() == null) {
			dto.setN_fix("N");
		}
		dao.db_edit(dto);
		return "redirect:/notice.do";
	}//수정기능
	
	
}//Controller end
