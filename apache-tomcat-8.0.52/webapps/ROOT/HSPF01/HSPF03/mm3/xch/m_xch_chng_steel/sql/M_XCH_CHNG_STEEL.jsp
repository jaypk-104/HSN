<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_LD_DT_FR = request.getParameter("V_LD_DT_FR") == null ? "" : request.getParameter("V_LD_DT_FR").toUpperCase().substring(0, 10);
		String V_LD_DT_TO = request.getParameter("V_LD_DT_TO") == null ? "" : request.getParameter("V_LD_DT_TO").toUpperCase().substring(0, 10);

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_M_XCH_CHNG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(4, V_LD_DT_FR);//V_LD_DT_FR
			cs.setString(5, V_LD_DT_TO);//V_LD_DT_TO
			cs.setString(6, V_M_BP_CD);//V_M_BP_CD
			cs.setString(7, V_S_BP_CD);//V_S_BP_CD
			cs.setString(8, "");//V_BL_NO
			cs.setString(9, "");//V_FORWARD_XCH
			cs.setString(10, "");//V_SPOT_XCH
			cs.setString(11, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			 
			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("LOADING_DT", rs.getString("LOADING_DT"));
				subObject.put("ID_DT", rs.getString("ID_DT"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("FORWARD_XCH", rs.getString("FORWARD_XCH"));
				subObject.put("SPOT_XCH", rs.getString("SPOT_XCH"));
				subObject.put("GR_YN", rs.getString("GR_YN"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("CC_NO", rs.getString("CC_NO"));
				subObject.put("MOD_YN", rs.getString("MOD_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I")) {
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
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_FORWARD_XCH = hashMap.get("FORWARD_XCH_MOD") == null ? "" : hashMap.get("FORWARD_XCH_MOD").toString();
					String V_SPOT_XCH = hashMap.get("SPOT_XCH_MOD") == null ? "" : hashMap.get("SPOT_XCH_MOD").toString();

					cs = conn.prepareCall("call USP_M_XCH_CHNG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
					cs.setString(4, V_LD_DT_FR);//V_LD_DT_FR
					cs.setString(5, V_LD_DT_TO);//V_LD_DT_TO
					cs.setString(6, V_M_BP_CD);//V_M_BP_CD
					cs.setString(7, V_S_BP_CD);//V_S_BP_CD
					cs.setString(8, V_BL_NO);//V_BL_NO
					cs.setString(9, V_FORWARD_XCH);//V_FORWARD_XCH
					cs.setString(10, V_SPOT_XCH);//V_SPOT_XCH
					cs.setString(11, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {

				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);					
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_FORWARD_XCH = jsondata.get("FORWARD_XCH_MOD") == null ? "" : jsondata.get("FORWARD_XCH_MOD").toString();
				String V_SPOT_XCH = jsondata.get("SPOT_XCH_MOD") == null ? "" : jsondata.get("SPOT_XCH_MOD").toString();
				
				cs = conn.prepareCall("call USP_M_XCH_CHNG_STEEL(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BL_DOC_NO);//V_BL_DOC_NO
				cs.setString(4, V_LD_DT_FR);//V_LD_DT_FR
				cs.setString(5, V_LD_DT_TO);//V_LD_DT_TO
				cs.setString(6, V_M_BP_CD);//V_M_BP_CD
				cs.setString(7, V_S_BP_CD);//V_S_BP_CD
				cs.setString(8, V_BL_NO);//V_BL_NO
				cs.setString(9, V_FORWARD_XCH);//V_FORWARD_XCH
				cs.setString(10, V_SPOT_XCH);//V_SPOT_XCH
				cs.setString(11, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
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


