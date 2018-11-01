package com.guest.honolja.board;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.guest.honolja.notice.NoticeDAO;
import com.guest.honolja.notice.NoticeDTO;

@Controller
public class BoardController {
	
	@Autowired
	@Inject
	BoardDAO dao;

	@Autowired
	NoticeDAO dao2;
	
	@Autowired
	ServletContext application;
	
	@RequestMapping("/board.do")	 //게시판 리스트
	public ModelAndView board_list(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView();
		String returnpage="";
		int pageNUM=1, pagecount=1; 
		int start=1,end=1,startpage=1,endpage=1,temp=1;
		String pnum="";
		String skey="",sval="";
		
		skey=request.getParameter("keyfield");
		sval=request.getParameter("keyword");
		
		if(skey==null||skey=="" || sval==null||sval=="") {
			skey="b_title"; sval="";
		}
		returnpage="&keyfield="+skey+"&keyword=" +sval;
		
		pnum=request.getParameter("pageNum");
		if(pnum==null || pnum=="") {pnum="1";} //비어있으면1p
		else{pageNUM=Integer.parseInt(pnum);}

		start=((pageNUM-1)*7)+1; //if(5 -> 41
		end=pageNUM*7;              //~50
		temp=(pageNUM-1)%7;    //if 5 == temp===4
		startpage=pageNUM-temp;    //1페이지
		endpage=startpage+6;         //10페이지
		
		
		int Gtotal=dao.dbCount(skey,sval);//카운트-전체값

		if(Gtotal%10==0) { pagecount=Gtotal/10; }
		else{pagecount=(Gtotal/10)+1;}
		
		if(endpage>pagecount) {endpage=pagecount;}
		
		List<BoardDTO> LB=dao.dbSelect(start,end,skey,sval);
		
		System.out.println(start);
		System.out.println(end);
		System.out.println(skey);
		System.out.println(sval);
		
		List<NoticeDTO> nto=dao2.dbsel();
		System.out.println("test");
		//List<NoticeDTO> nto=dao.dbsel();
		
		mav.addObject("list",nto);
		mav.addObject("pagecount",pagecount);
		mav.addObject("LB",LB);
		mav.addObject("Gtotal", Gtotal);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("pageNUM", pageNUM);
		mav.addObject("sval",sval);
		mav.addObject("skey",skey);
		mav.addObject("returnpage",returnpage);
		mav.setViewName("/board/board");
		return mav;
	}//board_list end

	@RequestMapping("/boardwrite.do") //게시글 작성 JSP
	public ModelAndView board_write(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		BoardDTO dto=new BoardDTO();
		String u_id = (String)session.getAttribute("checked");
		dto.setU_id(u_id);
		mav.addObject("dto",dto);
		mav.setViewName("/board/boardwrite");
		return mav;
	}
	
	@RequestMapping("/boardinsert.do")	//게시글 Insert
	public String board_insert(BoardDTO dto,HttpSession session)  throws Exception { 
		String u_id = (String)session.getAttribute("checked");
		dto.setU_id(u_id);
	long size=dto.getB_uploadfilename2().getSize();
		String path=application.getRealPath("/resources/bupload"); //경로지정
		System.out.println(path); //경로출력
		MultipartFile mf= dto.getB_uploadfilename2(); //mf=upload 파일
		String img=mf.getOriginalFilename(); //진짜이름 -> img에
		
		URLEncoder.encode(img,"UTF-8"); //한글화
		File file=new File(path,img);
		try {
			dto.getB_uploadfilename2().transferTo(file);
		} catch (Exception e) {e.printStackTrace(); }
		dto.setB_originalfilename(img);
		dao.dbInsert(dto);
		int num=dao.dbSelect();
		System.out.println("zzzzzzzzzzz"+ num);
		return "redirect:/boarddetail.do?idx=" +num;
	}//board_insert end
	
	@RequestMapping("/boarddetail.do")	//게시글 상세정보
	public ModelAndView board_detail(@RequestParam("idx") int b_no, HttpSession session) throws Exception {
		ModelAndView mav=new ModelAndView();
		dao.dbViewCnt(b_no); //정보 클릭하면 조회수 +1
		BoardDTO dto=dao.dbDetail(b_no);
		
		if(dto.getB_originalfilename() != null) {
			System.out.println(dto.getB_originalfilename());
		    mav.addObject("img", URLEncoder.encode(dto.getB_originalfilename(),"UTF-8"));
		    System.out.println(dto.getB_uploadfilename());
		}
		mav.addObject("dto",dto);
		mav.setViewName("/board/boarddetail");
		return mav;
	}
	
	@RequestMapping("/boardedit.do") //게시글 수정 JSP
	public ModelAndView board_edit(@RequestParam("idx") int b_no) throws Exception {
		ModelAndView mav=new ModelAndView();
		BoardDTO dto=dao.dbDetail(b_no);
		
		if(dto.getB_originalfilename() != null) {
			System.out.println(dto.getB_originalfilename());
		    mav.addObject("img", URLEncoder.encode(dto.getB_originalfilename(),"UTF-8"));
		    System.out.println(dto.getB_uploadfilename());
		}
		
		mav.addObject("dto",dto);
		mav.setViewName("board/boardedit");
		return mav;
	}
	
	@RequestMapping("/boardupdate.do") //게시글 Update
	public String board_update(BoardDTO dto) throws Exception {
		String path=application.getRealPath("/resources/bupload"); //경로지정
		System.out.println(path); //경로출력
		MultipartFile mf= dto.getB_uploadfilename2(); //mf=upload 파일
		String img=mf.getOriginalFilename(); //진짜이름 -> img에
		
		URLEncoder.encode(img,"UTF-8"); //한글화
		File file=new File(path,img);
		try {
			dto.getB_uploadfilename2().transferTo(file);
		} catch (Exception e) {e.printStackTrace(); }
		dto.setB_originalfilename(img);
		
		dao.dbUpdate(dto);
	return "redirect:/boarddetail.do?idx="+dto.getB_no();
	}
	
	@RequestMapping("/boarddelete.do") //게시글 삭제
	public String board_delete(@RequestParam("idx") int b_no) {
		System.out.println("b_no=" + b_no);
		dao.dbDelete(b_no);
		return "redirect:/board.do";
	}
	
	//댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@RequestMapping("/boardreply.do") //댓글 리스트
	public ModelAndView board_reply(@RequestParam("idx") int b_no, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		BoardDTO dto=new BoardDTO();
		String u_id=(String) session.getAttribute("checked");
		dto.setU_id(u_id);
		System.out.println(b_no);
		List<BoardDTO> Rlist = dao.dbRSelectReply(b_no);
		int rcnt=dao.dbRCount(b_no);
		
		mav.addObject("rcnt", rcnt);
		mav.addObject("Rlist", Rlist);
		mav.setViewName("board/boardreply");
		return mav;
	}			
	
	@RequestMapping("/boardreplyinsert.do") //댓글 Insert
	public String board_replyinsert(BoardDTO dto,HttpSession session) {
		String u_id=(String) session.getAttribute("checked");
		dto.setU_id(u_id);
		
		dao.dbRInsert(dto);
		return "redirect:/boarddetail.do?idx="+dto.getB_no(); 
	}
	
	@ResponseBody
	@RequestMapping("/boardreplyedit.do") //댓글 수정 JSP
	public ModelAndView board_replyedit(BoardDTO dto, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		dto.setU_id(u_id);
		dto=dao.dbRDetail(dto);
		mav.addObject("dto",dto);
		mav.setViewName("board/boardreplyedit");
		return mav;
	}//end
	
	@RequestMapping("boardreplyupdate.do") //댓글 Update
	public String board_replyupdate(BoardDTO dto) {
		System.out.println("b_no = " + dto.getB_no());
		System.out.println("br_no = " + dto.getBr_no());
		dao.dbRUpdate(dto);
		return "redirect:/boarddetail.do?idx=" +dto.getB_no();
	}
	
	@ResponseBody
	@RequestMapping("/boardreplydelete.do") //댓글 Delete
	public String board_replydelete(BoardDTO dto) {
		dao.dbRDelete(dto);
		return "true";
	}
	//대댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@RequestMapping("/boardrreply.do")	 //대댓글 List
	public ModelAndView board_replyreplywrite(@RequestParam("br_no") int br_no, @RequestParam("idx") int b_no,HttpSession session) {
	System.out.println("실행");
		
		BoardDTO dto=new BoardDTO();
		ModelAndView mav = new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		dto.setU_id(u_id);
		System.out.println(br_no);
		System.out.println(b_no);
		
		List<BoardDTO> RRlist = dao.dbRRSelect(br_no);
		mav.addObject("b_no", b_no);
		mav.addObject("RRlist", RRlist);
		mav.setViewName("/board/boardreplyreplylist");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/boardrreplyinsertForm.do") //대댓글 쓰는 Form
	public ModelAndView board_rreplyinsertForm(BoardDTO dto, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();	
		System.out.println("b_no = " + dto.getB_no());
		System.out.println("br_no = " + dto.getBr_no());
		
		mav.addObject("b_no", dto.getB_no());
		mav.addObject("br_no", dto.getBr_no());
		mav.setViewName("/board/boardreplyreplywrite");
		return mav;
	}
	
	@RequestMapping("/boardrreplyinsert.do") //대댓글 Insert
	public String board_rreplyinsert(BoardDTO dto, HttpSession session) {
		String u_id = (String)session.getAttribute("checked");
		dto.setU_id(u_id);
		dao.dbRRInsert(dto);
		
		return "redirect:/boarddetail.do?idx=" +dto.getB_no();
	}
	
	@ResponseBody
	@RequestMapping("/boardrreplyedit.do") //대댓글 수정 JSP
	public ModelAndView board_rreplyedit(BoardDTO dto, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		String u_id = (String)session.getAttribute("checked");
		int b_no=dto.getB_no();
		dto.setU_id(u_id);
		
		dto=dao.dbRRDetail(dto);
		
		System.out.println("대댓글 수정 jsp = b_no =" + dto.getB_no());
		System.out.println("대댓글 수정 jsp = br_no =" + dto.getBr_no());
		System.out.println("대댓글 수정 jsp = brr_no =" + dto.getBrr_no());
		mav.addObject("dto",dto);
		mav.addObject("b_no",b_no);
		mav.setViewName("board/boardrreplyedit");
		return mav;
	}//end
	
	@RequestMapping("boardrreplyupdate.do") //대댓글 Update
	public String board_rreplyupdate(BoardDTO dto) {
		System.out.println("b_no = " + dto.getB_no());
		System.out.println("br_no = " + dto.getBr_no());
		dao.dbRRUpdate(dto);
		return "redirect:/boarddetail.do?idx=" +dto.getB_no();
	}

	@ResponseBody
	@RequestMapping("/boardrreplydelete.do") //대댓글 Delete
	public String board_rreplydelete(BoardDTO dto) {
		dao.dbRRDelete(dto);
	return "true";  
	}
}//class end