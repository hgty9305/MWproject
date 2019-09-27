<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table.type03 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 3px solid #369;
  margin : 20px 10px;
}
table.type03 th {
    width: 147px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #153d73;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;

}
table.type03 td {
    width: 349px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
</style>
<html lang="en">
<head>
<title>main</title>
</head>
<body id="page-top">
      
 <jsp:include page="/MeetWhenGit/Main/boots_menubar.mw"/>
 <c:set value="${vo}" var="vo"/>
 <div class="container">
 	<div class="row">
 <table class="type03">
 <tr>
 <th>프로필사진</th>

	<td><img src="/MeetWhenGit/images/${vo.m_profile_img}" width="100px"/>
	<td><img src="/MeetWhenGit/images/qwqw.png" width="100px"/>
 ${vo.m_profile_img}
 <c:set var="img" value="${vo.m_profile_img}"/>
 
 <c:if test="${img eq 'default.png' }">
  ${img}
 	<td><img src="/MeetWhenGit/images/default.png" width="100px"/>
 </td>
 </c:if>


 </tr>
 
 </table>
 <div>
	<table class="type03">
	<tr>
	 <th scope="row">이름</th>
	<td><c:out value="${vo.m_name}"></c:out>
	</td>
	</tr>
	
	<tr><th scope="row">아이디</th>
	<td><c:out value="${vo.m_id}"></c:out>
	</td>
	</tr>	
	<tr>
		<th scope="row">이메일</th>
		<td>
		<c:out value="${vo.m_email}"></c:out>
		</td>
	</tr>
	</table>
	</div>
	</div>
</div>
<jsp:include page="/MeetWhenGit/Main/boots_footer.mw"/>

</body>

</html>
