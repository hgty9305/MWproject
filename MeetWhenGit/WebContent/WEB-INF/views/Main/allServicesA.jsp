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
    	<li><a href="#">아이디 찾기</a></li>
        <li><a href="#">비밀번호 찾기</a></li>
        <li><a href="#">회원정보 변경</a></li>
        <li><a href="#">회원 탈퇴</a></li>
        <li><a href="#">신고 센터</a></li>
        <li><a href="#">MW 고객센터</a></li>
    </ul>
  </div>
  <div class="item2">
  	<h3>내 서비스</h3>
  	<ul>
    	<li><a href="#">캘린더</a></li>
        <li><a href="#">내 주소</a></li>
        <li><a href="#">주변 정보</a></li>
        <li><a href="/MeetWhenGit/Error/cSoon.mw">여행 스타일</a></li>
    </ul>
  </div>
  <div class="item3">
  	<h3>사용 API</h3>
  	<ul>
  		<li><a href="https://fullcalendar.io/">캘린더</a></li>
  		<li><a href="https://www.data.go.kr/dataset/15000332/openapi.do">버스 정보</a></li>
  		<li><a href="http://data.seoul.go.kr/dataList/datasetView.do?infId=OA-12764&srvType=F&serviceKind=1&currentPageNo=1&searchValue=&searchKey=null">지하철 정보</a></li>
  		<li><a href="https://www.juso.go.kr/CommonPageLink.do?link=/addrlink/devAddrLinkRequestSample">주소 정보</a></li>
    	<li><a href="https://cloud.google.com/maps-platform/">구글 지도</a></li> 
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
