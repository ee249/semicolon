## Kakao 지도 API 

- 여러개 주소를 받아서 지도상에 표시하기

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여러개 마커 제어하기</title>
    
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>
<p>
    <button onclick="shMarkers()">신분당선</button>
    // 마커가 표시되지 않는 상태에서 버튼을 누르면 Marker가 표시되고 마커가 표시된 상태에서 버튼을 누르면 마커가 꺼진다.  
</p> 
<em>클릭한 위치에 마커가 표시됩니다!</em>
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1eb82a611b357dbfc3eb3e227b6ec2d3&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var flag = true;
// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
var markers = []; // 객체

jusoSearch('서울 강남구 강남대로 396'); 
jusoSearch('서울특별시 서초구 남부순환로 지하 2585');
jusoSearch('서울특별시 서초구 매헌로 지하 116'); 
jusoSearch('서울특별시 서초구 청계산로 지하 179');
jusoSearch('경기도 성남시 분당구 판교역로 지하 160');
jusoSearch('경기도 성남시 분당구 성남대로 지하 333');
jusoSearch('경기도 성남시 분당구 성남대로 지하 163');
jusoSearch('경기도 용인시 수지구 신수로 지하 760');
jusoSearch('경기도 용인시 수지구 풍덕천로 지하 120');
jusoSearch('경기도 용인시 수지구 수지로 지하 134');
jusoSearch('경기도 용인시 수지구 광교중앙로 지하 312');
jusoSearch('경기도 수원시 영통구 도청로 지하 45');
jusoSearch('경기도 수원시 영통구 대학로 55');

setMarkers(map);

function jusoSearch(f) {
   var geocoder = new kakao.maps.services.Geocoder(); 
   // 주소로 좌표를 검색합니다
   geocoder.addressSearch(f, function(result, status) { // geocoder중에서 addressSearch를 사용         
        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
           var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
         // 위치를 받아온다.
           
           // 결과값으로 받은 위치를 마커로 표시합니다
           // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
             position: coords
            });
           
           // 생성된 마커를 배열에 추가합니다
           markers.push(marker);   
              
           // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
           map.setCenter(coords);        
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
function shMarkers() {
   if(flag==true){
       setMarkers(map);
       flag=false;
   }
   else if(flag==false){
       setMarkers(null);    
       flag=true;
   }
}

// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
</script>
</body>
</html>
```

