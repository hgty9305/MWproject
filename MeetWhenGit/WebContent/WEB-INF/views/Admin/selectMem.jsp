<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
.btn {
  border: none;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}
.btnSearch {
  border: none;
  color: white;
  padding: 6px 10px;
  font-size: 14px;
  cursor: pointer;
}

.success {
	background-color: #4CAF50;
} /* Green */
.success:hover {
	background-color: #46a049;
}

.info {
	background-color: #2196F3;
} /* Blue */
.info:hover {
	background: #0b7dda;
}

</style>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
function getAllById(){
		var userId= $("#userId").val();	
		//console.log(userId);
		 if(userId==""){
				alert("찾으려는 회원 아이디를 입력해주세요");
		}else{
			$.ajax({
				type : 'POST',
				url : 'selectMemResult.mw',
				data : {userId : userId},
				success : function(data) {
					$("#findResult").html(data); },
				error : function() {
					$("#findResult").html('<h3>검색 결과가 존재하지않습니다.</h3>');
				}
			})
		}
	};
</script>
<body>
	<button class="btn" style="background-color: black;"
		onclick="window.location.href='/MeetWhenGit/Member/myPage.mw'">관리자페이지 HOME</button>
	<br>
	
	<h2>회원 정보 조회</h2>
	<c:forEach items="${dataList}" var="ent" begin="0" step="1" end="${listSize}">
		<span><b>ID : ${ent.m_id}</b>_ ${ent.registrationdate }</span>
		<br>
	</c:forEach>
	<hr>

	<form onsubmit="getAllById(); return false;">
        <input type="text" size="20" id="userId" name="userId"/>&nbsp;
        <button class="btnSearch info " type="submit">조회</button>
    </form> 
	<div id="findResult"></div> 
</body>
</html>
