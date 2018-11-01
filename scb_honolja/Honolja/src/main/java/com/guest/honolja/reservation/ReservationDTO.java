package com.guest.honolja.reservation;

import java.util.Date;

public class ReservationDTO {
	private int res_no;
	private String u_id;
	private int res_price;
	private char res_ok;
	private int res_people;
	private Date res_date;
	private String check_in;
	private String check_out;
	private int r_no;
	private int g_no;
	private String adult;
	private String child;

	public int getG_no() {
		return g_no;
	}

	public void setG_no(int g_no) {
		this.g_no = g_no;
	}

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public int getRes_price() {
		return res_price;
	}

	public void setRes_price(int res_price) {
		this.res_price = res_price;
	}

	public char getRes_ok() {
		return res_ok;
	}

	public int getRes_people() {
		return res_people;
	}

	public void setRes_people(int res_people) {
		this.res_people = res_people;
	}

	public Date getRes_date() {
		return res_date;
	}

	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}

	public void setRes_ok(char res_ok) {
		this.res_ok = res_ok;
	}

	public String getCheck_in() {
		return check_in;
	}

	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}

	public String getCheck_out() {
		return check_out;
	}

	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}

	public int getR_no() {
		return r_no;
	}

	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	
	private String r_name;
	private String r_content;
	private int r_price;
	private String img_url;
	private String res_startdate;
	private String res_enddate;
	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public int getR_price() {
		return r_price;
	}

	public void setR_price(int r_price) {
		this.r_price = r_price;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public String getRes_startdate() {
		return res_startdate;
	}

	public void setRes_startdate(String res_startdate) {
		this.res_startdate = res_startdate;
	}

	public String getRes_enddate() {
		return res_enddate;
	}

	public void setRes_enddate(String res_enddate) {
		this.res_enddate = res_enddate;
	}


	public String getAdult() {
		return adult;
	}

	public void setAdult(String adult) {
		this.adult = adult;
	}

	public String getChild() {
		return child;
	}

	public void setChild(String child) {
		this.child = child;
	}

}
