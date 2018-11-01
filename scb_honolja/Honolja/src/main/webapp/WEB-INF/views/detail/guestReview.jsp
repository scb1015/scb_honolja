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
<script type="text/javascript">
/* $('.starRev span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  return false;
	}); */
	
</script>
<style type="text/css">
.starR {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 20px;
	height: 20px;
	display: inline-block;
	text-indent: -9999px;
	cursor: pointer;
}

.starR.on {
	background-position: 0 0;
}

.star-rating {
	line-height: 32px;
	font-size: 1.25em;
}

.star-rating .fa-star {
	color: yellow;
}
</style>
</head>
<body>
	<div class="container-fluid" id="review-All">
		<c:choose>
			<c:when test="${empty sessionScope.checked}">
				<div class="place-room__message">
					<i class="badge-live">후기</i> 는 로그인한 회원만 작성할 수 있습니다.
				</div>
			</c:when>
			<c:otherwise>
				<c:set var="u_id" value="${sessionScope.checked}" />
				<div>
					<label for="content">comment</label>
					<form id="reviewForm" action="reviewAdd.do" method="post">
						<input type="hidden" name="g_no" value="${g_no}"> <input
							type="hidden" name="u_id" value="${u_id}">
						<div class="review-userinfo">
							<div class="col">
								<img
									src="http://member.yanolja.com/include/img/picture/default_picture.png"
									class="img-circle" alt="프로필사진" width="34px;" />&nbsp;<span
									class="nicname">${u_id}</span>
							</div>
						</div>
						<div class="form-group">
							<input class="form-control" id="re_title" name="re_title"
								placeholder="제목을 입력하세요.">
						</div>
						<div class="form-group">
							<textarea class="form-control" id="re_content" name="re_content"
								rows="3" placeholder="댓글을 입력하세요."></textarea>
						</div>
						<div class="form-group col-md-3">
							<!-- 	<button type="button" class="btn btn-default btn-sm">
								<span class="glyphicon glyphicon-picture"></span> Picture
							</button> -->
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-danger active"> <input
									type="radio" name="re_like" id="re_like" autocomplete="off"
									value="추천" checked> 추천
								</label> <label class="btn btn-danger"> <input type="radio"
									name="re_like" id="re_like" value="비추천" autocomplete="off">
									비추천
								</label>
							</div>
						</div>
						<div class="form-group col-md-3">
							<select class="form-control" id="re_score" name="re_score">
								<option value="1" selected="selected">★☆☆☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="3">★★★☆☆</option>
								<option value="4">★★★★☆</option>
								<option value="5">★★★★★</option>
							</select>
						</div>
						<div class="form-group col-md-3">
							<!-- <div class="starRev">
								<span class="starR on" id="star1" data-value="1">1</span> <span
									class="starR" id="star1" data-value="2">2</span> <span
									class="starR" id="star1" data-value="3">3</span> <span
									class="starR" id="star1" data-value="4">4</span> <span
									class="starR" id="star1" data-value="5">5</span>
							</div> -->
							<div class="container">
								<div class="row">
									<div class="col-lg-12">
										<div class="star-rating">
											<span class="fa fa-star-o" data-rating="1"></span> <span
												class="fa fa-star-o" data-rating="2"></span> <span
												class="fa fa-star-o" data-rating="3"></span> <span
												class="fa fa-star-o" data-rating="4"></span> <span
												class="fa fa-star-o" data-rating="5"></span> <input
												type="hidden" name="whatever1" class="rating-value"
												value="2.56">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="star-rating">
											<span class="fa fa-star-o" data-rating="1"></span> <span
												class="fa fa-star-o" data-rating="2"></span> <span
												class="fa fa-star-o" data-rating="3"></span> <span
												class="fa fa-star-o" data-rating="4"></span> <span
												class="fa fa-star-o" data-rating="5"></span> <input
												type="hidden" name="whatever2" class="rating-value"
												value="1.9">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="star-rating">
											<span class="fa fa-star-o" data-rating="1"></span> <span
												class="fa fa-star-o" data-rating="2"></span> <span
												class="fa fa-star-o" data-rating="3"></span> <span
												class="fa fa-star-o" data-rating="4"></span> <span
												class="fa fa-star-o" data-rating="5"></span> <input
												type="hidden" name="whatever3" class="rating-value"
												value="4.1">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<button class="btn btn-primary btn-block" type="button"
								data-toggle="modal" onclick="reviewBtn(${g_no})">등록</button>
						</div>
					</form>
				</div>
				<hr>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${rcnt == 0}">
				<div class="empty-content">
					<img
						src="https://yaimg.yanolja.com/joy/pw/common/empty/empty-icon__review.svg"
						class="empty__image" alt="img">
					<div class="empty__texts">
						<em class="empty__text">아직 작성된 후기가 없습니다.</em>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<br>
				<c:forEach var="review" items="${review}">
					<div class="place-review__item.is-thumbnail"
						id="reviewModify_${review.re_no}">
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
									<span class="badge-rap"><i class="badge-best"><em>${review.re_like}</em></i></span><strong>${review.re_title}
									</strong>
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
								<p class="review-info__content">${review.re_content}</p>
								<div class="review-userinfo">
									<div class="col">
										<img
											src="//member.yanolja.com/include/img/picture/default_picture.png"
											class="img-circle" alt="프로필사진" width="34px;" /> <span
											class="nicname">${review.u_id}</span><i class="bar"></i><span
											class="roomtype">${review.r_name}</span><i class="bar"></i><span
											class="date"><fmt:formatDate value="${review.re_date}"
												pattern="yyyy-MM-dd" /></span>
										<c:if test="${u_id == review.u_id}">
											<div class="btn-group pull-right">
												<button type="button" class="btn btn-info"
													data-toggle="modal"
													onclick="premodify(${review.re_no},${g_no})">수정</button>
												<button type="button" class="btn btn-secondary"
													data-toggle="modal"
													onclick="remove(${review.re_no},${g_no})">삭제</button>
											</div>
										</c:if>
									</div>
								</div>
								<br>
								<c:choose>
									<c:when test="${param.u_member != '점주' }">
									</c:when>
									<c:otherwise>
										<c:when test="${review.ansCnt > 0}">
											<div>
												<button type="button" class="btn btn-primary"
													onclick="answerView(${review.re_no})" data-toggle="modal">
													답변 <span class="badge badge-light">1</span>
												</button>
											</div>
										</c:when>
										<c:otherwise>
											<div>
												<button type="button" class="btn btn-primary"
													data-toggle="modal" onclick="answer(${review.re_no})">답변</button>
											</div>
										</c:otherwise>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<hr>
					</div>
					<div id="view_${review.re_no}" style="display: none;"></div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<c:import url="detailModal.jsp"></c:import>
	<script type="text/javascript">
	var $star_rating = $('.star-rating .fa');

	var SetRatingStar = function() {
	  return $star_rating.each(function() {
	    if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
	      return $(this).removeClass('fa-star-o').addClass('fa-star');
	    } else {
	      return $(this).removeClass('fa-star').addClass('fa-star-o');
	    }
	  });
	};

	$star_rating.on('click', function() {
	  $star_rating.siblings('input.rating-value').val($(this).data('rating'));
	  return SetRatingStar();
	});

	SetRatingStar();
	$(document).ready(function() {

	});
	</script>
</body>
</html>