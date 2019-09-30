<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<title>그룹이름 중복체크</title>
<body>
	<div class="container">
		<div class="text-center">
				<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
				<c:if test="${confirm==1}">
					<tr bgcolor="#FAE0D4"> 
						<td height="39" >이미 존재하는 그룹 이름입니다.</td>
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
							<p>사용가능한 이름 입니다! </p>
							<input type="button" value="닫기" onclick="setTitle()">
						</td>
					</tr>
					</c:if>
				</table>
		</div>
	</div>	
</body>
<script language="javascript">
	function setTitle(){		
    	opener.document.group.groupTitle.value="${groupTitle}";
		self.close();
	}
	function duplicate(){
		opener.document.group.groupTitle.value="";
		self.close();
	}
</script>