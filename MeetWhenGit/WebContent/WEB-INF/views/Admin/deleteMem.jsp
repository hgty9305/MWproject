<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
.btnTop {
  border: none;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}
.btn {
  border: none;
  color: white;
  padding: 5px 15px;
  font-size: 16px;
  cursor: pointer;
}

.success {background-color: #4CAF50;} /* Green */
.success:hover {background-color: #46a049;}

.info {background-color: #2196F3;} /* Blue */
.info:hover {background: #0b7dda;}

.warning {background-color: #ff9800;} /* Orange */
.warning:hover {background: #e68a00;}

.danger {background-color: #f44336;} /* Red */ 
.danger:hover {background: #da190b;}

</style>
</head>

<script type="text/javascript">
	// 삭제 전 다시 질문 하기
	function deleteInfo(m_id) {
		var msg = confirm("회원 " + m_id + "을/를 탈퇴 시키겠습니까?");
		if (msg) {
			alert("탈퇴를 진행합니다.");
			location.href = "/MeetWhenGit/Db/deleteMemPro.mw?m_id=" + m_id;
		}
	}
</script>
<body>
	<button class="btnTop" style="background-color:black;"
		onclick="window.location.href='/MeetWhenGit/Member/myPage.mw'">관리자페이지 HOME</button>
	<br>
	<br>
	<c:if test="${listSize eq 0}">
		<h1>회원이 존재하지 않습니다.</h1>
	</c:if>
	<c:if test="${listSize ne 0}">
		<h1>모든 회원 의 정보(${listSize}명)</h1>
	</c:if>

	<c:forEach items="${dataList}" var="ent" begin="0" step="1"
		end="${listSize}">
		<span><button type="button" class="btn danger"
				onclick="deleteInfo('${ent.m_id}')">탈퇴</button></span>
		<span><b>[ID:${ent.m_id} / PW:${ent.m_pw}]</b> : (NAME_${ent.m_name}),
			(EMAIL_${ent.m_email}),(IMG_${ent.m_profile_img}) </span>
		<br>
	</c:forEach>
</body>
</html>