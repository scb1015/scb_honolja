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
		<form id="modifyForm" method="post">
			<input type="hidden" value="${review.re_no}" name="re_no"> <input
				type="hidden" value="${review.u_id}" name="u_id"> <input
				type="hidden" value="${review.r_name}" name="r_name"> <input
				type="hidden" value="${review.g_no}" name="g_no">
			<div class="row">
				<c:if test="${review.re_img != null}">
					<div class="col-sm-4">
						<div class="place-review__image"
							style="background-image: url(./resources/images/${review.re_img}.jpg); background-size: cover; background-position: center center;"></div>
					</div>
				</c:if>
				<br>
				<div class="col" class="review-info">
					<div class="review-info__title">
						<div class="form-group">
							<span class="badge-rap"><i class="badge-best"><em>${review.re_like}</em></i></span>
							<c:if test="${review.re_score == 5 }">
								<span class="score-rap pull-right"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i></span>
							</c:if>
							<c:if test="${review.re_score == 4 }">
								<span class="score-rap pull-right"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:if>
							<c:if test="${review.re_score == 3 }">
								<span class="score-rap pull-right"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:if>
							<c:if test="${review.re_score == 2 }">
								<span class="score-rap pull-right"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:if>
							<c:if test="${review.re_score == 1 }">
								<span class="score-rap pull-right"><i
									class="icon-staylist icon-staylist-score score10"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i><i
									class="icon-staylist icon-staylist-score score00"></i></span>
							</c:if>
						</div>
					</div>
					<div class="form-group">
						<input class="form-control" type="text" name="re_title"
							value="${review.re_title}">
					</div>
					<div class="form-group">
						<textarea class="form-control" rows="4" cols="100%"
							name="re_content">${review.re_content}</textarea>
					</div>
					<div class="review-userinfo">
						<div class="form-group col-md-4">
							<img
								src="//member.yanolja.com/include/img/picture/default_picture.png"
								class="img-circle" alt="프로필사진" width="34px;" /> <span
								class="nicname">${review.u_id}</span><i class="bar"></i><i
								class="bar"></i><span class="date"><fmt:formatDate
									value="${review.re_date}" pattern="yyyy-MM-dd" /></span>
						</div>
						<div class="form-group col-md-3">
							<select class="form-control sm-3" id="re_like" name="re_like">
								<option value="추천" selected="selected">추천</option>
								<option value="비추천">비추천</option>
							</select>
						</div>
						<div class="form-group col-md-3">
							<select class="form-control sm-3" id="re_score" name="re_score">
								<option selected="selected">별점</option>
								<option value="1">★</option>
								<option value="2">★★</option>
								<option value="3">★★★</option>
								<option value="4">★★★★</option>
								<option value="5">★★★★★</option>
							</select>
						</div>
						<div class="btn-group pull-right">
							<button type="submit" class="btn btn-info" role="button"
								data-toggle="modal" onclick="modify(${review.re_no})">확인</button>
							<button type="button" class="btn btn-secondary" role="button"
								data-toggle="modal" onclick="review(${review.g_no})">취소</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<c:import url="detailModal.jsp"></c:import>
</body>
</html>