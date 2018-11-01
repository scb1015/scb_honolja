package com.guest.honolja.main;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.util.WebUtils;

import com.guest.honolja.member.MemberDTO;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MainDAO dao;
	
	@Autowired
	ServletContext application;

	@RequestMapping("/side_mypage.do")
	public String side_mypage() {
		return "/main/side_mypage";
	}
	
	@RequestMapping("/main.do")
	public ModelAndView main_page(HttpServletRequest request, HttpSession session) {
		String uid = (String)session.getAttribute("checked");
		String u_member = dao.membercheck(uid);
		
		ModelAndView mav = new ModelAndView();
			mav.addObject("u_member", u_member);
			mav.setViewName("/main/main");
		
		
		String access_token = "";
		
		//NAVER API Login part
		if(request.getParameter("code") != null) {
			
				String clientId = "KhHvxQuRC4gDkDcMKUBF";//Application Client ID Value
			    String clientSecret = "zIRvSbAaRp";//Application Client Secret Value
			    String code = request.getParameter("code");
			    String state = request.getParameter("state");
    
			    String redirectURI = null;
				try {
					//Address going to back
					redirectURI = URLEncoder.encode("http://localhost:8080/honolja/main.do", "UTF-8");
				} catch (UnsupportedEncodingException e1) {
					e1.printStackTrace();
				}
			    String apiURL;
			    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			    apiURL += "client_id=" + clientId;
			    apiURL += "&client_secret=" + clientSecret;
			    apiURL += "&redirect_uri=" + redirectURI;
			    apiURL += "&code=" + code;
			    apiURL += "&state=" + state;
			    //String access_token = "";
			    String refresh_token = "";
			    System.out.println("apiURL="+apiURL);
			    try {
			      URL url = new URL(apiURL);
			      HttpURLConnection con = (HttpURLConnection)url.openConnection();
			      con.setRequestMethod("GET");
			      int responseCode = con.getResponseCode();
			      BufferedReader br;
			      
			      System.out.print("responseCode = " + responseCode + "\n");
			      
			      if(responseCode==200) { //Login Success
			    	br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			    	System.out.println("NAVER Login Success !!!!");
			    	
			      } else {  //error occurred	    	  
			        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			        System.out.println("NAVER Login Fail !!!!");
			      }
			      String inputLine;
			      StringBuffer res = new StringBuffer();
			      while ((inputLine = br.readLine()) != null) {
			        res.append(inputLine);
			      }
			      br.close();
			      if(responseCode==200) {
			    	  //res.toString(); --> Enumerate naver_login_token_informations as JSON type
			    	  System.out.println("StringBuffer = " + res.toString());
			        
			    	  //get access_token from naver_login JSON data
			    	  JSONObject obj = new JSONObject(res.toString());
			    	  access_token = obj.getString("access_token");
			    	  
			    	  
			    	  
			    	  //start to insert info into users DB table.
			    	  String token = access_token;//NAVER Login access_token;
			  		
			          String header = "Bearer " + token; //Add gap after Bearer;
			          try {
			          	
			              apiURL = "https://openapi.naver.com/v1/nid/me";   
			              url = new URL(apiURL);
			              
			              con = (HttpURLConnection)url.openConnection();
			  	            con.setRequestMethod("GET");
			  	            con.setRequestProperty("Authorization", header);
			  	            
			              responseCode = con.getResponseCode();
			              
			              if(responseCode==200) { // Success calling
			                  br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			                  System.out.println("Success to Private Information Access!!!!");
			              } else {  //Occurred error
			                  br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			                  System.out.println("Fail to Private Information Access!!!!");
			              }

			              StringBuffer response = new StringBuffer();
			              
			              while ((inputLine = br.readLine()) != null) {
			                  response.append(inputLine);
			              }
			              
			              br.close();
			              
			              //response.toString() is to enumerate NAVER_PRIVATE_VALUES of JSON Type
			              System.out.println(response.toString());
			              	
//			              Below Example is to get String value of Private Information from JSON data.
			              
			              String temp = response.toString();
			              obj = new JSONObject(temp);
			              
			              String u_id = obj.getJSONObject("response").getString("id");
			              String u_img = "";
			              String u_gender = obj.getJSONObject("response").getString("gender");
			              String u_email = obj.getJSONObject("response").getString("email");
			              String u_name = obj.getJSONObject("response").getString("name");
			              String u_birth = obj.getJSONObject("response").getString("birthday");
			              	
			              if(u_gender.equals("����")) {
			            	  u_img = "boy.jpg";  
			              }else {
			            	  u_img = "girl.jpg";
			              }
       
			              //progress, if Id is not in users table
			              if(dao.dbSelectIdCheck(u_id) == 0) {
			            	  session.setAttribute("checked", u_id);
			            	  
			            	  MainDTO dto = new MainDTO();
				              	dto.setU_id(u_id);
				              	dto.setU_img(u_img);
				              	dto.setU_gender(u_gender);
				              	dto.setU_email(u_email);
				              	dto.setU_name(u_name);
				              	dto.setU_birth(u_birth);
			              	  	
				              dao.dbInsertUsersInfo(dto);
				              System.out.println("users Info insert success!!");
			              
				              System.out.println("u_id " + u_id);
				              System.out.println("u_img " + u_img);
				              System.out.println("u_gender " + u_gender);
				              System.out.println("u_email " + u_email);
				              System.out.println("u_name " + u_name);
				              System.out.println("u_birth " + u_birth);
				              
				              mav.addObject("u_id", u_id);
				              	
			              }else {
			            	  System.out.println("user Id already exist!!");
			            	  session.setAttribute("checked", u_id);
			              }
			          } catch (Exception e) {
			              System.out.println(e);
			          }
			      }
			    } catch (Exception e) {
			      System.out.println(e);
			    }
			
		}//NaverLogin Part END
		
		//Get text from DB noticeboard
		List<MainDTO> notices = dao.dbSelectFixedNotice();

		mav.addObject("notice", notices.get(0).getN_title());
			
		return mav;
	}
	
	
	@RequestMapping("/login_popup.do")
	public ModelAndView main_login_popup(HttpServletRequest request, Model model) {
		MemberDTO mto = new MemberDTO();
		String u_id = request.getParameter("u_id");
		
		long u_pwd = 0;
		
		if(request.getParameter("u_pwd") != null) {
			u_pwd = Integer.parseInt(request.getParameter("u_pwd"));
		}
		String host =  request.getParameter("host");
		int idCheck = 0;
		
		HttpSession session = request.getSession();
		
		String scriptMsg = null;
		String alertMsg = null;
		ModelAndView mav = new ModelAndView();
			mav.setViewName("/main/login_popup");
		//if params have id_value and pwd_value, progress dto/dao
		if(u_id != null) {
			mto.setU_id(u_id);
			mto.setU_pwd(u_pwd);
			int u_cnt = dao.dbSelect(mto);
			
			if(u_cnt == 1) {
			String u_emailcheck = dao.emailcheck(mto);
			
				if(u_emailcheck.equals("true")) {
					model.addAttribute("checked", u_id);
					
					alertMsg = "Login Success!!";
					scriptMsg = "opener.parent.location='"+host+"';";
					scriptMsg += "self.close();";
					
				}else if(u_emailcheck.equals("false")) {
					alertMsg = "emailcheck please";
				}
			}else if(u_cnt == 0){	
				alertMsg = "Id or Password is wrong.";
			}
		}//if end
		mav.addObject("scriptMsg", scriptMsg);
		mav.addObject("alertMsg", alertMsg);
			//JavaScript sentence send
			
			
		//if I'm NonLogin and there is Cookie saving login_id then Send id_value to page
		if(session.getAttribute("checked") == null) {
			try {
				Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
				mav.addObject("loginCookie", loginCookie.getValue());
			}catch (Exception e) {
				// TODO: handle exception
			}
		}
		
		return mav;
	}
	
	@RequestMapping("/naver_login.do")
	public RedirectView common_naver_login(Model model) {
		
		//NAVER API Login
	    String clientId = "KhHvxQuRC4gDkDcMKUBF";//Application Client ID Value
	    String redirectURI = null;
		try {
			redirectURI = URLEncoder.encode("http://localhost:8080/honolja/main.do", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    System.out.println("apiURL =  " + apiURL);
	    
	    model.addAttribute("checked", state);
	    //session.setAttribute("state", state);
	    	
    	RedirectView redirectView = new RedirectView();
    		redirectView.setUrl(apiURL);
		
		return redirectView;
	}

	
	@RequestMapping("/header.do")
	public ModelAndView common_header() {
		ModelAndView mav = new ModelAndView();
			mav.setViewName("/main/header");
		return mav;		
	}
	
	@RequestMapping("/footer.do")
	public String common_footer() {
		return "/main/footer";
	}
	
	@RequestMapping("/logout.do")
	public ModelAndView common_logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();

		//Host is an address to go back After logout
		mav.setViewName("redirect:/" + request.getParameter("host"));
		
		if(session.getAttribute("checked") != null) {
			session.removeAttribute("checked");
			session.invalidate();
			
			//Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			//if(loginCookie != null) {
			//	loginCookie.setMaxAge(0);
			//response.addCookie(loginCookie);
			
			//}
		}
		
		return mav;
	}
	
	int rn = 0;
	
	@RequestMapping("/main_notice.do")
	public ModelAndView main_notice() {
		
		List<MainDTO> notices = dao.dbSelectFixedNotice();
		
		rn++;
		if(rn == notices.size()) rn = 0;

		ModelAndView mav = new ModelAndView();
			mav.setViewName("/main/ajax_main_notice");
			mav.addObject("notice", notices.get(rn).getN_title());
			
		return mav;
	}
}
