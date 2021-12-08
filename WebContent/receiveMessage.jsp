<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="message.MessageDAO" %>
<%@ page import="message.Message" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device",initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover{
		color:#000000;
		text-decoration:none;
	}
</style>
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
   <li><a href="main.jsp">메인</a>
   <li><a href="bbs.jsp">구매</a>
   <li><a href="bbs2.jsp">판매</a>
   <li><a href="bbs3.jsp">내 정보</a>
   <li><a href="mapInfo.jsp">지도</a>
   <li><a href="assess.jsp">평가</a>
   <li class="active"><a href="messageForm.jsp">쪽지</a>
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
    <li> <a href="mybbs.jsp">내가 쓴 구매 글</a></li>
    <li> <a href="mybbs2.jsp">내가 쓴 판매 글</a></li>
    <li> <a href="sendMessage.jsp">보낸 쪽지</a></li>
    <li class="active"> <a href="receiveMessage.jsp">받은 쪽지</a></li>
   </ul>
  </li>
  </ul>	
  		<% 
  	}
  %>
   
 </div>
 </nav>
 <div class="container">
 	<div class="row">
 		<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
 			<thead>
 				<tr>
 				<th style="background-color:#eeeeee; text-align:center;">보낸이</th>
 				<th style="background-color:#eeeeee; text-align:center;">받는이</th>
 				<th style="background-color:#eeeeee; text-align:center;">내용</th>
 				<th style="background-color:#eeeeee; text-align:center;">작성일</th> 			
 				</tr>
 			</thead>
 			<tbody>
 			<%
 				MessageDAO messageDAO = new MessageDAO();
 				ArrayList<Message> list = messageDAO.getList();
 				ArrayList<Message> list2 = new ArrayList<Message>();
 				for(int i=0;i<list.size();i++){
 					if(list.get(i).getReceive().equals(userID)){
 						list2.add(list.get(i));
 					}
 				}
 				if (list2.size()>=20){
 	 				for(int i=list2.size()-1;i>=list2.size()-20;i--){
 	 			%>
 	 			 	<tr>
 	 					<td><%= list2.get(i).getSend() %></td>
 	 					<td><%= list2.get(i).getReceive() %></td>
 	 					<td style="max-width:20px; word-break:break-all"><a href="messageview.jsp?messageID=<%=list2.get(i).getMessageID()%>"><%= list2.get(i).getContent() %></a></td>
 	 					<td><%= list2.get(i).getMessageDate().substring(0,11)+list2.get(i).getMessageDate().substring(11,13)+"시"+list2.get(i).getMessageDate().substring(14,16)+"분" %></td>
 	 				</tr>
 	 			<%
 	 					}
 	 				}else{
 	 					for(int i=list2.size()-1;i>=0;i--){
 	 			 			%>
 	 			 			 	<tr>
 	 			 					<td><%= list2.get(i).getSend() %></td>
 	 			 					<td><%= list2.get(i).getReceive() %></td>
 	 			 					<td style="max-width:20px; word-break:break-all"><a href="messageview.jsp?messageID=<%=list2.get(i).getMessageID()%>"><%= list2.get(i).getContent() %></a></td>
 	 			 					<td><%= list2.get(i).getMessageDate().substring(0,11)+list2.get(i).getMessageDate().substring(11,13)+"시"+list2.get(i).getMessageDate().substring(14,16)+"분" %></td>
 	 			 				</tr>
 	 			 			<%
 	 			 					}
 	 				}
 	 			%>


 			</tbody>
 		</table>
 		<a href="messageForm.jsp" class="btn btn-primary pull-right">쪽지쓰기</a>
 	</div>
 </div>
 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>