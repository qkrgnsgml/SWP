package message;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.ArrayList;

import message.Message;

public class MessageDAO {
	private Connection conn;
	
	private ResultSet rs;
	
	public MessageDAO() {
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
		String SQL="SELECT messageID FROM message ORDER BY messageID DESC";
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
	
	public int upload(String send, String receive, String content) {
		String SQL="INSERT INTO message VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, send);
			pstmt.setString(2, receive);
			pstmt.setString(3, getDate());
			pstmt.setString(4, content);		
			pstmt.setInt(5, getNext());
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public ArrayList<Message> getList(){
		String SQL="SELECT * FROM message";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Message message = new Message();
				message.setSend(rs.getString(1));
				message.setReceive(rs.getString(2));
				message.setMessageDate(rs.getString(3));
				message.setContent(rs.getString(4));
				message.setMessageID(rs.getInt(5));
				list.add(message);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Message getMessage(int messageID) {
		String SQL="SELECT * FROM message WHERE messageID = ?";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,messageID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Message message = new Message();
				message.setSend(rs.getString(1));
				message.setReceive(rs.getString(2));
				message.setMessageDate(rs.getString(3));
				message.setContent(rs.getString(4));
				message.setMessageID(rs.getInt(5));
				return message;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}