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
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top">MeetWhen</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ml-auto">
					<c:if test="${empty sessionScope.loginUser}">
				        <li class="nav-item">
				          <a class="nav-link js-scroll-trigger" href="/MeetWhenGit/Member/login.mw">로그인</a>
				        </li>
				    </c:if>
					<c:if test="${not empty sessionScope.loginUser}">
						<li class="nav-item"><label
							class="nav-link js-scroll-trigger">${sessionScope.loginUser}님 환영합니다</label>
						</li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="/MeetWhenGit/Member/myPage.mw">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link "
							href="/MeetWhenGit/Member/logOut.mw">로그아웃</a></li>
					</c:if>
					
				</ul>
			</div>
		</div>
	</nav>
	
	<!-- Header -->
	<header class="masthead">
		<div class="container">
			<div class="intro-text">
				<div class="intro-lead-in"></div>
				<div class="intro-heading text-uppercase cHead">Welcome To 'MeetWhen'</div>
				<c:if test="${empty sessionScope.loginUser}">
					<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
					href="/MeetWhenGit/Member/join.mw">Join Us</a>
				</c:if>
				<c:if test="${not empty sessionScope.loginUser}">
					<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
					href="/MeetWhenGit/Main/boots_calendar.mw">Enjoy it</a>
				</c:if>
					
			</div>
		</div>
	</header>

	<!-- About -->
	<section class="page-section" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">For what?</h2>
					<h3 class="section-subheading text-muted">MeetWhen은 친구들과 만날 수
						있는 최상의 시간을 찾아줍니다.</h3>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<ul class="timeline">
						<li>
							<div class="timeline-image bgblack">
								<a href="/MeetWhenGit/Member/searchFriends.mw"><img class="rounded-circle img-fluid"
									src="/MeetWhenGit/img/main/friend.png" alt=""></a>
							</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4>1.친구들과 연락하기</h4>
									<h4 class="subheading">Keep in touch with friends</h4>
								</div>
								<div class="timeline-body">
									<p class="text-muted">여럿이서 만나는 그룹 모임은 한 번 만날 시간 정하기가 여간 쉽지
										않습니다. 오프라인으로 친구들과 연락하여 언제 만날 지 이야기 하다가 흐지부지 되어 만나지 않기가 다반사입니다.
										이를 어떻게 해결할 수 있을까요?</p>
								</div>
							</div>
						</li>
						<li class="timeline-inverted">
							<div class="timeline-image">
								<a href="/MeetWhenGit/Main/calendar_Form.mw"><img class="rounded-circle img-fluid"
									src="/MeetWhenGit/img/main/calendar.png" alt=""></a>
							</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4>2.가능한 시간 체크하기</h4>
									<h4 class="subheading">Check the available time or date</h4>
								</div>
								<div class="timeline-body">
									<p class="text-muted">그룹의 사람들은 각각 캘린더에 자신이 가능한 날짜, 시간 등을
										기록합니다. 그리고 모두의 캘린더의 일정을 합하여 겹치는 부분을 알아냅니다. 언제, 몇시, 기간은 어느정도인지
										한번에 알아낼 수 있습니다!</p>
								</div>
							</div>
						</li>
						<li>
							<div class="timeline-image">
								<a href="/MeetWhenGit/Transport/selfcheck.mw"><img class="rounded-circle img-fluid"
									src="/MeetWhenGit/img/main/subway.png" alt=""></a>
							</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4>3.실시간 교통정보 찾기</h4>
									<h4 class="subheading">Find Live traffic information</h4>
								</div>
								<div class="timeline-body">
									<p class="text-muted">만날 날짜를 찾아서 정하였다면 이젠 밖으로 나가야겠죠! 집 밖으로
										나가게 됩니다. 음... 가장 근처의 교통 정보가 어떻게 될까요? MeetWhen에서 한 번에 확인 할 수
										있습니다.</p>
								</div>
							</div>
						</li>
						<li class="timeline-inverted">
							<div class="timeline-image">
								<a href="/MeetWhenGit/Map/map1.mw"><img class="rounded-circle img-fluid" 
									src="/MeetWhenGit/img/main/passport.png" alt=""></a>
							</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4>4.해외여행을 위한 정보 찾기</h4>
									<h4 class="subheading">Find information for traveling
										abroad</h4>
								</div>
								<div class="timeline-body">
									<p class="text-muted">그룹원 모두가 가능한 기간이 길어 국내뿐만 아니라 해외여행도 가능할
										것 같다면? 공항통계를 한 눈에 볼 수 있는 페이지로 넘어가 봅시다 ! 방문자 수가 얼마인지, 해당 나라 간단한
										정보와 추천명소, 그리고 실시간 뉴스 까지 한눈에 확인할 수 있습니다.</p>
								</div>
							</div>
						</li>
						<li class="timeline-inverted">
							<div class="timeline-image">
								<h4>
									Enjoy <br>Our <br>Homepage!
								</h4>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</section>

	<!-- Team -->
	<section class="bg-light page-section" id="team">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">Developer</h2>
					<h3 class="section-subheading text-muted">팀원 소개 및 한 마디</h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="team-member">
						<img class="mx-auto rounded-circle" src="/MeetWhenGit/img/portfolio/csm.jpg"
							alt="">
						<h4>조성민</h4>
						<p class="text-muted">일이나 학업에 치여 친구를 만나기힘든 사람들에게 약속을 정할 때 편의성을 제공하는 서비스를 제공하는 것을 목표로 했습니다.</p>
						<p class="text-muted">해당 페이지 먼저보기</p>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="team-member">
						<img class="mx-auto rounded-circle" src="/MeetWhenGit/img/portfolio/jh.jpg"
							alt="">
						<h4>임지환</h4>
						<p class="text-muted">귀차니즘과 불편함은 <br/>아이디어의 아주 좋은 공급원입니다.</p>
						<p class="text-muted">해당 페이지 먼저보기</p>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="team-member">
						<img class="mx-auto rounded-circle" src="/MeetWhenGit/img/portfolio/ksm.jpg"
							alt="">
						<h4>김성민</h4>
						<p class="text-muted">여행을 좋아하는 1인으로써, 공항통계 자료를 한 눈에 볼 수있으면
							좋겠다는 생각에 구현해보게 되었습니다.</p>
						<p class="text-muted">해당 페이지 먼저보기</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="boots_footer.jsp" />
</body>
</html>
