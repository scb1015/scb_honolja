<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<form action="logincheck.do" onsubmit="loginCheck();" name="myform">
		<table width="500" cellspacing="0" cellpadding="5" border=1>
			<tr>
				<td>
					아이디&nbsp;&nbsp;&nbsp;
					<input type="text" name="u_id" id="u_id">
				</td>
				<td rowspan="2">
					<input type="submit" value="Login">
				</td>
			</tr>
			<tr>
				<td>
					비밀번호&nbsp;&nbsp;
					<input type="password" name="u_pwd" id="u_pwd">
				</td>
		</table>
	</form>

</body>
</html>