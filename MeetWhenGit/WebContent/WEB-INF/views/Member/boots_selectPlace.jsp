<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
<title>PlaceList</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw" ></script>
<style>
table.type03 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 3px solid #369;
  margin : 40px 10px;
}
table.type03 th {
    width: 200px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #153d73;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;

}
table.type03 td {
    width: 380px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
</style>
</head>

<body id="page-top">
 <jsp:include page="/MeetWhenGit/Main/boots_menubar.mw"/>
 
		<p3>등록된 주소들</p3>
		<br/>
		<hr/><hr/>
		
		<table class="type03" id="tbl_addressInfo">
		<c:set value="${addressInfo}" var="addressInfo"/>
		<thead>
			<tr>
				<th> 선택</th>
				<th> 주소 </th>
				<th> 위도 </th>
				<th> 경도 </th>
				<th> 편집 </th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="radio" name="seletedAddress"></td>
				<td>${addressInfo.address1}</td>
				<td>${addressInfo.lat1}</td>
				<td>${addressInfo.long1}</td> 
				<td><a href="/MeetWhenGit/Member/boots_regitPlace.mw?id=1">등록/수정</a> </td>
			</tr>
			<tr>
				<td><input type="radio" name="seletedAddress"></td>
				<td>${addressInfo.address2}</td>
				<td>${addressInfo.lat2}</td>
				<td>${addressInfo.long2}</td> 
				<td><a href="/MeetWhen/Member/boots_regitPlace.mw?id=2">등록/수정</a> </td>
				
			</tr>
			<tr>
				<td><input type="radio" name="seletedAddress"></td>
				<td>${addressInfo.address3}</td>
				<td>${addressInfo.lat3}</td>
				<td>${addressInfo.long3}</td> 
				<td><a href="/MeetWhen/Member/boots_regitPlace.mw?id=3">등록/수정</a> </td>
			</tr>
		</tbody>
		</table>
 	 	
 	 	<input type="button" value="Reload " onclick="Javascript:fnGetCurrentPosition();" />
 	 	
 	 	<div id="map" style="width:760px;height:400px;margin-top:20px;"></div>
<jsp:include page="/MeetWhenGit/Main/boots_footer.mw"/>
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
            navigator.geolocation.getCurrentPosition (function (pos)
           {
                lat = pos.coords.latitude;
                lng = pos.coords.longitude;
                lat1 =  ${addressInfo.lat1};
                lng1 =  ${addressInfo.long1};
                lat2 =  ${addressInfo.lat2};
                lng2 =  ${addressInfo.long2};
                lat3 =  ${addressInfo.lat3};
                lng3 =  ${addressInfo.long3}; 
                
                var people_location_arr = [
                	["a", lat, lng, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["hiru", lat1,lng1 , "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["${addressInfo.m_id}",lat2 ,lng2, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"],
                    ["${addressInfo.m_id}", lat3,lng3, "http://maps.google.com/mapfiles/ms/micons/yellow-dot.png"]
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
</script>
</body>

</html>
