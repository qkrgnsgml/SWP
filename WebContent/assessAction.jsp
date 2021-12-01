<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="broker.BrokerDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="broker.Broker" %>
    <%@ page import="java.io.PrintWriter" %>
	<%@ page import="java.util.ArrayList" %>
    
  
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int j=0;
	String userID = request.getParameter("userID");
	String grade = request.getParameter("grade");
	int score = Integer.parseInt(grade); //평가 점수
	BrokerDAO brokerDAO = new BrokerDAO();
	
	Broker broker = brokerDAO.getBroker(userID);
	int getcount = broker.getCount();
	getcount+=1;
	int getscore= broker.getSum();
	int getsum = getscore+score;
	float realscore = (float)getsum/(float)getcount; 
	
/* 	
	BrokerDAO brokerDAO = new BrokerDAO();
	ArrayList<Broker> list = brokerDAO.getList(); 
	for (int i = 0; i < list.size(); i ++) {
		if(userID==list.get(i).getUserID()){
			j=i; //j번째 대행인 평가
			break;
		}
	}
	int getcount = list.get(j).getCount(); //현재 대행인 카운트
	getcount = getcount+1; //요번에 평가 또 받앗으니까 +1
	int getscore=  list.get(j).getSum(); //현재 대행인 합계스코어
	int getsum = getscore +score; //지금까지 받은 합산에 요번 점수 더해줌
	float realscore = (float)getsum/(float)getcount; //업데이트된 평점 */
	
if(request.getParameter("userID")==null || request.getParameter("grade")==null){
PrintWriter script =response.getWriter();
script.println("<script>");
script.println("alert('입력이 안 된 곳이 있습니다.')");
script.println("history.back()");
script.println("</script>");
}else{
int result = brokerDAO.update(getcount, getsum, realscore, userID);
if(result ==-1){
PrintWriter script =response.getWriter();
script.println("<script>");
script.println("alert('평가에 실패하였습니다.')");
script.println("history.back()");
script.println("</script>");
}
else{
PrintWriter script =response.getWriter();
script.println("<script>");
script.println("alert('평가가 완료되었습니다.')");
script.println("location.href= 'main.jsp'");
script.println("</script>");
}
}
%>
</body>
</html>