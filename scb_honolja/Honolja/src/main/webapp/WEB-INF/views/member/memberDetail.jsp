<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
	
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			var g1 = document.getElementById("g1").value;
			var g2 = document.getElementById("g2").value;
			var g3 = document.getElementById("g3").value;
			 if(g1 == "" || g1 == null){
				$("#guest1").style.display = "none";
				$("#guest2").style.display = "none";
				$("#guest3").style.display = "none";
			}else{
				document.getElementById("guest1").style.display = "";
				document.getElementById("guest2").style.display = "";
				document.getElementById("guest3").style.display = "";
			}
		});
	 </script>
</head>
<body id="page-top" style="margin-top:51px;">

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<table class="table table-bordered" style="width: 500px; margin: 0 auto;">
				<thead><tr>  <th scope="row">회원번호</th> <td> ${mto.u_no} </td>  </tr></thead>
				<tr>  <th scope="row">프로필이미지</th>  <td> <img src="./image/${mto.u_img}" width="100" height="135">  </td>  </tr>
				<tr>  <th scope="row">구분</th>  <td> ${mto.u_member} </td>  </tr>
				<tr>  <th scope="row">아이디</th>  <td> ${mto.u_id} </td>  </tr>
				<tr>  <th scope="row">이름</th>  <td> ${mto.u_name} </td>  </tr>
				<tr>  <th scope="row">성별</th>  <td> ${mto.u_gender} </td>  </tr>
				<tr>  <th scope="row">이메일</th>  <td> ${mto.u_email} </td>  </tr>
				<tr>  <th scope="row">생년월일</th>  <td> ${mto.u_birth} </td>  </tr>
				<tr>  <th scope="row">핸드폰</th>  <td> ${mto.u_phn} </td>  </tr>
				<tr>  <th scope="row">등록날짜</th>  <td> ${mto.u_date} </td>  </tr>
				<tr>  <th scope="row">수정날짜</th>  <td> ${mto.u_update} </td>  </tr>
				<tr id="guest1" style="display:none">  <th scope="row">게스트하우스 이름</th>  <td> <input type="text" id="g1" value="${mto.u_guestname}"> </td>  </tr>
				<tr id="guest2" style="display:none">  <th scope="row">게스트하우스 주소</th>  <td> <input type="text" id="g2" value="${mto.u_postcode}  ${mto.u_guestjuso}">  </td>  </tr>
				<tr id="guest3" style="display:none">  <th scope="row">게스트하우스 연락처</th> <td> <input type="text" id="g3" value="${mto.u_guestnum}"> </td>  </tr>
	</table>

</body>
</html>