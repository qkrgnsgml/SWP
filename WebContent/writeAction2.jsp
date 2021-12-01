<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.Bbs"%>
    <%@ page import="bbs.BbsDAO2"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="java.io.File" %>
	<%@ page import="java.util.Enumeration" %>
	<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
	<%@ page import="com.oreilly.servlet.MultipartRequest"%>
    <%
    	request.setCharacterEncoding("UTF-8");
    %>
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
    <%-- <jsp:setProperty name="bbs" property="bbsTitle"/>
    <jsp:setProperty name="bbs" property="bbsContent"/>
    <jsp:setProperty name="bbs" property="price"/>
    <jsp:setProperty name="bbs" property="state"/>
    <jsp:setProperty name="bbs" property="img"/>
    <jsp:setProperty name="bbs" property="location"/> --%>
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
		
		BbsDAO2 bbsDAO = new BbsDAO2();
		Bbs bbs2= new Bbs();
		bbs2.setBbsID(bbsDAO.getNewNext());
		int bbsID = bbs2.getBbsID();
		String directory = application.getRealPath("/upload");
		
		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		int maxSize = 1024 * 1024 * 5;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, "utf-8",
				new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		String bbsTitle = multipartRequest.getParameter("bbsTitle");
		String bbsContent = multipartRequest.getParameter("bbsContent");
		String price = multipartRequest.getParameter("price");
		String state = multipartRequest.getParameter("state");
		String img = multipartRequest.getParameter("img");
		String location = multipartRequest.getParameter("location");
		bbs2.setBbsTitle(bbsTitle);
		bbs2.setBbsContent(bbsContent);
		bbs2.setPrice(price);
		bbs2.setState(state);
		bbs2.setImg(img);
		bbs2.setLocation(location);
		PrintWriter script =response.getWriter();
		if(userID==null){
			
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href= 'login.jsp'");
			script.println("</script>");
		}else{
			if(bbs2.getBbsTitle()==null || bbs2.getBbsContent()==null){
		
		script.println("<script>");
		script.println("alert('입력이 안 된 곳이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}else{
		/* BbsDAO2 bbsDAO2 = new BbsDAO2(); */
		int result = bbsDAO.write(bbs2.getBbsTitle(),userID,bbs2.getBbsContent(),bbs2.getPrice(),bbs2.getState(),fileName,bbs2.getLocation());
		if(result ==-1){
			
			script.println("<script>");
			script.println("alert('글쓰기에 실패하였습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			
			script.println("<script>");
			script.println("location.href= 'bbs2.jsp'");
			script.println("</script>");
		}
			}
		}
	%>

</body>
</html>