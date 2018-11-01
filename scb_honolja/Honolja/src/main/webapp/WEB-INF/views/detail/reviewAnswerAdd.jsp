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
		<form id="answerForm" method="post" action="answerAdd.do">
			<input type="hidden" value="" name="u_guestname"> <input
				type="hidden" value="${re_no}" name="re_no"> <input
				type="hidden" value="${g_no}" name="g_no"> <span><strong>관리자답변</strong></span>
			<c:set var="u_id" value="${sessionScope.checked}"></c:set>
			<div class="form-group">
				<div class="form-control">${u_id}</div>
			</div>
			<div class="form-group">
				<textarea class="form-control" rows="3" cols="100%" id="a_content"
					name="a_content"></textarea>
			</div>
			<div class="form-group pull-right">
				<button class="btn btn-info" type="button" data-toggle="modal"
					onclick="answerAdd(${re_no})">등록</button>
			</div>
		</form>
	</div>
	<c:import url="detailModal.jsp"></c:import>
</body>
</html>