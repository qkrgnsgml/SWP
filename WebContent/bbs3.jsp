<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="user.User"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="java.util.ArrayList" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    
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
	if(userID==null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'login.jsp'");
		script.println("</script>");
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
   <li class="active"><a href="bbs3.jsp">내 정보</a>
   <li><a href="mapInfo.jsp">지도</a>
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
    <li> <a href="mybbs.jsp">내가 쓴 구매 글</a></li>
    <li> <a href="mybbs2.jsp">내가 쓴 판매 글</a></li>
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

 
 <%
 	UserDAO userDAO = new UserDAO();
	ArrayList<User> list = userDAO.getList();
	int index = 0;
	for(int i=0; i<list.size();i++){
		if(userID.equals(list.get(i).getUserID())){
			index = i;
			break;
		}
	}
	
 %>
 <div class="container">
 	<div class="row">
 		<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
 			<thead>
 				<tr>
 				<th colspan="3" style="background-color:#eeeeee; text-align:center;">내정보 글 보기</th>			
 				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td style="width:20%;">아이디</td>
 					<td colspan="2"> <%=list.get(index).getUserID() %></td>
 				</tr>
 				<tr>
 					<td >비밀번호</td>
 					<td colspan="2"> <%=list.get(index).getUserPassword() %></td>
 				</tr>
 				<tr>
 					<td>이름</td>
 					<td colspan="2"><%=list.get(index).getUserName() %></td>
 				</tr>
 				<tr>
 					<td>성별</td>
 					<td colspan="2"><%=list.get(index).getUserGender() %></td>
 				</tr>
 				<tr>
 					<td>이메일</td>
 					<td colspan="2"><%=list.get(index).getUserEmail() %></td>
 				</tr>
 			</tbody>
 			
 		</table>
 		 		<%
 			if(userID !=null && userID.equals(list.get(index).getUserID())){
 		%>		
 				<a href="updateUser.jsp?bbsID=<%= list.get(index).getUserID()%>"class="btn btn-primary">수정</a> 		
 		<%
 			}
 		%>
 		
 	</div>
 </div>
 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>