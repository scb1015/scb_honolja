<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>[like_btn.jsp]</title>
</head>
<body>
	<c:choose>
		<c:when test="${btn_flag == 1}">
			<button type="button" class="btn btn-primary"
				onclick="like_btn(1,${g_no}, '${u_id }');">
				<span class="glyphicon glyphicon-thumbs-up"></span> Like
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-default btn-sm"
				onclick="like_btn(2,${g_no}, '${u_id }');">
				<span class="glyphicon glyphicon-thumbs-up"></span> Like
			</button>
		</c:otherwise>
	</c:choose>
</body>
</html>