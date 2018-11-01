<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Reply</title>

<meta charset="UTF-8">

</head>
<div id="test" style="display: none">
</div>
<body>
<div class="container">
	<form method="post"  id="editform" action="boardreplyupdate.do">
		<div class="media-body">
			<div class="media-heading">
				<textarea class="form-control" rows="3"  id="br_content" name="br_content">${dto.br_content}</textarea> 
					<input type="submit" value="수정" onclick="rinsert();" class="btn pull-right btn-success"> 
					<input type="hidden" name="br_no" value="${dto.br_no}">
					<input type="hidden" name="b_no" value="${dto.b_no}">
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">



</script>

</body>
</html>
