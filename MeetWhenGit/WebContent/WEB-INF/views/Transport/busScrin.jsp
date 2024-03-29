<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	var busIcon = new google.maps.MarkerImage("/MeetWhenGit/img/transport/BUSstation2.png", null, null, null, new google.maps.Size(20,40));
	var me = new google.maps.MarkerImage("/MeetWhenGit/img/transport/me.png", null, null, null, new google.maps.Size(30,30));
	var subway = new google.maps.MarkerImage("/MeetWhenGit/img/transport/subway.png", null,null,null,new google.maps.Size(20,20));
	
	//반복문으로 자바스크립트 배열내에 이름과 좌표를 넣어야한다.
	var locations = new Array;
	
	<c:forEach var="a1" items="${total}" begin="0" step="1" end="${buslistsize}">
	var locations2 = new Array;
		<c:forEach var="a2" items="${a1}" begin="0" step="1" end="4" varStatus="st">
			locations2.push(${a2});
		</c:forEach>
		locations.push(locations2);	
	</c:forEach>


	//마커 변수 선언
	var marker,i, myMarker, submarker;
	var markers = [];


	//내위치 마커 찍기
	 myMarker = new google.maps.Marker({
		position: new google.maps.LatLng(${myylat}, ${myxlat}),
		map: map,
		icon: me
		}); 
	markers.push(myMarker);
	

	//위치를 담을 변수
	var swLat,swLng,neLat,neLng,cenLat,cenLng;
	
	//위치를 담은 변수를 배열로 선별할 변수
	var allData,centerData,subfor;

	//아작스에서 나온 데이터를 운반할 변수
	var string;
	
	//시작함수
	function startFuc(){
		infowindow = new google.maps.InfoWindow();
		swLat = map.getBounds().getSouthWest().lat(); 
	    swLng = map.getBounds().getSouthWest().lng(); 
	    neLat = map.getBounds().getNorthEast().lat(); 
	    neLng = map.getBounds().getNorthEast().lng(); 
	    cenLat = map.getBounds().getCenter().lat(); 
	    cenLng = map.getBounds().getCenter().lng(); 
		allData = new Array(swLat, swLng, neLat, neLng);
		centerData = new Array(cenLat,cenLng);
	    subfor = allData[0]+"/"+allData[1]+"/"+ allData[2]+"/"+allData[3];
	}
	

	
	//움직일때마다 사용되는 지하철정보
	function subwayinfo(){
		$.ajax({
			url: "/MeetWhenGit/Transport/findSB.mw",
			type: "post",
			data: {subfor : subfor},
			success : function(data){
				var subArray = data;
			for (i = 0; i < subArray.length; i++) {
				console.log(subArray[i][0]);
				submarker = new google.maps.Marker({
			          id: i,
			          position: new google.maps.LatLng(subArray[i][1], subArray[i][2]),
			          icon: subway,
			          map: map
			        });
			        markers.push(submarker);
			        
			        google.maps.event.addListener(submarker, 'click', (function(submarker, i) {
				          return function() {
				        	  var title = subArray[i][0];
				              $.ajax({
				              	url: "/MeetWhenGit/Transport/returnSBinfo.mw",
				              	type: "post",
				              	data: {stationNm : subArray[i][0]},
				              	success : function(data){
				              	  	var subway = data;
				              		var str = '</br></br>';
				              		for (var i in subway) {
				              		str += '<TR><TD colsapn="5"></TD></TR><TR><TD colspan="3">' 
    				              		+ subway[i][1]+'</TD><TD colspan="2">'+ subway[i][2] +'</TD></TR>'+
				              		'<TR rowspan="2"><TD>'+ subway[i][0] +'</TD><TD colspan="4" rowspan="2">' 
				              		+ subway[i][4] + "(" + subway[i][3] + ")"+ '</TD></TR>'+
				              		'<TR><TD></TD></TR>';     
				              	}
				              	str += '</br>';
				              	infowindow.setContent(
				              		'<h3>' + title +'역 </h3>' + '가장 먼저 도착하는 순서입니다.'+
				              		'<table id="subList" border="1">' + '</table>');
				              		 $("#subList").append(str); 
				              	},
				              	error: function(textStatus, errorThrown) {
				              	alert("Status: " + textStatus); alert("Error :"+errorThrown);
				              	}
				              });
				            infowindow.open(map, submarker);
				          }
				        })			        
				        (submarker, i));  
				        if(submarker)
				        {
				        	submarker.addListener('click', function() {
				            map.setZoom(17);
				            map.setCenter(this.getPosition());
				          });
				       }
				        if(infowindow)
				        {
				        	infowindow.addListener('click', function() {
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
	}

	//움직일때마다 사용되는 버스정보
	function businfo(){
		$.ajax({
			url: "/MeetWhenGit/Transport/returnCenter.mw",
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
				              	url: "/MeetWhenGit/Transport/returnBSinfo.mw",
				              	type: "post",
				              	data: {arsId : locations[i][3]},
				              	success : function(data){
				              	  	var busArray = data;
				              		var str = '</br>'+'<TR><TD>버스</TD><TD>도착 시간</TD><TD>승객</TD></TR>';
				              		for (var i in busArray) {
				              		str += '<TR><TD rowspan="2">' + busArray[i][0]+'</br>'+ busArray[i][1]
				              		 +'</TD> <TD>' + busArray[i][2] + '</TD> <TD>' + busArray[i][3] +'</TD></TR>'+
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
				        })
				        
				        (marker, i));
				        
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
	}


	
	//처음 맵 로딩시 보여주는 화면부분.
	google.maps.event.addListenerOnce(map, 'idle', function(){
	startFuc();

	
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
	            	url: "/MeetWhenGit/Transport/returnBSinfo.mw",
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


   		//지하철을 찾는 부분
	    subwayinfo();
	});
		
	  //맵 움직일시 작동하는 코드 (위이 코드와 동일하며 맵 드래그 이벤트 기존 마커를 지우고 움직인 위치에따른 좌표값을 기준으로 마커를 찍고 정보를 불러온다.)
		var moveSerch = document.getElementById("moveSerch");
		var check = $(moveSerch).is(":checked");
		
		$(document).ready(function(){
		    $("#moveSerch").click(function(){
		        if($("#moveSerch").is(":checked")){
		        	var infowindow = new google.maps.InfoWindow();
		        	google.maps.event.addListener(map, 'dragend', function() {

		        		startFuc();
		        	    deleteMarkers();

		        		//내위치 마커 찍기
		        		 myMarker = new google.maps.Marker({
		        			position: new google.maps.LatLng(cenLat, cenLng),
		        			map: map,
		        			icon: me
		        			}); 
		        		markers.push(myMarker);
		        	    locations = new Array;
		        		string = centerData[0]+"/"+centerData[1];
		        		
		        		//버스 정보 가져오기
		        	    businfo();
		        		//지하철 정보 가져오는부분
		        		subwayinfo();
		        		});
		        
		        }else{
		        	google.maps.event.clearListeners(map, 'dragend');
		        }
		    });
		});

		

	function foo() {
		  // possibly long task
		  setTimeout(foo, 1500);
		}
	
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
    	location.href="/MeetWhenGit/Transport/selfcheck.mw?latX="+${myylat}+"&latY="+${myxlat};
        };
</script>