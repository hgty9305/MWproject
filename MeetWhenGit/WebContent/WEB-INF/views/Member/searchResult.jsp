<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form onsubmit="openPop();">
	 <c:forEach var="i" items="${slist}" >
	    <p><input type="checkbox" name="friendId" value="${i.m_id}"/><label>${i.m_id}</label></p>
	</c:forEach>
	<input type="submit" />
</form>
