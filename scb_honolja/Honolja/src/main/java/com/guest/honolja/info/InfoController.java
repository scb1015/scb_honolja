package com.guest.honolja.info;

import java.util.List;
import java.util.UUID;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InfoController {

	private static final Logger logger = LoggerFactory.getLogger(InfoController.class);

	@Autowired
	InfoDAO dao;

	@Autowired
	ServletContext application;

	@RequestMapping("/img_board.do")
	public ModelAndView info_img_board(HttpServletRequest request) {

		int page = 1;

		// Print list every 10 lines according to page_num
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int list_start = 1 + 10 * (page - 1);
		int list_end = list_start + 9;

		// Get the search key&value from view
		String skey = request.getParameter("skey");
		String sval = request.getParameter("sval");

		InfoDTO dto = new InfoDTO();
		dto.setList_start(list_start);
		dto.setList_end(list_end);
		dto.setSkey(skey);
		dto.setSval(sval);

		// Get the list from DB
		List<InfoDTO> list = dao.dbSelectImgBoard(dto);

		System.out.println(list.get(0).getReply_cnt());

		// Print page_button according to page_num
		int page_btn_start = page - (page - 1) % 10;
		int page_btn_end = page_btn_start + 9;

		// Get the total count
		int total_page = dao.dbCountImgBoard(dto);

		boolean page_end_flag = true;

		if (total_page % 10 == 0) {
			if (page_btn_end > total_page / 10) {
				page_btn_end = total_page / 10;
				page_end_flag = false;
			} else {
				page_end_flag = true;
			}
		} else {
			if (page_btn_end > total_page / 10 + 1) {
				page_btn_end = total_page / 10 + 1;
				page_end_flag = false;
			} else {
				page_end_flag = true;
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/img_board");
		mav.addObject("img_board", "class='active'");
		mav.addObject("list", list); // out image board list
		mav.addObject("page", page); // for pager button clicked
		mav.addObject("page_btn_start", page_btn_start);
		mav.addObject("page_btn_end", page_btn_end);
		mav.addObject("total_page", total_page);
		mav.addObject("page_end_flag", page_end_flag);

		return mav;
	}

	@RequestMapping("/img_board_detail.do")
	public ModelAndView info_img_board_detail(HttpServletRequest request) {

		String u_id = "";

		if (request.getSession().getAttribute("checked") != null) {
			u_id = request.getSession().getAttribute("checked").toString();
		}

		int i_no = 0;

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		// get data from 'img_board' table
		InfoDTO dto = dao.dbSelectImgBoardDetail(i_no);

		// increase viewcnt value
		int i_viewcnt = dto.getI_viewcnt();
		i_viewcnt += 1;

		InfoDTO dto2 = new InfoDTO();
		dto2.setI_no(i_no);
		dto2.setI_viewcnt(i_viewcnt);
		dto2.setU_id(u_id);

		dao.dbUpdateImgBoardViewCnt(dto2);

		// send info of clicked like_btn or not.
		InfoDTO likeCheck = dao.dbSelectImgBoardLike(dto2);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/img_board_detail");
		mav.addObject("img_board", "class='active'");
		mav.addObject("dto", dto);
		mav.addObject("likeCheck", likeCheck);
		mav.addObject("u_id", u_id);

		return mav;
	}

	@RequestMapping("/img_board_write.do")
	public ModelAndView info_img_board_write(HttpServletRequest request) {

		String u_id = "";

		if (request.getSession().getAttribute("checked") != null) {
			u_id = request.getSession().getAttribute("checked").toString();
		}

		int i_no = 0;
		InfoDTO dto = new InfoDTO();

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
			dto = dao.dbSelectImgBoardDetail(i_no);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/img_board_write");
		mav.addObject("img_board", "class='active'");
		mav.addObject("dto", dto);
		mav.addObject("u_id", u_id);

		return mav;
	}

	@RequestMapping("/img_board_write_backend.do")
	public ModelAndView info_img_board_write_backend(MultipartHttpServletRequest request) {

		String i_title = request.getParameter("title");
		String i_content = request.getParameter("content");
		String u_id = request.getParameter("id");
		String i_youtube = request.getParameter("youtube");
		MultipartFile mf = request.getFile("upload_f");

		System.out.println("mf: !!!!dddddfdf!!!!" + mf.getOriginalFilename());

		InfoDTO dto = new InfoDTO();
		dto.setI_title(i_title);
		dto.setI_content(i_content);
		dto.setU_id(u_id);
		dto.setI_youtube(i_youtube);
		// start to save file

		// set save_path
		String path = application.getRealPath("/resources/info_images");
		System.out.println("application.getRealPath : " + path);

		// set uploadFileName
		UUID random_path = UUID.randomUUID();
		System.out.println("random_path : " + random_path.toString());

		String i_originalFilename = mf.getOriginalFilename();
		System.out.println("i_originalFilename : " + i_originalFilename);
		dto.setI_originalFileName(i_originalFilename);

		String i_uploadFileName = random_path + "_" + i_originalFilename;
		System.out.println("i_uploadFileName : " + i_uploadFileName);
		dto.setI_uploadFileName(i_uploadFileName);

		// get file_size
		String i_fileSize = String.valueOf(mf.getSize()) + "byte";
		System.out.println("i_fileSizee : " + i_fileSize);
		dto.setI_fileSize(i_fileSize);

		// set File
		File file = new File(path, i_uploadFileName);

		// try to save file
		try {
			mf.transferTo(file); // 변환 시도
		} catch (Exception e) {
		}

		dao.dbInsertImgBoard(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board.do");

		return mav;
	}

	@RequestMapping("/img_board_update_backend.do")
	public ModelAndView info_img_board_update_backend(MultipartHttpServletRequest request) {

		String i_title = request.getParameter("title");
		String i_content = request.getParameter("content");
		String u_id = request.getParameter("id");
		MultipartFile mf = request.getFile("upload_f");

		int i_no = 0;

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		InfoDTO dto = new InfoDTO();
		dto.setI_no(i_no);
		dto.setI_title(i_title);
		dto.setI_content(i_content);

		if (mf != null) {
			// set save_path
			String path = application.getRealPath("/resources/info_images");
			System.out.println("application.getRealPath : " + path);

			// set uploadFileName
			UUID random_path = UUID.randomUUID();
			System.out.println("random_path : " + random_path.toString());

			String i_originalFileName = mf.getOriginalFilename();
			System.out.println("i_originalFilename : " + i_originalFileName);
			dto.setI_originalFileName(i_originalFileName);

			String i_uploadFileName = random_path + "_" + i_originalFileName;
			System.out.println("i_uploadFileName : " + i_uploadFileName);
			dto.setI_uploadFileName(i_uploadFileName);

			// get file_size
			String i_fileSize = String.valueOf(mf.getSize()) + "byte";
			System.out.println("i_fileSizee : " + i_fileSize);
			dto.setI_fileSize(i_fileSize);

			// set File
			File file = new File(path, i_uploadFileName);

			// try to save file
			try {
				mf.transferTo(file); // 변환 시도
			} catch (Exception e) {
			}
		}

		dao.dbUpdateImgBoardDetail(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_detail.do?i_no=" + i_no);

		return mav;
	}

	@RequestMapping("/img_board_delete_backend.do")
	public ModelAndView info_img_board_delete_backend(HttpServletRequest request) {
		int i_no = 0;

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		dao.dbDeleteImgBoard(i_no);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board.do");

		return mav;
	}

	@RequestMapping("/img_board_detail_download.do")
	public ModelAndView info_img_board_detail_download(HttpServletRequest request, HttpServletResponse response) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		String path = application.getRealPath("/resources/info_images");

		InfoDTO dto = dao.dbSelectImgBoardDetail(i_no);

		String i_uploadFileName = dto.getI_uploadFileName();

		try {
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String(i_uploadFileName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		File file = new File(path, i_uploadFileName);

		InputStream is = null;
		OutputStream os = null;
		byte[] b = null;

		try {
			is = new FileInputStream(file);
			os = response.getOutputStream();
			b = new byte[(int) file.length()];

			is.read(b, 0, b.length);
			os.write(b);

			is.close();
			os.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_detail.do?i_no=" + i_no);

		return mav;
	}

	boolean btn_flag = true;

	@RequestMapping("/like_btn.do")
	public ModelAndView img_board_detail_like_btn(HttpServletRequest request) {

		int i_no = 0;

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		String u_id = request.getParameter("u_id");
		String btn_flag = request.getParameter("btn_flag");

		// get star_cnt from DB
		InfoDTO dto = dao.dbSelectImgBoardDetail(i_no);
		int i_starcnt = dto.getI_starcnt();

		InfoDTO dto3 = new InfoDTO();
		dto3.setU_id(u_id);
		dto3.setI_no(i_no);
		dto3.setIl_like("none");

		// if user has clicked like_btn for the first time, then insert table
		if (dao.dbSelectImgBoardLikeCheck(dto3) == 0) {
			dao.dbInsertImgBoardLike(dto3);
		}

		if (btn_flag.equals("like")) {
			i_starcnt += 1;
			dto3.setIl_like("like");
			dao.dbUpdateImgBoardLike(dto3);
		} else if (btn_flag.equals("unlike")) {
			i_starcnt -= 2;
			dto3.setIl_like("unlike");
			dao.dbUpdateImgBoardLike(dto3);
		} else {
			i_starcnt += 1;
			dto3.setIl_like("none");
			dao.dbUpdateImgBoardLike(dto3);
		}

		InfoDTO dto2 = new InfoDTO();
		dto2.setI_no(i_no);
		dto2.setI_starcnt(i_starcnt);

		dao.dbUpdateImgBoardStarCnt(dto2);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/ajax_like_btn");

		return mav;
	}

	@RequestMapping("/img_board_reply.do")
	public ModelAndView img_board_reply(HttpServletRequest request) {

		int i_no = 0;

		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		String checked = request.getParameter("checked");

		List<InfoDTO> list = dao.dbSelectImgReply(i_no);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/ajax_img_reply");
		mav.addObject("list", list);
		mav.addObject("checked", checked);

		return mav;
	}

	@RequestMapping("/img_reply_insert.do")
	public ModelAndView img_reply_insert(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		String u_id = request.getParameter("u_id");
		String ir_content = request.getParameter("ir_content");

		InfoDTO dto = new InfoDTO();
		dto.setI_no(i_no);
		dto.setU_id(u_id);
		dto.setIr_content(ir_content);

		dao.dbInsertImgReply(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);

		return mav;
	}

	@RequestMapping("/img_reply_update.do")
	public ModelAndView img_reply_update(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		int ir_no = 0;
		if (request.getParameter("ir_no") != null) {
			ir_no = Integer.parseInt(request.getParameter("ir_no"));
		}

		String ir_content = request.getParameter("ir_content");

		InfoDTO dto = new InfoDTO();
		dto.setIr_no(ir_no);
		dto.setIr_content(ir_content);

		dao.dbUpdateImgReply(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);

		return mav;
	}

	@RequestMapping("/img_reply_delete.do")
	public ModelAndView img_reply_delete(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		int ir_no = 0;
		if (request.getParameter("ir_no") != null) {
			ir_no = Integer.parseInt(request.getParameter("ir_no"));
		}

		String checked = request.getParameter("checked");

		dao.dbDeleteImgReply(ir_no);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);
		mav.addObject("checked", checked);

		return mav;
	}

	@RequestMapping("/img_reply_of_reply.do")
	public ModelAndView img_reply_of_reply_select(HttpServletRequest request) {

		int ir_no = 0;
		if (request.getParameter("ir_no") != null) {
			ir_no = Integer.parseInt(request.getParameter("ir_no"));
		}

		String checked = request.getParameter("checked");

		List<InfoDTO> list_rr = dao.dbSelectImgReplyOfReply(ir_no);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/info/img_reply_of_reply");
		mav.addObject("list_rr", list_rr);
		mav.addObject("checked", checked);

		return mav;
	}

	@RequestMapping("/insert_ror.do")
	public ModelAndView insert_ror(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		int ir_no = 0;
		if (request.getParameter("ir_no") != null) {
			ir_no = Integer.parseInt(request.getParameter("ir_no"));
		}

		String u_id = request.getSession().getAttribute("checked").toString();
		String irr_content = request.getParameter("irr_content");

		InfoDTO dto = new InfoDTO();
		dto.setU_id(u_id);
		dto.setIrr_content(irr_content);
		dto.setIr_no(ir_no);

		dao.dbInsertImgReplyOfReply(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);

		return mav;
	}

	@RequestMapping("/update_ror.do")
	public ModelAndView update_ror(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		int irr_no = 0;
		if (request.getParameter("irr_no") != null) {
			irr_no = Integer.parseInt(request.getParameter("irr_no"));
		}

		String irr_content = request.getParameter("irr_content");

		InfoDTO dto = new InfoDTO();
		dto.setI_no(i_no);
		dto.setIrr_no(irr_no);
		dto.setIrr_content(irr_content);

		dao.dbUpdateImgReplyOfReply(dto);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);

		return mav;
	}

	@RequestMapping("/delete_ror.do")
	public ModelAndView delete_ror(HttpServletRequest request) {

		int i_no = 0;
		if (request.getParameter("i_no") != null) {
			i_no = Integer.parseInt(request.getParameter("i_no"));
		}

		int irr_no = 0;
		if (request.getParameter("irr_no") != null) {
			irr_no = Integer.parseInt(request.getParameter("irr_no"));
		}

		System.out.println("i_no : " + i_no);
		System.out.println("irr_no : " + irr_no);

		dao.dbDeleteImgReplyOfReply(irr_no);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/img_board_reply.do?i_no=" + i_no);

		return mav;
	}

}
