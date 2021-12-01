<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="user.User" %>
  
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
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
	
	else{
		if(request.getParameter("userPassword")==null || request.getParameter("userName")==null
				||request.getParameter("userPassword").equals("")||request.getParameter("userName").equals("")){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 곳이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(request.getParameter("userPassword"),request.getParameter("userName"),request.getParameter("userGender"),request.getParameter("userEmail"),request.getParameter("userId"));
			if(result ==-1){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패하였습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("location.href= 'bbs3.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>