<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
<title>main</title>
<style>
/* Create two equal columns that floats next to each other */
.column1 {
	float: left;
	width: 25%;
	padding: 10px;
	height: 400px; /* Should be removed. Only for demonstration */
}

.column2 {
	float: left;
	width: 75%;
	padding: 10px;
	height: 400px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.colAfter:after {
	content: "";
	display: table;
	clear: both;
	width: 100%;
}

/*sideBar*/
a {
	text-decoration: none;
}

.vertical-menu {
	width: 200px;
}

.vertical-menu a {
	background-color: #eee;
	color: black;
	display: block;
	padding: 12px;
	text-decoration: none;
}

.vertical-menu a:hover {
	background-color: #ccc;
}

.vertical-menu a.active {
	background-color: #4CAF50;
	color: white;
}
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
<script language="javascript">
	function begin() {
		document.myform.passwd.focus();
	}

	function checkIt() {
		if (!document.myform.passwd.value) {
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body id="page-top" onload="begin()">
	<jsp:include page="/Main/boots_menubar.mw" />
	<c:set value="${vo}" var="vo" />
	<div class="container">
		<div class="row">
			<div class="column1">
				<div class="vertical-menu">
					<a href="myPage.mw" class="active" style="text-align: center">회원 정보 관리</a> 
						<a href="myInfo.mw">개인정보 확인</a> <a href="modify.mw">개인정보 수정</a> 
						<%-- 
						<a href="#">주소 등록/수정</a> 
						<a href="#">여행 스타일 등록/수정</a> --%>
						<a href="delete.mw">회원 탈퇴</a>
				</div>
			</div>
			<div class="column2">
				<form name="myform" action="deletePro.mw" method="post"
					onSubmit="return checkIt()">
					<h3>회원 탈퇴</h3>
					<br />
					<table class="type03">
						<tr>
							<td>비밀번호</td>
							<td><INPUT type="password" name="passwd" size="15"
								maxlength="12"></td>
						</tr>
					</table>
					<span><button type="submit" class="btn btn btn-danger"
							onclick="fetchPage('allServicesA.mw')">회원탈퇴</button></span> <span><button
							type="button" class="btn btn btn-success"
							onclick="javascript:window.location='myPage.mw'">취소</button></span>
				</form>
			</div>
		</div>

	</div>
	<jsp:include page="/Main/boots_footer.mw" />
</body>
</html>
