package com.guest.honolja.notice;

public class NoticeDTO {

	int rn, n_viewcnt;
	String n_title, n_content, n_date, u_id;
	String n_fix;
	public int getRn() {return rn;}
	public void setRn(int rn) {this.rn = rn;}
	public String getN_title() {return n_title;}
	public void setN_title(String n_title) {this.n_title = n_title;}
	public String getN_content() {return n_content;}
	public void setN_content(String n_content) {this.n_content = n_content;}
	public String getN_date() {return n_date;}
	public void setN_date(String n_date) {this.n_date = n_date;}
	public int getN_viewcnt() {return n_viewcnt;}
	public void setN_viewcnt(int n_viewcnt) {this.n_viewcnt = n_viewcnt;}
	public String getU_id() {return u_id;}
	public void setU_id(String u_id) {this.u_id = u_id;}
	public String getN_fix() {return n_fix;}
	public void setN_fix(String n_fix) {this.n_fix = n_fix;}
	
	int n_no;
	public int getN_no() {return n_no;}
	public void setN_no(int n_no) {this.n_no = n_no;}
	
	int start, end;
	public int getStart() {return start;}
	public void setStart(int start) {this.start = start;}
	public int getEnd() {return end;}
	public void setEnd(int end) {this.end = end;}
	
	String skey, sval;
	public String getSkey() {return skey;}
	public void setSkey(String skey) {this.skey = skey;}
	public String getSval() {return sval;}
	public void setSval(String sval) {this.sval = sval;}
	
	String u_member;
	public String getU_member() {return u_member;}
	public void setU_member(String u_member) {this.u_member = u_member;}
	
	
	
}//end
