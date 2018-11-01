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

	function idcheck(){
		var u_name = document.getElementById("u_name").value;
		var uname = document.getElementById("uname");
		
		if(u_name == null || u_name == ""){
			uname.innerHTML = "<font color='red'>이름을 입력해주세요.</font>";
		}else{
			uname.innerHTML = "";
		}
	}//idcheck end
	
	//폰번체크
	function phnCheck(){
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
		}
	}//phnCheck end
	
	$(function(){
		$("#findid").click(function(){
			var u_name = document.getElementById("u_name").value;
			var uname = document.getElementById("uname");
			var u_phn = document.getElementById("u_phn").value;
			var uphn = document.getElementById("uphn");
			
			if(u_name == null || u_name == ""){
				uname.innerHTML = "<font color='red'>이름을 입력해주세요</font>";
				return;
			}else if(u_phn == null || u_phn == ""){
				uphn.innerHTML = "<font color='red'>핸드폰 번호를 입력해주세요</font>";
				return;
			}else{ }
			
			$.ajax({
				async : true,
				type : 'POST',
				data : {"u_name" : u_name, "u_phn" : u_phn},
				url : "findingID.do",
				dataType : "text",
				success : function(data){
					if(data != null && data != ""){
						document.getElementById("test3").innerHTML = ""+data;
						$(".div1").html("고객님의 정보와 일치하는 아이디 입니다");
						$(".btn_login").show();
						$(".btn_findid").hide();
						$("#txt_uname").hide();
						$("#txt_uphn").hide();
						$("#txt_uid").show();
					}else {
						alert("등록된 아이디가 없습니다.");
						return false;
					}
				},error : function(error){
					alert(error);
				}
			});
		});
	});//findid end
	
</script>
</head>
<body id="page-top" style="margin-top:51px;">

		<c:import url="http://localhost:8080/honolja/header.do">
			<c:param name="checked" value="${checked}"></c:param>
			<c:param name="host" value="main.do"></c:param>
		</c:import>
	
		<div style="height: 100px;"></div>
		
		<div>
		 	<div class="div1" style="color: grey;" align="center">
				회원정보로 등록한 이름과 휴대전화 번호를 입력해주세요
			</div> <p> <br>
			
			<div class="form-group" id="txt_uname" style="margin: 0 auto; width:20%;">
				이름 <input type="text" name="u_name" id="u_name" class="form-control" onkeyup="idcheck();">
				<label id="uname"></label>
			</div>
			
			<div class="form-group" id="txt_uphn" style="margin: 0 auto; width:20%;">
				휴대전화 <input type="text" name="u_phn" id="u_phn" onkeyup="phncheck();" placeholder="'-'없이 입력하세요" class="form-control">
				<label id="uphn"></label>
			</div>
			
			<div class="form-group" id="txt_uid" align="center" style="margin: 0 auto; width:20%; display: none;" >
				<label id="test3"></label>
			</div> 
			
			<p>
			<div class="btn_login" style="display: none;" align="center">
				<input type="button" id="btn_login" onclick="popupWindow('login_popup.do?host=${param.host}', 'login', 410, 450)" class="btn btn-primary" value="로그인">
				<input type="button" class="btn btn-primary" value="비밀번호 찾기" onclick="location='findPW.do'">
			</div>
			<div class="btn_findid" align="center">		
				<input type="button" id="findid" class="btn btn-primary" value="아이디 찾기">
			</div>
		</div>
	
		<div class="ff">
			<c:import url="http://localhost:8080/honolja/footer.do" />
		</div>

</body>
</html>