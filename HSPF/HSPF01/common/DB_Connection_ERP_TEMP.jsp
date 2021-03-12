<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>


<%
/*
 String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
 String url = "jdbc:sqlserver://123.142.124.141:1433";
 String user = "sa";
 String password = "hsnadmin";

 String connectionString = "jdbc:sqlserver://123.142.124.141:1433;" + "databaseName=UNIERP_HSN;user=sa;password=hsnadmin";

 Class.forName(driver);
 Connection e_conn = DriverManager.getConnection(connectionString);
 Statement e_stmt = null;
 e_stmt = e_conn.createStatement();
 ResultSet e_rs = null;
 CallableStatement e_cs = null;
*/

	Connection e_conn = null;
	Statement e_stmt = null;
	ResultSet e_rs = null;
	CallableStatement e_cs = null;

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource dataSource2 = (DataSource) envCtx.lookup("jdbc/UNIERP_HSN");
		e_conn = dataSource2.getConnection();
		e_stmt = e_conn.createStatement();

	} catch (NamingException e) {

	}

	
%>