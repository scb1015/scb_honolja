<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<title>[notice_detail.jsp]</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<style type="text/css">
	
		#con {
			padding-top: 50px;
			padding-left: 20px;
		}

	</style>
  	 
</head>

<script type="text/javascript">

	function delete_check(){
		
		var msg = confirm("정말로 삭제하시겠습니까?");
		
		if ( msg == true ){
			alert("공지사항이 삭제되었습니다.");
			location.href='notice_delete.do?idx='+${dto.n_no};
		}
		
	}//삭제 확인

</script>

<body id="page-top" style="margin-top:51px;" >
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

<p>
<br>

<div class="container">
	<table border="2" align="center" class="table table-bordered" style="width: 70%">
		<tr> 
			<td><b>Title:</b> ${dto.n_title}</td>
			<td style="color: grey" align="center">
				<fmt:parseDate value="${dto.n_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
 
 		<tr>
			<td colspan="2"><b>Writer:</b> ${dto.u_id} <a href="javascript:void(window.open('msg_send.do?userid=${checked}&receiver=${dto.u_id}', 'text', 'width=440, height=650, top=100, left=100'))">
				<span class="glyphicon glyphicon-envelope"></span></a>
			</td>
		</tr>
 
		<%pageContext.setAttribute("newLineChar", "\n");%>
		<tr height="700">
			<td colspan="2" id="con">${fn:replace(dto.n_content, newLineChar, "<br/>")}</td>
		</tr>
 
		<tr align="right">
			<td colspan="2">
				<input type="button" class="btn btn-primary" value="목록으로" onclick="location.href='notice.do'"> &nbsp;&nbsp;
					<c:if test="${u_member eq '관리자'}">
				<input type="button" class="btn btn-primary" value="수정" onclick="location.href='notice_preEdit.do?idx=${dto.n_no}'"> &nbsp;&nbsp;
				<input type="button" class="btn btn-primary" value="삭제" onclick="delete_check(); return false;"> &nbsp;&nbsp;
					</c:if>
			</td>
		</tr> 
	</table>
</div>
</body>
</html>