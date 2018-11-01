<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	/* 대댓글 삭제 */
	function rrdel(brr_no,b_no) { 
		
		if (confirm("댓글을 삭제하시겠습니까?") == true) {
			
		$.ajax({
		url : 'boardrreplydelete.do',
		type : 'post',
		data : {
			brr_no : brr_no,
			b_no : b_no
		},
		success : function(data) {
			$("#note-title2_" + brr_no ).hide();
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
			console.log("error");
		}
		})
		
	}
}
	/* 대댓글 Form */
	 function rreply(br_no,b_no) {
		
			$.ajax({ 
				url : 'boardrreplyinsertForm.do',
				type : 'post',
				data : {"br_no" : br_no,
							"b_no" : b_no
					},
				success : function(data) {
					$('#rreply_' + br_no).html(data);
					$('#rreply_' + br_no).focus();
				},
				error : function(request, status, error) {
					alert('code:' + request.status + '\n' + 'message:'
							+ request.responseText + '\n' + 'error:' + error); 
					}
				})
	}
	 /* 대댓글 수정Ajax */
	 function rredit(brr_no,b_no) {
	 	if(confirm("수정하시겠습니까?")) {
	 	
	 	$.ajax({
	 		url : 'boardrreplyedit.do',
	 		type : 'post',
	 		data : { "brr_no" : brr_no,
	 					"b_no" : b_no
	 			},
	 		success : function(data) {
	 			$('#rredit_' + brr_no).html(data);
	 			$('#rredit_' + brr_no).focus();
	 		},
	 		error : function(request, status, error) {
	 			alert('code:' + request.status + '\n' + 'message:'
	 					+ request.responseText + '\n' + 'error:' + error);
	 			}
	 		})
	 	}
	 }
	</script>

<title>대댓글리스트</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8">

</head>
<body>
			
<c:forEach var="dto" items="${RRlist}">
	<li id="note-title2_${dto.brr_no}" class="list-group-item note-title" style="margin-left: 5%;">
		<div class="media-body" >
			<div class="media-heading">
				<span class="member">
					<a href="javascript:void(0);" onclick="showSideView(this, 'bsocks', '갈루노', '', '');">  ${dto.u_id}</a>
				</span> 
					<span class="font-11 text-muted"> 
						 <span class="media-info"> <i class="fa fa-clock-o"></i> ${dto.brr_date} </span>
		 				 <a href="javascript:void(0); " onclick="rreply(${dto.br_no},${b_no});">대댓글 달기</a>
		 			</span>
						<div id="rredit_${dto.brr_no}"> 
							<div class="media-content"> ${dto.brr_content}   
								<c:if test="${sessionScope.checked eq dto.u_id}">
									 <a href="javascript:void(0);" onclick="rredit(${dto.brr_no},${b_no})">[수정]</a>
									 <a href="javascript:void(0);" onclick="rrdel(${dto.brr_no},${b_no}); return false;">[삭제]</a>
								 </c:if>
							  </div>
						</div>
				</div>
							 	<div id="rreply_${dto.br_no}"> </div>	
							 		<input type="hidden" id="br_no" name="br_no" value="${dto.br_no}">
		</div>
	</li>
</c:forEach>
<input type="hidden" id="b_no" name="b_no" value="${dto.b_no}">
	
</body>
</html>