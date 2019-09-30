<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:set var="groupId" value="${groupId}"/>
	 <c:forEach var="i" items="${slist}" >
	    <p><input type="checkbox" name="friendId" value="${i.m_id}"/><label>${i.m_id}</label></p>
	    <c:set var="friend" value="${i.m_id}"/>
	</c:forEach>
	<input type="button" value="추가" onclick="location.href='/MeetWhenGit/Main/addfriend.mw?friend=${friend}'" />

