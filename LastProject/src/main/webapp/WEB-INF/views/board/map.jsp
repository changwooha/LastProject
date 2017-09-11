<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta name="google-site-verification"
	content="jmcSA7d-dnNJUWyZJBghach5uXuiSGdvmGkD0cNDRDA" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<style>

/* Always set the map height explicitly to define the size of the div
 * element that contains the map. */
#map {
	height: 100%;
	width: 70%;
	margin: 0 auto;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 80%;
	margin: 0;
	padding: 0;
}

#floating-panel {
	position: absolute;
	top: 233px;
	left: 20%;
	z-index: 5;
	padding: 5px;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
	width: 20%;
}
</style>
<!-- <link rel="stylesheet" href="../resources/styles/map.css"> -->
<!-- <script type="text/javascript" src="../resources/js/mapAPI.js"></script> -->
<script type="text/javascript">
	$(function() {
		initMap()
	});

	function initMap() {
		var addr = $('#address').val()
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 15,
			center : {
				lat : 37.5110,
				lng : 127.0333
			}
		});
		var marker = new google.maps.Marker({
			position : {
				lat : 37.5110,
				lng : 127.0333
			},
			map : map
		})
		var contentString = '<div id="content">' + addr + '</div>';

		var infowindow = new google.maps.InfoWindow({
			content : contentString
		});
		marker.addListener('click', function() {
			infowindow.open(map, marker);
		});
		var geocoder = new google.maps.Geocoder();
		document.getElementById('submit').addEventListener('click', function() {
			geocodeAddress(geocoder, map);
		});
	}

	function geocodeAddress(geocoder, resultsMap) {
		address = document.getElementById('address').value;
		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status === 'OK') {
				var addr = $('#address').val()
				resultsMap.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map : resultsMap,
					position : results[0].geometry.location
				});
				var contentString = '<div id="content">' + addr + '</div>';
				var infowindow = new google.maps.InfoWindow({
					content : contentString
				});
				marker.addListener('click', function() {
					infowindow.open(map, marker);
				});
			} else {
				alert('Geocode was not successful for the following reason: '
						+ status);
			}
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>위치</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<div id="floating-panel">
		<div class="input-group">
			<input id="address" type="text" class="form-control"
				value="서울특별시 강남구 학동로30길 49"> <span class="input-group-btn">
				<button id="submit" type="button" class="btn btn-default">검색</button>
			</span>
		</div>
	</div>
	<div id="map"></div>
	<!-- Replace the value of the key parameter with your own API key. -->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDQiBN7Peqpk2INR8v8WcmDfHMtvjgDK1g&callback=initMap">
		
	</script>
</body>
</html>