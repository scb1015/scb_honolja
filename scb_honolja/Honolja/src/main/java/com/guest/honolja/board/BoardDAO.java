package com.guest.honolja.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.guest.honolja.notice.NoticeDTO;

@Repository
public class BoardDAO {

	@Autowired
	SqlSessionTemplate temp;
	// private static final Logger logger = LoggerFactory.getLogger(LoginDAO.class);


	//리스트@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	public int dbSelect() {
		int num=temp.selectOne("board.select");
		return num;
	}
	
	public List<BoardDTO> dbSelect(int start, int end, String skey, String sval) {
		BoardDTO dto = new BoardDTO();
		dto.setStart(start);
		dto.setEnd(end);
		dto.setSkey(skey);
		dto.setSval(sval);
		List<BoardDTO> list = temp.selectList("board.selectAll", dto);
		return list;
	}//End
	
	public List<NoticeDTO> dbsel() {
		List<NoticeDTO> list2=temp.selectList("notice.sel");
		return list2;
	}

	public int dbCount(String skey, String sval) {
		BoardDTO dto = new BoardDTO();
		dto.setSkey(skey);
		dto.setSval(sval);
		int total = temp.selectOne("board.countAll", dto);
		return total;
	}//End

	public void dbInsert(BoardDTO dto) {
		dto.setB_uploadfilename(dto.getB_uploadfilename2().toString());
		temp.insert("board.insert", dto);
	}//End

	public BoardDTO dbDetail(int b_no) {
		BoardDTO dto = temp.selectOne("board.detail", b_no);
		return dto;
	}//End

	public void dbDelete(int b_no) {
		temp.delete("board.del3", b_no);
		temp.delete("board.del2", b_no);
		temp.delete("board.del", b_no);
	}//End

	public void dbUpdate(BoardDTO dto) {
		temp.update("board.edit", dto);
	}//End

	public void dbViewCnt(int data) {
		temp.update("board.viewcnt", data);
	}//End
	

	//댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	public List<BoardDTO> dbRSelectReply(int b_no) {
		List<BoardDTO> list = temp.selectList("board.Rselect", b_no);
		return list;
	}//End

	public BoardDTO dbRDetail(BoardDTO dto) {
	   dto= temp.selectOne("board.Rdetail", dto);
		return dto;
	}//End

	public int dbRCount(int b_no) {
		int rcnt = temp.selectOne("board.Rcount", b_no);
		return rcnt;
	}//End
	
	public int dbRRCount() {
		int rrcnt = temp.selectOne("board.RRcount");
		return rrcnt;
	}//End

	public void dbRInsert(BoardDTO dto) {
		temp.insert("board.Rinsert", dto);
	}//End

	public void dbRDelete(BoardDTO dto) {
		temp.delete("board.Rdelete2", dto);
		temp.delete("board.Rdelete", dto);

		
	}//End

	public void dbRUpdate(BoardDTO dto) {
		temp.update("board.Rupdate", dto);
		
	}//End

	//대댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	public void dbRRInsert(BoardDTO dto) {
		temp.insert("board.RRinsert", dto);
	}//End

	public List<BoardDTO> dbRRSelect(int br_no) {
		List<BoardDTO> list = temp.selectList("board.RRselect", br_no);
		return list;
	}//End
	
	public BoardDTO dbRRDetail(BoardDTO dto) {
		   dto= temp.selectOne("board.RRdetail", dto);
			return dto;
		}//End
	
	public void dbRRUpdate(BoardDTO dto) {
		temp.update("board.RRupdate", dto);
	}//End

	public void dbRRDelete(BoardDTO dto) {
		temp.delete("board.RRdelete", dto);
	}//End
	

}//Class End
