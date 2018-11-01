<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		.btn_write {
			margin-left: 76%;
		}
		
		.foot {
			position: absolute;
			bottom: 0;
			width: 100%;	 
	 }
	 
	</style>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>[notice.jsp]</title>

</head>

<body id="page-top" style="margin-top:51px;" >

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

<div class="container"><p><br>

<h1>공지사항</h1><p><br>

<table  class="table">
	<tr align="center" style="background-color: #F6F6F6;">
		<td><b>No</b></td>
		<td><b>제목</b></td>
		<td><b>작성자</b></td>
		<td><b>작성일</b></td>
		<td><b>조회수</b></td>
	</tr>
 
	<c:set var="reversecnt" value="${reversecnt+1}"></c:set>
  
	<c:forEach items="${dto}" var="list">
	<tr align="center">
		<c:choose>
			<c:when test="${list.n_fix eq 'N'}"><td>${reversecnt=reversecnt-1}</td></c:when>
			<c:otherwise><td><span class="label label-primary">공지</span></td></c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${list.n_fix eq 'N'}">
				<td><a href="notice_detail.do?idx=${list.n_no}">${list.n_title}</a></td>
			</c:when>
			<c:otherwise>
				<td><a href="notice_detail.do?idx=${list.n_no}"><b>${list.n_title}</b></a></td>
			</c:otherwise>
		</c:choose>
 	
		<td>${list.u_id}</td>
		<td><fmt:parseDate value="${list.n_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
			<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd HH:mm"/></td>
		<td>${list.n_viewcnt}</td>
	</tr>
	</c:forEach>
 
</table>

<div align="center">
	<ul class="pagination">
		<c:if test="${startpage>5}">
			<a href="notice.do?pageNum=${startpage-5}${returnpage}">[이전]</a>
		</c:if>
 
	<c:forEach var="i" begin="${startpage}" end="${endpage}">
		<c:choose>
			<c:when test="${pageNUM==i}">
				<li class="active"><a>${i}</a></li>
			</c:when>
		<c:otherwise>
			<li class="active"><a style="background-color:white; color:#337ab7;" href="notice.do?pageNum=${i}${returnpage}">${i}</a></li>
		</c:otherwise>
		</c:choose>
 	</c:forEach>
 	
 		<c:if test="${endpage<pagecount}">
			<a href="notice.do?pageNum=${startpage+5}${returnpage}">[다음]</a>
 		</c:if>
	</ul>
</div>

<form name="search" action="notice.do">
	<div class="input-group" style="float: right; width: 200px;">
		<input type="text" name="keyword" value="${sval}" class="form-control" placeholder="Search" name="search">
		<div class="input-group-btn">
			<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
		</div>
	</div>
	<div class="form-group" style="float: right; width: 150px;" >
		<select class="form-control" name="keyfield" value="${skey}">
			<option value="n_title" <c:if test="${skey eq 'n_title'}">selected</c:if>>제목검색</option>
			<option value="n_content" <c:if test="${skey eq 'n_content'}">selected</c:if>>내용검색</option>
		</select>
	</div>

</form>
</div>

<div class="btn_write">
 	 <c:if test="${u_member eq '관리자'}"> 
	 <input type="button" class="btn btn-primary" value="글 작성" onclick="location.href='notice_insert.do'"> &nbsp;
 	</c:if>
</div>

<div class="foot">
	<c:import url="http://localhost:8080/honolja/footer.do" />
</div>

</body>
</html>