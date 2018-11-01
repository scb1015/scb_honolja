package com.guest.honolja.list;

public class ListDTO {
	private  int g_no; //guesthouse nomber
	private  String g_name; // guesthouse name
	private  String g_addr; //guesthouse address
	private  String g_position_n; //guesthouse location x position
	private  String g_position_e; //guesthouse location y position
	private  String g_detail; //guesthouse content(����)
	private  String g_url;	//guesthouse img
	private  String guesthouse; //guesthouse table
	private  java.util.Date  nalja;  // guesthouse like time
	private String check_in, check_out; //checkin check out
	private String filter, range; //filter range
	private int reviewcnt; //reply count
	private String u_id;
	private int avgs;

	public int getAvgs() {	return avgs;}
	public void setAvgs(int avgs) {	this.avgs = avgs;}
	
	public String getU_id() {	return u_id;}
	public void setU_id(String u_id) {	this.u_id = u_id;}
	
	private int rcnt;	//guesthouse count
	private  String skey; //guesthouse search key
	private int r_price;
	  
	private  String sval; //guesthouse search value
	private  String area, basic; //���� �ʱ���ǥ

	private int startprice, endprice; //���� �˻� => ���۰���~ ������
	private int islike; //like
	
	public int getIslike() {	return islike;}
	public void setIslike(int islike) {	this.islike = islike;}

	int low_price; //price search
	
	private int gl_no;
	private String gl_date;

	private String check_like;
	private int btn_flag;
	
	
	public int getBtn_flag() {
		return btn_flag;
	}
	public void setBtn_flag(int btn_flag) {
		this.btn_flag = btn_flag;
	}
	public String getCheck_like() {
		return check_like;
	}
	public void setCheck_like(String check_like) {
		this.check_like = check_like;
	}

	public int getReviewcnt() {	return reviewcnt;}
	public void setReviewcnt(int reviewcnt) {	this.reviewcnt = reviewcnt;}
	
	public String getFilter() {	return filter;}
	public void setFilter(String filter) {	this.filter = filter;}
	
	public String getRange() {	return range;}
	public void setRange(String range) {	this.range = range;}

	public int getGl_no() {	return gl_no;}
	public void setGl_no(int gl_no) {	this.gl_no = gl_no;}
	
	public String getGl_date() {	return gl_date;}
	public void setGl_date(String gl_date) {	this.gl_date = gl_date;}
	
	public String getBasic() {	return basic;}
	public void setBasic(String basic) {	this.basic = basic;}
	
	public int getR_price() {	return r_price;}
	public void setR_price(int r_price) {	this.r_price = r_price;} 
	  
	public String getCheck_in() {	return check_in;}
	public void setCheck_in(String check_in) {	this.check_in = check_in;}
	
	public String getCheck_out() {	return check_out;}
	public void setCheck_out(String check_out) {	this.check_out = check_out;}
	
	public int getLow_price() {	return low_price;}
	public void setLow_price(int low_price) {	this.low_price = low_price;}
	
	public int getStartprice() {	return startprice;}
	public void setStartprice(int startprice) {	this.startprice = startprice;}
	
	public int getEndprice() {	return endprice;}
	public void setEndprice(int endprice) {	this.endprice = endprice;}
	
	public String getArea() {return area;}
	public void setArea(String area) {	this.area = area;}
	
	public String getSkey() {return skey;}
	public void setSkey(String skey) {this.skey = skey;}
	
	public String getSval() {return sval;}
	public void setSval(String sval) {this.sval = sval;}
	
	public String getG_url() {	return g_url;}
	public void setG_url(String g_url) {this.g_url = g_url;}
	
	public int getG_no() {return g_no;}
	public void setG_no(int g_no) {this.g_no = g_no;}
	
	public String getG_name() {return g_name;}
	public void setG_name(String g_name) {this.g_name = g_name;}
	
	public String getG_addr() {return g_addr;}
	public void setG_addr(String g_addr) {this.g_addr = g_addr;}
	
	public String getG_position_n() {return g_position_n;}
	public void setG_position_n(String g_position_n) {this.g_position_n = g_position_n;}
	
	public String getG_position_e() {return g_position_e;}
	public void setG_position_e(String g_position_e) {	this.g_position_e = g_position_e;}
	
	public String getG_detail() {	return g_detail;}
	public void setG_detail(String g_detail) {this.g_detail = g_detail;}
	
	public String getGuesthouse() {	return guesthouse;}
	public void setGuesthouse(String guesthouse) {	this.guesthouse = guesthouse;}
	
	public int getRcnt() {	return rcnt;}
	public void setRcnt(int rcnt) {	this.rcnt = rcnt;}
	
	public java.util.Date getNalja() {return nalja;}
	public void setNalja(java.util.Date nalja) {this.nalja = nalja;}

}
