<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
   <%@ page import="java.io.PrintWriter" %>
   <%@ page import="bbs.BbsDAO2" %>
<%@ page import="bbs.Bbs" %>
  
    <%
      	request.setCharacterEncoding("UTF-8");
      %>
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
			
			int bbsID = 0;
			String title=null;
			if(request.getParameter("bbsID")!=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		title = request.getParameter("title");
		title="[거래중]"+title;
			}
			if(bbsID==0){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href= 'bbs2.jsp'");
		script.println("</script>");
			}
			Bbs bbs = new BbsDAO2().getBbs(bbsID);
			if(!userID.equals(bbs.getUserID())){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href= 'login.jsp'");
		script.println("</script>");
			}
			
			else{
			BbsDAO2 bbsDAO = new BbsDAO2();
			int result = bbsDAO.updateIng(bbsID,title);
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
		script.println("location.href= 'bbs2.jsp'");
		script.println("</script>");
			}
			}
	%>
</body>
</html>