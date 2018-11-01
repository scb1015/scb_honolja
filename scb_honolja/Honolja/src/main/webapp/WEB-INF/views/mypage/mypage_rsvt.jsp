<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>mypage_rsvt.jsp</title>

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
  		margin : 20px 10px;
	}

	table.ta td {
    	padding: 10px;
    	border-bottom: 1px solid #ccc;
	}
	
</style>
	
</head>
<body>

	<c:import url="http://localhost:8080/honolja/header.do">
		<c:param name="checked" value="${checked}"></c:param>
		<c:param name="host" value="main.do"></c:param>
	</c:import>

	<div style="height: 100px;"></div>
	
	<div>
  		<c:import url="http://localhost:8080/honolja/side_mypage.do">
		</c:import>
	</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <div class="modal-content">

        <div class="modal-header">
          <h4 class="modal-title">예약 취소 확인</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        
        <div class="modal-body">
          	예약을 취소하시겠습니까?
          	<input type="hidden" id="myModalvalue" value="">
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
          <button type="button" id="cancel_check" class="btn btn-primary"  >예</button>
        </div>

      </div>
      
    </div>
</div>

<div align="center">

 <h1>Reservation Info</h1>

<form name="myform" >
	<table class="ta">
	<c:forEach var="listRS" items="${listRS}">
		<tr>
			<td rowspan="7"><img src="${listRS.img_url}"></td>
			<td width="120px">방 이름</td>
			<td width="280px" align="right"><a href="guestdetail.do?g_no=${listRS.g_no}">${listRS.r_name}</a>
				<input type="hidden" value="${listRS.r_no}" name="resno">
			</td>
			
		</tr>
		<tr><td>예약자명</td><td align="right">${listRS.u_id}</td></tr>
		<tr><td>가격</td><td align="right">${listRS.res_price} 원</td></tr>
		<tr><td>예약 인원</td><td align="right">${listRS.res_people} 명</td></tr>
		<tr><td>예약 날짜</td><td align="right">
			<fmt:formatDate value="${listRS.res_date}" pattern="yyyy-MM-dd"/>
		</td></tr>
		<tr><td>숙박 기간</td><td align="right">
		
		<fmt:parseDate value="${listRS.check_in}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
      <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/> ~ 
  	<fmt:parseDate value="${listRS.check_out}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
      <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
		
		</td></tr>
		<tr><td colspan="2">
			<input type="button" data-toggle="modal" data-src="${listRS.r_no}" 
				data-target="#myModal" class="btn btn-primary btn_modal" value="예약 취소">
			</td>
		</tr>
			
<script type="text/javascript">
	$(function(){
		$(".btn_modal").on("click", function() {
			var a = $(this).attr("data-src");
			$("#myModalvalue").val(a);
		});
		
		$("#cancel_check").on("click", function() {
			var cancel = $("#myModalvalue").val();
			location.href='rsvt_cancel.do?idx=' + cancel;
		});
	});
</script>

	</c:forEach>
	</table>
</form>

</div>

	<div style="margin-left: 27%; color: gray;">
		※홈페이지 예약 취소는 미결제 예약에 한해서만 가능합니다. 결제가 진행된 예약분의 취소는 해당 게스트하우스로 문의하시기 바랍니다.
	</div>

	<div style="height: 100px;"></div>

	<div class="ff">
		<c:import url="http://localhost:8080/honolja/footer.do" />
	</div>



</body>
</html>