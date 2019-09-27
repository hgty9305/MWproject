<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>servicesA</title>
</head>
<style>
.grid-container {
  display: grid;
  grid-template-columns: auto auto auto auto;
  grid-gap: 1px;
  /*background-color: black;*/
}

.grid-container > div {
  /*background-color: rgba(255, 255, 255, 0.8);*/
  text-align: center;
  padding: 20px 0;
  font-size: 15px;
}
ul{
	list-style:none;
    padding-left:0px;
}
a{
	color:black;
}
</style>
<body id="page-top">
<div class="grid-container">
  <div class="item1">
  	<h3>고객센터</h3>
  	<ul>
    	<li>아이디 찾기</li>
        <li>비밀번호 찾기</li>
        <li>회원정보 변경</li>
        <li>회원 탈퇴</li>
        <li>신고 센터</li>
        <li>MW 고객센터</li>
    </ul>
  </div>
  <div class="item2">
  	<h3>내 서비스</h3>
  	<ul>
    	<li>캘린더</li>
        <li>내 주소</li>
        <li>주변 정보</li>
         <li>여행 스타일</li>
    </ul>
  </div>
  <div class="item3">
  	<h3>사용 API</h3>
  	<ul>
    	<li><a href="https://cloud.google.com/maps-platform/">구글 지도</a></li>
        <li>버스 정보</li>
        <li>캘린더</li>
        <li><a href="https://www.juso.go.kr/CommonPageLink.do?link=/addrlink/devAddrLinkRequestSample">주소 정보</a></li>
    </ul>
  </div>  
  <div class="item4">
  	<h3>MAP</h3>
  	<ul>
    	<li><a href="/MeetWhenGit/Map/map1.mw">세계 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map2.mw">유럽 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map3.mw">아프리카 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map4.mw">중동 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map5.mw">오세아니아 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map6.mw">아시아 지도</a></li>
        <li><a href="/MeetWhenGit/Map/map7.mw">북아메리카 지도</a></li>
         <li><a href="/MeetWhenGit/Map/map8.mw">남아메리카 지도</a></li>
    </ul>
  </div>
  <%-- 
  <div class="item5">5</div>
  <div class="item6">6</div>
  <div class="item7">7</div>
  <div class="item8">8</div>
  --%>
</div>

</body>

</html>
