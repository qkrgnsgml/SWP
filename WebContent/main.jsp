<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.BbsDAO2" %>
<%@ page import="bbs.Bbs" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
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
   <li class="active"><a href="main.jsp">메인</a>
   <li><a href="bbs.jsp">구매</a>
   <li><a href="bbs2.jsp">판매</a>
   <li><a href="bbs3.jsp">내 정보</a>
   <li><a href="map.jsp">지도</a>
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
 <div class="container">
 	<div class="jumbotron">
 		<div class="container">
 			<h1>거래대신해드립니다</h1>
 			<p>고액의 중고거래 직거래를 대행해주는 사이트입니다.</p>
 			<p><a class="btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
 		</div>
 	</div>
 </div>
 <div class="container">
 <div class="jumbotron">
 	<div class="row">
 		<table class="table table-striped" style="table-layout:fixed;text-align: center; border:1px solid #dddddd">
 			<%
 				BbsDAO2 bbsDAO = new BbsDAO2();
				ArrayList<Bbs> list2 = bbsDAO.getList2();
 				%>
 			<thead>
 				<tr>
 				<%if(list2.size()<3){
 	 				for(int i=0;i<list2.size();i++){%>
 				<th style="background-color:#eeeeee; text-align:center;"><a href="view2.jsp?bbsID=<%=list2.get(i).getBbsID()%>"><%=list2.get(i).getBbsTitle() %></a></th>	
 				<% }} else{
 					for(int i=0;i<3;i++){ %>
 				<th style="background-color:#eeeeee; text-align:center;"><a href="view2.jsp?bbsID=<%=list2.get(i).getBbsID()%>"><%=list2.get(i).getBbsTitle() %></a></th>
 				<%}} %>
 				</tr>
 			</thead>
 			<tbody>
 			<%
 				if(list2.size()<3){
 				for(int i=0;i<list2.size();i++){
 			%>
 			<tr>
 			 	

 					<td><a href="view2.jsp?bbsID=<%=list2.get(i).getBbsID()%>"><img src="upload/<%= list2.get(i).getImg() %>"  width=365 height=384 ></a></td>				
 				
 			<%
 				}}else{
 					for(int i=0;i<3;i++){ 				
 			%>
 			<td><a href="view2.jsp?bbsID=<%=list2.get(i).getBbsID()%>"><img src="upload/<%= list2.get(i).getImg() %>" style="width: 100%; height: auto;" ></a></td>
 			<%}}%>
			</tr>
			</tbody>
 		</table>
 	</div>
 	</div>
 </div>
 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>