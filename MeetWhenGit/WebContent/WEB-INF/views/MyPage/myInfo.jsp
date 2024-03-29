<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* Create two equal columns that floats next to each other */
.column1 {
	float: left;
	width: 25%;
	padding: 15px;
	height: 400px; /* Should be removed. Only for demonstration */
}

.column2 {
	float: left;
	width: 75%;
	padding: 15px;
	height: 400px; /* Should be removed. Only for demonstration */
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
	width:50%;
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
<html lang="en">
<head>
<title>main</title>
</head>
<body id="page-top">
	<jsp:include page="/Main/boots_menubar.mw" />

	<c:set value="${vo}" var="vo" />

	<div class="container">
		<div class="row">
			<div class="column1">
				<div class="vertical-menu">
					<a href="myPage.mw" class="active" style="text-align:center">회원 정보 관리</a>
					<a href="myInfo.mw">개인정보 확인</a>
					<a href="modify.mw">개인정보 수정</a>
					<c:if test="${sessionScope.loginUser ne 'admin' }">
						<a href="/MeetWhenGit/Member/selectPlace.mw">장소 등록/수정</a>
						<a href="delete.mw">회원 탈퇴</a> 
					</c:if>
					<c:if test="${sessionScope.loginUser eq 'admin' }">
						<a href="/MeetWhenGit/Db/dbControl.mw">DB 정보 관리</a>
						<a href="/MeetWhenGit/Db/selectMem.mw">회원 정보 조회</a> 
						<a href="/MeetWhenGit/Db/deleteMem.mw">회원 탈퇴 관리</a> 
					</c:if>
					<%-- 
						<a href="#">주소 등록/수정</a> 
						<a href="#">여행 스타일 등록/수정</a> --%> 
				</div>
			</div>
			<div class="column2">
				<table class="type03">
					<tr>
						<th>프로필사진</th>
						<td><c:if test="${img ne 'default.png'}">
								<img src="/MeetWhenGit/img/${vo.m_profile_img}" width="100px" />
							</c:if> <c:if test="${img eq 'default.png'}">
								<td><img src="/MeetWhenGit/img/default.png" width="100px" />
							</c:if></td>
					</tr>
				</table>

				<table class="type03">
					<tr>
						<th scope="row">이름</th>
						<td><c:out value="${vo.m_name}"></c:out></td>
					</tr>
					<tr>
						<th scope="row">아이디</th>
						<td><c:out value="${vo.m_id}"></c:out></td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td><c:out value="${vo.m_email}"></c:out></td>
					</tr>
				</table>
			</div>
			</div>
		</div>
	
	<jsp:include page="/Main/boots_footer.mw" />
</body>
</html>
