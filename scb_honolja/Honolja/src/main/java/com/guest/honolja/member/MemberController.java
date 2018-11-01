package com.guest.honolja.member;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
public class MemberController {

	@Autowired
	MemberDAO dao;
	@Autowired
	ServletContext application;
	@Autowired
	HttpSession session;
	@Inject
	JavaMailSender mailSender;
	

	public static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("/m_agree.do")
	public String agree() {
		return "member/agree";
	}//end
	
	@RequestMapping(value = "/m_join.do", method = RequestMethod.GET)
	public String member(Locale locale, Model model) {
		return "member/join";
	}// end

	//회원가입
	@RequestMapping("/m_insert.do")
	public String member_insert(MemberDTO mto) throws Exception {
		int month = Integer.parseInt(mto.getMonth());
		String month1 = "";
		if(month < 10) {
			month1 = "0" + month;
		}else {
			month1 = "" + month;
		}
		mto.setU_birth(mto.getYear() + month1 + mto.getDay());
		mto.setU_guestjuso(mto.u_guestjuso + " " + mto.u_guestjuso1);
		String path = "C:\\Users\\bit-user\\git\\Honolja\\Honolja\\src\\main\\webapp\\image\\";
		MultipartFile mf = mto.getUpload_img();
		String img = mf.getOriginalFilename();
		
		if(img.equals("") || img == null) {
			if(mto.getU_gender().equals("남자")) {
				img = "boy.jpg"; 
			}else if(mto.getU_gender().equals("여자")) {
				img = "girl.jpg";
			}
		}//if end
		
		img = URLEncoder.encode(img, "UTF-8");
		File file = new File(path, img);
		mto.setU_imgpath(path+img);

		try {
			mto.getUpload_img().transferTo(file);
		} catch (Exception ex) {
		}
		mto.setU_img(img);

		dao.m_insert(mto);
		dao.m_emailfalse(mto); //이메일 인증 안했을 시 false
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[Honolja 회원가입 이메일 인증입니다]");
		sendMail.setText(new StringBuffer().append("<h1>Honolja 회원가입 이메일 인증입니다</h1>").append("<h2><a href='http://localhost:8080/honolja/emailcheck.do?u_id="+mto.getU_id()).append("' target='_blenk'>인증하기</a></h2>").toString());
		sendMail.setFrom("aa01088921067@gmail.com", "Honolja");
		sendMail.setTo(mto.getU_email());
		sendMail.send();
		return "redirect:main.do";
	}// end
	
	//이메일체크
	@RequestMapping(value="/emailcheck.do", method = RequestMethod.GET)
	public String m_emailcheck(HttpServletRequest request, Model model) throws Exception {
		String u_id = request.getParameter("u_id");
		dao.m_Auth(u_id);
		return "redirect:main.do";
	}//end

	//회원목록
	@RequestMapping("/m_list.do")
	public ModelAndView member_list(HttpServletRequest request) {
		String u_member = request.getParameter("u_member");
		if(u_member == null) {
			u_member = "";
		}
		System.out.println("u_member = " + u_member);
		MemberDTO mto = new MemberDTO();
		mto.setU_member(u_member);
		
		int pageNUM=1, pagecount=1;
		int start=1, end=1, temp=1, startpage=1, endpage=1;
		String pnum="", returnpage="";
		String skey="", sval="";
		skey = request.getParameter("keyfield");
		sval = request.getParameter("keyword");
	
		if( skey == null || skey.equals("") || sval == null || sval.equals("")) {
			skey = "u_id";
			sval = "";
		}
		
		returnpage="&keyfield="+skey+"&keyword="+sval;		
		
		pnum=request.getParameter("pageNum");
		if(pnum == null || pnum == "") { pageNUM=1;	}
		else { pageNUM=Integer.parseInt(pnum); }
		
		mto.setSkey(skey);
		mto.setSval(sval);

		int cnt = dao.m_count(mto);
		
		if(cnt%10 == 0 ) { pagecount=cnt; }
		else { pagecount = (cnt/10)+1; }
		
		start=((pageNUM-1)*10)+1;
		end=pageNUM*10;
		
		temp=(pageNUM-1)%10;
		startpage=pageNUM - temp;
		endpage=startpage+9; 
		if(endpage > pagecount) { endpage=pagecount; }
		
		mto.setStart(start);
		mto.setEnd(end);

		List<MemberDTO> list = dao.m_select(mto);
		String success = "success";
		ModelAndView mav = new ModelAndView();
		if(u_member.equals("")) {
			u_member = "전체";
		}
		mav.addObject("u_member", u_member);
		mav.addObject("success", success);
		mav.addObject("cnt", cnt);
		mav.addObject("list", list);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("pagecount", pagecount);
		mav.addObject("pageNUM", pageNUM);
		mav.setViewName("member/memberList");
		return mav;
	}// end

	//회원상세
	@RequestMapping("/m_detail.do")
	public ModelAndView member_detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int data = Integer.parseInt(request.getParameter("idx"));
		MemberDTO mto = dao.m_detail(data);

		mav.addObject("mto", mto);
		mav.setViewName("member/memberDetail");
		return mav;
	}// end

	//로그인
	@RequestMapping("/m_login.do")
	public String m_login() {
		return "member/m_login";
	}// end

	//아이디 중복체크
	@ResponseBody
	@RequestMapping("/idcheck.do")
	public String idcheck(@RequestBody String u_id) {
		int u_cnt = dao.idCheck(u_id);
		String retVal = "";
		
		if(u_cnt > 0) { retVal = "true"; }
		else { retVal = "false"; }
		
		return retVal;
	}//end
	
	@RequestMapping("/findID.do")
	public String findID() {
		return "member/findID";
	}//end
	
	//아이디찾기
	@ResponseBody
	@RequestMapping("/findingID.do")
	public String findingID(MemberDTO mto) {
		ModelAndView mav = new ModelAndView();
		String u_id = dao.findingID(mto);
		return u_id;
	}//end
	
	
	@RequestMapping("/findPW.do")
	public String findPW() {
		return "member/findPW";		
	}//end
	
	//비밀번호 찾기 - 1.아이디입력(체크)
	@ResponseBody
	@RequestMapping("/findPWid.do/{u_id}")
	public String findPWid(@PathVariable("u_id") String u_id) {
		/*u_id = u_id.substring(0, u_id.length()-1);*/
		String u_name = dao.findPWid(u_id);
		return u_name;
	}//end
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("/findingPW.do")
	public String findingPW(MemberDTO mto)throws Exception {
		String result = "true";
		String key = new TempKey().getKey(10, false); //비밀번호 찾기 키값
		mto.setU_emailkey(key);
		dao.findingPW(mto);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[Honolja 이메일 인증 입니다.]");
		sendMail.setText(new StringBuffer().append("<h1>비밀번호 찾기 인증</h1><br><h3> 인증코드 : "+key+"</h3>").toString());
		sendMail.setFrom("aa01088921067@gmail.com", "Honolja");
		sendMail.setTo(mto.getU_email());
		sendMail.send();
		return result;
	}//end
	
	//비밀번호 찾기 - 인증코드 체크
	@ResponseBody
	@RequestMapping("/emailkeyCheck.do")
	public String emailkeyCheck(MemberDTO mto) {
		String u_id = dao.emailkeyCheck(mto);
		return u_id;
	}//end
	
	//비밀번호 재설정
	@ResponseBody
	@RequestMapping("/pwdupdate.do")
	public String pwdupdate(MemberDTO mto) {
		String result = "";
		dao.pwdupdate(mto);
		result = "true";
		return result;
	}//end
	
	/*//회원관리 점주, 회원, 관리자 구분
	@ResponseBody
	@RequestMapping("/selectbox.do")
	public String selectbox(@RequestBody String member) {
		String result = null;
		dao.selectbox
		
		return result;
	}
	*/
}//MemberController Class END
