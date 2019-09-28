<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>main</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?key=AIzaSyCexlJx5Gqv4JLwdSxZIeYwAE2IIRN_iGw"></script>
<script type="text/javascript">
	$(document).ready(function() {
		fnGetCurrentPosition();
	});

	function fnGetCurrentPosition() {
		if (navigator.geolocation) {
			$("#userLocation").html("");
			$("#errormsg").html("");
			navigator.geolocation
					.getCurrentPosition(
							function(pos) {

								lat = pos.coords.latitude;
								lng = pos.coords.longitude;

								var people_location_arr = [
										[ 'people1', lat, lng,
												"http://maps.google.com/mapfiles/ms/micons/yellow-dot.png" ],
										[
												'umchong',
												37.555744,
												126.970431,
												"https://scontent-gmp1-1.xx.fbcdn.net/v/t1.0-1/p240x240/62424434_2249840091798196_4628670479484321792_n.jpg?_nc_cat=108&_nc_oc=AQkH0HZC97GVLwpNhNvjjmG8WtOwoE3W0YnQNWLQ4LfiKDZyGG9uqdYV3Xkcgvh8CZM&_nc_ht=scontent-gmp1-1.xx&oh=ca9768053ee6f8eeb35f358b9ce5bc13&oe=5DD5A8AC" ],
										[
												'yeeumho',
												37.49794199999999,
												127.02762099999995,
												"https://scontent-gmp1-1.xx.fbcdn.net/v/t1.0-9/22852260_529360264070168_1787899260599766627_n.jpg?_nc_cat=103&_nc_oc=AQlSKq7S8qeUQMhgyQ4hOz4llvVTAlpfFAfjGTmcdsrWL2ZxMDolG6O_XqvQxpjCqRg&_nc_ht=scontent-gmp1-1.xx&oh=d976fb3801833f474b403a56e6dcbecb&oe=5E0D13A4" ] ];

								$("#userLocation").html(
										"latitude : " + lat + "longitude : "
												+ lng);

								var mapOptions = {
									zoom : 11,
									mapTypeId : google.maps.MapTypeId.ROADMAP,
									center : new google.maps.LatLng(lat, lng)
								};

								map = new google.maps.Map(document
										.getElementById('map'), mapOptions);

								var myIcon = new google.maps.MarkerImage(
										"http://maps.google.com/mapfiles/ms/micons/yellow-dot.png",
										null, null, null, new google.maps.Size(
												30, 30));
								var latlngbounds = new google.maps.LatLngBounds(); //ì¤ìê°ì ì°¾ê¸°ìíì¬ì´

								for (i = 0; i < people_location_arr.length; i++) {
									var photo = new google.maps.MarkerImage(
											people_location_arr[i][3], null,
											null, null, new google.maps.Size(
													30, 30));
									new google.maps.Marker({
										position : new google.maps.LatLng(
												people_location_arr[i][1],
												people_location_arr[i][2]),
										map : map,
										draggable : false,
										animation : google.maps.Animation.DROP,
										icon : photo,
										label : people_location_arr[i][0]
									});
									//ì¤ìê°ì°¾ìë ¤ê³  ë§ì»¤ë¤ ëª¨ë extendíëê±°ê°ì
									latlngbounds.extend(new google.maps.LatLng(
											people_location_arr[i][1],
											people_location_arr[i][2]));
								}

								// ë§ì»¤ë¤ ê°ì´ ëª¨ë ë´ê¸´ latlngboundsìì .getCenter() ë©ìëë¥¼ì´ì©í´ì ì¤ìê°ì ë¦¬í´ë°ì
								// ê·¸ë°í ë§ì»¤ì°ê¸°
								var centerIcon_Ref = "https://scontent-gmp1-1.xx.fbcdn.net/v/t1.0-9/41021555_289093925222211_8440374429069869056_n.png?_nc_cat=111&_nc_oc=AQklHljtQIycKDtvOyyat4lDnjQ716p7daM5rZM7NHQJIYndXH7--4KcFqd44RgNdOI&_nc_ht=scontent-gmp1-1.xx&oh=8743bd7e56ae7eddfada6ec77c32ba90&oe=5E0E8591";
								var centerIcon = new google.maps.MarkerImage(
										centerIcon_Ref, null, null, null,
										new google.maps.Size(50, 50));
								new google.maps.Marker({
									position : latlngbounds.getCenter(),
									map : map,
									draggable : false,
									icon : centerIcon

								});
								markers.push(google.maps.Marker);

							},
							function(error) {
								switch (error.code) {
								case 1:
									$("#errormsg")
											.html(
													"User denied the request for Geolocation.");
									break;
								case 2:
									$("#errormsg")
											.html(
													"Location information is unavailable.");
									break;
								case 3:
									$("#errormsg")
											.html(
													"The request to get user location timed out.");
									break;
								case 0:
									$("#errormsg").html(
											"An unknown error occurred.");
									break;
								}
							});
		} else {
			$("#errormsg")
					.html("Geolocation is not supported by this browser.");
		}
	}
</script>
</head>
<body id="page-top">

	<jsp:include page="/Main/boots_menubar.mw" />
	
	<div id="errormsg"></div>
	<div id="userLocation"></div>
	<div id="friendlatlng"></div>
	<input type="button" value="Reload "
		onclick="Javascript:fnGetCurrentPosition();" />
	<div id="map" style="width: 760px; height: 400px; margin-top: 20px;"></div>
	
	<jsp:include page="/Main/boots_footer.mw" />

</body>
</html>
