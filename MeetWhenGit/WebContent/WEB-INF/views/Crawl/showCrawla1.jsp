<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--ũ�Ѹ�1: ���̹� �˻����  --%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>crawling 1</title>
</head>
<style>
table {
	border: 2px solid black;
	border-collapse: collapse;
	text-align: center;
	background-color:white;
}
td {
	font-weight: bold;
	border: 1px solid black;
	padding: 10px;
}
</style>
<body>
	<table>
		<tr>
			<td>������</td>
			<td>${vo.cwa1_cont}</td>
		</tr>
		<tr>
			<td>����</td>
			<td><img src="${vo.cwa1_img}" width=200px; height=150px/></td>
		</tr>
		<tr>
			<c:if test="${vo.cwa1_type!='3'}">
				<td>��ġ</td>
			</c:if>
			<c:if test="${vo.cwa1_type=='3'}">
				<td>����</td>
			</c:if>
			<td>${vo.cwa1_cap}</td>
		</tr>
		<tr>
			<c:if test="${vo.cwa1_type=='2'}">
				<td>��ȭ</td>
			</c:if>
			<c:if test="${vo.cwa1_type!='2'}">
				<td>ȯ��</td>
			</c:if>
			<td>
				${vo.cwa1_rat}
			</td>
		</tr>
	</table>
</body>
</html>