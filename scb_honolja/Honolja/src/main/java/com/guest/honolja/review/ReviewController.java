package com.guest.honolja.review;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.guest.honolja.main.MainController;

@Controller
public class ReviewController {

	@Autowired
	ReviewDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/review.do")
	@ResponseBody
	public ModelAndView guest_review(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		List<ReviewDTO> review = dao.dbreviewSelect(dto.getG_no());
		int rcnt = dao.dbreviewCount(dto.getG_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("rcnt", rcnt);
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReview");
		return mav;
	}

	@RequestMapping("/reviewAdd.do")
	@ResponseBody
	public ModelAndView guest_reviewAdd(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		dao.dbreivewAdd(dto);
		List<ReviewDTO> review = dao.dbreviewSelect(dto.getG_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReview");
		return mav;
	}

	@RequestMapping("/reviewDel.do")
	@ResponseBody
	public ModelAndView guest_reviewDel(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		dao.dbreviewDel(dto.getRe_no());
		List<ReviewDTO> review = dao.dbreviewSelect(dto.getG_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReview");
		return mav;
	}

	@RequestMapping("/reviewPremod.do")
	@ResponseBody
	public ModelAndView guest_reviewPremod(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		ReviewDTO review = dao.dbreviewPremodify(dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReviewModify");
		return mav;
	}

	@RequestMapping("/reviewModify.do")
	@ResponseBody
	public ModelAndView guest_reviewMod(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		dao.dbreviewModify(dto);
		List<ReviewDTO> review = dao.dbreviewSelect(dto.getG_no());
		mav.addObject("re_no", dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReview");
		return mav;
	}

	@RequestMapping("/answer.do")
	@ResponseBody
	public ModelAndView guest_answer(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		ReviewDTO answer = dao.dbanswerView(dto.getRe_no());
		mav.addObject("re_no", dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("answer", answer);
		mav.setViewName("/detail/reviewAnswerView");
		return mav;
	}

	@RequestMapping("/answerPreAdd.do")
	@ResponseBody
	public ModelAndView guest_answerPreAdd(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("re_no", dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.setViewName("/detail/reviewAnswerAdd");
		return mav;
	}

	@RequestMapping("/answerAdd.do")
	@ResponseBody
	public ModelAndView guest_answerAdd(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		dto.setU_guestname("게스트하우스");
		dao.dbanswerAdd(dto);
		ReviewDTO answer = dao.dbanswerView(dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("answer", answer);
		mav.setViewName("/detail/reviewAnswerView");
		return mav;
	}

	@RequestMapping("/answerDel.do")
	@ResponseBody
	public ModelAndView guest_answerDel(ReviewDTO dto) {
		ModelAndView mav = new ModelAndView();
		dao.dbanswerDel(dto.getRe_no());
		List<ReviewDTO> review = dao.dbreviewSelect(dto.getG_no());
		mav.addObject("re_no", dto.getRe_no());
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("review", review);
		mav.setViewName("/detail/guestReview");
		return mav;
	}
}