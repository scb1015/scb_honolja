package com.guest.honolja.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {
	
	@Autowired
	SqlSessionTemplate temp;
	
	public List<NoticeDTO> db_select(int start, int end, String skey, String sval) {
		
		NoticeDTO dto = new NoticeDTO();
		dto.setStart(start);
		dto.setEnd(end);
		dto.setSkey(skey);
		dto.setSval(sval);
		List<NoticeDTO> list = temp.selectList("notice.selectNAll", dto);
		return list;
	}//select end
	
	public List<NoticeDTO> dbsel() {
		List<NoticeDTO> list2=temp.selectList("notice.sel");
		 return list2;
	}
	
	public int db_count(String skey, String sval) {
		NoticeDTO dto = new NoticeDTO();
		dto.setSkey(skey);
		dto.setSval(sval);
		int cnt = (Integer) temp.selectOne("notice.selectCnt", dto);
		return cnt;
	}
	
	public List<NoticeDTO> db_selectT(){
		List<NoticeDTO> listT = temp.selectList("notice.selectNTOP");
		return listT;
	}//selectT 상단공지 end
	
	public void db_insert(NoticeDTO dto) {
		temp.insert("notice.insertN", dto);
	}//insert end
	
	public NoticeDTO db_detail(int data){
		NoticeDTO dto = temp.selectOne("notice.selectDetail", data);
		return dto;
	}//공지글 상세 
	
	public void db_cnt(NoticeDTO dto) {
		temp.update("notice.updatecnt", dto);
	}
	
	public void db_delete(int data) {
		temp.delete("notice.deleteN", data);
	}//공지글 삭제
	
	public NoticeDTO db_preEdit(int data) {
		NoticeDTO dto = temp.selectOne("notice.preEdit", data);
		return dto;
	}//공지글 수정화면 select
	
	public void db_edit(NoticeDTO dto) {
		temp.update("notice.edit", dto);
	}//공지글 수정기능
	
	public String db_selectM(String u_id) {
		String u_member = temp.selectOne("notice.selectM", u_id);
		return u_member;
	}

}//DAO end
