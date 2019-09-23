<%@ page session="false" pageEncoding="UTF-8"%>

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
#map_canvas {width:80%; height:600px; clear:both; border:solid 1px;}
html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
</style>
<script type="text/javascript">

	var nav = null;
	var map;
	var marker;
	/* 현재 위치(위도/경도)를 받아오기 위한 부분 */
	$(function() {
		if (nav == null) {
			nav = window.navigator;
		}
		if (nav != null) {
			var geoloc = nav.geolocation;
			if (geoloc != null) {
				/* Callback 성공 시, successCallback() 호출 */
				geoloc.getCurrentPosition(successCallback);
			} else {
				alert("geolocation not supported");
			}
		} else {
			alert("Navigator not found");
		}
	});

	function successCallback(position) {
		/* 위도 */ var latitude = position.coords.latitude;
		/* 경도 */ var longitude = position.coords.longitude; 
		
		/* Google Map으로 위도와 경도 초기화 */
		initialize(latitude, longitude);
	}

	function initialize(latitude, longitude) {
		/* 현재 위치의 위도와 경도 정보를 currentLocatioon 에 초기화 */
		var currentLocation = new google.maps.LatLng(latitude, longitude);
		var mapOptions = {
			center : currentLocation, /* 지도에 보여질 위치 */ 				
			zoom : 14, /* 지도 줌 (0축소 ~ 18확대),  */ 	
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		/* DIV에 지도 달아주기 */
		map = new google.maps.Map(document.getElementById("map_canvas"),
				mapOptions);
		/* 지도 위에 마커 달아주기 */
		marker = new google.maps.Marker({
			position : currentLocation,
			map : map
		});
		google.maps.event.addListener(marker, 'click', toggleBounce(marker));

		// This event listener will call addMarker() when the map is clicked.
		/* 지도에서 마우스 클릭시 마커 생성 */
		google.maps.event.addListener(map, 'click', function(event) {
			addMarker(event.latLng);
		});
	}

	//Add a marker to the map and push to the array.
	/*
	 * 이 소스는 마커를 하나만 추가할 수 있도록 구현해놓습니다.
	 * 개발자분들 재량에 따라 코드를 응용하도록 하세요.  
	 */
	function addMarker(location) {
		/* 기존에 있던 마커 삭제 후 */
		/*새 마커 추가하기. */ 
		marker.setMap(null);
		marker = new google.maps.Marker({
			position : location,
			map : map
		});
		/* 마커 토글바운스 이벤트 걸어주기(마커가 통통 튀도록 애니메이션을 걸어줌) */
		google.maps.event.addListener(marker, 'click', toggleBounce(marker));
	}
	
	function toggleBounce(marker) {
		if (marker.getAnimation() != null) {
			marker.setAnimation(null);
		} else {
			marker.setAnimation(google.maps.Animation.BOUNCE);
		}
	}
	google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
	<div id = "map_canvas"></div>
	
</body>

</html>