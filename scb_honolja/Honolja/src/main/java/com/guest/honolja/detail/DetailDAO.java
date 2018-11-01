package com.guest.honolja.detail;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DetailDAO {

	@Autowired
	SqlSessionTemplate temp;

	public DetailDTO dbroomView(int g_no) {
		DetailDTO view = temp.selectOne("detail.roomView", g_no);
		return view;
	}
	
	public List<DetailDTO> dbroomSelect(DetailDTO dto) {
		List<DetailDTO> info = temp.selectList("detail.roomSelect", dto);
		return info;
	}

	public List<DetailDTO> dbimageSelect(int g_no) {
		List<DetailDTO> list = temp.selectList("detail.imageSelect", g_no);
		return list;
	}
}
