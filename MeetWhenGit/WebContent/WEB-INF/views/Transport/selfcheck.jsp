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

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>

      // This example displays a marker at the center of Australia.
      // When the user clicks the marker, an info window opens.
	  var lat;
	  var lng;
		
      function selfCheck() {
    	  var marker;
    	  
    	  if (navigator.geolocation)
          {
              navigator.geolocation.getCurrentPosition (function (pos)
              {
            	  if(${xlat!="1"}){
					  lat = ${ylat};
					  lng = ${xlat}
				  }else{
                  lat = pos.coords.latitude;
                  lng = pos.coords.longitude;
				  }
                  $("#userLocation").html("latitude : " + lat + "longitude : "+ lng);

                  var mapOptions = {
                      zoom: 16,
                      mapTypeId: google.maps.MapTypeId.ROADMAP,
                      center: new google.maps.LatLng(lat,lng)
                  };
   
                  map = new google.maps.Map(document.getElementById('map'),mapOptions);
                  marker = new google.maps.Marker({
                          position: new google.maps.LatLng(lat, lng),
                          map: map,
                          draggable: true,
                          animation: google.maps.Animation.DROP
                      });  
        
                  var infowindow = new google.maps.InfoWindow({
                    content: " "
                  });
					
                  google.maps.event.addListener(marker, 'dragend', function() {
                      lat = marker.getPosition().lat();
                      lng = marker.getPosition().lng();
                      infowindow.close();
                  });

                  google.maps.event.addListener(map, 'click', function(event) {
                	  lat = marker.getPosition().lat();
                      lng = marker.getPosition().lng();
                	  clickMarker(event.latLng);
                	  infowindow.close();
                	});

				  function clickMarker(location){
					  marker.setPosition(location);
				    }
				    
                  marker.addListener('click', function() {
	               	  lat = marker.getPosition().lat();
	                  lng = marker.getPosition().lng();   
	               	  infowindow.setContent('<a id="link" href="/MeetWhenGit/Transport/BusSerch.mw?selfX='+ lng +'&selfY='+ lat +'" ><h2>내 주변 대중교통 찾기</h2></a>');
	                  infowindow.open(map, marker);
                  });
                
                  
              },function(error)
              {
                  switch(error.code)
                  {
                      case 1:
                          $("#errormsg").html("User denied the request for Geolocation.");
                          break;
                      case 2:
                          $("#errormsg").html("Location information is unavailable.");
                          break;
                      case 3:
                          $("#errormsg").html("The request to get user location timed out.");
                          break;
                      case 0:
                          $("#errormsg").html("An unknown error occurred.");
                          break;
                  }
              });
          }
          else
          {
              $("#errormsg").html("Geolocation is not supported by this browser.");
          }
      }
      
      function goPopup(){
    	    var pop = window.open("jusoPopup.mw","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
    	}
  	
      function goreset(){
    	  	location.href="/MeetWhenGit/Transport/selfcheck.mw";
  		}
      
      function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
				, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno
				, emdNo, entX, entY){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		/* document.form.roadAddrPart1.value = roadAddrPart1;
		document.form.roadAddrPart2.value = roadAddrPart2;
		document.form.addrDetail.value = addrDetail;
		document.form.zipNo.value = zipNo;
		document.form.entX.value = entX;
		document.form.entY.value = entY; */
		location.href="/MeetWhenGit/Transport/selfcheck.mw?entX="+entX+"&entY="+entY;
		}

    </script>
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw&callback=selfCheck">
    </script>
    <input type="hidden" name="xlat" value="document.lat"/>
  	<input type="hidden" name="xlat" value="document.lng"/>

  	<jsp:include page="/Main/boots_footer.mw"/>
  </body>
</html>