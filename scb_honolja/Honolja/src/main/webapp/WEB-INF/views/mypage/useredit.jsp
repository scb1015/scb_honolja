<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="css/mypage_menu.css" rel="stylesheet" type="text/css">
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script type="text/javascript">

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
	}
	
	function pwd_check(){
		var pch = myform.u_pwd.value;
		
		if ( pch == null || pch == ""){
			alert("수정 사항 반영을 위해 비밀번호를 입력해주세요.");
			return;
		}
		
		myform.submit();
		
	}
	
</script>

<style type="text/css">
	
	.img-circle {
		border-radius: 50%;
		width: 150px;
		height: 150px;
 	}

	#upload_img {  
  		display: none;
	}

	.txt_name {
		font-size: 10pt;
		font-weight: bold;
	}
</style>

<script type="text/javascript">
	function eventOccur(evEle, evType){
		if (evEle.fireEvent) {
			evEle.fireEvent('on' + evType);
		} else {
			var mouseEvent = document.createEvent('MouseEvents');
			mouseEvent.initEvent(evType, true, false);
			var transCheck = evEle.dispatchEvent(mouseEvent);

			if (!transCheck) {
				console.log("클릭 발생 실패");
			}
		}
	}

	function check(){
		eventOccur(document.getElementById('upload_img'),'click');
	}
</script>

</head>
<body>

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">개인정보 수정</h4>
	</div>
        
	<div class="modal-body" id="member"><p>

	<form action="usereditsave.do" enctype="multipart/form-data" method="post" name="myform" onsubmit="pwd_check(); return false;">

		<button type="button" class="btn btn-default btn-sm" id="replace" onclick="check();">
			<span class="glyphicon glyphicon-picture"></span> Picture
        </button>
 	
	<div align="center">
		<input type="file" id="upload_img" name="upload_img" accept="image/*" onchange="showImg(this)"><p>
		<img id="thumb" src="./image/${mto.u_img}" class="img-circle">
	</div> <p>

	<input type="hidden" name="u_id" id="u_id" value="${mto.u_id}">
										
	<div>
		<span class="txt_name">이름</span>
		<input type="text" class="form-control" name="u_name" id="u_name" value="${mto.u_name}">
		<label id="uname"> </label>
	</div> <p>
				
	<div>
		<span class="txt_name">비밀번호</span>
		<input type="password" class="form-control" name="u_pwd" id="u_pwd" >
		<label id="pwd"> </label>
	</div> <p>
				
	<div>
		<span class="txt_name">휴대전화</span>
		<input type="text" class="form-control" name="u_phn" id="u_phn" value="${mto.u_phn}" placeholder="'-' 없이 입력하세요">
		<label id="uphn"> </label>
	</div> <p>
				
	<div>
		<span class="txt_name">이메일</span>
		<input type="text" class="form-control" name="u_email" id="u_email" value="${mto.u_email}">
		<label id="umail"> </label>
	</div> <p> <br>
				
	<div align="center">
		<input type="submit" class="btn btn-default btn-md" style="height:40px;" value="수정하기">
	</div>
	</form>
	
	</div>

</body>
</html>