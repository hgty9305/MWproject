<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
	function makegroup(){
		window.opener.postMessage
	}
</script>
</head>
<body>
	<%--클릭한 값 받아와서 그룹원으로 초대할거냐고 묻기 Y/N --%>
	<%--Y면, 그값 다시 serchFriends페이지로 가져와서 추가++ --%>
	<h3>xx님을 그룹원으로 초대하시겠습니까?</h3>
	<table>
	<tr>
	<td><button onclick="">네</button></td>
	
	<td><button onclick ="self.close()">아니오</button><td>
	</tr>
	</table>
</body>
</html>