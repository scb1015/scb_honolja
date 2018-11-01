<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<meta charset="UTF-8">
	<title>[chatting.jsp]</title>
</head>
<body>
	<table border="0" cellspacing = 0 style="width: 100%">
		
		<c:forEach var="rotation" begin="1" end="20">
			<tr>
				<td>운영자채팅 내용 출력</td>
			</tr>
			<tr>
				<td style="text-align: right;">사용자 채팅 내용 출력</td>
			</tr>
		</c:forEach>

	</table>
	<table border="0" cellspacing = 0 
		style="
			width: 100%;
			height: 80px;
			position: fixed;
			bottom: 0;
			left: 0;
			background-color: lightgray;
		">
		<tr>
			<td>
				<textarea class="form-control" id="comment" style = "resize: none; height: 100%;"></textarea>
			</td>
			<td style="width: 80px;">
				<button type="button" class="btn" style="width: 100%;height: 100%;" >전송</button>
			</td>
		</tr>
	</table>
</body>
</html>