<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="message.MessageDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="message" class="message.Message" scope="page"/>
    <jsp:setProperty name="message" property="send"/>
    <jsp:setProperty name="message" property="receive"/>
    <jsp:setProperty name="message" property="content"/>
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
	}else{
		if(message.getSend()==null||message.getReceive()==null|| message.getContent()==null){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 곳이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			MessageDAO messageDAO = new MessageDAO();
			int result = messageDAO.upload(message.getSend(),message.getReceive(),message.getContent());
			if(result ==-1){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패하였습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('쪽지가 발송되었습니다.')");
				script.println("location.href= 'messageForm.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>