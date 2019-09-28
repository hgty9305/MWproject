<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
<title>main</title>
<style>
/*table style*/
table.type03 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 3px solid #8FBD24;
	margin: 20px 10px;
}

table.type03 td {
	width: 349px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	text-align: center;
	vertical-align: middle;
}
</style>
</head>
<c:if test="${check ==1}">
<body id="page-top">
	<jsp:include page="/Main/boots_menubar.mw" />
	<div class="container">
		<div class="row">
			<form method="post" action="/MeetWhenGit/Main/main.mw" name="userinput">
			<table class="type03">
				<tr>
					<td height="39" align="center"><font size="+1">
					<b>회원정보가 삭제되었습니다.</b></font></td>
				</tr>
				<tr>
					<td align="center">
					<p>흑흑.... 서운합니다. 안녕히 가세요.</p> 
					<meta http-equiv='refresh' content='10;url=/Main/main.mw'>
				</td>
				</tr>
				<tr>
					<td align="center"><input type="submit" value="확인"></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</c:if>
<c:if test="${check!=1}">
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
</c:if>

	<jsp:include page="/Main/boots_footer.mw" />
</body>
</html>