<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw" ></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<style>
#map {width:100%; height:600px; clear:both; border:solid 1px;}
html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
</style>
</head>
<body id="page-top">

 <jsp:include page="/Main/boots_menubar.mw"/>
 <jsp:include page="busScrin.jsp"/>
 <div class="container">
 	<div class="row">
 		<div class="col-lg-12 text-center">
          <h2 class="section-heading text-uppercase">내 주변 교통정보</h2>
          <h3 class="section-subheading text-muted">마커를 클릭하세요</h3>
        </div>
 	</div>
 	  	
  	<input type="checkbox" id="moveSerch" />현지도에서 검색하기
    <div id="map" class="timeline"></div>
    <input type="button" value="위치 다시 정하기" onclick="reSerch();">
</div>


<jsp:include page="/Main/boots_footer.mw"/>
</body>

</html>