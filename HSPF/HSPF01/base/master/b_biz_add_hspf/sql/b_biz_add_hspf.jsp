<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
// 		System.out.println(V_TYPE);
		//그리드 조회
		if (V_TYPE.equals("S")) {
// 			System.out.println("SS");
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String BP_NM = request.getParameter("BP_NM") == null ? "" : request.getParameter("BP_NM").toUpperCase();
			
			cs = conn.prepareCall("call USP_B_BIZ_ADD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, V_TYPE);
			cs.setString(3, V_BP_CD); //V_BP_CD
			cs.setString(4, ""); //V_BP_SEQ2
			cs.setString(5, ""); //V_BP_PUR_TYPE
			cs.setString(6, ""); //V_BP_SALE_TYPE
			cs.setString(7, ""); //V_PUR_PAY_METH
			cs.setString(8, ""); //V_PUR_INCOTERMS
			cs.setString(9, ""); //V_SALE_PAY_METH
			cs.setString(10, ""); //V_SALE_INCOTERMS
			cs.setString(11, ""); //V_VAT_TYPE
			cs.setString(12, ""); //V_CUR
			cs.setString(13, ""); //V_USE_YN
			cs.setString(14, ""); //V_USR_ID
			
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_SEQ", rs.getString("BP_SEQ"));
				subObject.put("BP_PUR_TYPE", rs.getString("BP_PUR_TYPE"));
				subObject.put("BP_PUR_TYPE_NM", rs.getString("BP_PUR_TYPE_NM"));
				subObject.put("BP_SALE_TYPE", rs.getString("BP_SALE_TYPE"));
				subObject.put("BP_SALE_TYPE_NM", rs.getString("BP_SALE_TYPE_NM"));
				subObject.put("PUR_PAY_METH", rs.getString("PUR_PAY_METH"));
				subObject.put("PUR_PAY_METH_NM", rs.getString("PUR_PAY_METH_NM"));
				subObject.put("PUR_INCOTERMS", rs.getString("PUR_INCOTERMS"));
				subObject.put("PUR_INCOTERMS_NM", rs.getString("PUR_INCOTERMS_NM"));
				subObject.put("SALE_PAY_METH", rs.getString("SALE_PAY_METH"));
				subObject.put("SALE_PAY_METH_NM", rs.getString("SALE_PAY_METH_NM"));
				subObject.put("SALE_INCOTERMS", rs.getString("SALE_INCOTERMS"));
				subObject.put("SALE_INCOTERMS_NM", rs.getString("SALE_INCOTERMS_NM"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("USE_YN", rs.getString("USE_YN"));

				jsonArray.add(subObject);
			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}
		else if (V_TYPE.equals("SYNC")) {

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap jsondata = (HashMap) jsonAr.get(i);
					V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
					String BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
					String BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
					String BP_SEQ = jsondata.get("BP_SEQ") == null ? "" : jsondata.get("BP_SEQ").toString();
					String BP_PUR_TYPE = jsondata.get("BP_PUR_TYPE") == null ? "" : jsondata.get("BP_PUR_TYPE").toString();
					String BP_SALE_TYPE = jsondata.get("BP_SALE_TYPE") == null ? "" : jsondata.get("BP_SALE_TYPE").toString();
					String PUR_PAY_METH = jsondata.get("PUR_PAY_METH") == null ? "" : jsondata.get("PUR_PAY_METH").toString();
					String PUR_INCOTERMS = jsondata.get("PUR_INCOTERMS") == null ? "" : jsondata.get("PUR_INCOTERMS").toString();
					String SALE_PAY_METH = jsondata.get("SALE_PAY_METH") == null ? "" : jsondata.get("SALE_PAY_METH").toString();
					String SALE_INCOTERMS = jsondata.get("SALE_INCOTERMS") == null ? "" : jsondata.get("SALE_INCOTERMS").toString();
					String VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
					String CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
					String USE_YN = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();

					cs = conn.prepareCall("call USP_B_BIZ_ADD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_TYPE);
					cs.setString(3, BP_CD); //V_BP_CD
					cs.setString(4, BP_SEQ); //V_BP_SEQ2
					cs.setString(5, BP_PUR_TYPE); //V_BP_PUR_TYPE
					cs.setString(6, BP_SALE_TYPE); //V_BP_SALE_TYPE
					cs.setString(7, PUR_PAY_METH); //V_PUR_PAY_METH
					cs.setString(8, PUR_INCOTERMS); //V_PUR_INCOTERMS
					cs.setString(9, SALE_PAY_METH); //V_SALE_PAY_METH
					cs.setString(10, SALE_INCOTERMS); //V_SALE_INCOTERMS
					cs.setString(11, VAT_TYPE); //V_VAT_TYPE
					cs.setString(12, CUR); //V_CUR
					cs.setString(13, USE_YN); //V_USE_YN
					cs.setString(14, V_USR_ID); //V_USR_ID
					
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String BP_SEQ = jsondata.get("BP_SEQ") == null ? "" : jsondata.get("BP_SEQ").toString();
				String BP_PUR_TYPE = jsondata.get("BP_PUR_TYPE") == null ? "" : jsondata.get("BP_PUR_TYPE").toString();
				String BP_SALE_TYPE = jsondata.get("BP_SALE_TYPE") == null ? "" : jsondata.get("BP_SALE_TYPE").toString();
				String PUR_PAY_METH = jsondata.get("PUR_PAY_METH") == null ? "" : jsondata.get("PUR_PAY_METH").toString();
				String PUR_INCOTERMS = jsondata.get("PUR_INCOTERMS") == null ? "" : jsondata.get("PUR_INCOTERMS").toString();
				String SALE_PAY_METH = jsondata.get("SALE_PAY_METH") == null ? "" : jsondata.get("SALE_PAY_METH").toString();
				String SALE_INCOTERMS = jsondata.get("SALE_INCOTERMS") == null ? "" : jsondata.get("SALE_INCOTERMS").toString();
				String VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String USE_YN = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();

				cs = conn.prepareCall("call USP_B_BIZ_ADD_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);
				cs.setString(2, V_TYPE);
				cs.setString(3, BP_CD); //V_BP_CD
				cs.setString(4, BP_SEQ); //V_BP_SEQ2
				cs.setString(5, BP_PUR_TYPE); //V_BP_PUR_TYPE
				cs.setString(6, BP_SALE_TYPE); //V_BP_SALE_TYPE
				cs.setString(7, PUR_PAY_METH); //V_PUR_PAY_METH
				cs.setString(8, PUR_INCOTERMS); //V_PUR_INCOTERMS
				cs.setString(9, SALE_PAY_METH); //V_SALE_PAY_METH
				cs.setString(10, SALE_INCOTERMS); //V_SALE_INCOTERMS
				cs.setString(11, VAT_TYPE); //V_VAT_TYPE
				cs.setString(12, CUR); //V_CUR
				cs.setString(13, USE_YN); //V_USE_YN
				cs.setString(14, V_USR_ID); //V_USR_ID
				
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
		}
		


		
	} catch (Exception e) {

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


