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
<body>
<div id = "map"></div>
<script type="text/javascript">
	////지도 표시부분 --------------------------------------
	
	var mapOptions = {
			center : new google.maps.LatLng(${myylat}, ${myxlat}), /* 지도에 보여질 위치 */ 				
			zoom : 17, /* 지도 줌 (0축소 ~ 18확대),  */ 	
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
	
	var map = new google.maps.Map(document.getElementById("map"),mapOptions);
	var infowindow = new google.maps.InfoWindow();
	
	////마커 관련 옵션---------------------------------------
	
	var busIcon = new google.maps.MarkerImage("/MeetWhen/imgs/BUSstation2.png", null, null, null, new google.maps.Size(20,40));
	var me = new google.maps.MarkerImage("/MeetWhen/imgs/me.png", null, null, null, new google.maps.Size(30,30));

	
	//반복문으로 자바스크립트 배열내에 이름과 좌표를 넣어야한다.
	var locations = new Array;
	
	<c:forEach var="a1" items="${total}" begin="0" step="1" end="${buslistsize}">
	var locations2 = new Array;
		<c:forEach var="a2" items="${a1}" begin="0" step="1" end="4" varStatus="st">
			locations2.push(${a2});
		</c:forEach>
		locations.push(locations2);	
	</c:forEach>

	console.log('locations: ' + locations[0]); 

	//마커 변수 선언
	var marker,i, myMarker;
	var markers = [];


	//내위치 마커 찍기
	 myMarker = new google.maps.Marker({
		position: new google.maps.LatLng(${myylat}, ${myxlat}),
		map: map,
		icon: me
		}); 
	markers.push(myMarker);
	

	//
	var swLat,swLng,neLat,neLng,cenLat,cenLng;
	

	//맵 움직일시 작동하는 코드
	google.maps.event.addListener(map, 'dragend', function() {
		
	swLat = map.getBounds().getSouthWest().lat(); 
    swLng = map.getBounds().getSouthWest().lng(); 
    neLat = map.getBounds().getNorthEast().lat(); 
    neLng = map.getBounds().getNorthEast().lng(); 
    cenLat = map.getBounds().getCenter().lat(); 
    cenLng = map.getBounds().getCenter().lng(); 

   
    var allData = new Array(swLat, swLng, neLat, neLng);
    var centerData = new Array(cenLat,cenLng);
    deleteMarkers();

	//내위치 마커 찍기
	 myMarker = new google.maps.Marker({
		position: new google.maps.LatLng(cenLat, cenLng),
		map: map,
		icon: me
		}); 
	markers.push(myMarker);
	
    var locations = new Array;

	var string = centerData[0]+"/"+centerData[1];
    $.ajax({
		url: "/MeetWhen/bus/returnCenter.mw",
		type: "post",
		data: {string : string},
		success : function(data){
			locations = data;
			for (i = 0; i < locations.length; i++) {
			      marker = new google.maps.Marker({
			          id: i,
			          position: new google.maps.LatLng(locations[i][2], locations[i][1]),
			          icon: busIcon,
			          map: map
			        });
			        markers.push(marker);
			        
			     
			        google.maps.event.addListener(marker, 'click', (function(marker, i) {
			          return function() {
			              var title = locations[i][0];
			              $.ajax({
			              	url: "/MeetWhen/bus/returnBSinfo.mw",
			              	type: "post",
			              	data: {arsId : locations[i][3]},
			              	success : function(data){
			              	  	var busArray = data;
			              		var str = '</br>'+'<TR><TD>버스</TD><TD>도착 시간</TD><TD>탑승객</TD></TR>';
			              		for (var i in busArray) {
			              		str += '<TR><TD rowspan="2">' + busArray[i][0]+'</br>'+ busArray[i][1] +'</TD> <TD>' + busArray[i][2] + '</TD> <TD>' + busArray[i][3] +'</TD></TR>'+
			              		'<TR><TD>'+ busArray[i][4] +'</TD><TD>' + busArray[i][5] +  '</TD></TR>';     
			              	}
			              	str += '</br>';
			              	infowindow.setContent(
			              		'<h3>' + title +'</h3>' +
			              		'<table id="boardList" border="1">' + '</table>');
			              		 $("#boardList").append(str); 
			              	},
			              	error: function(textStatus, errorThrown) {
			              	alert("Status: " + textStatus); alert("Error :"+errorThrown);
			              	}
			              });
			            infowindow.open(map, marker);
			          }
			        })(marker, i));
			        
			        if(marker)
			        {
			          marker.addListener('click', function() {
			            map.setZoom(17);
			            map.setCenter(this.getPosition());
			          });
			        }
			      }
		},
		error: function(textStatus, errorThrown) {
		alert("Status: " + textStatus); alert("Error :"+errorThrown);
		}
	});
	

	});
	
	

	
	//지하철 정보 가져오기
	
	
	/* $.ajax({
		url: "/MeetWhen/bus/좌표내 역좌표찾기.mw",
		type: "post",
		data: allData,
		success : function(data){
			var subArray = data;
			
		  }

		},
		error: function(textStatus, errorThrown) {
		alert("Status: " + textStatus); alert("Error :"+errorThrown);
		}
	}); */
	
	/* $.ajax({
		url: "/MeetWhen/bus/returnBSinfo.mw",
		type: "post",
		data: {arsId : locations[i][3]},
		success : function(data){
		  	var busArray = data;
			var str = '</br>'+'<TR><TD>버스</TD><TD>도착 시간</TD><TD>탑승객</TD></TR>';
			for (var i in busArray) {
			str += '<TR><TD rowspan="2">' + busArray[i][0]+'</br>'+ busArray[i][1] +'</TD> <TD>' + busArray[i][2] + '</TD> <TD>' + busArray[i][3] +'</TD></TR>'+
			'<TR><TD>'+ busArray[i][4] +'</TD><TD>' + busArray[i][5] +  '</TD></TR>';     
		}
		str += '</br>';
		 
		infowindow.setContent(
			'<h3>' + title +'</h3>' +
			'<table id="boardList" border="1">' + '</table>');
			 $("#boardList").append(str); 
		},
		error: function(textStatus, errorThrown) {
		alert("Status: " + textStatus); alert("Error :"+errorThrown);
		}
	}); */
	
	
	
    ////전달받은 마커들을 전부 찍는 작업(맵에 표시 까지 하는 부분)
    for (i = 0; i < locations.length; i++) {
      marker = new google.maps.Marker({
        id: i,
        position: new google.maps.LatLng(locations[i][2], locations[i][1]),
        icon: busIcon,
        map: map
      });
      markers.push(marker);
      
     ///지도위 버스 정류장 마커를 클릭시 생기는 이벤트
      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
            var title = locations[i][0];
            $.ajax({
            	url: "/MeetWhen/bus/returnBSinfo.mw",
            	type: "post",
            	data: {arsId : locations[i][3]},
            	success : function(data){
            	  	var busArray = data;
            		var str = '</br>'+'<TR><TD>버스</TD><TD>도착 시간</TD><TD>탑승객</TD></TR>';
            		for (var i in busArray) {
            		str += '<TR><TD rowspan="2">' + busArray[i][0]+'</br>'+ busArray[i][1] +'</TD> <TD>' + busArray[i][2] + '</TD> <TD>' + busArray[i][3] +'</TD></TR>'+
            		'<TR><TD>'+ busArray[i][4] +'</TD><TD>' + busArray[i][5] +  '</TD></TR>';     
            	}
            	str += '</br>';
            	infowindow.setContent(
            		'<h3>' + title +'</h3>' +
            		'<table id="boardList" border="1">' + '</table>');
            		 $("#boardList").append(str); 
            	},
            	error: function(textStatus, errorThrown) {
            	alert("Status: " + textStatus); alert("Error :"+errorThrown);
            	}
            });
          infowindow.open(map, marker);
        }
      })(marker, i));
      
      if(marker)
      {
        marker.addListener('click', function() {
          map.setZoom(17);
          map.setCenter(this.getPosition());
        });
      }
    }


	//드래그시 기존 마커 지우고 다시 생성
	
	//마커 제거 함수
   function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }
	function clearMarkers() {
        setMapOnAll(null);
      }
	function deleteMarkers() {
        clearMarkers();
        markers = [];
      }
    
    //다시 검색 함수
    function reSerch(){
    	location.href="/MeetWhen/bus/selfcheck.mw?latX="+${myylat}+"&latY="+${myxlat};
        };
</script>
  	<input type="button" value="위치 다시 정하기" onclick="reSerch();">
</body>

</html>