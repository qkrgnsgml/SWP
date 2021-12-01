package broker;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.ArrayList;


import broker.Broker;



public class BrokerDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BrokerDAO() {
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
	
	public int join(Broker broker) {
		String SQL="INSERT INTO broker(userID, loc, userName) VALUES(?,?,?)";
		try{
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, broker.getUserID());
			pstmt.setString(2, broker.getLoc());
			pstmt.setString(3, broker.getUserName());

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Broker> getList(){
		String SQL="SELECT * FROM broker";
		ArrayList<Broker> list = new ArrayList<Broker>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Broker broker = new Broker();
				broker.setUserID(rs.getString(1));
				broker.setLoc(rs.getString(2));
				broker.setUserName(rs.getString(3));
				broker.setCount(rs.getInt(4));
				broker.setSum(rs.getInt(5));
				broker.setGrade(rs.getFloat(6));
				list.add(broker);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int update(int count, int sum, float grade, String userID) {
		String SQL="UPDATE broker SET count =?, sum=?, grade=? WHERE userID=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, count);
			pstmt.setInt(2, sum);
			pstmt.setFloat(3, grade);
			pstmt.setString(4, userID);

			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db¿À·ù
	}
	
	public Broker getBroker(String userID) {
		String SQL="SELECT * FROM broker WHERE userID = ?";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Broker broker = new Broker();
				broker.setUserID(rs.getString(1));
				broker.setLoc(rs.getString(2));
				broker.setUserName(rs.getString(3));
				broker.setCount(rs.getInt(4));
				broker.setSum(rs.getInt(5));
				broker.setGrade(rs.getFloat(6));
				return broker;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}