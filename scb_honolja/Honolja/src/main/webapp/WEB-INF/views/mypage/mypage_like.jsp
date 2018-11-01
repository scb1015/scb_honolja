<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage_like.jsp</title>

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	
	 <style type="text/css">
	 
	.ff {
		position: relative;
		bottom: 0;
		width: 100%;
	}
	 
	table.ta {
    	border-collapse: separate;
    	border-spacing: 1px;
    	text-align: center;
    	line-height: 1.5;
    	border-top: 1px solid #ccc;
    	border-bottom: 1px solid #ccc;
  		margin : 20px 10px;
	}

	table.ta td {
    	width: 350px;
    	padding: 10px;
    	border-bottom: 1px solid #ccc;
	}
	 
	 </style>
</head>

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

	<div style="height: 100px;"></div>
	
	<div>
  		<c:import url="http://localhost:8080/honolja/side_mypage.do">
		</c:import>
	</div>


<div align="center">

<h1>LikeList</h1>


	<table class="ta">
	<c:forEach var="listL" items="${listL}">
		<tr>
			<td rowspan="2"><img src = "${listL.g_url}" width="500px" height="180px"></td>
			<td><a href="guestdetail.do?g_no=${listL.g_no}">${listL.g_name}</a></td>
		</tr>
		
		<tr>
			<td>${listL.g_addr}</td>
		</tr>
	</c:forEach>
	</table>

</div>

<div style="height: 100px;"></div>


	<div class="ff">
		<c:import url="http://localhost:8080/honolja/footer.do" />
	</div>

</body>
</html>