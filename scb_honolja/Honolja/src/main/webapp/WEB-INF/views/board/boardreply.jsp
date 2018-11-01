<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">

/* 댓글 체크 */
function rcheck() {
	var content = myform2.br_content.value;

	if (content == "" || content == null) {
		alert("댓글 입력해주세요.");
		myform2.br_content.focus();
		return false;
	}
	document.myform2.submit();
}

/* 댓글 삭제 */
	function rdel(br_no,b_no) { 
		
		if (confirm("댓글을 삭제하시겠습니까?") == true) {
			
		$.ajax({
		url : 'boardreplydelete.do',
		type : 'post',
		data : {
			br_no : br_no,
			b_no : b_no
		},
		success : function(data) {
			$("#note-title1_" + br_no ).hide();
			$("#note-title2_" + br_no ).hide();
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
			console.log("error");
		}
		})
	}
}

/* 댓글 수정Ajax */
function redit(br_no) {
	
	if(confirm("수정하시겠습니까?")) {
	
	$.ajax({
		url : 'boardreplyedit.do',
		type : 'post',
		data : { "br_no" : br_no},
		success : function(data) {
			$('#redit_' + br_no).html(data);
			$('#redit_' + br_no).focus();
		},
		error : function(request, status, error) {
			alert('code:' + request.status + '\n' + 'message:'
					+ request.responseText + '\n' + 'error:' + error);
			}
		})
	}
}

/* 댓댓글 Ajax */
 function reply(br_no,b_no) {
	
		$.ajax({
			url : 'boardrreplyinsertForm.do',
			type : 'post',
			data : {"br_no" : br_no,
						"b_no" : b_no
				},
			success : function(data) {
				$('#reply_' + br_no).html(data);
				$('#reply_' + br_no).focus();
			},
			error : function(request, status, error) {
				alert('code:' + request.status + '\n' + 'message:'
						+ request.responseText + '\n' + 'error:' + error); 
				}
			})
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
<title>Reply</title>
</head>

<body>
	<form name="myform2" method="post" action="boardreplyinsert.do" onsubmit="rcheck(); return false;">
		<br>
		<div>
			<textarea  class="form-control" rows="3"  id="comment" name="br_content" placeholder="댓글을 입력하세요"></textarea>
			<input type="submit" value="등록" class="btn pull-right btn-success"> 
			<input type="hidden" name="b_no" value="${dto.b_no}" >
		</div>
		<br>
	</form>

		<div class="col-xs-2">
			<label for="ex1" id="rp1">총 댓글 :${rcnt}</label>
		</div>
		
	<form>
		<br>
			<c:forEach var="dto" items="${Rlist}">
				<li id="note-title1_${dto.br_no}" class="list-group-item note-title">
					<div class="media-body">
						<span class="member"> <a href="javascript:void(0);">${dto.u_id }</a> </span> 
							<span class="font-11 text-muted">  
								<span class="media-info"> <i class="fa fa-clock-o"></i> ${dto.br_date} </span>
									 <a href="javascript:void(0);" onclick="reply(${dto.br_no},${dto.b_no});">댓글 달기</a> 
							</span> 
							
				<div id="redit_${dto.br_no}"> 
					<div class="media-content">${dto.br_content}  
						<c:if test="${sessionScope.checked eq dto.u_id}">
							<a href="javascript:void(0);" onclick="redit(${dto.br_no});">[수정]</a>
							<a href="javascript:void(0);" onclick="rdel(${dto.br_no},${dto.b_no}); return false;">[삭제]</a>
						</c:if>
					</div>
				</div>
						<div id="reply_${dto.br_no}"> </div>
					</div>
				</li>
					<input type="hidden" id="b_no" name="b_no" value="${dto.b_no}" > 
					<c:import url="/boardrreply.do?idx=${dto.b_no}&br_no=${dto.br_no}"/>
			</c:forEach>
</form>

</body>
</html>
