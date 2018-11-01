package com.guest.honolja.message;

public class MsgDTO {
	int rn, m_no;
	String m_title, m_content, m_id, u_id, m_date, m_send, m_receive;
	
	public int getRn() {return rn;}
	public void setRn(int rn) {this.rn = rn;}
	public int getM_no() {return m_no;}
	public void setM_no(int m_no) {this.m_no = m_no;}
	public String getM_title() {return m_title;}
	public void setM_title(String m_title) {this.m_title = m_title;}
	public String getM_content() {return m_content;}
	public void setM_content(String m_content) {this.m_content = m_content;}
	public String getM_id() {return m_id;}
	public void setM_id(String m_id) {this.m_id = m_id;}
	public String getU_id() {return u_id;}
	public void setU_id(String u_id) {this.u_id = u_id;}
	public String getM_date() {return m_date;}
	public void setM_date(String m_date) {this.m_date = m_date;}
	
	public String getM_send() { return m_send; }
	public void setM_send(String m_send) { this.m_send = m_send; }
	public String getM_receive() { return m_receive; }
	public void setM_receive(String m_receive) { this.m_receive = m_receive; }

	String userid;

	public String getUserid() {return userid;}
	public void setUserid(String userid) {this.userid = userid;}
	
	String m_check;

	public String getM_check() {return m_check;}
	public void setM_check(String m_check) {this.m_check = m_check;}
	
	String receiver;

	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	
	
	
	
}//end
