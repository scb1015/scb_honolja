<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[img_reply.jsp]</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
	function reply_update(reply_num, ir_no){
		
		var content_value = document.getElementById("reply_content_" + reply_num).textContent;
		
		document.getElementById("reply_content_" + reply_num).innerHTML = "<textarea id = \"ir_content_update\" class=\"form-control\" style = \"resize : none;\" >" + content_value + "</textarea>";
		document.getElementById("reply_update_btn_" + reply_num).innerHTML = "<button type=\"button\" class=\"btn btn-primary btn-sm\" onclick = \"update_reload_reply(" + ir_no + ");\">수정완료</button>";
	}
	
	//댓글의 댓글달기 버튼 클릭시 발생
	function reply_of_reply(ir_no) {
		
		var tag_str;
		
		tag_str = "<td>";
		tag_str += "<textarea id = \"irr_content_insert\" class=\"form-control\" style = \"resize : none; width : 86%; margin-left : 140px;\" ></textarea>";
		tag_str += "</td>";
		tag_str += "<td style = \"vertical-align : middle;\">";
		tag_str += "<button type=\"button\" class=\"btn btn-primary btn-sm\" onclick = \"insert_reload_ror(" + ir_no + ");\">작성완료</button>";
		tag_str += "</td>";

		document.getElementById("reply_of_reply_btn_" + ir_no).innerHTML = "";
		document.getElementById("reply_of_reply_area_" + ir_no).innerHTML = tag_str;

	}

	</script>
	
</head>
<body id="reply_body">
	<div class="container">            
		<table class="table">
			<thead>
				<tr>
					<th colspan="2" style="padding: 0;"></th>
				</tr>
			</thead>
			<tbody>
				<!-- 댓글 출력 란 -->
				<c:forEach var="list" items="${list}" varStatus="i">
					<tr>
						<td style="padding-left:80px;">
							<!-- 작성자 -->
							<h3 style="font-weight: bold; margin-top: 10px;">
								${list.u_id}
								<span style="font-weight: normal; font-size: 12px;">
									<fmt:formatDate value="${list.ir_date }" pattern="yyyy-MM-dd HH:mm:ss"/>
								</span>
							</h3>		 
							<p>
							<!-- 댓글 내용 -->
							<span id="reply_content_${list.ir_no}">${list.ir_content}</span>
							<p>
							
							<!-- 댓글의 댓글달기 버튼 -->
							<span id = "reply_of_reply_btn_${list.ir_no }">	
								<button type="button" class="btn btn-default btn-xs" onclick = "reply_of_reply(${list.ir_no}, ${list.ir_no });">댓글달기</button>
							</span>
						</td>
						<td style="vertical-align: middle;">
							<!-- 댓글 수정/삭제 버튼 -->
							<span id="reply_update_btn_${list.ir_no}">
								<c:if test="${param.checked == list.u_id || checked == list.u_id}">
									<button type="button" class="btn btn-success btn-xs" onclick="reply_update(${list.ir_no });">수정</button>
									<button type="button" class="btn btn-danger btn-xs" onclick = "delete_reply_confirm(${list.ir_no});">삭제</button>
								</c:if>
							</span>
						</td>
					</tr>
					<!-- 댓글의 댓글 버튼 클릭시 활성화 -->
					<tr id = "reply_of_reply_area_${list.ir_no}"></tr>
					
					<!-- 댓글의 댓글 리스트 출력 -->
					<c:import url="http://localhost:8080/honolja/img_reply_of_reply.do">
						<c:param name="ir_no" value="${list.ir_no }" />
						<c:param name="checked" value="${checked }" />	
					</c:import>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>