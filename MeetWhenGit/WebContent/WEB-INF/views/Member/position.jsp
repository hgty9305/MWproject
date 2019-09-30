<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw" ></script>
<title>위치 출력</title>
</head>
<body id="page-top">
   <jsp:include page="/Main/boots_menubar.mw" />
<c:set value="${user1}" var="user1"/>
<c:set value="${user2}" var="user2"/>
<c:set value="${user3}" var="user3"/>
   
        <input type="button" value="현재위치 갱신" onclick="Javascript:fnGetCurrentPosition();" />
        
        <div id="map" style="width:760px;height:400px;margin-top:20px;"></div>

<script>
var selectedAddress = new Array();
$("#tbl_addressInfo tr").click(function(){
   var td = $(this).children();
   selectedAddress = new Array();
   td.each(function(i){
      selectedAddress.push(td.eq(i).text());
   });
});
$("#btn_sendAddress").click(function(){
   alert(selectedAddress);
   
   //boots_currentPostion.mw;
})

</script>
<script type="text/javascript">
var markers = [];
$(document).ready(function() {
   fnGetCurrentPosition();
});

    function fnGetCurrentPosition() {
        if (navigator.geolocation)
        {
            $("#userLocation").html("");
            $("#errormsg").html("");
            navigator.geolocation.getCurrentPosition (function (pos){
            //현재 자신의 위도경도
                lat = pos.coords.latitude; 
                lng = pos.coords.longitude;

                //user1 위도경도
                lat1 =  ${user1.lat1};
                lng1 =  ${user1.long1};
            console.log(lat1);
                //user2 
                lat2 =  ${user2.lat2};
                lng2 =  ${user2.long2};
 
                //user3
                lat3 =  ${user3.lat3};
                lng3 =  ${user3.long3}; 
                
                var people_location_arr = [
                   ["현재위치", lat, lng, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["user1", lat1,lng1 , "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["user2",lat2 ,lng2, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["user3", lat3,lng3, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"]
                  ];
 
                $("#userLocation").html("latitude : " + lat + "longitude : "+ lng);
                var mapOptions = {
                    zoom: 11,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(lat,lng)
                };
 
                map = new google.maps.Map(document.getElementById('map'),mapOptions);
                
                var myIcon = new google.maps.MarkerImage("http://maps.google.com/mapfiles/ms/micons/yellow-dot.png", null, null, null, new google.maps.Size(30,30));
                var latlngbounds = new google.maps.LatLngBounds();
                
                for(i=0; i<people_location_arr.length; i++){
                   
                   var photo = new google.maps.MarkerImage(people_location_arr[i][3], null, null, null, new google.maps.Size(30,30));
                   var Marker = new google.maps.Marker({
                        position: new google.maps.LatLng(people_location_arr[i][1], people_location_arr[i][2]),
                        
                        map: map,
                        draggable: false,
                        animation: google.maps.Animation.DROP,
                        icon: photo,
                        label:people_location_arr[i][0]
                    });
                   latlngbounds.extend(new google.maps.LatLng(people_location_arr[i][1], people_location_arr[i][2])); 
                }
               
               var centerIcon_Ref = "https://scontent-gmp1-1.xx.fbcdn.net/v/t1.0-9/41021555_289093925222211_8440374429069869056_n.png?_nc_cat=111&_nc_oc=AQklHljtQIycKDtvOyyat4lDnjQ716p7daM5rZM7NHQJIYndXH7--4KcFqd44RgNdOI&_nc_ht=scontent-gmp1-1.xx&oh=8743bd7e56ae7eddfada6ec77c32ba90&oe=5E0E8591";
               var centerIcon = new google.maps.MarkerImage(centerIcon_Ref, null, null, null, new google.maps.Size(50,50));
               new google.maps.Marker({
                   position: latlngbounds.getCenter(),
                   map: map, 
                   draggable: false, 
                   icon: centerIcon
               });
               markers.push(Marker);
               
               
            },function(error){
                switch(error.code){
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
        else{
            $("#errormsg").html("Geolocation is not supported by this browser.");
        }
    }
</script>
<jsp:include page="/Main/boots_footer.mw" />
</body>
</html>