<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>[혼놀자]</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=lpJuL0fDxe8fMB7Sysgn&submodules=geocoder"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=lpJuL0fDxe8fMB7Sysgn&submodules=geocoder"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./resources/js/detail.js"></script>

<link rel="stylesheet" href="./resources/css/detail.css" />

</head>
<body>
	<div class="container-fluid">
		<table class="table">
			<tr>
				<td>
					<div class="review-userinfo">
						<div class="col">
							<img
								src="//member.yanolja.com/include/img/picture/default_picture.png"
								class="img-circle" alt="프로필사진" width="34px;" /> <span
								class="nicname">${answer.u_guestname}</span><i class="bar"></i><span
								class="date"><fmt:formatDate value="${answer.a_date}"
									pattern="yyyy-MM-dd" /></span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>${answer.a_content}</td>
			</tr>
			<tr>
				<td><div class="btn-group pull-right">
						<button type="submit" class="btn btn-info" role="button"
							data-toggle="modal"
							onclick="answerDel(${answer.re_no}, ${answer.a_no},${g_no})">삭제</button>
					</div></td>
			</tr>
		</table>
	</div>
	<c:import url="detailModal.jsp"></c:import>
</body>
</html>