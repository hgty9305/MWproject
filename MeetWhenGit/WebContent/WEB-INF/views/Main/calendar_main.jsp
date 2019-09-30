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

<body id="page-top">
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="/MeetWhenGit/Main/main.mw">MeetWhen</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ml-auto">
					<c:if test="${not empty sessionScope.loginUser}">
						<li class="nav-item"><label
							class="nav-link js-scroll-trigger">${sessionScope.loginUser}님 환영합니다</label>
						</li>
						<c:if test="${sessionScope.loginUser eq 'admin'}">
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="/MeetWhenGit/Member/myPage.mw">관리자페이지</a></li>
						</c:if>
						<c:if test="${sessionScope.loginUser ne 'admin'}">
						<li class="nav-item">
							<a class="nav-link js-scroll-trigger" 
							href="/MeetWhenGit/Member/myPage.mw">마이페이지</a></li>
						<li class="nav-item cBlack"> <a class="nav-link js-scroll-trigger"
							href="/MeetWhenGit/Member/searchFriends.mw">그룹원 구성</a></li>
						<li class="nav-item cBlack"><a class="nav-link "
							href="/MeetWhenGit/Member/selectPlace.mw">장소등록</a></li>
						<li class="nav-item cBlack"><a class="nav-link "
							href="/MeetWhenGit/Map/map1.mw">해외정보</a></li>
						</c:if>
						
						<li class="nav-item"><a class="nav-link "
							href="/MeetWhenGit/Member/logOut.mw">로그아웃</a></li>
					</c:if>
					
				</ul>
			</div>
		</div>
	</nav>
<header class="masthead">
		<div class="container">
			<div class="intro-text">
				<img alt="" src="">
				<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
				href="/MeetWhenGit/Main/calendar_Form.mw">일정 생성</a>
		

				<img alt="" src="">
				<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
				href="/MeetWhenGit/Main/calendar_list.mw">일정 목록</a>
					</div>
		</div>
	</header>
	
	<!-- Header -->

		


	<jsp:include page="boots_footer.jsp" />
</body>
</html>
