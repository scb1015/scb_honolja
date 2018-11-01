package com.guest.honolja.list;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ListDAO {
		
	@Autowired
	SqlSessionTemplate temp;
	
	public List<ListDTO> dbSelect( ){
		List<ListDTO> list=temp.selectList("firstlist.selectAll");
		return list;
	}//end
	
	public List<ListDTO> dbSelect(String skey, String sval, int startprice, int endprice, String filter,String range, String u_id) {
		ListDTO dto = new ListDTO();
			dto.setU_id(u_id);
			dto.setSkey(skey);
			dto.setSval(sval);
			dto.setStartprice(startprice);
			dto.setEndprice(endprice);
			dto.setFilter(filter);
			dto.setRange(range);
		List<ListDTO> list=temp.selectList("firstlist.selectAll",dto);
	  return list;
	}//end
	
	public List<ListDTO> dbSelectlo(String g_addr,int startprice, int endprice, String filter,String range,String u_id){
		ListDTO dto = new ListDTO();
		dto.setU_id(u_id);
		dto.setStartprice(startprice);
		dto.setEndprice(endprice);
		dto.setG_addr(g_addr);
		dto.setFilter(filter);
		dto.setRange(range);
		List<ListDTO> listlo=temp.selectList("firstlist.selectlo",dto);
		return listlo;
	}//end
	
	public int dbCount() {
		int cnt=(Integer)temp.selectOne("firstlist.countAll");
		return cnt;
	}//end

	public int dbCount(String skey, String sval){ 
		ListDTO dto = new ListDTO();
		dto.setSval(sval);
		int total = (Integer)temp.selectOne("firstlist.countAll",dto);
		return total;
	}//end
	public int dblike_cnt(ListDTO dto) {
		return temp.selectOne("firstlist.like_cnt", dto);
	}
	public void dbinsertlike(ListDTO dto) {
		temp.selectOne("firstlist.insertlike", dto);
	}
	public void dbdeletelike(ListDTO dto) {
		temp.selectOne("firstlist.deletelike", dto);
	}
	public List<ListDTO> dbselscore() {
		List<ListDTO> list1 = temp.selectList("firstlist.selscore");
		return list1;
	}
}
