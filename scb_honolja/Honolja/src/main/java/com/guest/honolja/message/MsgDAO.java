package com.guest.honolja.message;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MsgDAO {
	
	@Autowired
	SqlSessionTemplate temp;
	
	public void db_insert(MsgDTO dto) {
		dto.setM_send("true");
		temp.insert("message.msgSend", dto);
	}//硫붿꽭吏� 蹂대궡湲�
		
	public List<MsgDTO> db_selectR(String m_id){
		List<MsgDTO> listR = temp.selectList("message.msgSelectR", m_id);
		return listR;
	}//諛쏆�履쎌��븿 �엫�떆(湲곕뒫援ы쁽�솗�씤�슜)
	
	public List<MsgDTO> db_selectS(String u_id){
		List<MsgDTO> listS = temp.selectList("message.msgSelectS", u_id);
		return listS;
	}//蹂대궦履쎌��븿 �엫�떆 (湲곕뒫援ы쁽�솗�씤�슜)

	public MsgDTO db_detail(int data) {
		MsgDTO dto=temp.selectOne("message.msgDetail", data);
		return dto;
	}//履쎌� �긽�꽭 �솗�씤
	
	public void db_check(int data) {
		temp.update("message.msgCheck", data);
	}//履쎌� �씫�쓬 �쟾�솚
	
	public int db_msgcheck(String u_id) {
		int cnt = temp.selectOne("message.msgselect", u_id);
		return cnt;
	}
	
	public void db_deleteS(int data) {
		temp.update("message.msgDeleteS", data);
	}//蹂대궦 履쎌� �궘�젣(hide)
	
	public void db_deleteR(int data) {
		temp.update("message.msgDeleteR", data);
	}//諛쏆� 履쎌� �궘�젣(hide)
	
	public void db_cancel(MsgDTO dto) {
		temp.delete("message.msgCancel", dto);
	}//諛쒖넚 痍⑥냼

	
}//DAO end
