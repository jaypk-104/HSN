<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>
<%


// 	String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
// 	String id = "swm";
// 	String pwd = "hsnadmin";                             
// 	Connection conn = null;
// 	Statement stmt = null;
// 	Class.forName("com.tmax.tibero.jdbc.TbDriver");
// 	conn=DriverManager.getConnection(url,id,pwd);
// 		stmt = conn.createStatement();

	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envCtx.lookup("jdbc/TiberoSWM");
		conn = dataSource.getConnection();
		stmt = conn.createStatement();

	} catch (NamingException e) {

	}
	
%>