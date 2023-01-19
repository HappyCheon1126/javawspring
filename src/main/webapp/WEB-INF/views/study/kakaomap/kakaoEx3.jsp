<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaoEx3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
		var address = '${address}';
    
    function addressSearch() {
    	var searchAddress = document.getElementById("searchAddress").value;
    	var latitude = document.myform.latitude.value;
    	var longitude = document.myform.longitude.value;
    	if(searchAddress == "") {  // 입력된 검색어가 없거나, 검색을 하고 왔는데, 카카오DB에 자료가 없어서 위도/경도가 값이 넘어오지 않았다면..
    		alert("검색할 지점을 선택하세요.");
    		document.myform.searchAddress.focus();
    		return false;
    	}
    	location.href = "${ctp}/study/kakaomap/kakaoEx3?address="+searchAddress;
    }
  
    function addressSave() {
    	var address = document.myform.address.value;
    	var latitude = document.myform.latitude.value;
    	var longitude = document.myform.longitude.value;
    	if(latitude == "" || longitude == "") {
    		alert("검색할 지점을 선택하세요.");
    		document.myform.searchAddress.focus();
    		return false;
    	}
    	//alert("위도:"+latitude+" 경도:"+longitude+" 장소명:"+address);
    	var query = {
    		address  : address,
    		latitude : latitude,
    		longitude: longitude
    	}
    	
    	// 아래 저장부분은 kakaoEx1과 동일하다.
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/kakaomap/kakaoEx1",
    		data : query,
    		success:function(data) {
    			if(data == "1") alert("선택한 지점이 등록되었습니다.");
    			else alert("이미 같은지점이 있습니다. 이름을 변경해서 다시 등록할수 있습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    	
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>지명으로 위치검색후 위도/경도 알아내어(카카오DB에서) 내DB에 등록하기(키워드(주소명)로 장소 검색)</h2>
  <hr/>
  <form name="myform">
		<p>주소(지점명)입력 :
		  <input type="text" name="searchAddress" id="searchAddress" autofocus onkeypress="if(event.keyCode==13){addressSearch();}" />
		  <input type="button" value="검색" onclick="addressSearch()" class="btn btn-success btn-sm" /> &nbsp;
		  <input type="button" value="검색된위치를 내DB에저장" onclick="addressSave()" class="btn btn-primary btn-sm" /> &nbsp;
		  / 검색한주소(지점명) : <font color="blue"><b><span id="selectAddress">${address}</span></b></font>
		</p>
		<input type="hidden" name="address" id="address" />
		<input type="hidden" name="latitude" id="latitude" />
		<input type="hidden" name="longitude" id="longitude" />
	</form>
  <hr/>
	<div id="map" style="width:100%;height:600px;"></div>
	<hr/>
	<jsp:include page="kakaoMenu.jsp"/>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c&libraries=services"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		// 키워드로 장소를 검색합니다
		ps.keywordSearch('${address}', placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
						
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
		        
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다(앞에서 출력된 지점을 중심으로 카카오DB에 저장되어 있는, 주변지역에 마커표시한다.)
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 		// 위도:place.y, 경도:place.x
		    });

		    // 마커에 클릭이벤트를 등록합니다(마커를 클릭하면 지역명을 출력시켜주게 된다.)
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다(지역명 : place.place_name)
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		        
		        // 클릭시에 장소명(place.place_name)을 알아올수 있기에, 현재위치(위도/경도)와 함께 hidden필드로 값을 저장시켜둔다.
		        $("#selectAddress").html(place.place_name);
		        $("#address").val(place.place_name);
		        $("#latitude").val(place.y);
		        $("#longitude").val(place.x);
		    });
		}
	</script>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>