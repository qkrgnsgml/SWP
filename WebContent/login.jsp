<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   <li class="active"><a href="main.jsp">메인</a>
   <li><a href="bbs.jsp">구매</a>
   <li><a href="bbs2.jsp">판매</a>
   <li><a href="bbs3.jsp">내 정보</a>
   <li><a href="map.jsp">지도</a>
   <li><a href="assess.jsp">평가</a>
   <li><a href="messageForm.jsp">쪽지</a>
  </ul>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropddown-toggle"
    data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">접속하기<span class="caret"></span></a>
   <ul class="dropdown-menu">
    <li  class="active"><a href="login.jsp">로그인</a></li>
    <li ><a href="join.jsp">회원가입</a></li>
   </ul>
  </li>
  </ul> 
 </div>
 </nav>
 <br><br><br>
 <div class="container">
 	<form method="post" action="loginAction.jsp">
 		<table class="table table-bordered table-hover" style="text-align:center;border : 1px solid #dddddd">
 			<thead>
 				<tr>
 					<th colspan="2"><h4 style="color:white">로그인 페이지</h4></th>
 				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td style="width:110px;"><h5>아이디</h5></td>
 					<td><input class="form-control" type="text" name="userID" maxlength="20"  placeholder="아이디를 입력하세요"></td>
 				</tr>
 				<tr>
 					<td style="width:110px;"><h5>비밀번호</h5></td>
 					<td><input class="form-control" type="text" name="userPassword" maxlength="20"  placeholder="비밀번호를 입력하세요"></td>
 				</tr>
 				<tr>
 					<td style="text-align:left" colspan="2"><input class="btn btn-primary pull-right" type="submit" value="로그인"></td>
 				</tr>
 			</tbody>
 		</table>
 	</form>
 </div>
 
 
<!--  
 
 <div class="container">
  <div class="col-lg-4"></div>
  <div class="col-lg-4">
   <div class="jumbtron" style="padding-top: 20px;">
   <form method="post" action="loginAction.jsp">
    <h3 style="text-align: center;">로그인화면</h3>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">     
    </div>    
    <div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">     
    </div>
    <input type="submit" class="btn btn-primary form-control" value="로그인">
   </form>
  </div>
 </div> 
  <div class="col-lg-4"></div>
 </div> -->
 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>