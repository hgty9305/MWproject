<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:out value="${loginState}"/>
<c:if test="${loginState eq true}">
	<script>	
	 	alert("로그인 완료");
	</script>
</c:if>
<c:if test="${loginState eq false}">
	<script>
	 	alert("아이디와 비밀번호가 일치하지않습니다");
	 	history.go(-1);
	</script>
</c:if>
<c:if test="${sessionScope.loginUser eq null}">
	<script>
		alert("해당정보없음");
		window.location.href("boots_login.mw")
	</script>
</c:if>