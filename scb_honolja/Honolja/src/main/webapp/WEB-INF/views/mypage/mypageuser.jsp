<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="css/styles_side.css" rel="stylesheet" type="text/css">
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>

	<style type="text/css">
	 
		.img-circle {
			border-radius: 50%;
			width: 150px;
			height: 150px; 
		}
	 
		.ff {
			position: relative;
			bottom: 0;
			width: 100%;
		}

		#member {
			background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
			width: 100%; 
			height: 75%;
			padding: 50px;
		}

		table.minfo {
			text-align: left;
			margin : 20px 10px;
		}

		table.minfo td {
			width: 320px;
			vertical-align: top;
			padding: 20px;
		}

		#ttop {
			border-top: 1px solid #ccc;
		}

		#tbottom {
			border-bottom: 1px solid #ccc;
		}

		#tbold {
			font-weight: bold;
		}
	 
	 </style>
</head>

<body>

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<div style="height:100px;"></div>
	
	<div>
  		<c:import url="http://localhost:8080/honolja/side_mypage.do">
		</c:import>
	</div>

		
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <div class="modal-content">

          

      </div>
      
    </div>
</div>
		

<div class="tt" align="center">
	<table class="minfo">
		<tr>
			<td colspan="2"><img src="./image/${mto.u_img}" class="img-circle"></td>
			<td align="right" valign="bottom"><button type="button" class="btn btn-default" href="useredit.do" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-cog"></i></button></td>
		</tr>
		
		<tr>
			<td rowspan="3" id="ttop" style="font-size: large; font-weight: bold;">아이디</td>
			<td id="ttop" style="font-weight: bold;">HONOLJA 아이디</td>
			<td id="ttop">${mto.u_id}</td>				
		</tr>
		<tr>
			<td id="tbold">가입일</td>
			<td> 					
				<fmt:parseDate value="${mto.u_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
      			<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
			</td> 
		</tr>
		<tr>
			<td id="tbold">회원 구분</td>
			<td>${mto.u_member}</td>
		</tr>
		
		<tr>
			<td rowspan="3" id="ttop" style="font-size: large; font-weight: bold;">이름/연락처</td>
			<td id="ttop" style="font-weight: bold;">이름</td>
			<td id="ttop">${mto.u_name}</td>
		</tr>
		<tr>
			<td rowspan="2" id="tbold">연락처</td>
			<td><span class="glyphicon glyphicon-phone"></span>&nbsp;${mto.u_phn}</td>
		</tr>
		<tr>
			<td><span class="glyphicon glyphicon-envelope"></span>&nbsp;${mto.u_email}</td>
		</tr>
		
		<tr>
			<td rowspan="2" id="ttop" style="font-size: large; border-bottom: 1px solid #ccc; font-weight: bold;">개인정보</td>
			<td id="ttop" style="font-weight: bold;">성별</td>
			<td id="ttop">${mto.u_gender}</td>
		</tr>
		<tr>
			<td id="tbottom" style="font-weight: bold;">생일</td>
			<td id="tbottom">${mto.u_birth}</td>
		</tr>

		<c:if test="${mto.u_member eq '점주'}">
>>>>>>> branch 'master' of https://github.com/duracelldog/Honolja
			<tr>
				<td rowspan="3" id="ttop" style=" font-weight: bold; font-size: large; border-bottom: 1px solid #ccc;">게스트하우스 정보</td>
				<td id="ttop" style="font-weight: bold;">게스트하우스 이름</td>
				<td id="ttop">${mto.u_guestname}</td>
			</tr>
			
			<tr>
				<td id="tbold">게스트하우스 주소</td>
				<td>${mto.u_postcode}  ${mto.u_guestjuso}</td>
			</tr>
			
			<tr>
				<td id="tbottom" style="font-weight: bold;">게스트하우스 연락처</td>
				<td id="tbottom">${mto.u_guestnum}</td>
			</tr>
		</c:if>
	</table>
</div>		
	
	<div style="height: 100px;"></div>
		
	<div class="ff">
		<c:import url="http://localhost:8080/honolja/footer.do" />
	</div>
	
</body>
</html>