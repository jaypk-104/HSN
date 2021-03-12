<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_DN_IS_DT_FR = request.getParameter("V_DN_IS_DT_FR") == null ? "" : request.getParameter("V_DN_IS_DT_FR").toUpperCase().substring(0, 10);
		String V_DN_IS_DT_TO = request.getParameter("V_DN_IS_DT_TO") == null ? "" : request.getParameter("V_DN_IS_DT_TO").toUpperCase().substring(0, 10);
		String V_BILL_DT_FR = request.getParameter("V_BILL_DT_FR") == null ? "" : request.getParameter("V_BILL_DT_FR").toUpperCase().substring(0, 10);
		String V_BILL_DT_TO = request.getParameter("V_BILL_DT_TO") == null ? "" : request.getParameter("V_BILL_DT_TO").toUpperCase().substring(0, 10);
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_ISDT_CHG_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_DN_IS_DT_FR);//V_DN_IS_DT_FR
			cs.setString(4, V_DN_IS_DT_TO);//V_DN_IS_DT_TO
			cs.setString(5, V_BILL_DT_FR);//V_BILL_DT_FR
			cs.setString(6, V_BILL_DT_TO);//V_BILL_DT_TO
			cs.setString(7, V_S_BP_NM);//V_S_BP_CD
			cs.setString(8, "");//V_CHG_DT
			cs.setString(9, V_BILL_NO);//V_BILL_NO
			cs.setString(10, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(11);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BILL_NO", rs.getString("BILL_NO"));
				subObject.put("BILL_DT", rs.getString("BILL_DT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
				subObject.put("BILL_LOC_AMT", rs.getString("BILL_LOC_AMT"));
				subObject.put("DN_ISSUE_DT", rs.getString("DN_ISSUE_DT"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("VAT_AMT", rs.getString("VAT_AMT"));
				subObject.put("TOT_AMT", rs.getString("TOT_AMT"));
				subObject.put("TO_SALES_GRP", rs.getString("TO_SALES_GRP"));
				subObject.put("TO_SALES_GRP_NM", rs.getString("TO_SALES_GRP_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_BILL_NO = hashMap.get("BILL_NO") == null ? "" : hashMap.get("BILL_NO").toString();
			 			String V_CHG_DT = hashMap.get("CHG_DT") == null ? "" : hashMap.get("CHG_DT").toString().substring(0, 10);

			 			cs = conn.prepareCall("call USP_003_S_ISDT_CHG_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_DN_IS_DT_FR
						cs.setString(4, "");//V_DN_IS_DT_TO
						cs.setString(5, "");//V_BILL_DT_FR
						cs.setString(6, "");//V_BILL_DT_TO
						cs.setString(7, "");//V_S_BP_CD
						cs.setString(8, V_CHG_DT);//V_CHG_DT
						cs.setString(9, V_BILL_NO);//V_BILL_NO
						cs.setString(10, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				} else {
					JSONParser parser = new JSONParser();
					Object obj = parser.parse(jsonData);
					JSONObject jsondata = (JSONObject) obj;
					
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					V_BILL_NO = jsondata.get("BILL_NO") == null ? "" : jsondata.get("BILL_NO").toString();
		 			String V_CHG_DT = jsondata.get("CHG_DT") == null ? "" : jsondata.get("CHG_DT").toString().substring(0, 10);

		 			cs = conn.prepareCall("call USP_003_S_ISDT_CHG_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_DN_IS_DT_FR
					cs.setString(4, "");//V_DN_IS_DT_TO
					cs.setString(5, "");//V_BILL_DT_FR
					cs.setString(6, "");//V_BILL_DT_TO
					cs.setString(7, "");//V_S_BP_CD
					cs.setString(8, V_CHG_DT);//V_CHG_DT
					cs.setString(9, V_BILL_NO);//V_BILL_NO
					cs.setString(10, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}

				jsonObject.put("success", true);
				jsonObject.put("resultList", jsonArray);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
		}

	} catch (Exception e) {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(e.toString());
		pw.flush();
		pw.close();

		e.printStackTrace();
	} finally {
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>


