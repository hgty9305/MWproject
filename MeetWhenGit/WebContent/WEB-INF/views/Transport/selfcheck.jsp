<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
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
     <jsp:include page="selfScrin.jsp"/>
 <div class="container">
 	<div class="row">
 		<div class="col-lg-12 text-center">
          <h2 class="section-heading text-uppercase">내 주변 교통정보</h2>
          <h3 class="section-subheading text-muted">마커를 클릭하세요</h3>
        </div>
 	</div>
    <div id="map" class="timeline"></div>
     <input type="button" value="주소로 검색" onclick="goPopup();"/>
  	<input type="button" value="ip로 검색" onclick="goreset();"/>
</div>


    <input type="hidden" name="xlat" value="document.lat"/>
  	<input type="hidden" name="xlat" value="document.lng"/>

  	<jsp:include page="/Main/boots_footer.mw"/>
  </body>
</html>