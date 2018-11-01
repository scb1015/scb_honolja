<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<script type="text/javascript" src="./resources/ckeditor/ckeditor.js"></script>


	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./resources/ckeditor/ckeditor.js"></script>
 

<title>[notice_insert.jsp]</title>
<script type="text/javascript">

	function blank_check(){
		var title = myform.n_title.value;
		var content = CKEDITOR.instances.n_content.getData();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요.");
			return false;
		}//content end
		
		myform.submit();
	}//blank_check end
	
</script>

</head>
<body id="page-top" style="margin-top:51px;" >
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

<p><br><p><br>  

<div align="center">
<form action="notice_insert.do" method="post" name="myform" id="myform" onsubmit="blank_check(); return false;" style="width:1000px; height:1000px;">

	<div class="form-group" style="margin: 0 auto; width:100%;">
			<input type="text" name="n_title" id="n_title" class="form-control" placeholder="제목을 입력해주세요."> <p>
			<input type="hidden" value="${checked}" >
	</div>

			<textarea rows="50" name="n_content" id="n_content" class="ckeditor"></textarea>
			<script type="text/javascript">
    			CKEDITOR.replace('n_content', {height: 500});
			</script>	
<p>			

	<div align="center">
		<input type="checkbox" id="n_fix" name="n_fix" value="Y">
		<label id="">이 공지사항을 목록 상단에 고정합니다.</label> <br> <p>
			<input type="submit" class="btn btn-primary" value="등록">
			<input type="reset" class="btn btn-primary" value="새로 작성">
			<input type="button" onclick="location.href='notice.do'" class="btn btn-primary" value="취소">
	</div>
</form>
</div>

</body>

</html>