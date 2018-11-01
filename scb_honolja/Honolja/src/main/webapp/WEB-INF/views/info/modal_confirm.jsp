<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">알림${param.url }</h4>
				</div>
				<div class="modal-body">
					<p id="error"></p>
				</div>
				<div class="modal-footer">
					<button id = "check_btn" type="button" class="btn btn-default" data-dismiss="modal">확인</button>
					<button id = "cancel_btn" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>  
		</div>
	</div>
</body>
</html>