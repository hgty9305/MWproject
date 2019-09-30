<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--메인페이지 --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>MeetWhen</title>

  <!-- Bootstrap core CSS -->
  <link href="/MeetWhenGit/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="/MeetWhenGit/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

  <!-- Custom styles for this template -->
  <link href="/MeetWhenGit/css/agency.min.css" rel="stylesheet">
<style>
	.cHead{
		color:#FFD228;
	}
</style>
</head>


<script>
function checkReg() {
	    var group = document.group;
	    if (group.groupTitle.value == "") {
	        alert("이름을 입력하세요");
	        return;
	     }
	 }
	function openCheckTitle(group) {
		 
	    // url과 사용자 입력 id를 조합합니다.
	    url = "confTitle.mw?groupTitle=" + group.groupTitle.value;
	
	    // 새로운 윈도우를 엽니다.
	    open(
	          url,
	          "confirm",
	          "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
	 }

</script>

<body id="page-top">

	<jsp:include page="boots_menubar.jsp" />
			<br/>

		<div class="container">
			<div class="col-lg-12 text-center">
				<h2 class="section-heading text-uppercase">생성한 일정 리스트</h2>
				<c:forTokens var="name" items="${g_list}" delims="#">
				<img alt="" src="">
				<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
				href="/MeetWhenGit/Main/boots_calendar.mw?groupId=${name}">${name}</a>
				</c:forTokens>
			</div>
		</div>

	
	<!-- Header -->



	<jsp:include page="boots_footer.jsp" />
</body>
</html>
