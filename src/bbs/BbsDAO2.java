package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;


public class BbsDAO2 {
	private Connection conn;
	
	private ResultSet rs;
	
	public BbsDAO2() {
		try {
			String dbURL= "jdbc:mysql://localhost:3306/SWP?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID="root";
			String dbPassword="root";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL="SELECT NOW()";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //db오류
	}
	
	public int getNext() {
		String SQL="SELECT bbsID FROM BBS2 ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫개시물
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent,String price,String state, String img, String location) {
		String SQL="INSERT INTO BBS2(bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, price,state, img, location) VALUES (?,? ,?, ?, ?, ?, ?, ?, ?, ?)";
		
//		String SQL="INSERT INTO BBS2(bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, price,state, img, location) VALUES (2, 'a', 'b', '2021-10-31', 'd', 1, 'e','f', 'f', 'g')";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, price);
			pstmt.setString(8, state);
			pstmt.setString(9, img);
			pstmt.setString(10, location);
			

			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL="SELECT * FROM BBS2 WHERE bbsID < ? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext()-(pageNumber - 1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setPrice(rs.getString(7));
				bbs.setState(rs.getString(8));
				bbs.setImg(rs.getString(9));
				bbs.setLocation(rs.getString(10));
				list.add(bbs);				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * FROM BBS2 WHERE bbsID < ? AND bbsAvailable=1";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext()-(pageNumber - 1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL="SELECT * FROM BBS2 WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setPrice(rs.getString(7));
				bbs.setState(rs.getString(8));
				bbs.setImg(rs.getString(9));
				bbs.setLocation(rs.getString(10));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String price,String state, String img, String location, String bbsContent) {
		String SQL="UPDATE BBS2 SET bbsTitle =?, price =?, state=?, img=?, location=?,bbsContent =? WHERE bbsID =?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, price);
			pstmt.setString(3, state);
			pstmt.setString(4, img);
			pstmt.setString(5, location);
			pstmt.setString(6, bbsContent);
			pstmt.setInt(7,bbsID);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int delete(int bbsID) {
		String SQL="UPDATE BBS2 SET bbsAvailable = 0 WHERE bbsID =?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int getNewNext() {
		String SQL = "SELECT bbsID FROM BBS2 ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList2(){
		String SQL="SELECT * FROM BBS2 where bbsAvailable = 1 ORDER BY bbsID DESC";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setPrice(rs.getString(7));
				bbs.setState(rs.getString(8));
				bbs.setImg(rs.getString(9));
				bbs.setLocation(rs.getString(10));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public ArrayList<Bbs> getListUser(String userID){
		//컨셉이 나만의 블로그기때문에 해당 로그인한 userID만이 쓴 글의 정보를 가져오는 함수
		String SQL="SELECT * FROM bbs2 WHERE userID= ? and bbsAvailable=1 ORDER BY bbsID DESC";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setPrice(rs.getString(7));
				bbs.setState(rs.getString(8));
				bbs.setImg(rs.getString(9));
				bbs.setLocation(rs.getString(10));
				list.add(bbs);		
			} 
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int updateIng(int bbsID, String bbsTitle) {
		String SQL="UPDATE BBS2 SET bbsTitle =? WHERE bbsID =?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setInt(2,bbsID);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	
}
