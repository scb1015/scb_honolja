<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
	
	<style type="text/css">
		.listform {
			width: 1000px;
			margin-left: 30%;
			margin-top: 100px;
		}
	</style>
	<script type="text/javascript">
			function member(selectedIndex){
				if(selectedIndex == "1"){
					selectedIndex = "일반회원"
				}else if(selectedIndex == "2"){
					selectedIndex = "점주"
				}else if(selectedIndex == "3"){
					selectedIndex = "관리자"
				}else{
					selectedIndex = ""
				}
				location.href="m_list.do?u_member=" + selectedIndex;
			}
			
			$(document).ready(function(){
				var umember = document.getElementById("umember").value;
				$("#u_member").val(umember).prop("selected", true);
			});
	</script>
</head>
<body id="page-top" style="margin-top:51px;">
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	
	<div class="listform">
		<table class="table table-hover" >
			<tr>
			 	<td colspan="9" align="center">
			 	<input type="hidden" id="umember" value="${u_member}">
			 		<select id="u_member" onchange="member(this.selectedIndex);">
			 			<option value="전체" selected>전체</option>
			 			<option value="일반회원">일반회원</option>
			 			<option value="점주">점주</option>
			 			<option value="관리자">관리자</option>
			 		</select>
					총 회원수 : ${cnt}
				</td>
			</tr>
			<tr>
				<td>번호</td> <td>구분</td> <td>아이디</td> <td>이름</td>
				<td>성별</td> <td>전화번호</td> <td>이메일</td> <td>등록날짜</td> <td>수정날짜</td>
			</tr>
			<c:forEach var="mto" items="${list}">
			<tr>
				<td>${mto.rn}</td>
				<td>${mto.u_member}</td>
				<td id="u_id"><a style="color:black;" href="m_detail.do?idx=${mto.u_no}">${mto.u_id}</a></td>
				<td>${mto.u_name}</td>
				<td>${mto.u_gender}</td>
				<td>${mto.u_phn}</td>
				<td>${mto.u_email}</td>
				<td>${mto.u_date}</td>
				<td>${mto.u_update}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
		<div style="margin-left:55%; margin-top:10px;">
			<ul class="pagination">
		      		<c:if test="${startpage>10}">
		      			<li><a href="m_list.do?pageNum=${startpage-10}&u_member=${u_member}">[이전]</a></li>
		      		</c:if>
		      		<c:forEach var="i" begin="${startpage}" end="${endpage}">
		      			<c:choose>
					 	 	<c:when test="${pageNUM==i}">
					 	 		<li class="active"><a href="m_list.do?pageNum=${i}&u_member=${u_member}">${i}</a></li>
					 	 	</c:when>
					 	 	<c:otherwise>
					 	 		<li><a href="m_list.do?pageNum=${i}&u_member=${u_member}">${i}</a></li>
					 	 	</c:otherwise>
					 	</c:choose>
		      		</c:forEach>
		      		<c:if test="${endpage<pagecount}">
		      			<li><a href="m_list.do?pageNum=${startpage+10}&u_member=${u_member}">[다음]</a></li>
		      		</c:if>
			</ul>
		</div>
		<form action="m_list.do" style="margin-left: 47%;">
			<select name="keyfield">
				<option value="" selected>전체검색</option>
				<option value="u_id">아이디검색</option>
				<option value="u_name">이름검색</option>
			</select>
			<input type="text" name="keyword">
			<input type="submit" class="btn btn-primary" style="font-size:8pt; font-weight:bold;" value="검색">
		</form>
</body>
</html>