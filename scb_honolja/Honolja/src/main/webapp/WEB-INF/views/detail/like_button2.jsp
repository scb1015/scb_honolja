<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>[혼놀자]</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<script type="text/javascript">

</script>
<body>
	<c:set value="${sessionScope.checked}" var="u_id"></c:set>
	<c:choose>
		<c:when test="${empty sessionScope.checked}">
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${btn_flag == 1}">
					<button type="button" class="btn btn-primary"
						onclick="detaillike_btn(${btn_flag}, ${g_no}, '${u_id}');">
						<span class="glyphicon glyphicon-thumbs-up"></span> Like
					</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-default btn-sm"
						onclick="detaillike_btn(${btn_flag}, ${g_no}, '${u_id}');">
						<span class="glyphicon glyphicon-thumbs-up"></span> Like
					</button>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
</body>
</html>