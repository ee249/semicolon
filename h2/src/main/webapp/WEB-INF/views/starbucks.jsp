<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.StarbucksVO, java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1eb82a611b357dbfc3eb3e227b6ec2d3&libraries=services"></script>
</head>
<!-- 
${vo.storeid}
${vo.storename}
${vo.storeaddr}
${vo.storelat}
${vo.storelng}
 -->
<body>

	<form method="POST" action="/h2/csv2db" enctype="multipart/form-data">
		<input type="file" name="file">
		 <input type="submit" value="csv2db 변환">
	</form>	
	<hr>
	<button onclick="StarbucksMarkers()">스타벅스</button>
	
	<p></p>
	<div id="map" style="width: 100%; height: 800px;"></div>
	<c:if test="${!empty listAll}">

		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			mapOption = {
				center : new kakao.maps.LatLng(37.564214, 127.001699), // 지도의 중심좌표
				level : 8
			// 지도의 확대 레벨
			};
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			var flag = true;
			// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
			var markers = []; // 객체
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
			var imageSize = new kakao.maps.Size(24, 35);
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

			<c:forEach var="vo" items="${listAll}" varStatus="status">
			jusoSearch("${vo.storeaddr}");
			</c:forEach>

			setMarkers(map);

			function jusoSearch(f) {
				var geocoder = new kakao.maps.services.Geocoder();
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(f, function(result, status) { // geocoder중에서 addressSearch를 사용         
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						
						<c:forEach var="vo" items="${listAll}" varStatus="status">
						jusoSearch("${vo.storeaddr}");
						</c:forEach>
						
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 위치를 받아온다.

						// 결과값으로 받은 위치를 마커로 표시합니다
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
							position : coords,
							image : markerImage

						});

						// 생성된 마커를 배열에 추가합니다
						markers.push(marker);

						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						//map.setCenter(coords);
					}
				});
			}

			// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
			function setMarkers(map) {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(map);
				}
			}

			// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
			function StarbucksMarkers() {
				if (flag == true) {
					setMarkers(map);
					flag = false;
				} else if (flag == false) {
					setMarkers(null);
					flag = true;
				}
			}
		</script>
	</c:if>
	
	<c:if test="${empty listAll}">
	<h2>데이터가 없습니다!!!!!</h2>
	</c:if>
</body>
</html>