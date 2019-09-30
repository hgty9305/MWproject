<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	input.submit{
	left:40%;
	}
</style>
<form onsubmit="openPop();" action="position.mw">
	 <c:forEach var="i" items="${slist}" >
	    <p><input type="checkbox" name="friendId" value="${i.m_id}" class="section-subheading text-muted"/><label>${i.m_id}</label></p>
	</c:forEach>
	<input type="submit" value="친구들 위치보기" class="section-subheading text-muted"/>
</form>
