<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[like_btn.jsp]</title>
</head>
<body>
	<c:choose>
		<c:when test="${param.btn_flag == 'like' }">
			<button type="button" class="btn btn-primary" onclick = "like_btn_ajax(1);">
				<span class="glyphicon glyphicon-thumbs-up"></span> Like
			</button>
		</c:when>
		<c:when test="${param.btn_flag == 'unlike' }">
			<button type="button" class="btn btn-danger" onclick = "like_btn_ajax(2);">
				<span class="glyphicon glyphicon-thumbs-down"></span> Unlike
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-default btn-sm" onclick = "like_btn_ajax(3);">
				<span class="glyphicon glyphicon-thumbs-up"></span> Like
			</button>
		</c:otherwise>
	</c:choose>
</body>
</html>