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

	request.setCharacterEncoding("utf-8");
	System.out.println("DB START >> ");

	BufferedReader reader = request.getReader();
	StringBuffer jb = new StringBuffer();
	
	String line      = null;
	String V_TYPE    = "";
	String V_USERID  = "";
	String V_BARCODE = "";
	String V_MATID   = "";
	String V_PASSQTY = "";
	String V_FAILQTY = "";
	String V_TOTQTY  = "";
	String V_REASON  = "";
	
	JSONObject jsonObject = null;
	JSONArray  jsonArray  = null;
	JSONObject subObject  = null;
	
	try {	
		while ((line = reader.readLine()) != null) {
			jb.append(line);
			System.out.println("JSON DATA : " + line);
			
			JSONParser jP   = new JSONParser();
			JSONObject jObj = (JSONObject)jP.parse(line);
			
			V_TYPE = jObj.get("type").toString();
	
			if(V_TYPE.equals("LOGIN")) {
				
				System.out.println(">> LOGIN");
				
				/* 로그인 */
				
				cs = conn.prepareCall("{call USP_BARCODE_INFO(?,?,?,?,?,?)}");
				cs.setString(1, V_TYPE);/* B_TYPE */
				cs.setString(2, "");/* COMP_CD */
				cs.setString(3, "");/* BAR_NO 바코드 */
				cs.setString(4, "");/* MVMT_DT 입고일 */
				cs.setString(5, "");/* STS 전체,미입고 */
				cs.setString(6, V_USERID);/* USR_ID */
				rs = cs.executeQuery();
				
				jsonArray = new JSONArray();
				
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("STS", rs.getString("STS"));
					subObject.put("MSG_TEXT", rs.getString("MSG_TEXT"));
					subObject.put("COMP_CODE", rs.getString("COMP_CODE"));
					subObject.put("USER_NAME", rs.getString("USER_NAME"));
					subObject.put("SCM_YN", rs.getString("SCM_YN"));
					subObject.put("SL_CD", rs.getString("SL_CD"));
					
					jsonArray.add(subObject);
				}
				
	// 			jsonObject = new JSONObject();
	// 			jsonObject.put("RESULT", "YES");
	// 			jsonObject.put("resultList", jsonArray);
				
				System.out.println(subObject);
	
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(subObject);
				pw.flush();
				pw.close();
			
			} else if(V_TYPE.equals("QCCHK_S")) {
				V_BARCODE = jObj.get("barcode").toString();	
				
				System.out.println(">> QCCHK_S");
				/* 바코드정보 */
				
				cs = conn.prepareCall("{call USP_APP_ZQCMINSCHK_S(?)}");
				cs.setString(1, V_BARCODE);/* Barcode */
				rs = cs.executeQuery();
				
				jsonArray = new JSONArray();
				
				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("ERRCODE", rs.getString("ERRCODE"));
					subObject.put("RESULT", rs.getString("RESULT"));
					subObject.put("MATID", rs.getString("MATID"));
					subObject.put("MATNAME", rs.getString("MATNAME"));
					subObject.put("MATDESC", rs.getString("MATDESC"));
					subObject.put("TOTQTY", rs.getString("TOTQTY"));
					subObject.put("REQTY", rs.getString("REQTY"));
					subObject.put("INQTY", rs.getString("INQTY"));
					subObject.put("REASON", rs.getString("REASON"));
					
					jsonArray.add(subObject);
				}
				
				System.out.println(subObject);
	
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(subObject);
				pw.flush();
				pw.close();		
				
			} else if(V_TYPE.equals("QCCHK_U")) {
				V_BARCODE = jObj.get("barcode").toString();
				V_MATID   = jObj.get("matid").toString() == null ? "0" : jObj.get("matid").toString(); 
				V_TOTQTY  = jObj.get("totalqty").toString() == null ? "0" : jObj.get("totalqty").toString();
				V_PASSQTY = jObj.get("passqty").toString() == null ? "0" : jObj.get("passqty").toString();
				V_FAILQTY = jObj.get("failqty").toString() == null ? "0" : jObj.get("failqty").toString();
				V_REASON  = jObj.get("reason").toString() == null ? "" : jObj.get("reason").toString();
				V_USERID  = jObj.get("userid").toString() == null ? "" : jObj.get("userid").toString();
				
				System.out.println(">> QCCHK_U");
				
				cs = conn.prepareCall("{call USP_APP_ZQCMINSCHK_U(?,?,?,?,?,?,?)}");
				
				cs.setString(1, V_BARCODE); // Barcode				
				cs.setString(2, V_MATID);   // Material ID
				cs.setString(3, V_TOTQTY);  // Total Qty
				cs.setString(4, V_PASSQTY); // Pass Qty
				cs.setString(5, V_FAILQTY); // Fail Qty
				cs.setString(6, V_REASON);  // Fail Reason
				cs.setString(7, V_USERID);  // User ID
				cs.execute();
				
	 			jsonObject = new JSONObject();
	 			jsonObject.put("RESULT", "YES");
	 			jsonObject.put("data", jsonArray);
	
				//rs = cs.executeQuery();
				
				//jsonArray = new JSONArray();
				
				/* while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("ERRCODE", rs.getString("ERRCODE"));
					subObject.put("RESULT", rs.getString("RESULT"));
					subObject.put("MATID", rs.getString("MATID"));
					subObject.put("MATNAME", rs.getString("MATNAME"));
					subObject.put("MATDESC", rs.getString("MATDESC"));
					subObject.put("TOTQTY", rs.getString("TOTQTY"));
					subObject.put("REQTY", rs.getString("REQTY"));
					subObject.put("INQTY", rs.getString("INQTY"));
					subObject.put("REASON", rs.getString("REASON"));
					
					jsonArray.add(subObject);
				}
				
				System.out.println(subObject);
	
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(subObject);
				pw.flush();
				pw.close();	 */	
			}
		}	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}	
%>
