<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.io.IOUtils"%>

<%
	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	String url = "jdbc:sqlserver://192.168.40.100:24100";
	//  String url = "jdbc:sqlserver://67.53.72.230:24100";
	String user = "HSNA_PDA";
	String password = "HsnaadminPDA1!";
	// 	String connectionString = "jdbc:sqlserver://67.53.72.230:24100;" + "databaseName=HSNAWMS;user=HSNA_PDA;password=HsnaadminPDA1!";
	// 	String connectionString = "jdbc:sqlserver://192.168.40.100:24100;" + "databaseName=HSNAWMS;user=HSNA_PDA;password=HsnaadminPDA1!";
	String connectionString = "jdbc:sqlserver://192.168.40.100:24100;" + "databaseName=HSNATEST;user=HSNA_PDA;password=HsnaadminPDA1!";

	Class.forName(driver);
	Connection conn = DriverManager.getConnection(connectionString);
	Statement stmt = null;
	stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	CallableStatement cs = null;
%>