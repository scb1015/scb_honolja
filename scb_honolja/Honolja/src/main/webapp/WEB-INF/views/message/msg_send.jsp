<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function check(){
		var title = myform.m_title.value;
		var rec = myform.m_id.value;
		var content = myform.m_content.value;
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요.");
			return;
		} //제목 체크
		
		if(rec == null || rec == ""){
			alert("받는 사람을 입력해주세요.");
			return;
		} //수신자 체크
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요.");
			return;
		}//내용 체크
		
		var msg = $("#myform").serialize();
		
		$.ajax({
			type : 'POST',
			data : msg,
			url : "msg_insert.do",
			success : function(result) 
			{
				alert("쪽지가 발송되었습니다");
				window.close();
			},
			error : function(error) {
				alert("error : " + error);
			}
		});
		
	}//check end
	
	
</script>
</head>
<body>

<p>

<div class="container">
	<form method="post" name="myform" id="myform" onsubmit="check(); return false;">
	<div class="form-group" style="margin: 0 auto; width:70%;">
		<label for="m_title">Title: </label>
		<input type="text" name="m_title" id="m_title" class="form-control"> <p>
	</div>
	
	<div class="form-group" style="margin: 0 auto; width:70%;">
		<label for="u_id">From: </label>
		<input type="text" name="u_id" value="${checked}" class="form-control" readonly/> <br>
	</div>

	<div class="form-group" style="margin: 0 auto; width:70%;">	 
		<label for="m_id">To: </label>
		<input type="text" name="m_id" id="m_id" value="${receiver}" class="form-control"> <br>
	</div>
	
	<div class="form-group" style="margin: 0 auto; width:70%;">
		<label for="m_content">Content: </label>
		<textarea class="form-control" rows="14" name="m_content" id="m_content"></textarea>
	</div> <p> <br>
	
	<div align="center">
		<input type="submit" class="btn" value="보내기">
		<input type="reset" class="btn" value="새로 작성">
		<input type="button" onclick="javascript:window.close();" class="btn" value="취소">
	</div>
	</form>
</div>


</body>
</html>