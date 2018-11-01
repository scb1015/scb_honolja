package com.guest.honolja.reservation;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.guest.honolja.detail.DetailDTO;

@Repository
public class ReservationDAO {

	@Autowired
	SqlSessionTemplate temp;

	public List<DetailDTO> dbresSelect(DetailDTO dto) {
		List<DetailDTO> res = temp.selectList("reservation.resSelect", dto);
		return res;
	}

	public DetailDTO dbres(DetailDTO dto) {
		DetailDTO res = temp.selectOne("reservation.res", dto);
		return res;
	}

	public void dbresAdd(DetailDTO dto) {
		temp.insert("reservation.resAdd", dto);
	}

	public DetailDTO dbresCheck(DetailDTO dto) {
		DetailDTO check = temp.selectOne("reservation.resSelect", dto);
		return check;
	}
}
