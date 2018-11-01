<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>모임게시판</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

 <style>
    }
    .table-hover > tbody > tr:hover {
      background-color: #e6ecff;
    }
    		.btn_write {
			margin-left: 76%;
		}
  </style>
</head>

<body id="page-top" style="margin-top:51px;" >

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}" />
		<c:param name="host" value="main.do" />
	</c:import>
	
	<div class="container">
	<p>
	<br>
	<h1 > <a href="board.do">자유게시판</a> </h1>
	<p> 
	<br>
	
	
		<table class="table table-hover">
			<thead>
				<tr align="center"> 
					<td width="10%">No</td>
					<td width="50%">제목</td>
					<td width="10%">작성자</td>
					<td width="20%">작성일</td>
					<td width="10%">조회</td>
				</tr>
			</thead>
			
			<tbody>

  
  <c:forEach items="${list}" var="list">
 <tr align="center">
	<td><span class="label label-primary">공지</span></td>
 	<td><a style="background-color:white; color:#337ab7;" href="notice_detail.do?idx=${list.n_no}">${list.n_title}</a></td>
 	<td><a href="javascript:void(window.open('msg_send.do?userid=${checked}&receiver=${dto.u_id}', 'text', 'width=440, height=650, top=100, left=100'))"><font color="ㅈ">${list.u_id}</font><span class="glyphicon glyphicon-envelope"></span></a></td>
 	<td><fmt:parseDate value="${list.n_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
      <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd HH:mm"/></td>
 	<td>${list.n_viewcnt}</td>
 </tr>
 </c:forEach>
			
			
			<tbody>
				<c:forEach var="dto" items="${LB}" varStatus="status">
				
						<tr align="center">
							<td width="10%">${(Gtotal-status.index)-((pageNUM-1) * 7)}</td>
							<td width="50%"><a href="boarddetail.do?idx=${dto.b_no}"><font color="black">${dto.b_title}</font></a> 
							<font color="#ff0000">[${dto.cnt}]</font> 
							<c:if test="${dto.b_originalfilename != null }">	<li class="glyphicon glyphicon-picture"></li></c:if> </td>
							<td width="10%"><a href="javascript:void(window.open('msg_send.do?userid=${checked}&receiver=${dto.u_id}', 'text', 'width=440, height=650, top=100, left=100'))"><font color="black">${dto.u_id}</font><span class="glyphicon glyphicon-envelope"></span></a></td>
					 		<td width="20%">
      <fmt:formatDate value="${dto.b_date}" pattern="yyyy-MM-dd HH:mm"/></td>
							<td width="10%">${dto.b_viewcnt}</td>
						</tr>
				</c:forEach>
			</tbody>
			
					<tr align="center">
						<td colspan="5">
						<span style="float: right">
						<input type="button" class="btn btn-primary" value="글쓰기" onclick="location.href='boardwrite.do'"> 
						</span>
						<c:if test="${startpage>10}">
								<a href="board.do?pageNum=${startpage-10}">《 </a>
						</c:if> 
						<c:forEach var="i" begin="${startpage}" end="${endpage}">
								<c:choose>
									<c:when test="${pageNUM==i}"><font color=red>${i}</font> </c:when>
										<c:otherwise>
											<a href="board.do?pageNum=${i}${returnpage}">${i} </a>
										</c:otherwise>
								</c:choose>
						</c:forEach>
							 <c:if test="${endpage<pagecount}"> 
							 <a href="board.do?pageNum=${startpage+10}"> 》 </a>
							</c:if> &nbsp;&nbsp;&nbsp;&nbsp;</td>
						</tr>
		</table>
				
			<table align="center">	
				<tr align="center">
					<td colspan="6" align="center">
						<form name="myform2" action="board.do">
							<div class="input-group" style="float: left; width: 150px;">
								<select name="keyfield" class="form-control" name="keyfield">
									<option value="" selected="selected">전체검색
									<option value="b_title" <c:if test="${skey eq 'b_title'}">selected</c:if>>제목검색</option>
									<option value="b_content" <c:if test="${skey eq 'b_content'}">selected</c:if>>내용검색</option>
									<option value="u_id" <c:if test="${skey eq 'u_id'}">selected</c:if>>아이디검색</option>
								</select> 
							</div>
							
						<div class="input-group" style="float: right; width: 200px;">
								<input type="text" name="keyword" value="${sval}" class="form-control" placeholder="Search">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
							</div>
						</div>
						</form>
					</td>
				</tr>
			</table>
			
		</div>
	
<div class="foot" style="position:absolute; bottom:0%; width:100%; ">
	<c:import url="http://localhost:8080/honolja/footer.do"/>
</div>
	
</body>
</html>