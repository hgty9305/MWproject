<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>main</title>
</head>
<body id="page-top">

<jsp:include page="/MeetWhenGit/Main/boots_menubar.mw"/>

	    <div id="friendList">
        <table id="bList" width="800" border="3" bordercolor="lightgray">
        	
            <tr height="30">
            	<th></th>
                <th>아이디</th>
            </tr>
            <c:forEach var="i" items="${friendList}" begin="0" end ="${CntfriendList-1}">
            <tr>
            	<td></td>
                <td>${i.link_m_id}</td>
            </tr>
            </c:forEach>
        </table>
    </div>
<jsp:include page="/MeetWhenGit/Main/boots_footer.mw"/>

</body>

</html>
