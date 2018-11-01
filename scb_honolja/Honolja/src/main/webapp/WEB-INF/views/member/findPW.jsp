<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
	 .ff {
	  position: absolute;
	  bottom: 0;
	  width: 100%;
	 }
</style>

<script type="text/javascript">
	var pwdcheck = false;
	
	//비밀번호 체크
	function pwdCheck() {
		var u_pwd = document.getElementById("u_pwd").value;
		var u_pwd2 = document.getElementById("u_pwd2").value;
		var pwd = document.getElementById("pwd");
		var pwd2 = document.getElementById("pwd2");
		
		if(u_pwd == "" || u_pwd == null){
			pwd.innerHTML = "<font color='red'>필수 정보입니다.</font>";
		}else{
			pwd.innerHTML = "";
			if (u_pwd == u_pwd2) {
				pwd2.innerHTML = "<font color='red'>비밀번호가 일치합니다.</font>";
				pwdcheck = true;
			} else {
				pwd2.innerHTML = "<font color='red'>비밀번호가 일치하지 않습니다.</font>";
			}
		}
	}//pwdCheck end
	
	$(function(){
		$("#findID").click(function(){
			var u_id = document.getElementById("u_id").value;
			$.ajax({
				async : true,
				type : 'POST',
				url: "findPWid.do/"+u_id,
				data: u_id,
				dataType : "text",
				success: function(data){
					if(data == null || data == ""){
						alert("등록된 아이디가 없습니다");
					}else{
						$("#id1").hide();
						$(".btn_next").hide();
						$("#findID").hide();
						$(".div2").html("본인확인 이메일로 인증").show();
						$(".div1").html("본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다");
						$("#email").show();
						
						$("#btn_email").click(function(){
							alert("인증번호를 발송했습니다. 인증번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요");
							$(".div1").html("인증 코드를 입력하세요");
							$("#emailkey").show();
							$(".div2").hide();
							$("#emaildiv").hide();
							$("#emailkey").show();
							var u_email = document.getElementById("u_email").value;
							$.ajax({
								async : true,
								type : 'POST',
								url: "findingPW.do",
								data: {"u_id" : u_id, "u_email" : u_email},
								dataType : "text",
								success: function(data){
									if(data == "true"){
										$("#email1").show();
										$("#btn_email2").click(function(){
											var u_emailkey = document.getElementById("u_emailkey").value;
											$.ajax({
												async : true,
												type : 'POST',
												url: "emailkeyCheck.do",
												data: {"u_id" : u_id, "u_emailkey" : u_emailkey},
												dataType : "text",
												success: function(data){
													if(data == null || data == ""){
														alert("인증코드가 올바르지 않습니다");
													}else{
														$(".div1").html("새로운 비밀번호를 입력하세요");
														$("#divpwd").show();
														$("#email").hide();
														$("#email1").hide();
														
														$("#btn_pwd").click(function(){
															var u_pwd = document.getElementById("u_pwd").value;
															if(pwdcheck == true){
																$.ajax({
																	async : true,
																	type : 'POST',
																	url: "pwdupdate.do",
																	data: {"u_id" : u_id, "u_pwd" : u_pwd},
																	dataType : "text",
																	success: function(data){
																		if(data == "true"){
																			alert("변경된 비밀번호로 다시 로그인하세요");
																			location.href="main.do";
																		}else{
																			alert("다시 확인해주세요")
																		}
																	},error: function(error){
																		alert(error);	
																	}
																});	
															}else{
																alert("입력하신 정보를 다시한번 확인해주세요");
															}
														});
													}
												},error: function(error){
													alert(error);
												}
											});
										});
									}else{
										alert("에러");
									}
									
								},error: function(error){
									alert(error);
								}
							});
						});
					}
				},error: function(error){
					alert(error);
				}
			});
		});
	});
	
	function msg_time() {	// 1초씩 카운트
		var SetTime = 299;		// 최초 설정 시간(기본 : 초)
		m = Math.floor(SetTime / 60) + " : " + (SetTime % 60);	// 남은 시간 계산
		document.getElementById("time").innerHTML = m; 
		SetTime--;					// 1초씩 감소
		
		if (SetTime < 0) {			// 시간이 종료 되면
			clearInterval(tid);		// 타이머 해제
			location.href="main.do";
		}
	}//msg_time end
	
	window.onload = function TimerStart(){
		tid=setInterval('msg_time()',1000) 
	};

	//아이디 체크
	function idCheck(){
		var idcheck = false;
		var u_id = document.getElementById("u_id").value;
		var uid = document.getElementById("uid");
		
		if(u_id.length < 5 || u_id.length > 20){
			if(u_id == "" || u_id == null){
				uid.innerHTML = "<font color='red'>필수 정보입니다.</font>";
			}else{
			uid.innerHTML = "<font color='red'>5~20자 내로 입력해주세요.</font>";
			}
		}else{
			uid.innerHTML = "";
			idcheck = true;
		}
	}//idCheck end
	
	//폰번체크
	function phnCheck(){
		var phncheck = false;
		var u_phn = document.getElementById("u_phn").value;
		var uphn = document.getElementById("uphn");
		
		if(u_phn.length != 11){
			if(u_phn == "" || u_phn == null){
				uphn.innerHTML = "<font color='red'>필수 정보입니다.</font>";
			}else{
				uphn.innerHTML = "<font color='red'>형식에 맞지 않는 번호입니다.</font>";
			}
		}else{
			uphn.innerHTML = "";
			phncheck = true;
		}
	}//phnCheck end
	
	//이메일 체크
	function uemailCheck(){
		mailcheck = false;
		var u_email = document.getElementById("u_email").value;
		var uemail = document.getElementById("uemail");
		var emailcheck = /^([\S]{2,16})@([a-zA-Z]{2,10})\.([a-zA-Z]{2,10})$/;
		
		if(u_email == "" || u_email == null){
			uemail.innerHTML = "<font color='red'>필수 정보입니다.</font>";
		}else{
			uemail.innerHTML = "";
			if(emailcheck.test(u_email)){
				uemail.innerHTML = "";	
				mailcheck = true;
			}else{
				uemail.innerHTML = "<font color='red'>이메일 주소를 다시 확인해주세요.</font>";
			}
		} 
	}//uemailCheck end
	
	function sendmail(){
		if(idcheck == true && phncheck == true && mailcheck == true){
			alert("이메일이 전송되었습니다.");
			myform.onsubmit();
		}else{
			alert("입력하신 정보를 다시 확인해주세요");
		}
	}//sendmail end
</script>
</head>
<body id="page-top" style="margin-top:51px;">

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

	<div style="height: 100px;"></div>
	
	<div class="joinform">
		<div>
			<div class="div2" style="display: none;" align="center">
			</div>
		 	<div class="div1" style="color: gray;" align="center">
				비밀번호를 찾고자 하는 아이디를 입력해 주세요
			</div> <p> <br>
			
			<div class="form-group" id="id1" style="margin: 0 auto; width:20%;">
				아이디 <input type="text" name="u_id" id="u_id" class="form-control" onkeyup="idCheck();">
				<label id="uid"></label>
			</div>
				
			<div class="form-group" id="email" style="margin: 0 auto; width:20%; display: none;">
				이메일
					<div id="emaildiv" style="display: -webkit-inline-box;">
						<input type="text" name="u_email" id="u_email" class="form-control" onkeyup="uemailCheck();">
						<input type="button" id="btn_email" class="btn btn-primary" value="인증번호 받기" style="margin-left: 15%;">
					</div>
					<div id="emailkey" style="display: none;">
						<div style="display: -webkit-inline-box;">
							<input type="text" name="u_emailkey" id="u_emailkey" class="form-control">
							<input type="button" id="btn_email2" class="btn btn-primary" value="인증" style="margin-left: 15%;">
						</div>
					</div>
			</div>
			<div align="center" id="email1" style="display: none;">		
				<label id="time"></label>
			</div>
			
			<div class="form-group" id="divpwd" style="margin: 0 auto; width:20%; display: none;">
					<span class="txt_name">비밀번호</span>
					<input type="password" class="form-control" name="u_pwd" id="u_pwd" />
					<label id="pwd"> </label>
					
					<span class="txt_name">비밀번호확인</span>
					<input type="password" class="form-control" id="u_pwd2"onkeyup="pwdCheck();" />
					<label id="pwd2"> </label>
					
					<input type="button" id="btn_pwd" class="btn btn-primary" value="비밀번호 변경" style="margin-left: 15%;">
			</div>
			
			<p> <br>
			<div id="btn_next" align="center">		
				<input type="button" id="findID" class="btn btn-primary" value="다음">
			</div>
		</div>
	</div>
	
		<div class="ff">
			<c:import url="http://localhost:8080/honolja/footer.do" />
		</div>

</body>
</html>