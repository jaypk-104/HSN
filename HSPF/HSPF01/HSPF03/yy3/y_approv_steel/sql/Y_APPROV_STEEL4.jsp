<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%-- <%@page import="net.sf.json.JSONObject"%> --%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
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
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TYPE2 = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_TAB_TYPE = request.getParameter("V_TAB_TYPE") == null ? "" : request.getParameter("V_TAB_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_RISK_NO = request.getParameter("V_RISK_NO") == null ? "" : request.getParameter("V_RISK_NO").toUpperCase();
		String V_APPROV_MGM_NO = request.getParameter("V_APPROV_MGM_NO") == null ? "" : request.getParameter("V_APPROV_MGM_NO").toUpperCase();
		String V_BS_DT = request.getParameter("V_BS_DT") == null ? "" : request.getParameter("V_BS_DT").toUpperCase();
		String V_APPROV_DT4 = request.getParameter("V_APPROV_DT4") == null ? "" : request.getParameter("V_APPROV_DT4").toUpperCase().substring(0, 10);
// 		System.out.println("V_TYPE" + V_TYPE);
// 		System.out.println("V_COMP_ID" + V_COMP_ID);
// 		System.out.println("V_APPROV_MGM_NO_ALL" + V_APPROV_MGM_NO);
// 		System.out.println("V_APPROV_DT4" + V_APPROV_DT4);

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_001_E_APPROV_AR_STEEL(?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
			cs.setString(4, "");//V_APPROV_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("APPROV_MGM_NO", rs.getString("APPROV_MGM_NO"));
				subObject.put("O_N_TYPE", rs.getString("O_N_TYPE"));
				subObject.put("O_N_TYPE_NM", rs.getString("O_N_TYPE_NM"));
				subObject.put("D_TYPE", rs.getString("D_TYPE"));
				subObject.put("D_TYPE_NM", rs.getString("D_TYPE_NM"));
				subObject.put("BAS_DT", rs.getString("BAS_DT"));
				subObject.put("N_ST_AMT", rs.getString("N_ST_AMT"));
				subObject.put("O_ST_AMT", rs.getString("O_ST_AMT"));
				subObject.put("L_ST_AMT", rs.getString("L_ST_AMT"));
				subObject.put("T_ST_AMT", rs.getString("T_ST_AMT"));
				subObject.put("F_TAX_AMT", rs.getString("F_TAX_AMT"));
				subObject.put("S_TOT_AMT", rs.getString("S_TOT_AMT"));
				subObject.put("L_AR_AMT", rs.getString("L_AR_AMT"));
				subObject.put("N_AR_AMT", rs.getString("N_AR_AMT"));
				subObject.put("O_AR_AMT", rs.getString("O_AR_AMT"));
				subObject.put("B_AR_AMT", rs.getString("B_AR_AMT"));
				subObject.put("A_TOT_AMT", rs.getString("A_TOT_AMT"));
				subObject.put("AR_TOT_AMT", rs.getString("AR_TOT_AMT"));
				subObject.put("C_GUR_AMT", rs.getString("C_GUR_AMT"));
				subObject.put("B_GUR_AMT", rs.getString("B_GUR_AMT"));
				subObject.put("S_GUR_AMT", rs.getString("S_GUR_AMT"));
				subObject.put("L_GUR_AMT", rs.getString("L_GUR_AMT"));
				subObject.put("G_TOT_AMT", rs.getString("G_TOT_AMT"));
				subObject.put("AR_GUR_AMT", rs.getString("AR_GUR_AMT"));
				subObject.put("AR_GUR_RATE", rs.getString("AR_GUR_RATE"));
				subObject.put("REMARK", rs.getString("REMARK"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I") || V_TYPE.equals("D")) {

			cs = conn.prepareCall("call USP_001_E_APPROV_AR_STEEL(?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
			cs.setString(4, V_APPROV_DT4);//V_APPROV_NM
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
		} else if (V_TYPE.equals("SYNC")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_O_N_TYPE = hashMap.get("O_N_TYPE") == null ? "" : hashMap.get("O_N_TYPE").toString();
					String V_L_AR_AMT = hashMap.get("L_AR_AMT") == null ? "" : hashMap.get("L_AR_AMT").toString();
					String V_N_AR_AMT = hashMap.get("N_AR_AMT") == null ? "" : hashMap.get("N_AR_AMT").toString();
					String V_O_AR_AMT = hashMap.get("O_AR_AMT") == null ? "" : hashMap.get("O_AR_AMT").toString();
					String V_B_AR_AMT = hashMap.get("B_AR_AMT") == null ? "" : hashMap.get("B_AR_AMT").toString();
					String V_C_GUR_AMT = hashMap.get("C_GUR_AMT") == null ? "" : hashMap.get("C_GUR_AMT").toString();
					String V_B_GUR_AMT = hashMap.get("B_GUR_AMT") == null ? "" : hashMap.get("B_GUR_AMT").toString();
					String V_L_GUR_AMT = hashMap.get("L_GUR_AMT") == null ? "" : hashMap.get("L_GUR_AMT").toString();

					cs = conn.prepareCall("call USP_001_E_APP_AR_MODI_STEEL(?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_O_N_TYPE);//V_APPROV_MGM_NO
					cs.setString(4, V_L_AR_AMT);//V_L_AR_AMT
					cs.setString(5, V_N_AR_AMT);//V_N_AR_AMT
					cs.setString(6, V_O_AR_AMT);//V_O_AR_AMT
					cs.setString(7, V_B_AR_AMT);//V_B_AR_AMT
					cs.setString(8, V_C_GUR_AMT);//V_C_GUR_AMT
					cs.setString(9, V_B_GUR_AMT);//V_SM_TYPE
					cs.setString(10, V_L_GUR_AMT);//V_GRADE
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
// 				JSONObject jsondata = JSONObject.fromObject(jsonData);  //큰수에 소수점이 있는경우 숫자계산이 이상해서 수정함. 20200108 김장운
				
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_O_N_TYPE = jsondata.get("O_N_TYPE") == null ? "" : jsondata.get("O_N_TYPE").toString();
				String V_L_AR_AMT = jsondata.get("L_AR_AMT") == null ? "" : jsondata.get("L_AR_AMT").toString();
				String V_N_AR_AMT = jsondata.get("N_AR_AMT") == null ? "" : jsondata.get("N_AR_AMT").toString();
				String V_O_AR_AMT = jsondata.get("O_AR_AMT") == null ? "" : jsondata.get("O_AR_AMT").toString();
				String V_B_AR_AMT = jsondata.get("B_AR_AMT") == null ? "" : jsondata.get("B_AR_AMT").toString();
				String V_C_GUR_AMT = jsondata.get("C_GUR_AMT") == null ? "" : jsondata.get("C_GUR_AMT").toString();
				String V_B_GUR_AMT = jsondata.get("B_GUR_AMT") == null ? "" : jsondata.get("B_GUR_AMT").toString();
				String V_L_GUR_AMT = jsondata.get("L_GUR_AMT") == null ? "" : jsondata.get("L_GUR_AMT").toString();

				cs = conn.prepareCall("call USP_001_E_APP_AR_MODI_STEEL(?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_APPROV_MGM_NO);//V_APPROV_MGM_NO
				cs.setString(3, V_O_N_TYPE);//V_APPROV_MGM_NO
				cs.setString(4, V_L_AR_AMT);//V_L_AR_AMT
				cs.setString(5, V_N_AR_AMT);//V_N_AR_AMT
				cs.setString(6, V_O_AR_AMT);//V_O_AR_AMT
				cs.setString(7, V_B_AR_AMT);//V_B_AR_AMT
				cs.setString(8, V_C_GUR_AMT);//V_C_GUR_AMT
				cs.setString(9, V_B_GUR_AMT);//V_SM_TYPE
				cs.setString(10, V_L_GUR_AMT);//V_GRADE
				cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
			}

		}

	} catch (

	Exception e) {
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


