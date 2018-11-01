<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>수정</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="./resources/ckeditor/ckeditor.js"></script>

 	<script type="text/javascript">
	  function check( ){
		  var title=myform.b_title.value;
		  var content=CKEDITOR.instances.b_content.getData();
		 
			if (title == "" || title == null) {
				alert("제목을 입력해주세요.");  
			myform.b_title.focus();
			return false;
			}
			if (content == "" || content == null) {
				alert("내용을 입력해주세요.");
			myform.b_content.focus();
			return false;
			}
			document.myform.submit(); 
	  }
	  
	  </script>
	  
</head>

<body id="page-top" style="margin-top:51px;" >
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}" />
		<c:param name="host" value="main.do" />
	</c:import>
<div class="container">
	<h2> <a href="board.do">게시판</a> </h2>
		<form action="boardupdate.do" name="myform" method="post" enctype="multipart/form-data" id="fileform"
			onsubmit="check(); return false;">
			<div class="form-group">
				<label for="usr">제목 :</label> 
				<input type="text" name="b_title" class="form-control" id="b_title" placeholder="제목을 입력하세요." value="${dto.b_title}">
				<br> <label for="comment">내용:</label>
				<textarea name="b_content" class="form-control" rows="10" id="b_content" placeholder="내용을 입력하세요." class="ckeditor" >${dto.b_content} </textarea>
					<script type="text/javascript">
					CKEDITOR.replace('b_content', {height: 400});
					</script>	
			</div>
			<div id="fileDiv">
				<p>
					<input class="multi" type="file" name="b_uploadfilename2" multiple="multiple">
				</p>
				<span style="float: right">
				  <input type="button" onclick="location.href='board.do'" value="목록으로"  class="btn btn-primary"> 
				 <input type="submit" class="btn btn-primary" value="확인"> 
				 </span>
			<c:if test="${dto.b_originalfilename  != null }">
				<img src='${pageContext.request.contextPath}/resources/bupload/${img}' width=100 height=100 border=0> <br> ${dto.b_originalfilename}
			</c:if>
				<br> <br> <br>
				 	<input type="hidden" name="u_id" value="${dto.u_id}"> 
				 	<input type="hidden" name="b_no" value="${dto.b_no}">
			</div>
		</form>
	</div>

		 <br> 
		<p>
		


</body>
</html>
