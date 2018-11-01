package com.guest.honolja.main;

import java.util.List;

import org.apache.log4j.chainsaw.Main;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.guest.honolja.member.MemberDTO;

@Repository
public class MainDAO {
		
	@Autowired
	SqlSessionTemplate temp;
	
	public int dbSelect(MemberDTO mto) {
		int u_cnt = temp.selectOne("main.selectIdPwd", mto);
		return u_cnt;
	}//end
	
	public String emailcheck(MemberDTO mto) {
		String u_emailcheck = temp.selectOne("main.emailcheck", mto);
		return u_emailcheck;
	}
	
	//Print notice_list in main view
	public List<MainDTO> dbSelectFixedNotice() {
		return temp.selectList("main.selectFixedNotice");
	}
	
	//Insert id when guest try to login as NAVER API
	public void dbInsertUsersInfo(MainDTO dto){
		temp.insert("main.insertUsersInfo", dto);
	}
	
	//Check id in DB for NAVER Login. if it isn't, insert.
	public int dbSelectIdCheck(String u_id) {
		return temp.selectOne("main.selectIdCheck", u_id);
	}//end
	
	//관리자 체크
	public String membercheck(String u_id) {
		String u_member = temp.selectOne("main.membercheck", u_id);
		return u_member;
	}//end
	
}
