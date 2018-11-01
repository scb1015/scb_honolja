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
<!-- 달력 사용하기  -->
<script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js"
	type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css"
	rel="stylesheet" type="text/css" />

<script src="./resources/js/detail.js"></script>
<link rel="stylesheet" href="./resources/css/detail.css" />
<style type="text/css">
.payment-topcont.pc {
	padding: 30px 0;
}

.payment-topcont {
	position: relative;
}

.payment-topcont.pc .image-box {
	top: 30px;
	left: 0;
	width: 270px;
	height: 180px;
}

.payment-topcont.pc .image-box img {
	width: 100%;
}

img {
	border: 0;
	vertical-align: top;
}

.payment-topcont.pc .info-box {
	margin-left: 270px;
	padding-left: 30px;
	min-height: 180px;
}

.room-name {
	color: #333;
	font-size: 28px;
	margin-top: 10px;
	font-weight: 400;
}

.place-name {
	color: #333;
	font-size: 15px;
	margin-top: 10px;
}

.room-standard {
	color: #333;
	font-size: 15px;
	margin-top: 15px;
}

.DateRangePicker-top1 {
	padding: 0 20px;
}

.datepicker-content1 {
	background-color: #595f63;
	color: #fff;
	padding-top: 30px;
	padding-bottom: 30px;
}

.DateRangePicker1 {
	font-size: 20px;
	color: #fff;
	box-sizing: border-box;
	margin: 10px 0 20px;
	padding: 0 20px;
	width: 100%;
	position: relative;
	display: inline-block;
	border: 0 none;
	background: none;
}

.DateInput1 {
	display: inline-block;
	position: relative;
	background: none;
	padding: 0;
	font-size: 15px;
}

.DateRangePicker-day {
	padding: 0 18px 20px;
	padding-bottom: 15px;
}

.DateRangePicker-bottom {
	border-top: 1px solid #888;
	font-size: 13px;
	color: #fff;
	padding: 10px 0;
	margin: 0 20px;
}

.btn-payment {
	-webkit-background: linear-gradient(top, #ff4143, #ff2d60);
	background: linear-gradient(top, #ff4143, #ff2d60);
	background: #ff4143;
	background: -webkit-gradient(linear, left top, right bottom, color-stop(0, #ff4143),
		color-stop(100%, #ff2d60));
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#ff4143",
		endColorstr="#ff1764", GradientType=0);
	color: #fff;
	font-size: 18px;
	width: 100%;
	height: 60px;
}
</style>
<script type="text/javascript">
	function resAdd() {

		var dataForm = $("#resForm").serialize();

		var g_no = <c:out value='${list.g_no}'/>;
		var check_in = document.getElementById("check_in").value;
		var check_out = document.getElementById("check_out").value;
		var adult = <c:out value='${adult}'/>;
		var child = <c:out value='${child}'/>;
		var nights = <c:out value='${nights}'/>;

		$.ajax({
			url : 'reservationAdd.do',
			type : 'post',
			data : dataForm,
			success : function(data) {
				if (data == "success") {
					alter("예약 되었습니다.");
					location.href = 'guestdetail.do?g_no=' + g_no + '&adult='
							+ adult + '&child=' + child + '&check_in='
							+ check_in + '&check_out=' + check_out + '&nights='
							+ nights;
					$("#modal_title").html("확인");
					$("#modal_body").html("예약 되었습니다.");
					$('#ignismyModal').modal('show');

				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
</script>
</head>
<body>
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="access_token" value="${access_token}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	<div class="container" style="margin-top: 70px; height: 700px">
		<div class="row">
			<c:set var="u_id" value="${sessionScope.checked}" />
			<form method="post" id="resForm">
				<input type="hidden" name="u_id" value="${u_id}"> <input
					type="hidden" name="r_name" value="${list.r_name}"> <input
					type="hidden" name="adult" value="${adult}"> <input
					type="hidden" name="child" value="${child}"> <input
					type="hidden" name="res_price" value="${list.r_price}"> <input
					type="hidden" name="r_no" value="${list.r_no}"> <input
					type="hidden" name="g_no" value="${list.g_no}"> <input
					type="hidden" name="nights" value="${nights}">
				<div class="col-md-7">
					<div class="image-box">
						<img src="${list.img_url}" alt="${list.r_name}">
					</div>
					<div class="info-box">
						<div class="room-name">${list.r_name}</div>
						<div class="place-name">${list.g_name}</div>
						<div class="place-address">${list.g_addr}</div>
						<div class="room-standard">
							<span>${list.r_content}</span>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="datepicker-content1">
						<div class="DateRangePicker-top1">
							<span class="f-left">체크인</span><span class="f-right">체크아웃</span>
						</div>
						<div class="DateRangePicker1">
							<div class="DateRangePickerInput">
								<div class="col-md-5">
									<input type="text" id="check_in" name="check_in"
										value="${check_in}" placeholder="YYYY/MM/DD">
								</div>
								<div class="col-md-2">
									<span class="glyphicon glyphicon-arrow-right"
										aria-hidden="true"></span>
								</div>
								<div class="col-md-5">
									<input type="text" id="check_out" name="check_out"
										value="${check_out}" placeholder="YYYY/MM/DD">
								</div>
							</div>
						</div>
						<div class="DateRangePicker-day">
							<span class="f-left">14:00 이후</span><span class="f-right">11:00
								이전</span>
						</div>
						<br>
						<div class="DateRangePicker-bottom">
							<span class="f-left">성인 : ${adult}</span><span>아동 :
								${child}</span> <span class="f-right" id="nights">${nights}박</span>
						</div>
						<br>
						<div class="f-right" id="res_price"
							style="margin: 0 20px; font-size: 15px;">
							<fmt:formatNumber value="${list.r_price}"
								pattern="###,###,###.##" />
							<i>원</i>
						</div>
					</div>
					<button type="button" class="btn-payment btn-block"
						onclick="resAdd()">예약하기</button>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#check_in").datepicker({
				format : 'yyyy/mm/dd'
			});
			$("#check_out").datepicker({
				format : 'yyyy/mm/dd'
			});
		});
	</script>
	<c:import url="detailModal.jsp"></c:import>
	<c:import url="http://localhost:8080/honolja/footer.do"></c:import>
</body>
</html>