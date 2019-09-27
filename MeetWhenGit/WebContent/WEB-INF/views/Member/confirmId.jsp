<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<title>아이디 중복체크</title>
<body>
	<div class="container">
		<div class="text-center">
				<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
				<c:if test="${confirm==1}">
					<tr bgcolor="#FAE0D4"> 
						<td height="39" >이미 사용중인 아이디입니다.</td>
					</tr>
					<tr>
					<td align ="center"><input type ="button" value="닫기" onclick="duplicate()"><td>
					<tr>
					</c:if>
				</table>
			
				<table width="270" border="0" cellspacing="0" cellpadding="5">
				<c:if test="${confirm==0}">
					<tr bgcolor="#8C8C8C"> 
						<td align="center"> 
							<p>사용가능한 아이디 입니다! </p>
							<input type="button" value="닫기" onclick="setid()">
						</td>
					</tr>
					</c:if>
				</table>
		</div>
	</div>	
</body>
<script language="javascript">
	function setid(){		
    	opener.document.member.m_id.value="${m_id}";
		self.close();
	}
	function duplicate(){
		opener.document.member.m_id.value="";
		self.close();
	}
</script>