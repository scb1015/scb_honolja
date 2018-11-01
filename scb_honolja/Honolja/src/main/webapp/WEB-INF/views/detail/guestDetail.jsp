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
</head>
<body>
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="access_token" value="${access_token}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>
	<div id="myCarousel" class="carousel slide" data-ride="carousel"
		data-interval="false">
		<div class="carousel-inner">
			<c:forEach var="img" items="${img}" varStatus="status">
				<div class="item <c:if test='${status.first}'>active</c:if>">
					<img src="${img.img_url}" alt="" style="width: 100%; height: 400px">
				</div>
			</c:forEach>
		</div>
		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<div class="container">
		<div class="row justify-content-center">
			<div id="detail-info" class="col-sm-8">
				<section>
					<h2 class="detail-info__title">${info.g_name}
						<!-- 좋아요 시작 -->
						<span id="detaillike"> <c:import url="like_button2.jsp"></c:import>
						</span>
						<!-- 좋아요 끝 -->
					</h2>
					<div class="detail-info__address">
						<div>${info.g_addr}</div>
						<div></div>
					</div>
					<div class="detail-info__score">
						<c:choose>
							<c:when test="${avg == 5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i></span>
							</c:when>
							<c:when test="${5 > avg && avg >= 4.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i></span>
							</c:when>
							<c:when test="${4.5 > avg && avg >= 4}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${4 > avg && avg >= 3.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${3.5 > avg && avg >= 3}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${3 > avg && avg >= 2.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${2.5 > avg && avg >= 2}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${2 > avg && avg >= 1.5}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score05"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:when test="${1.5 > avg && avg >= 1}">
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:when>
							<c:otherwise>
								<span class="score-rap"><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:otherwise>
						</c:choose>
						<em> 후기 ${rcnt}개 </em>
					</div>
					<br>
				</section>
				<section>
					<div>
						<ul class="nav nav-tabs nav-justified">
							<li class="active"><a href="#room-info" data-toggle="tab"
								href="#room-info">객실정보</a></li>
							<li><a href="#review" data-toggle="tab" href="#review"
								onclick="review(${g_no})">후기</a></li>
						</ul>
						<div class="tab-content" id="my-tab-content">
							<div class="tab-pane active" id="room-info">
								<c:forEach var="list" items="${list}" varStatus="status">
									<div class="row">
										<div class="col-sm-7">
											<div id="${list.r_no}" class="carousel slide"
												data-ride="carousel" data-interval="false">
												<div class="carousel-inner">
													<div class="item active">
														<img src="${list.img_url}" alt="첫번째 슬라이드" width="500px"
															height="300px">
													</div>
													<div class="item">
														<img src="${list.img_url2}" alt="두번째 슬라이드" width="500px"
															height="300px">
													</div>
													<div class="item">
														<img src="${list.img_url3}" alt="세번째 슬라이드" width="500px"
															height="300px">
													</div>
												</div>
												<a class="left carousel-control" href="#${list.r_no}"
													data-slide="prev"> <span
													class="glyphicon glyphicon-chevron-left"></span> <span
													class="sr-only">Previous</span>
												</a> <a class="right carousel-control" href="#${list.r_no}"
													data-slide="next"> <span
													class="glyphicon glyphicon-chevron-right"></span> <span
													class="sr-only">Next</span>
												</a>
											</div>
										</div>
										<div class="col-sm-4">
											<div>
												<h2>
													<em>${list.r_name}</em>
												</h2>
											</div>
											<p>
											<div>${list.r_content}</div>
											<br>
											<div align="right">
												<font color="#FF69B4" size="15px"><fmt:formatNumber
														value="${list.r_price}" pattern="###,###,###.##" /> </font><i>원</i>
											</div>
											<c:choose>
												<c:when test="${list.res_ok eq res[status.index].res_ok}">
													<button type="button" class="btn btn-primary btn-block"
														disabled>예약불가</button>
												</c:when>
												<c:when test="${empty sessionScope.checked}">
													<button type="button" class="btn btn-primary btn-block"
														onclick="popupWindow('login_popup.do?host=guestdetail.do?g_no=${list.g_no}&adult=${adult}&child=${child}&check_in=${check_in}&check_out=${check_out}&nights=${nights}', 'login', 410, 450)">예약
														하기</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-primary btn-block"
														onclick="reservation(${list.r_no}, ${nights}, ${g_no})">예약
														하기</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<hr>
								</c:forEach>
							</div>
							<div class="tab-pane" id="review">
								<div id="reviews">
									<c:import url="guestReview.jsp"></c:import>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<div class="col-sm-4">
				<div class="datepicker-content">
					<div class="DateRangePicker-top">
						<span class="f-left">체크인</span><span class="f-right">체크아웃</span>
					</div>
					<div class="DateRangePicker">
						<div class="DateRangePickerInput">
							<div class="DateInput DateInput--open-down">
								<div class="col-md-5">
									<input type="text" id="check_in" name="check_in"
										class="datePicker" value="${check_in}"
										placeholder="YYYY/MM/DD">
								</div>
								<div class="col-md-2">
									<span class="glyphicon glyphicon-arrow-right"
										aria-hidden="true"></span>
								</div>
								<div class="col-md-5">
									<input type="text" id="check_out" name="check_out"
										class="datePicker" value="${check_out}"
										placeholder="YYYY/MM/DD">
								</div>
							</div>
						</div>
						<div class="form-group">
							<table style="width: 100%;">
								<tr>
									<td><label for="usr"
										style="display: block; align-content: center;"><font
											color="#fff">성인</font></label> <a
										onclick="countMinus('adult');progress();" href="#"
										style="color: #ff777a;"><span
											class="glyphicon glyphicon-minus"></span></a> &nbsp;&nbsp;<input
										id="adult" name="adult" type="text" class="form-control"
										id="usr" style="width: 35px; display: inline;"
										value="${adult}" readonly="readonly">&nbsp;&nbsp; <a
										onclick="countPlus('adult');progress();" href="#"
										style="color: #ff777a;"><span
											class="glyphicon glyphicon-plus"></span></a></td>
									<td><label for="usr" style="display: block;"><font
											color="#fff">아동</font> </label> <a onclick="countMinus('child');"
										href="#" style="color: #ff777a;"><span
											class="glyphicon glyphicon-minus"></span></a> &nbsp;&nbsp;<input
										id="child" name="child" type="text" class="form-control"
										id="usr" style="width: 35px; display: inline;"
										value="${child}" readonly="readonly">&nbsp;&nbsp; <a
										onclick="countPlus('child');" href="#" style="color: #ff777a;"><span
											class="glyphicon glyphicon-plus"></span></a></td>
								</tr>
							</table>
						</div>
						<div class="DateRangePicker-bottom">
							<span class="f-right" id="nights">${nights}박</span>
						</div>
					</div>
				</div>
				<div id="map" style="width: 400px; height: 400px;" align="center"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
 	var now = new Date();
	var today = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate();
	var today1 = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + (now.getDate() + 7);
	$('#check_in').datepicker({
		header: true,
        footer: true,
        format: 'yyyy/mm/dd',
        minDate: today,
        maxDate: function () {
            return $('#check_out').val();
        }
    });
    $('#check_out').datepicker({
    	header: true,
        footer: true,
        format: 'yyyy/mm/dd',
        minDate: function () {
            return $('#check_in').val();
        },
        change: function (e) {
        	alert("변경 되었습니다.");
        	detail();
        }
    });
    
    function detail() {
    	var g_no = <c:out value='${g_no}'/>;
		var check_in = document.getElementById("check_in").value;
		var check_out = document.getElementById("check_out").value;
		var adult = <c:out value='${adult}'/>;
		var child = <c:out value='${child}'/>;
		
		var _in = check_in.substring(8,10);
		var _out = check_out.substring(8,10);
		var nights = _out - _in;
		
			location.href = 'guestdetail.do?g_no=' + g_no + '&adult='
			+ adult + '&child=' + child + '&check_in='
			+ check_in + '&check_out=' + check_out + '&nights='
			+ nights;
	}

		var	x=<c:out value='${info.g_position_n}'/>;
		var	y=<c:out value='${info.g_position_e}'/>;
			
		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(x, y),
			zoomControl: true,
			zoomControlOptions: {
			    style: naver.maps.ZoomControlStyle.SMALL,
			    position: naver.maps.Position.TOP_RIGHT
				}
			});

		var	marker=new naver.maps.Marker({
			position :	new naver.maps.LatLng(x, y),
			map : map
			});	
	
		function countPlus(id){
			
			var value = document.getElementById(id).value;		
			
			if(value == 9){
				document.getElementById(id).value = 9;
			}else{
				value++;
				document.getElementById(id).value = value;
			}
			
		}
		
		function countMinus(id){
			
			var value = document.getElementById(id).value;		
			
			if(value == 0){
				document.getElementById(id).value = 0;
			}else{
				value--;
				document.getElementById(id).value = value;
			}
			
		}; 
		
	</script>

	<c:import url="detailModal.jsp"></c:import>
	<c:import url="http://localhost:8080/honolja/footer.do"></c:import>
</body>
</html>