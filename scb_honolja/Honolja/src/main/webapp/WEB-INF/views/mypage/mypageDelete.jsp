<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript">
	function deleteCheck(){
		var pwd = myform.u_pwd.value;
		var pwd2 = myform.u_pwd2.value;
		
		if(pwd == null || pwd == ""){
			alert("비밀번호를 입력해주세요");
			return;
		}else{
			if(pwd == pwd2){
				var flag = confirm("정말 탈퇴하시겠습니까?");
				if(flag == true){
					alert("정상적으로 탈퇴되었습니다.")
					myform.submit();
				}else{
					return;
				}
			}else{
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
		}
	}//deleteCheck end
</script>

<style type="text/css">

	.ff {
		 position: absolute;
	 	 bottom: 0;
	 	 width: 100%;
	 }
	 
</style>

</head>

<body>

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<div style="height: 100px;"></div>
	
	<div>
  		<c:import url="http://localhost:8080/honolja/side_mypage.do">
		</c:import>
	</div>

<div align="center">
	<form name="myform" action="m_delete.do" onsubmit="deleteCheck(); return false;">

	<div style="width: 100px; float: left; margin-left: 40%; font-size: 16pt; font-weight: bold;">비밀번호 </div>
	
	<div style="width: 200px; float: left;">
		<input type="password" id="u_pwd" name="u_pwd" class="form-control">
		<input type="hidden" id="u_pwd2" value="${u_pwd}">
	</div>
	
	<div style="height: 70px;"></div>
	
	<div>
		<input type="submit" class="btn" value="회원탈퇴">
	</div>
		
	</form>
</div>

	<div class="ff">
		<c:import url="http://localhost:8080/honolja/footer.do" />
	</div>
</body>
</html>