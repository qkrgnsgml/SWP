<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="broker.BrokerDAO" %>
<%@ page import="broker.Broker" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
	<title>Kakao 지도 시작하기</title>
</head>
<style>
html, body {
	width: 100%; height: 100%;
}
</style>
<body>
<%
	String loc = request.getParameter("location");
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}


	BrokerDAO brokerDAO = new BrokerDAO();
	ArrayList<Broker> list = brokerDAO.getList(); 
	
%>
<nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed"
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expanded="false">
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
  </button>  
  <a class="navbar-brand" href="main.jsp">거래 대신해드립니다.</a>
 </div>
 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
  <ul class="nav navbar-nav">
   <li><a href="main.jsp">메인</a>
   <li><a href="bbs.jsp">구매</a>
   <li><a href="bbs2.jsp">판매</a>
   <li><a href="bbs3.jsp">내 정보</a>
   <li class="active"><a href="map.jsp">지도</a>
   <li><a href="assess.jsp">평가</a>
   <li><a href="messageForm.jsp">쪽지</a>
  </ul>
  <%
  	if(userID==null){
  		%>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">접속하기<span class="caret"></span></a>
   <ul class="dropdown-menu">
    <li ><a href="login.jsp">로그인</a></li>
    <li ><a href="join.jsp">회원가입</a></li>
   </ul>
  </li>
  </ul>
  		
  		<%
  	}else{
  		%>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">회원관리<span class="caret"></span></a>
   <ul class="dropdown-menu">
    <li ><a href="logoutAction.jsp">로그아웃</a></li>
    <li> <a href="joinBroker.jsp">대행가입</a></li>
    <li> <a href="sendMessage.jsp">보낸 쪽지</a></li>
    <li> <a href="receiveMessage.jsp">받은 쪽지</a></li>
   </ul>
  </li>
  </ul>	
  		<% 
  	}
  %>
   
 </div>
 </nav>
   <!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ffe963e305028ce4a7701b2b69455cae"></script> -->
<div id="map" style="width:100%;height:100%"></div>

 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ffe963e305028ce4a7701b2b69455cae&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(35.17975118241483, 129.07505720361954), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('<%=loc%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">판매자</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    

/* var positions = [
    {
        //title: '대행자1', 
        content: '<div>대행자 : 홍길동<br>평점 : 3.7<br>대행 횟수 : 16회</div>',
        latlng: new kakao.maps.LatLng(34.762071297381624,127.658519516876)
    },
    {
        //title: '대행자2', 
        content: '<div>대행자 : 정수현<br>평점 : 4.2<br>대행 횟수 : 25회</div>',
        latlng: new kakao.maps.LatLng( 34.7602094400595, 127.6644136951491)
    },
    {
        //title: '대행자3', 
        content: '<div>대행자 : 남도진<br>평점 : 2.2<br>대행 횟수 : 6회</div>',
        latlng: new kakao.maps.LatLng(35.17992529387588 ,  129.0793532319004)
    },
    {
        //title: '대행자4',
        content: '<div>대행자 : 홍길동<br>평점 : 4.1<br>대행 횟수 : 46회</div>',
        latlng: new kakao.maps.LatLng(35.180362836030966, 129.07117626448348 )
    },
    {
        //title: '대행자5',
        content: '<div>대행자 : 홍길동<br>평점 : 4.1<br>대행 횟수 : 46회</div>',
        latlng: new kakao.maps.LatLng(35.153398516025455, 128.99203354646772 )
    }
]; */
 
//마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 


<%for (int i = 0; i < list.size(); i ++) {%>
	geocoder.addressSearch('<%=list.get(i).getLoc()%>', function(result, status){
	// 마커 이미지의 이미지 크기 입니다
	var imageSize = new kakao.maps.Size(24, 35); 
	// 마커 이미지를 생성합니다    
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  
	
	var coords = new kakao.maps.LatLng(result[0].y,result[0].x);
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: coords, // 마커를 표시할 위치
        //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
    var infowindow = new kakao.maps.InfoWindow({
        content: '아이디 : <%=list.get(i).getUserID()%><br> 대행횟수 : <%=list.get(i).getCount()%>회 <br> 평점 : <%=list.get(i).getGrade()%>' // 인포윈도우에 표시할 내용
    	});
    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	
	});
<%}%>

/*
for (var i = 0; i < positions.length; i ++) {
	
	// 마커 이미지의 이미지 크기 입니다
	var imageSize = new kakao.maps.Size(24, 35); 
	// 마커 이미지를 생성합니다    
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  
	
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content  // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}
	*/
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
</script>
</body>
</html>