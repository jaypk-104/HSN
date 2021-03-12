<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
// 		System.out.println("V_TYPE : " + V_TYPE);
		
		
		if (V_TYPE.equals("S")) {
			String V_GR_DT_FROM = request.getParameter("V_GR_DT_FROM") == null ? "" : request.getParameter("V_GR_DT_FROM").toUpperCase();
			String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").toUpperCase();
			String V_DN_DT_FROM = request.getParameter("V_DN_DT_FROM") == null ? "" : request.getParameter("V_DN_DT_FROM").toUpperCase();
			String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase();
			String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
			String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
			String V_PUR_GRP = request.getParameter("V_PUR_GRP") == null ? "" : request.getParameter("V_PUR_GRP").toUpperCase();
			
			if(V_GR_DT_FROM.length() > 10){
				V_GR_DT_FROM = V_GR_DT_FROM.substring(0,10);
			}
			else if (V_GR_DT_FROM.length() == 0){
				V_GR_DT_FROM = "2019-01-01";
			}
			
			
			
			
			if(V_GR_DT_TO.length() > 10){
				V_GR_DT_TO = V_GR_DT_TO.substring(0,10);
			}
			else if (V_GR_DT_TO.length() == 0){
				V_GR_DT_TO = "2119-01-01";
			}
			
			if(V_DN_DT_FROM.length() > 10){
				V_DN_DT_FROM = V_DN_DT_FROM.substring(0,10);
			}
			else if (V_DN_DT_FROM.length() == 0){
				V_DN_DT_FROM = "2019-01-01";
			}
			
			if(V_DN_DT_TO.length() > 10){
				V_DN_DT_TO = V_DN_DT_TO.substring(0,10);
			}
			else if (V_DN_DT_TO.length() == 0){
				V_DN_DT_TO = "2119-01-01";
			}
			
			
			
			
			cs = conn.prepareCall("call USP_001_GOCHUL_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_GR_DT_FROM);//V_GR_DATE_FR
			cs.setString(3, V_GR_DT_TO);//V_GR_DATE_TO
			cs.setString(4, "");//V_IV_DN_NO
			cs.setString(5, "");//V_GR_DT
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, V_M_BP_CD);//V_M_BP_CD
			cs.setString(8, V_PUR_GRP);//V_PUR_GRP
			cs.setString(9, "");//V_CAR_NO
			cs.setString(10, "");//V_LOC_NM
			cs.setString(11, "");//V_GRADE_CD
			cs.setString(12, "");//V_TOTAL_KG
			cs.setString(13, "");//V_GONG_KG
			cs.setString(14, "");//V_MINUS_KG
			cs.setString(15, "");//V_GR_KG
			cs.setString(16, "");//V_PRC
			cs.setString(17, "");//V_GR_AMT
			cs.setString(18, "");//V_GR_VAT
			cs.setString(19, "");//V_TOTAL_AMT
			cs.setString(20, V_S_BP_CD);//V_S_BP_CD
			cs.setString(21, "");//V_DN_DT
			cs.setString(22, "");//V_DN_PRC
			cs.setString(23, "");//V_DN_AMT
			cs.setString(24, "");//V_DN_VAT
			cs.setString(25, "");//V_DN_TOTAL_AMT
			cs.setString(26, "");//V_USER_ID
			cs.setString(27, "");//V_DELV_AMT
			cs.setString(28, "");//V_DELV_PRC
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(30, V_DN_DT_FROM);//
			cs.setString(31, V_DN_DT_TO);//
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(29);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IV_DN_NO", rs.getString("IV_DN_NO"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_SEQ", rs.getString("DN_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PUR_GRP", rs.getString("PUR_GRP"));
				subObject.put("PUR_GRP_NM", rs.getString("PUR_GRP_NM"));
				subObject.put("CAR_NO", rs.getString("CAR_NO"));
				subObject.put("LOC_NM", rs.getString("LOC_NM"));
				subObject.put("GRADE_CD", rs.getString("GRADE_CD"));
				subObject.put("TOTAL_KG", rs.getString("TOTAL_KG"));
				subObject.put("GONG_KG", rs.getString("GONG_KG"));
				subObject.put("MINUS_KG", rs.getString("MINUS_KG"));
				subObject.put("GR_KG", rs.getString("GR_KG"));
				subObject.put("DELV_AMT", rs.getString("DELV_AMT"));
				subObject.put("DELV_PRC", rs.getString("DELV_PRC"));
				subObject.put("PRC", rs.getString("PRC"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("GR_VAT", rs.getString("GR_VAT"));
				subObject.put("TOTAL_AMT", rs.getString("TOTAL_AMT"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("DN_PRC", rs.getString("DN_PRC"));
				subObject.put("DN_AMT", rs.getString("DN_AMT"));
				subObject.put("DN_VAT", rs.getString("DN_VAT"));
				subObject.put("DN_TOTAL_AMT", rs.getString("DN_TOTAL_AMT"));
				subObject.put("GRADE_NM", rs.getString("GRADE_NM"));
				
				
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

			// 			System.out.println(jsonData);
			
			String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
			String V_JIGUB_DT = request.getParameter("V_JIGUB_DT") == null ? "" : request.getParameter("V_JIGUB_DT").toString().substring(0,10);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String IV_DN_NO = hashMap.get("IV_DN_NO") == null ? "" : hashMap.get("IV_DN_NO").toString();
					String GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0,10);
					String CAR_NO = hashMap.get("CAR_NO") == null ? "" : hashMap.get("CAR_NO").toString();
					String LOC_NM = hashMap.get("LOC_NM") == null ? "" : hashMap.get("LOC_NM").toString();
					String GRADE_CD = hashMap.get("GRADE_CD") == null ? "" : hashMap.get("GRADE_CD").toString();
					String TOTAL_KG = hashMap.get("TOTAL_KG") == null ? "" : hashMap.get("TOTAL_KG").toString();
					String GONG_KG = hashMap.get("GONG_KG") == null ? "" : hashMap.get("GONG_KG").toString();
					String MINUS_KG = hashMap.get("MINUS_KG") == null ? "" : hashMap.get("MINUS_KG").toString();
					String GR_KG = hashMap.get("GR_KG") == null ? "" : hashMap.get("GR_KG").toString();
					String PRC = hashMap.get("PRC") == null ? "" : hashMap.get("PRC").toString();
					String GR_AMT = hashMap.get("GR_AMT") == null ? "" : hashMap.get("GR_AMT").toString();
					String GR_VAT = hashMap.get("GR_VAT") == null ? "" : hashMap.get("GR_VAT").toString();
					String DN_DT = hashMap.get("DN_DT") == null ? "" : hashMap.get("DN_DT").toString().substring(0,10);
					String TOTAL_AMT = hashMap.get("TOTAL_AMT") == null ? "" : hashMap.get("TOTAL_AMT").toString();
					String PUR_GRP = hashMap.get("PUR_GRP") == null ? "" : hashMap.get("PUR_GRP").toString();
					String M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String DN_PRC = hashMap.get("DN_PRC") == null ? "" : hashMap.get("DN_PRC").toString();
					String DN_AMT = hashMap.get("DN_AMT") == null ? "" : hashMap.get("DN_AMT").toString();
					String DN_VAT = hashMap.get("DN_VAT") == null ? "" : hashMap.get("DN_VAT").toString();
					String DN_TOTAL_AMT = hashMap.get("DN_TOTAL_AMT") == null ? "" : hashMap.get("DN_TOTAL_AMT").toString();
					String DELV_AMT = hashMap.get("DELV_AMT") == null ? "" : hashMap.get("DELV_AMT").toString();
					String DELV_PRC = hashMap.get("DELV_PRC") == null ? "" : hashMap.get("DELV_PRC").toString();

					cs = conn.prepareCall("call USP_001_GOCHUL_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, "");//V_GR_DATE_FR
					cs.setString(3, "");//V_GR_DATE_TO
					cs.setString(4, IV_DN_NO);//V_IV_DN_NO
					cs.setString(5, GR_DT);//V_GR_DT
					cs.setString(6, ITEM_CD);//V_ITEM_CD
					cs.setString(7, M_BP_CD);//V_M_BP_CD
					cs.setString(8, PUR_GRP);//V_PUR_GRP
					cs.setString(9, CAR_NO);//V_CAR_NO
					cs.setString(10, LOC_NM);//V_LOC_NM
					cs.setString(11, GRADE_CD);//V_GRADE_CD
					cs.setString(12, TOTAL_KG);//V_TOTAL_KG
					cs.setString(13, GONG_KG);//V_GONG_KG
					cs.setString(14, MINUS_KG);//V_MINUS_KG
					cs.setString(15, GR_KG);//V_GR_KG
					cs.setString(16, PRC);//V_PRC
					cs.setString(17, GR_AMT);//V_GR_AMT
					cs.setString(18, GR_VAT);//V_GR_VAT
					cs.setString(19, TOTAL_AMT);//V_TOTAL_AMT
					cs.setString(20, S_BP_CD);//V_S_BP_CD
					cs.setString(21, DN_DT);//V_DN_DT
					cs.setString(22, DN_PRC);//V_DN_PRC
					cs.setString(23, DN_AMT);//V_DN_AMT
					cs.setString(24, DN_VAT);//V_DN_VAT
					cs.setString(25, DN_TOTAL_AMT);//V_DN_TOTAL_AMT
					cs.setString(26, V_USR_ID);//V_USER_ID
					cs.setString(27, DELV_AMT);//V_DELV_AMT
					cs.setString(28, DELV_PRC);//V_DELV_PRC
					cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(30, "");//
					cs.setString(31, "");//
					
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String IV_DN_NO = jsondata.get("IV_DN_NO") == null ? "" : jsondata.get("IV_DN_NO").toString();
				String GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0,10);
				String CAR_NO = jsondata.get("CAR_NO") == null ? "" : jsondata.get("CAR_NO").toString();
				String LOC_NM = jsondata.get("LOC_NM") == null ? "" : jsondata.get("LOC_NM").toString();
				String GRADE_CD = jsondata.get("GRADE_CD") == null ? "" : jsondata.get("GRADE_CD").toString();
				String TOTAL_KG = jsondata.get("TOTAL_KG") == null ? "" : jsondata.get("TOTAL_KG").toString();
				String GONG_KG = jsondata.get("GONG_KG") == null ? "" : jsondata.get("GONG_KG").toString();
				String MINUS_KG = jsondata.get("MINUS_KG") == null ? "" : jsondata.get("MINUS_KG").toString();
				String GR_KG = jsondata.get("GR_KG") == null ? "" : jsondata.get("GR_KG").toString();
				String PRC = jsondata.get("PRC") == null ? "" : jsondata.get("PRC").toString();
				String GR_AMT = jsondata.get("GR_AMT") == null ? "" : jsondata.get("GR_AMT").toString();
				String GR_VAT = jsondata.get("GR_VAT") == null ? "" : jsondata.get("GR_VAT").toString();
				String DN_DT = jsondata.get("DN_DT") == null ? "" : jsondata.get("DN_DT").toString().substring(0,10);
				String TOTAL_AMT = jsondata.get("TOTAL_AMT") == null ? "" : jsondata.get("TOTAL_AMT").toString();
				String PUR_GRP = jsondata.get("PUR_GRP") == null ? "" : jsondata.get("PUR_GRP").toString();
				String M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String DN_PRC = jsondata.get("DN_PRC") == null ? "" : jsondata.get("DN_PRC").toString();
				String DN_AMT = jsondata.get("DN_AMT") == null ? "" : jsondata.get("DN_AMT").toString();
				String DN_VAT = jsondata.get("DN_VAT") == null ? "" : jsondata.get("DN_VAT").toString();
				String DN_TOTAL_AMT = jsondata.get("DN_TOTAL_AMT") == null ? "" : jsondata.get("DN_TOTAL_AMT").toString();
				String DELV_AMT = jsondata.get("DELV_AMT") == null ? "" : jsondata.get("DELV_AMT").toString();
				String DELV_PRC = jsondata.get("DELV_PRC") == null ? "" : jsondata.get("DELV_PRC").toString();

				cs = conn.prepareCall("call USP_001_GOCHUL_STEEL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, "");//V_GR_DATE_FR
				cs.setString(3, "");//V_GR_DATE_TO
				cs.setString(4, IV_DN_NO);//V_IV_DN_NO
				cs.setString(5, GR_DT);//V_GR_DT
				cs.setString(6, ITEM_CD);//V_ITEM_CD
				cs.setString(7, M_BP_CD);//V_M_BP_CD
				cs.setString(8, PUR_GRP);//V_PUR_GRP
				cs.setString(9, CAR_NO);//V_CAR_NO
				cs.setString(10, LOC_NM);//V_LOC_NM
				cs.setString(11, GRADE_CD);//V_GRADE_CD
				cs.setString(12, TOTAL_KG);//V_TOTAL_KG
				cs.setString(13, GONG_KG);//V_GONG_KG
				cs.setString(14, MINUS_KG);//V_MINUS_KG
				cs.setString(15, GR_KG);//V_GR_KG
				cs.setString(16, PRC);//V_PRC
				cs.setString(17, GR_AMT);//V_GR_AMT
				cs.setString(18, GR_VAT);//V_GR_VAT
				cs.setString(19, TOTAL_AMT);//V_TOTAL_AMT
				cs.setString(20, S_BP_CD);//V_S_BP_CD
				cs.setString(21, DN_DT);//V_DN_DT
				cs.setString(22, DN_PRC);//V_DN_PRC
				cs.setString(23, DN_AMT);//V_DN_AMT
				cs.setString(24, DN_VAT);//V_DN_VAT
				cs.setString(25, DN_TOTAL_AMT);//V_DN_TOTAL_AMT
				cs.setString(26, V_USR_ID);//V_USER_ID
				cs.setString(27, DELV_AMT);//V_DELV_AMT
				cs.setString(28, DELV_PRC);//V_DELV_PRC
				cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(30, "");//
				cs.setString(31, "");//
				
				cs.executeQuery();

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
// 		System.out.println(cs);
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


