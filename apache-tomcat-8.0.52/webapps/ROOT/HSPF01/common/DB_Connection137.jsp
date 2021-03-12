<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>


<%
	Connection conn137 = null;
	Statement stmt137 = null;

	
		String url = "jdbc:tibero:thin:@123.142.124.144:8629:hsnetwork2";
		String id = "hsplatform_test";
		String pwd = "hsnadmin";                             
		
		Class.forName("com.tmax.tibero.jdbc.TbDriver");
		conn137 =DriverManager.getConnection(url,id,pwd);
		stmt137 = conn137.createStatement();
	
%>