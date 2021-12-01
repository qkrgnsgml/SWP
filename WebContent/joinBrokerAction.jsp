<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="broker.BrokerDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="broker" class="broker.Broker" scope="page"/>
    <jsp:setProperty name="broker" property="userID"/>
    <jsp:setProperty name="broker" property="loc"/>
    <jsp:setProperty name="broker" property="userName"/>
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
	if(userID.equals(broker.getUserID())){
		if(broker.getUserID()==null || broker.getLoc()==null ||broker.getUserName()==null
				){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 곳이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			BrokerDAO brokerDAO = new BrokerDAO();
			int result = brokerDAO.join(broker);
			if(result ==-1){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 에러.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('가입완료')");
				script.println("location.href= 'main.jsp'");
				script.println("</script>");
			}
		}
	}else{
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('사용자의 아이디가 일치하지 않습니다')");
		script.println("history.back()");
		script.println("</script>");
	}
		
	%>
</body>
</html>