<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${listSize eq 0}">
	<h1>회원이 존재하지 않습니다.</h1>
</c:if>
<c:if test="${listSize ne 0}">
	<h1> 모든 회원 의 정보</h1>
</c:if>

<c:forEach items="${dataList}" var="ent" begin="0" step="1" end="${listSize}">
	<c:if test="${num==6}"><%--Member --%>
		<span>[ID:${ent.m_id} / PW:${ent.m_pw}] : (NAME_${ent.m_name}), (EMAIL_${ent.m_email}),(IMG_${ent.m_profile_img})</span><br>
	</c:if>	
</c:forEach>
