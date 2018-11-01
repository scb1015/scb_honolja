package com.guest.honolja.info;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class InfoDTO {
	
	String u_id;
	String u_pwd;
	String u_img;
	String u_gender;
	String u_email;
	String u_name;
	String u_birth;
	
	String n_title;
	int rn;
	
	int i_no;
	String i_title;
	String i_content;
	Date i_date;
	int i_viewcnt;
	int i_starcnt;
	String i_originalFileName;
	String i_uploadFileName;
	String i_fileSize;
	
	MultipartFile upload_f;
	
	int ir_no;
	String ir_content;
	Date ir_date;
	
	int list_start;
	int list_end;
	
	String skey;
	String sval;
	
	int il_no;
	String il_like;
	
	
    int irr_no; 
    String irr_content;
    Date irr_date; 
    
    int reply_cnt;
    
    String i_youtube;
    
    
	
	public String getI_youtube() {
		return i_youtube;
	}
	public void setI_youtube(String i_youtube) {
		this.i_youtube = i_youtube;
	}
	public int getReply_cnt() {
		return reply_cnt;
	}
	public void setReply_cnt(int reply_cnt) {
		this.reply_cnt = reply_cnt;
	}
	public Date getIrr_date() {
		return irr_date;
	}
	public void setIrr_date(Date irr_date) {
		this.irr_date = irr_date;
	}
	public int getIrr_no() {
		return irr_no;
	}
	public void setIrr_no(int irr_no) {
		this.irr_no = irr_no;
	}
	public String getIrr_content() {
		return irr_content;
	}
	public void setIrr_content(String irr_content) {
		this.irr_content = irr_content;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pwd() {
		return u_pwd;
	}
	public void setU_pwd(String u_pwd) {
		this.u_pwd = u_pwd;
	}
	public String getU_img() {
		return u_img;
	}
	public void setU_img(String u_img) {
		this.u_img = u_img;
	}
	public String getU_gender() {
		return u_gender;
	}
	public void setU_gender(String u_gender) {
		this.u_gender = u_gender;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_birth() {
		return u_birth;
	}
	public void setU_birth(String u_birth) {
		this.u_birth = u_birth;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public int getI_no() {
		return i_no;
	}
	public void setI_no(int i_no) {
		this.i_no = i_no;
	}
	public String getI_title() {
		return i_title;
	}
	public void setI_title(String i_title) {
		this.i_title = i_title;
	}
	public String getI_content() {
		return i_content;
	}
	public void setI_content(String i_content) {
		this.i_content = i_content;
	}
	public Date getI_date() {
		return i_date;
	}
	public void setI_date(Date i_date) {
		this.i_date = i_date;
	}
	public int getI_viewcnt() {
		return i_viewcnt;
	}
	public void setI_viewcnt(int i_viewcnt) {
		this.i_viewcnt = i_viewcnt;
	}
	public int getI_starcnt() {
		return i_starcnt;
	}
	public void setI_starcnt(int i_starcnt) {
		this.i_starcnt = i_starcnt;
	}
	public String getI_originalFileName() {
		return i_originalFileName;
	}
	public void setI_originalFileName(String i_originalFileName) {
		this.i_originalFileName = i_originalFileName;
	}
	public String getI_uploadFileName() {
		return i_uploadFileName;
	}
	public void setI_uploadFileName(String i_uploadFileName) {
		this.i_uploadFileName = i_uploadFileName;
	}
	public String getI_fileSize() {
		return i_fileSize;
	}
	public void setI_fileSize(String i_fileSize) {
		this.i_fileSize = i_fileSize;
	}
	public MultipartFile getUpload_f() {
		return upload_f;
	}
	public void setUpload_f(MultipartFile upload_f) {
		this.upload_f = upload_f;
	}
	public int getIr_no() {
		return ir_no;
	}
	public void setIr_no(int ir_no) {
		this.ir_no = ir_no;
	}
	public String getIr_content() {
		return ir_content;
	}
	public void setIr_content(String ir_content) {
		this.ir_content = ir_content;
	}
	public Date getIr_date() {
		return ir_date;
	}
	public void setIr_date(Date ir_date) {
		this.ir_date = ir_date;
	}
	public int getList_start() {
		return list_start;
	}
	public void setList_start(int list_start) {
		this.list_start = list_start;
	}
	public int getList_end() {
		return list_end;
	}
	public void setList_end(int list_end) {
		this.list_end = list_end;
	}
	public String getSkey() {
		return skey;
	}
	public void setSkey(String skey) {
		this.skey = skey;
	}
	public String getSval() {
		return sval;
	}
	public void setSval(String sval) {
		this.sval = sval;
	}
	public int getIl_no() {
		return il_no;
	}
	public void setIl_no(int il_no) {
		this.il_no = il_no;
	}
	public String getIl_like() {
		return il_like;
	}
	public void setIl_like(String il_like) {
		this.il_like = il_like;
	}	

}
