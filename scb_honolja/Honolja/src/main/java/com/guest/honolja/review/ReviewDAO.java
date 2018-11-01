package com.guest.honolja.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class ReviewDAO {

	@Autowired
	SqlSessionTemplate temp;

	public List<ReviewDTO> dbreviewSelect(int g_no) {
		List<ReviewDTO> list = temp.selectList("review.select", g_no);
		return list;
	}

	public ReviewDTO dbanswerView(int re_no) {
		ReviewDTO dto = temp.selectOne("review.answerView", re_no);
		return dto;
	}

	public void dbreivewAdd(ReviewDTO dto) {
		temp.insert("review.add", dto);
	}

	public void dbanswerAdd(ReviewDTO dto) {
		temp.insert("review.answerAdd", dto);
	}

	public int dbreviewCount(int g_no) {
		int count = temp.selectOne("review.countAll", g_no);
		return count;
	}

	public ReviewDTO dbreviewPremodify(int re_no) {
		ReviewDTO review = temp.selectOne("review.premodify", re_no);
		return review;
	}

	public void dbreviewModify(ReviewDTO dto) {
		temp.update("review.modify", dto);
	}

	public void dbreviewDel(int re_no) {
		temp.delete("review.del", re_no);
	}

	public void dbanswerDel(int a_no) {
		temp.delete("review.answerDel", a_no);
	}
}
