<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
/*table style*/
table.type03 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1;
	border-top: 1px solid #ccc;
	border-left: 3px solid #8FBD24;
	margin: 10px 10px;
}

table.type03 td {
	width: 300px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	text-align: center;
	vertical-align: middle;
}
</style>

</head>
<body>
	<c:if test="${check eq 1}">
		<h3>${memVO.m_id}의정보</h3>
		<table class="type03">
			<tr>
				<td>가입 일</td>
				<td>${memVO.registrationdate}</td>
			</tr>
			<tr>
				<td>시리얼 번호</td>
				<td>${memVO.m_serialnumber}</td>
			</tr>
			<tr>
				<td>PW</td>
				<td>PW:${memVO.m_pw}</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>${memVO.m_name}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${memVO.m_email}</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>${memVO.m_profile_img})</td>
			</tr>
		</table>
		<br>

		<h3>등록 주소 정보</h3>
		<table class="type03">
			<tr>
				<td>주소 1</td>
				<td>${addVO.address1}</td>
			</tr>
			<tr>
				<td>주소 2</td>
				<td>${addVO.address2}</td>
			</tr>
			<tr>
				<td>주소 3</td>
				<td>${addVO.address3}</td>
			</tr>
		</table>
		<br>

		<h3>친구 추가 정보</h3>
		<table class="type03">
			<tr>
				<td>등록 일</td>
				<td>친구 ID</td>
			</tr>
			<c:forEach var="link" items="${linkList}" begin="0" step="1"
				end="${listSize}">
				<tr>
					<td>${link.request_date}</td>
					<td>${link.link_m_id}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${check eq 0}">
		<img src="/MeetWhenGit/img/error/noResult.gif" height=300px;/>
	</c:if>
</body>
</html>
