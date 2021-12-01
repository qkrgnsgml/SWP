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
  </button>  
  <a class="navbar-brand" href="main.jsp">거래 대신해드립니다.</a>
 </div>
 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
  <ul class="nav navbar-nav">
   <li><a href="main.jsp">메인</a>
   <li><a href="bbs.jsp">구매</a>
   <li><a href="bbs2.jsp">판매</a>
   <li class="active"><a href="bbs3.jsp">내 정보</a>
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
  <div class="col-lg-4"></div>
  <div class="col-lg-4">
   <div class="jumbtron" style="padding-top: 20px;">
   <form method="post" action="updateUserAction.jsp">
    <h3 style="text-align: center;">내 정보 수정화면</h3>   
    <div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userId" maxlength="20" value = "<%=list.get(index).getUserID() %>" readonly>     
    </div>     
    <div class="form-group">
     <input type="text" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value = "<%=list.get(index).getUserPassword() %>">     
    </div>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value = "<%=list.get(index).getUserName() %>">     
    </div>
    <div class="form-group" style="text-align : center;">
     <div class="btn-group" data-toggle="buttons">
     	<label class="btn btn-primary">
     		<input type="radio" name="userGender" autocomplete="off" value="남자" >남자
     	</label>
     	<label class="btn btn-primary">
     		<input type="radio" name="userGender" autocomplete="off" value="여자" >여자
     	</label>
      </div>
     </div>
     	<div class="form-group">
     		<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50" value = "<%=list.get(index).getUserEmail() %>">     
    	</div>
    <input type="submit" class="btn btn-primary form-control" value="수정">
   </form>
  </div>
 </div> 
  <div class="col-lg-4"></div>
 </div>
 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>