<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[img_board.jsp]</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<style type="text/css">
	
		.board_box{
			width: 80%;
			margin: 0 auto;
			margin-top : 70px;
			text-align: center;
		}
	
		.grid{
			display: grid;
			grid-template-columns: 1fr 1fr 1fr 1fr 1fr;	
		}
		
		.grid_img{
   			width: 250px; 
   			height: 250px;
   			margin: 20px 0 20px 0;
   			border-radius: 5px;
		}
		
		.pagination{
			padding-top: 10px;
		}
	</style>
	
	<script type="text/javascript">
	
	function nullCheck(){
		
		if(document.getElementById("searchText").value == ''){
			$(document).ready(function(){
				$('#alertbox').ready(function(){
					$("#error").html("검색어를 입력해 주세요.");
					$('#myModal').modal("show");
				});
			});
			return;
		}
		
		if(document.getElementById("sel1").value == 'default'){
			$(document).ready(function(){
				$('#alertbox').ready(function(){
					$("#error").html("검색 타입을 입력해 주세요.");
					$('#myModal').modal("show");
				});
			});
			return;
		}
		
		searchForm.submit();
	}
	
	</script>

</head>
<body style="margin-top: 50px;">
	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="img_board" value="${img_board}"></c:param>
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="img_board.do"></c:param>
	</c:import>
	
	<!-- Modal(== alert) 기능 구현 시 필요 -->
	<jsp:include page="../main/modal.jsp" />
	
	<div class = "board_box">
		<div class = "grid">
		
			<!-- 게시물 리스트 출력 -->
			<c:forEach var="list" items="${list}">
				<div style="text-align: center;">
			 	  	<a href="img_board_detail.do?i_no=${list.i_no }">
			 	  		<c:choose>
			 	  			<c:when test="${list.i_originalFileName != null}">
			 	  				<img class = "grid_img" src="resources/info_images/${list.i_uploadFileName}">
			 	  			</c:when>
			 	  			<c:otherwise>
			 	  				<img class = "grid_img" src="resources/info_images/ccc.gif">
			 	  			</c:otherwise>
			 	  		</c:choose>
			 	  		
		 	  		</a>
					<div style="margin-bottom: 5px;">
						${list.i_title}&nbsp;
						<c:if test="${list.reply_cnt != 0 }">
							<span class="badge" style="background-color: #337ab7;">${list.reply_cnt}</span>
						</c:if>					
					</div>
					<div style="padding: 0 30px 0 30px;">
						<span style="float: left;">작성자 : ${list.u_id }</span>
						<span style="float: right;">
							작성시간 : <fmt:formatDate value="${list.i_date }" pattern="yyyy-MM-dd"/>
						</span>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<!-- 페이징 버튼 -->
		<ul class="pagination pagination-lg">
		
			<!-- 이전 버튼 -->
			<c:if test="${page > 10 }">
				<li><a style="background-color: #eee;" href="img_board.do?page=${page_btn_start -10 }">이전</a></li>
			</c:if>
			
			<!-- 페이징 버튼 출력 -->	
			<c:forEach varStatus="i" begin="${page_btn_start }" end="${page_btn_end }" >
				<c:choose>
					<c:when test="${page == i.index}">
						<li class="active"><a href="img_board.do?page=${i.index}&sval=${param.sval}&skey=${param.skey}">${i.index}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="img_board.do?page=${i.index}&sval=${param.sval}&skey=${param.skey}">${i.index}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 다음 버튼 -->
			<c:if test="${page_end_flag == true }">
				<li><a style="background-color: #eee;" href="img_board.do?page=${page_btn_start +10 }">다음</a></li>
			</c:if>
			
			<!-- 글 작성 버튼 -->
			<button style="position: absolute; right: 11%;" type="button" class="btn btn-success btn-lg" onclick="location.href = 'img_board_write.do'">글 작성</button>
		</ul>
		
		<!-- 검색 후, 선택 유지 -->
		<c:choose>
			<c:when test="${param.skey == 'title' }">
				<c:set var="title" value="selected" />
			</c:when>
			<c:when test="${param.skey == 'content' }">
				<c:set var="content" value="selected" />
			</c:when>
			<c:when test="${param.skey == 'writer' }">
				<c:set var="writer" value="selected" />
			</c:when>
		</c:choose>
		
		<!-- 검색 버튼 -->
		<form name = "searchForm" action="">
			<select name = "skey" class="form-control input-lg" id="sel1" style="width: 100px; display: inline; vertical-align: top;">
				<option value = "default">선택</option>
				<option value = "title" ${title}>제목</option>
				<option value = "content" ${content}>내용</option>
				<option value = "writer"${writer}>작성자</option>
			</select>
			<input id = "searchText" name = "sval" value="${param.sval}" type="text" placeholder="Search" class="form-control input-lg" id="usr" style="display: inline; width: 200px;">
			<button type="button" class="btn btn-primary btn-lg" style="vertical-align: top;" onclick="nullCheck();">
				<i class="glyphicon glyphicon-search"></i>
			</button>	
		</form>
	</div>

	
	${total_page }개
</body>
</html>