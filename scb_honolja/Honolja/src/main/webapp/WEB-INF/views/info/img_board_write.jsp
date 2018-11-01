<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[img_board_write.jsp]</title>
	
	<script src="//cdn.ckeditor.com/4.10.1/basic/ckeditor.js"></script>
	
	<script type="text/javascript">
	
		function make_file_btn(){
			document.getElementById("update_file").innerHTML = 
				"파일 첨부 : <input style=\"display: inline;\" type=\"file\" name = \"upload_f\">";
		}
		
		function popupWindow(url, title, w, h) {
			
			var left = (screen.width/2) - (w/2);
			var top = (screen.height/2) - (h/2) - 50;
			
			return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
    	}
		
		var url_flag = true;
		
		function urlCheck(){
			
			var url = document.getElementsByClassName("youtube")[0].value;
			var url_check = /^[a-z\:]{4,6}\/\/[a-zA-Z\.\/]{20,50}$/; 
			
			if(url_check.test(url) == false){
				document.getElementById("url_warning").style.color = "red";
				document.getElementById("url_warning").innerHTML = "URL형식이 잘못 되었습니다.";
				url_flag = false;
			}else{
				document.getElementById("url_warning").style.color = "blue";
				document.getElementById("url_warning").innerHTML = "URL형식이 정상입니다.";
				url_flag = true;
			}
			
			if(url == ""){
				url_flag = true;
				document.getElementById("url_warning").innerHTML = "";
			}
		}
		
		function nullCheck(){
			
			var title_val = document.getElementsByClassName("title")[0].value;
			//var content_val = document.getElementsByClassName("content")[0].value;
			var content_val = CKEDITOR.instances.editor1.getData();
			
			
			if(title_val == ""){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("제목을 입력해 주세요.");
						$('#myModal').modal("show");
					});
				});
				return;
			}
			
 	 		if(content_val == ""){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("내용을 입력해 주세요.");
						$('#myModal').modal("show");
					});
				});
				return;
			}
			
			if(url_flag == false){
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("URL을 정확히 입력해 주세요.");
						$('#myModal').modal("show");
					});
				});
				return;
			}
			
			if("${param.i_no}" == ""){
				document.getElementById("form_write").submit();	
			}else{
				document.getElementById("form_update").submit();	
			}
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
	<jsp:include page="modal_confirm.jsp"/>
	
	<c:choose>
		<c:when test="${u_id == ''}">
			<script type="text/javascript">
				$(document).ready(function(){
					$('#alertbox').ready(function(){
						$("#error").html("로그인이 필요합니다. 로그인 하시겠습니까?");
						$('#myModal').modal("show");
						$('#check_btn').click(function(){
							popupWindow('login_popup.do?host=' + 'img_board_write.do', 'login', 410, 450);
						});
						$('#cancel_btn').click(function(){
							location.href = 'img_board.do';
						});
					});
				});
			</script>
		</c:when>
		
		<c:otherwise>
			<div class="container" style="margin-top: 80px;">
				<h2>리뷰 게시판</h2>
				<p>게스트 하우스에 대한 정보를 공유하는 공간입니다. 광고/홍보용 사진은 삭제됨을 알려드립니다.</p> 
				<c:choose>
					<c:when test="${param.i_no != null }">
						<form id = "form_update" action="img_board_update_backend.do" enctype="multipart/form-data" method="post">
					</c:when>
					<c:otherwise>
						<form id = "form_write" action="img_board_write_backend.do" enctype="multipart/form-data" method="post">
					</c:otherwise>
				</c:choose>           
					<table class="table" style="margin-top: 30px;">
						<thead>
						
							<!-- 제목 -->
							<tr>
								<th colspan="2" style="font-size: 25px;">
									제목 : <input 
										name = "title" 
										value="${dto.i_title }" 
										style="display: inline; 
										width: 90%;" type="text" 
										class="form-control title" 
										id="usr">
								</th>
							</tr>
							
							<!-- 작성자 -->
							<tr>
								<th colspan="2">작성자 : ${checked }</th>
								<input type="hidden" name="id" value = "${checked}">
							</tr>
						</thead>
						<tbody>
						
							<!-- 내용 -->
							<tr>
								<td colspan="2" style="height: 500px;">
									<textarea
										name = "content" 
										class="form-control content" 
										id = "editor1"
										style="resize: none; 
										height: 100%;">${dto.i_content }</textarea>
								</td>
							</tr>
							
							<!-- 동영상 URL -->
							<tr>
								<td colspan="2">
									동영상 URL :  <input 
										OnChange="urlCheck();" 
										placeholder="https://www.youtube.com/embed/aaaaaAAAAAA" 
										name = "youtube" value="${dto.i_youtube }" 
										style="display: inline; width: 50%;" 
										type="text" 
										class="form-control youtube" 
										id="usr">
									&nbsp;<span id="url_warning" style="font-weight: bold;"></span>
								</td>
							</tr>
							
							<!-- 파일 첨부 -->
							<tr>
								<td style="text-align: left;">
									<c:choose>
										<c:when test="${dto.i_originalFileName != null}">
											<span id = "update_file">
												파일 첨부 : <button type="button" class="btn btn-success" onclick="make_file_btn();">파일 변경</button>
												&nbsp;${dto.i_originalFileName}
											</span>
										</c:when>
										<c:otherwise>
											파일 첨부 : <input style="display: inline;" type="file" name = "upload_f">
										</c:otherwise>
									</c:choose>
								</td>
								
								<!-- 작성 완료 / 다시 쓰기 버튼 -->
								<td style="text-align: right;">
									<input type="hidden" name = "i_no" value = "${param.i_no }">
									<button type="button" class="btn btn-info" onclick="nullCheck();">작성 완료</button>
									&nbsp;
									<button type="reset" class="btn btn-danger">다시 작성</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</c:otherwise>
	</c:choose>
	
	<script type="text/javascript">		
		CKEDITOR.replace('editor1');
		CKEDITOR.config.height = '450px';
	</script>
	
</body>
</html>