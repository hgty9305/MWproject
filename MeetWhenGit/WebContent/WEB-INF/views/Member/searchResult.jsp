<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
 <c:forEach var="i" items="${slist}" >
     <div id="smtest">${i.m_id }</div>
=======
 <c:forEach var="i" items="${slist}">
     <div id="searchResult">${i.m_id}</div>
>>>>>>> refs/remotes/origin/master
</c:forEach>