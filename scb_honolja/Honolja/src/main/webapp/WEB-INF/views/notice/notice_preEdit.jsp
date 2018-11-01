<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script type="text/javascript" src="./resources/ckeditor/ckeditor.js"></script>


	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 

<title>[notice_detail.jsp]</title>
</head>

<script type="text/javascript">

	function pop(){
		alert("글이 수정되었습니다.");
		myform.submit();
	}
</script>


<body id="page-top" style="margin-top:51px;" >
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
<p>
<br>

<p> <div class="container">
	<form action="notice_edit.do" method="post" name="myform" id="myform" onsubmit="pop(); return false;">
		<input type="hidden" value="${dto.n_no}" name="n_no">
		
	<div class="form-group" style="margin: 0 auto; width:100%;">
			<input type="text" name="n_title" id="n_title" class="form-control" value="${dto.n_title}"> <p>
			<input type="hidden" value="${checked}" >
	</div>
	
		<input type="hidden" value="${dto.n_viewcnt}" name="n_viewcnt" id="n_viewcnt">
		
		<textarea rows="50" name="n_content" id="n_content" class="ckeditor" >${dto.n_content}</textarea>
		<script type="text/javascript">
			CKEDITOR.replace('n_content', {height: 500});
		</script>

		<br>
			<div align="center">
		<input type="checkbox" id="n_fix" name="n_fix" value="Y">
		<label id="">이 공지사항을 목록 상단에 고정합니다.</label>
		<p>
		<input type="submit" class="btn btn-primary" value="수정">
		<input type="reset" class="btn btn-primary" value="새로 작성">
		<input type="button" onclick="location.href='notice.do'" class="btn btn-primary" value="취소">
			</div>
	</form>
</div>

<p>


</body>
</html>