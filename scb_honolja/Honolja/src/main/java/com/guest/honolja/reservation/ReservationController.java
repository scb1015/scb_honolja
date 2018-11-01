package com.guest.honolja.reservation;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.guest.honolja.detail.DetailDAO;
import com.guest.honolja.detail.DetailDTO;
import com.guest.honolja.main.MainController;
import com.guest.honolja.review.ReviewDAO;

@Controller
public class ReservationController {
 

	@Autowired
	ReservationDAO dao;
	@Autowired
	DetailDAO dao1;
	@Autowired
	ReviewDAO dao2;

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/reservationPre.do")
	@ResponseBody
	public ModelAndView guest_room(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int r_no = Integer.parseInt(request.getParameter("r_no"));
		String adult = request.getParameter("adult");
		String child = request.getParameter("child");
		String check_in = request.getParameter("check_in");
		String check_out = request.getParameter("check_out");
		String nights = request.getParameter("nights");
		DetailDTO dto = new DetailDTO();
		dto.setR_no(r_no);
		DetailDTO room = dao.dbres(dto);
		mav.addObject("g_no", dto.getG_no());
		mav.addObject("list", room);
		mav.addObject("adult", adult);
		mav.addObject("child", child);
		mav.addObject("check_in", check_in);
		mav.addObject("check_out", check_out);
		mav.addObject("nights", nights);
		mav.setViewName("/detail/reservation");
		return mav;
	}

	@RequestMapping("/reservationCheck.do")
	@ResponseBody
	public String resCheck(DetailDTO dto) {
		int res_people = Integer.parseInt(dto.getAdult()) + Integer.parseInt(dto.getChild());

		String result = "true";

		DetailDTO room = dao.dbres(dto);
		List<DetailDTO> res = dao.dbresSelect(dto);

		for (int i = 0; i < res.size(); i++) {
			if (res.get(i).getR_no() == room.getR_no()) {

				if (res_people < (room.getR_people() - res.get(i).getRes_people())) {
					result = "true";
				} else {
					result = "fault";
				}
			}
		}

		return result;
	}

	@RequestMapping("/reservationAdd.do")
	@ResponseBody
	public String resAdd(DetailDTO dto) {
		int res_people = Integer.parseInt(dto.getAdult()) + Integer.parseInt(dto.getChild());
		dto.setRes_people(res_people);
		dto.setRes_ok('y');
		dto.setG_no(dto.getG_no());
		dto.setCheck_in(dto.getCheck_in());
		dto.setCheck_out(dto.getCheck_out());
		dao.dbresAdd(dto);
		return "success";
	}
}
