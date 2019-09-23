<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구글 맵 api 활용 및 테스트</title>
<!-- 기본스크립트  -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw" ></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<style>
#map {width:80%; height:600px; clear:both; border:solid 1px;}
html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
</style>

</head>
<body>

<div id="map"></div>

<script type="text/javascript">
	var map, infoWindow;
	function initMap(){
		map=new google.maps.Map(document.getElementById('map'),{
			center : {lat:37.554169, lng:126.971383},
			zoom: 16,
	          
		});
		infoWindow = new google.maps.InfoWindow;

		if(navigator.geolocation){
			navigator.geolcation.getCurrentPosition(function(position){
			var pos = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};

			infoWindow.setPosition(pos);
			infoWindow.setContent('지역을 찾았습니다.');
			infoWindow.open(map);
			map.setCenter(pos);
			}, function(){
				handleLocationError(true, infoWindow, map.getCenter());
			});
			
		}else{
			handleLocationError(false, infoWindow, map.getCenter());
		}
	}

	function handleLocationError(browserHasGeolocation, infoWindow, pos) {
		infoWindow.setPosition(pos);
		infoWindow.setContent(browserHasGeolocation ? '에러:Geolocation서비스 실패' : '에러:당실의 브라우저가 geolcation서비스를 지원하지않습니다.')
		infoWinfow.open(map);
	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw&callback=initMap"  async defer ></script>



</body>
</html>