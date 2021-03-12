<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>


<%
	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	String url = "jdbc:sqlserver://43.254.152.58";
	String user = "unilite";
	String password = "UNILITE";
	//TEST DATABASE NAME UNISCM_EDU
// 	String connectionString = "jdbc:sqlserver://43.254.152.58;" + "databaseName=UNISCM;user=unilite;password=UNILITE";
	String connectionString = "jdbc:sqlserver://43.254.152.58;" + "databaseName=UNISCM_EDU;user=unilite;password=UNILITE";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(connectionString);
	Statement stmt = null;
	stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	CallableStatement cs = null;
%>