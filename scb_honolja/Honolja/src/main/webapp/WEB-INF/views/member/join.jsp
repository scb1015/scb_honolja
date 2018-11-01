<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
<style type="text/css">
	*{
		font-size: 10pt;
		font-weight: bold;
	}
	.joinform {
		width: 500px;
		margin: 0 auto;
	}
	.logo {
		display: block;
	    overflow: hidden;
	    width: 240px;
	    height: 100px;
	    margin: 0 auto;
	    color: blue;
		}
	.loghoh1 {
		font-size: 44px;
		font-weight: bold;
	}
	.logo .loghoh1 a{
		text-decoration: none;
	}
	.honolja{
		font-size: 44px;
		font-weight: bold;
	    overflow: hidden;
	    clip: rect(0 0 0 0);
	    margin: -1px;
	    width: 1px;
	    height: 1px;
	}
	.option-input {
		-webkit-appearance: none;
		-moz-appearance: none;
		-ms-appearance: none;
		-o-appearance: none;
		appearance: none;
		position: static;
		top: 13.33333px;
		right: 0;
		bottom: 0;
		left: 0;
		height: 20px;
		width: 20px;
		transition: all 0.15s ease-out 0s;
		background: #cbd1d8;
		border: none;
		color: #fff;
		cursor: pointer;
		margin-right: 0.5rem;
		outline: none;
		position: relative;
		z-index: 1000;
	}
	.option-input:hover {
		background: #9faab7;
	}
	.option-input:checked {
		background: blue;
	}
	.option-input:checked::before {
		height: 20px;
		width: 20px;
		position: absolute;
		content: '?';
		font-size: 15px;
		text-align: center;
		line-height: 20px;
	}
	.option-input:checked::after {
		-webkit-animation: click-wave 0.65s;
		-moz-animation: click-wave 0.65s;
		animation: click-wave 0.65s;
		background: #40e0d0;
		content: '';
		position: relative;
		z-index: 100;
	}
	.option-input.radio {
		border-radius: 50%;
	}
	.option-input.radio::after {
		border-radius: 50%;
	}
	.txtlayout {
		width: 100%;
		height: 51px;
		border: solid 1px;
		display: block;
		border-color: #dadada;
		padding: 7px 13px 10px;
	}
			
	.img-circle {
		border-radius: 50%;
		width: 150px;
		height: 150px;
 	}
 	
 	#upload_img {
 		display: none;
 	}
 	
	#u_member, #u_gender {
		margin: -25px 0 0 0; 
		vertical-align:middle;
	}
	
</style>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">

	var flagID = false;
	
	//radio버튼
	function radioCheck(v, id, id2, id3) {
		var guestname = document.getElementById(id);
		var guestjuso = document.getElementById(id2);
		var guestphn = document.getElementById(id3);
		if (v == "점주") {
			guestname.style.display = ""; //보여줌
			guestjuso.style.display = "";
			guestphn.style.display = "";
		} else {
			guestname.style.display = "none"; //숨김
			guestjuso.style.display = "none";
			guestphn.style.display = "none";
		}
	}//radioCheck end
	
	//아이디 체크
	function idCheck(){
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
			var u_id = $("#u_id").val();
			
			$.ajax({
				async : true,
				type : 'POST',
				data : u_id,
				url : "idcheck.do",
				dataType : "text",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					if(data == "true")
					{
						uid.innerHTML = "<font color='red'>이미 사용중이거나 탈퇴한 아이디입니다.</font>";
						flagID = false;
					}
					else
					{
						uid.innerHTML = "<font color='blue'>멋진 아이디네요!</font>";
						flagID = true;
					}
				},
				error : function(error) {
					alert("error : " + error);
				}
			});
		}
	}//idCheck end
	
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
			} else {
				pwd2.innerHTML = "<font color='red'>비밀번호가 일치하지 않습니다.</font>";
			}
		}
	}//pwdCheck end
	
	//이름 체크
	function nameCheck(){
		var u_name = document.getElementById("u_name").value;
		var uname = document.getElementById("uname");
		
		if(u_name == "" || u_name == null){
			uname.innerHTML = "<font color='red'>필수 정보입니다.</font>";
		}else{
			uname.innerHTML = "";
		}
	}//nameCheck end
	
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
	
	//이메일 체크
	function uemailCheck(){
		var u_email = document.getElementById("u_email").value;
		var uemail = document.getElementById("uemail");
		var emailcheck = /^([\S]{2,16})@([a-zA-Z]{2,10})\.([a-zA-Z]{2,10})$/;
		
		if(u_email == "" || u_email == null){
			uemail.innerHTML = "<font color='red'>필수 정보입니다.</font>";
		}else{
			uemail.innerHTML = "";
			if(emailcheck.test(u_email)){
				uemail.innerHTML = "";	
			}else{
				uemail.innerHTML = "<font color='red'>이메일 주소를 다시 확인해주세요.</font>";
			}
		} 
	}//uemailCheck end
	
	//생년월일 체크
	function birthCheck(){
		var ubirth = document.getElementById("ubirth");
		var year = document.getElementById("year").value;
		var month = document.getElementById("month").value;
		var day = document.getElementById("day").value;
		if(year.length < 4){
			ubirth.innerHTML = "<font color='red'>태어난 년도 4자리를 정확하게 입력하세요.</font>";
		}else if(month == "월"){
			ubirth.innerHTML = "<font color='red'>태어난 월을 선택해주세요.</font>";
		}else if(day == "" || day == null){
			ubirth.innerHTML = "<font color='red'>태어난 일(날짜) 2자리를 정확하게 입력하세요.</font>";
		}
	}//birthCheck end
	
	//성별 체크
	function ugenderCheck(){
		var u_gender = document.getElementById("u_gender").value;
		var ugender = document.getElementById("ugender");
		
		if(u_gender.checked.length < 1){
			ugender.innerHTML = "<font color='red'>필수 정보입니다.</font>";
		}else{
			ugender.innerHTML = "";
		}
	}//ugenderCheck end
	
	
	//주소
	function DaumPostcode() 
	{
		new daum.Postcode
		({
			oncomplete:function(data) 
			{
				//팝업에서 검색결과 항목을 클릭했을 떄 실행할 코드를 작성하는 부분
				//각 주소의 노출 규칙에 따라 주소를 조합한다
				//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다
				var fullAddr = '';//최종 주소 변수
				var extraAddr = '';//조합형 주소 변수
				
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다
				if (data.userSelectedType === 'R') //사용자가 도로명 주소를 선택했을 경우 
				{
					fullAddr = data.roadAddress;
				} 
				else //사용자가 지번 주소를 선택했을 경우(J) 
				{
					fullAddr = data.jibunAddress;
				}
				
				//사용자가 선택한 주소가 도로명 타입일때 조합한다
				if (data.userSelectedType === 'R') //법적동명이 있을 경우 추가한다 
				{
					if (data.bname !== '') 
					{
						extraAddr += data.bname;
					}
				
					//건물명이 있을 경우 추가 한다
					if (data.buildingName !== '') 
					{
						extraAddr += (extraAddr !== '' ? ',' + data.buildingName : data.buildingName);
					}
					//조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종주소를 만든다
					fullAddr += (extraAddr !== '' ? '(' + extraAddr + ')' : '');
				}
				
				//우편번호와 주소 정보를 해당 필드에 넣는다
				document.getElementById('u_postcode').value = data.zonecode;//5자리 새우편번호 사용
				document.getElementById('u_guestjuso').value = fullAddr;
			
				//커서를 상세주소 필드로 이동한다
				document.getElementById('u_guestjuso1').focus();
			}
		}).open();
	}//DaumPostcode end

	function insertCheck() {
		var u_id = myform.u_id.value;
		var uid = document.getElementById("uid");
		var u_pwd = myform.u_pwd.value;
		var u_pwd2 = myform.u_pwd2.value;
		var u_name = myform.u_name.value;
		var year = myform.year.value;
		var month = myform.month.value;
		var day = myform.day.value;
		var u_phn = myform.u_phn.value;
		var u_email = myform.u_email.value;
		
		var u_gender = document.getElementById("u_gender");
		var pwd = document.getElementById("pwd");
		var pwd2 = document.getElementById("pwd2");
		
		if (u_id == "" || u_id == null) {
			document.getElementById("u_id").focus();
			$("#testmodal").modal("show");
			uid.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return false;
		} else if (u_pwd == "" || u_pwd == null) {
			document.getElementById("u_pwd").focus();
			pwd.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		} else if (u_name == "" || u_name == null) {
			document.getElementById("u_name").focus();
			uname.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		} else if (year == "" || year == null) {
			document.getElementById("year").focus();
			ubirth.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		} else if (month == "월") {
			document.getElementById("month").focus();
			ubirth.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		} else if (day == "" || day == null) {
			document.getElementById("day").focus();
			ubirth.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		} else if (u_phn == "" || u_phn == null) {
			document.getElementById("u_phn").focus();
			uphn.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		}else if(u_gender.checked.length < 1){
			document.getElementById("u_gender").focus();
			ugender.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		}else if (u_email == "" || u_email == null) {
			document.getElementById("u_email").focus();
			uemail.innerHTML = "<font color='red'>필수 정보입니다.</font>"
			return;
		}//end
		
		//게스트하우스 이름 체크
		function uguestnameCheck(){
			var u_guestname = document.getElementById("u_guestname").value;
			var uguestname = document.getElementById("uguestname");
			
			if(u_guestname == "" || u_guestname == null){
				uguestname.innerHTML = "<font color='red'>필수 정보입니다.</font>";
			}
		}//end
		
		//게스트하우스 연락처 체크
		function uguestnumCheck(){
			var u_guestnum = document.getElementById("u_guestnum").value;
			var uguestnum = document.getElementById("uguestnum");
			
			if(u_guestnum == "" || u_guestnum == null){
				uguestnum.innerHTML = "<font color='red'>필수 정보입니다.</font>";
			}
		}//end
		
		
		//점주 null체크
		var u_member = myform.u_member.value;
		var u_guestname = myform.u_guestname.value;
		var u_postcode = myform.u_postcode.value;
		var u_guestjuso = myform.u_guestjuso.value;
		var u_guestjuso1 = myform.u_guestjuso1.value;
		var u_guestnum = myform.u_guestnum.value;
		
		if(u_member.checked != null){
			if(u_guestname == "" || u_guestname == null){
				alert("게스트하우스명을 입력해주세요");
				return;
			}else if(u_postcode == "" || u_postcode == null){
				alert("우편번호를 입력해주세요");
				return;
			}else if(u_guestjuso == "" || u_guestjuso == null){
				alert("주소를 입력해주세요");
				return;
			}else if(u_guestjuso1 == "" || u_guestjuso1 == null){
				alert("상세주소를 입력해주세요");
				return;
			}else if(u_guestnum == "" || u_guestnum == null){
				alert("게스트하우스 연락처를 입력해주세요");
				return;
			}	
		}//점주 체크

		//중복체크여부
		if (flagID == false) {
			alert("아이디 중복체크를 해주세요");
			return;
		}
		alert("인증 메일이 발송되었습니다");
		myform.submit();
	}//insertCheck end
	
	function showImg(fileInput) {
	    var files = fileInput.files;
	    for (var i = 0; i < files.length; i++) {           
	        var file = files[i];
	        var imageType = /image.*/;     
	        if (!file.type.match(imageType)) {
	            alert("이미지 파일만 가능합니다.");
	            return;
	        }           
	        var img=document.getElementById("thumb");            
	        img.file = file;    
	        var reader = new FileReader();
	        reader.onload = (function(aImg) { 
	            return function(e) { 
	                aImg.src = e.target.result; 
	            }; 
	        })(img);
	        reader.readAsDataURL(file);
	    }    
	}//이미지 썸네일 보여주기
	
	function eventOccur(evEle, evType){
		if (evEle.fireEvent){
			evEle.fireEvent('on' + evType);
		} else {
			var mouseEvent = document.createEvent('MouseEvents');
			mouseEvent.initEvent(evType, true, false);
			var transCheck = evEle.dispatchEvent(mouseEvent);
			
			if(!transCheck){
			console.log("클릭 이벤트 발생 실패");
			}
		}
		
	}//이미지 업로드 버튼 클릭 이벤트
	
	function check(){
		eventOccur(document.getElementById('upload_img'),'click');
	}//클릭 이벤트
	
	
</script>
</head>
<body id="page-top" style="margin-top:51px;">
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<div class="logo" role="banner">
		<h1 class="loghoh1">
			<a href="main.do">
				<span class="honolja">HONOlJA</span>
			</a>
		</h1>
	</div>
	
	
	<div class="joinform">
		<form action="m_insert.do" method="post" name="myform" onsubmit="insertCheck(); return false;" enctype="multipart/form-data">
				
			<label>구분</label>
					<div>
						<input type="radio" class="option-input radio" name="u_member" id="u_member" checked="checked" style="display:inline-flex;"	onclick="radioCheck(this.value,'name','juso','num');" value="일반회원" /> 
						일반회원			
						<input type="radio" class="option-input radio" name="u_member" id="u_member" style="display:inline-flex;" onclick="radioCheck(this.value,'name','juso','num');" value="점주" />
						점주
					</div> <p> <br>
				
			<div style="float: left;">	
				<div>
					<label>아이디</label>
					<input type="text" class="form-control" name="u_id" id="u_id" onkeyup="idCheck();"/>
					<label id="uid"></label>
				</div>
				<div>
					<label>비밀번호</label>
					<input type="password" class="form-control" name="u_pwd" id="u_pwd" />
					<label id="pwd"> </label>
					
				</div>
				<div>
					<label>비밀번호확인</label>
					<input type="password" class="form-control" id="u_pwd2"onkeyup="pwdCheck();" />
					<label id="pwd2"> </label>
				</div>
			</div>
			
			<div style="margin-left: 65%; margin-top: 5%;">
			<input type="file" id="upload_img" name="upload_img" accept="image/*" onchange="showImg(this)"><p>
					<img id="thumb" src="./image/default.png" class="img-circle">	<p>
					
					<button type="button" class="btn btn-default btn-sm" id="replace" onclick="check();" style="margin-left: 35px;">
						<span class="glyphicon glyphicon-picture"></span> Picture
					</button>	
			
			</div> <br> <p>
		
				<div>
					<label>이름</label>
					<input type="text" class="form-control" name="u_name" id="u_name" onkeyup="nameCheck();"/>
					<label id="uname"> </label>
				</div>
				<div>
					<label for="sel1">생년월일</label>
						<div class="form-group" style="display:inline-flex;">
							<input type="text" class="form-control" id="year" name="year" placeholder="년(4자)" onkeyup="birthCheck();">
							<select class="form-control" id="month" name="month" style="margin-left:20px; margin-right:20px;" onkeyup="birthCheck();">
									<option selected>월</option>
									<c:forEach var="i" begin="0" end="${12-1}">
										<c:set var="month" value="${12-i}"/>
										<option value="${month}">${month}</option>
									</c:forEach>
							</select>
							<input type="text" class="form-control" id="day" name="day" placeholder="일" onkeyup="birthCheck();">
						</div>
						<label id="ubirth"></label>
				</div>
				<div>
					<label>휴대전화</label>
					<input type="text" class="form-control" name="u_phn" id="u_phn" placeholder="'-' 없이 입력하세요" onkeyup="phnCheck();">
					<label id="uphn"> </label>
				</div>
				<div>
					<label>성별</label><p>
						<input type="radio" class="option-input radio" style="display:inline-flex;" name="u_gender" id="u_gender" value="남자" onkeyup="ugenderCheck();">
						<span>남자</span>
						<input type="radio" class="option-input radio" style="display:inline-flex;" name="u_gender" id="u_gender" value="여자">
						<span>여자</span>
						<label id="ugender"></label>
				</div><br>
				
				<div>
					<label>본인 확인 이메일</label>
					<input type="text" class="form-control" name="u_email"id="u_email" onkeyup="uemailCheck();">
					<label id="uemail"> </label>
				</div>

				<div id="name" style="display: none">
					<label>게스트하우스 이름</label>
					<input type="text" class="form-control" id="u_guestname" name="u_guestname" onkeyup="uguestnameCheck();">
					<label id="uguestname"></label>
				</div>
				<div id="juso" style="display: none"> 
					<label>게스트하우스 주소</label>
						<input type="text" class="form-control" id="u_postcode" name="u_postcode" readonly>
                        <input type="button" onclick="DaumPostcode()" value="우편번호"><br>
                        <input type="text" class="form-control" id="u_guestjuso" name="u_guestjuso" readonly style="margin-top: 10px;"><br>
                        <input type="text" class="form-control" id="u_guestjuso1" name="u_guestjuso1"  style="margin-top: 10px;" placeholder="상세주소 입력하세요">
				</div><p><br>
				
				<div id="num" style="display: none"> 					
					<label>게스트하우스 연락처 </label>
					<input type="text" class="form-control" id="u_guestnum" name="u_guestnum" placeholder="'-' 없이 입력하세요" onkeyup="uguestnumCheck();">
					<label id="uguestnum"></label>
				</div>
				<div>
					<input type="submit" class="btn btn-primary btn-md" style="height: 50px; width: 100%; margin-top: 20px; font-size: 12pt; font-weight: bold;" value="가입하기">
				</div>
		</form>
	</div>
	
	<div style="height: 100px;"></div>
</body>
</html>