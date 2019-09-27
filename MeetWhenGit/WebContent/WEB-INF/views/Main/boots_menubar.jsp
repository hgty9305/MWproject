<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>MeetWhen?</title>

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
</head>
<body>
	<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="/MeetWhenGit/Main/main.mw">Meet When</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav text-uppercase ml-auto">
        <c:if test="${empty sessionScope.loginUser}">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/MeetWhenGit/Member/boots_login.mw">�α���</a>
          </li>
          </c:if>
          <c:if test="${not empty sessionScope.loginUser}">
                    
          <li class="nav-item">
            <label class="nav-link js-scroll-trigger">${sessionScope.loginUser}ȸ����</label>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/MeetWhenGit/Member/boots_MyPage.mw">ȸ������</a>
          </li>

          <li class="nav-item">
            <a class="nav-link " href="/MeetWhenGit/Member/logOut.mw">�α׾ƿ�</a>
          </li>
          </c:if>
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- Header -->
  <header class="masthead">
    <div class="container">
      <div class="intro-text"></div>
    </div>
  </header>
  
</body>
</html>