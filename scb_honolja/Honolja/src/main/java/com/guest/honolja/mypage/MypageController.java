package com.guest.honolja.mypage;

import java.util.List;
import java.io.File;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.guest.honolja.board.BoardDTO;
import com.guest.honolja.list.ListDTO;
import com.guest.honolja.member.MemberDTO;
import com.guest.honolja.reservation.ReservationDTO;

@Controller
public class MypageController {
	@Autowired
	MypageDAO dao;
	
	@Autowired
	ServletContext application;
	
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	//마이페이지 메뉴바
	@RequestMapping("/mypage.do")
	public String mypage() {
		return "/mypage/mypage_menu";
	}//mypage end
	
	//내가 쓴 글
	@RequestMapping("/mypage_board.do")
	public ModelAndView mypage_board(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		List<BoardDTO> listB = dao.mypage_board(u_id);
		mav.addObject("listB", listB);
		mav.setViewName("/mypage/mypage_board");
		return mav;
	}//end
	
	//찜 목록
	@RequestMapping("/mypage_like.do")
	public ModelAndView mypage_like(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		List<ListDTO> listL = dao.mypage_like(u_id);
		mav.addObject("listL", listL);
		mav.setViewName("/mypage/mypage_like");
		return mav;
	}//end
	
	//예약 현황
	@RequestMapping("/mypage_rsvt.do")
	public ModelAndView mypage_rsvt(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		List<ReservationDTO> listRS = dao.mypage_rsvt(u_id);
		mav.addObject("listRS", listRS);
		mav.setViewName("/mypage/mypage_rsvt");
		return mav;
	}//end
	
	@RequestMapping("/rsvt_cancel.do")
	public String rsvt_cancel(HttpServletRequest request) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println("idx = " + idx);
		dao.rsvt_cancel(idx);
		return "redirect:/mypage_rsvt.do";
	};
	

	//회원정보

	@RequestMapping("/mypageuser.do")
	public ModelAndView mypageuser(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberDTO mto = new MemberDTO();
		String u_id = session.getAttribute("checked").toString();
			mto = dao.mypageselect(u_id);
			mav.addObject("mto", mto);
			mav.setViewName("/mypage/mypageuser");
		return mav;
	}//end
	
	@RequestMapping("/useredit.do")
	public ModelAndView useredit(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		MemberDTO mto = dao.useredit(u_id);
		mav.addObject("mto", mto);
		mav.setViewName("/mypage/useredit");
		return mav;
	}//end
	
	
	@RequestMapping("/usereditsave.do")
	public String usereditsave(MemberDTO mto) {
		  String path=application.getRealPath("/resources/upload");
		  System.out.println(path);
		  MultipartFile mf=mto.getUpload_img(); 
		  String img=mf.getOriginalFilename();
		  
		  File file=new File(path, img);
		  try{
			  FileCopyUtils.copy(mto.getUpload_img().getBytes(), file);
		  }catch(Exception ex){ }
		  mto.setU_img(img);		  
		dao.usereditsave(mto);
		return "redirect:mypageuser.do";
	}//end
	
	@RequestMapping("/mypageDelete.do")
	public ModelAndView mypage_delete(HttpSession session) {
		String u_id = session.getAttribute("checked").toString();
		String u_pwd = dao.mypageDelete(u_id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("u_pwd", u_pwd);
		mav.setViewName("mypage/mypageDelete");

		return mav;
	}// end
	
	@RequestMapping("m_delete.do")
	public String m_delete(HttpSession session, MemberDTO mto) {
		mto.setU_id(session.getAttribute("checked").toString());
		dao.m_delete(mto);
		session.invalidate(); //占쏙옙占실삼옙占쏙옙
		
		return "redirect:main.do";
	}//end

}
