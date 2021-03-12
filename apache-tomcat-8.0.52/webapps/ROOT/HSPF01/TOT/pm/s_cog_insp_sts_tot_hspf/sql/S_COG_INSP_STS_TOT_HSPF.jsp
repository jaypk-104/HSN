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
		String V_YYYYMM = request.getParameter("V_YYYYMM") == null ? "" : request.getParameter("V_YYYYMM").replace("-", "").substring(0, 6);
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, "I");//V_TYPE
			cs.setString(3, "");//V_YYYYMM_FR
			cs.setString(4, "");//V_YYYYMM_TO 
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD 
			cs.setString(6, V_S_BP_CD);//V_S_BP_CD 
			cs.setString(7, V_YYYYMM);//V_YYYYMM 
			cs.setString(8, "");//V_MVMT_NO
			cs.setString(9, V_ITEM_CD);//V_ITEM_CD
			cs.setString(10, "");//V_MVMT_MAT_QTY
			cs.setString(11, "");//V_MARGIN
			cs.setString(12, "");//V_AVG_PRC2
			cs.setString(13, "");//V_CFM_YN
			cs.setString(14, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(16, V_ITEM_NM);//V_ITEM_NM
			cs.setString(17, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(18, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.executeQuery();
			
			cs.setString(2, V_TYPE);//V_TYPE
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(15);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("YYYYMM", rs.getString("YYYYMM"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("MVMT_BL_QTY", rs.getString("MVMT_BL_QTY"));
				subObject.put("MVMT_SOJE_QTY", rs.getString("MVMT_SOJE_QTY"));
				subObject.put("MVMT_UNIT", rs.getString("MVMT_UNIT"));
				subObject.put("MVMT_CUR", rs.getString("MVMT_CUR"));
				subObject.put("MVMT_PRC", rs.getString("MVMT_PRC"));
				subObject.put("MAGIN_WIDTH", rs.getString("MAGIN_WIDTH"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("SALES_PRC", rs.getString("SALES_PRC"));
				subObject.put("PURCHASE_PRC", rs.getString("PURCHASE_PRC"));
				subObject.put("SOJE_PUR_PRC", rs.getString("SOJE_PUR_PRC"));
				subObject.put("DOC_PRC", rs.getString("DOC_PRC"));
				subObject.put("XCHG_RATE1", rs.getString("XCHG_RATE1"));
				subObject.put("MVMT_LOC_AMT", rs.getString("MVMT_LOC_AMT"));
				subObject.put("MVMT_SOJE_AMT", rs.getString("MVMT_SOJE_AMT"));
				subObject.put("INDIVIDUAL_SALES_PRC", rs.getString("INDIVIDUAL_SALES_PRC"));
				subObject.put("CC_LOC_AMT", rs.getString("CC_LOC_AMT"));
				subObject.put("DISTRIBT_AMT", rs.getString("DISTRIBT_AMT"));
				subObject.put("DISTRIBT_PRC", rs.getString("DISTRIBT_PRC"));
				subObject.put("TOT_DISTRIBT_AMT", rs.getString("TOT_DISTRIBT_AMT"));
				subObject.put("TOT_IV_AMT", rs.getString("TOT_IV_AMT"));
				subObject.put("SOJE_SALE_PRC", rs.getString("SOJE_SALE_PRC"));
				subObject.put("INDIVIDUAL_SALES_AMT", rs.getString("INDIVIDUAL_SALES_AMT"));
				subObject.put("PROFIT", rs.getString("PROFIT"));
				subObject.put("MVMT_UNIT2", rs.getString("MVMT_UNIT2"));
				subObject.put("INDIVIDUAL_SALES_PRC2", rs.getString("INDIVIDUAL_SALES_PRC2"));
				subObject.put("AVG_PRC", rs.getString("AVG_PRC"));
				subObject.put("INDIVIDUAL_SALES_PRC2_SUM", rs.getString("INDIVIDUAL_SALES_PRC2_SUM"));
				subObject.put("AVG_AMT", rs.getString("AVG_AMT"));
				subObject.put("AVG_PRC2", rs.getString("AVG_PRC2"));
				subObject.put("AVG_AMT2", rs.getString("AVG_AMT2"));
				subObject.put("CFM_YN", rs.getString("CFM_YN"));
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
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_MARGIN = hashMap.get("MAGIN_WIDTH") == null ? "" : hashMap.get("MAGIN_WIDTH").toString();
					String V_AVG_PRC2 = hashMap.get("AVG_PRC2") == null ? "" : hashMap.get("AVG_PRC2").toString();
					String V_MVMT_MAT_QTY = hashMap.get("DN_QTY") == null ? "" : hashMap.get("DN_QTY").toString();
	
					cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_YYYYMM_FR
					cs.setString(4, "");//V_YYYYMM_TO 
					cs.setString(5, "");//V_M_BP_CD 
					cs.setString(6, V_S_BP_CD);//V_S_BP_CD 
					cs.setString(7, V_YYYYMM);//V_YYYYMM 
					cs.setString(8, V_MVMT_NO);//V_MVMT_NO
					cs.setString(9, V_ITEM_CD);//V_ITEM_CD
					cs.setString(10, V_MVMT_MAT_QTY);//V_MVMT_MAT_QTY
					cs.setString(11, V_MARGIN);//V_MARGIN
					cs.setString(12, V_AVG_PRC2);//V_AVG_PRC2
					cs.setString(13, "");//V_CFM_YN
					cs.setString(14, V_USR_ID);//V_USR_ID 		
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(16, "");//V_ITEM_NM
					cs.setString(17, "");//V_LC_DOC_NO
					cs.setString(18, "");//V_BL_DOC_NO
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
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_MARGIN = jsondata.get("MAGIN_WIDTH") == null ? "" : jsondata.get("MAGIN_WIDTH").toString();
				String V_AVG_PRC2 = jsondata.get("AVG_PRC2") == null ? "" : jsondata.get("AVG_PRC2").toString();
				String V_MVMT_MAT_QTY = jsondata.get("DN_QTY") == null ? "" : jsondata.get("DN_QTY").toString();
	
				cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_YYYYMM_FR
				cs.setString(4, "");//V_YYYYMM_TO 
				cs.setString(5, "");//V_M_BP_CD 
				cs.setString(6, V_S_BP_CD);//V_S_BP_CD 
				cs.setString(7, V_YYYYMM);//V_YYYYMM 
				cs.setString(8, V_MVMT_NO);//V_MVMT_NO
				cs.setString(9, V_ITEM_CD);//V_ITEM_CD
				cs.setString(10, V_MVMT_MAT_QTY);//V_MVMT_MAT_QTY
				cs.setString(11, V_MARGIN);//V_MARGIN
				cs.setString(12, V_AVG_PRC2);//V_AVG_PRC2
				cs.setString(13, "");//V_CFM_YN
				cs.setString(14, V_USR_ID);//V_USR_ID 		
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(16, "");//V_ITEM_NM
				cs.setString(17, "");//V_LC_DOC_NO
				cs.setString(18, "");//V_BL_DOC_NO
				cs.executeQuery();
	
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
	
			}
			
		} else if (V_TYPE.equals("C")) {
			
			cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_YYYYMM_FR
			cs.setString(4, "");//V_YYYYMM_TO 
			cs.setString(5, "");//V_M_BP_CD 
			cs.setString(6, "");//V_S_BP_CD 
			cs.setString(7, V_YYYYMM);//V_YYYYMM 
			cs.setString(8, "");//V_MVMT_NO
			cs.setString(9, "");//V_ITEM_CD
			cs.setString(10, "");//V_MVMT_MAT_QTY
			cs.setString(11, "");//V_MARGIN
			cs.setString(12, "");//V_AVG_PRC2
			cs.setString(13, "");//V_CFM_YN
			cs.setString(14, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(16, "");//V_ITEM_NM
			cs.setString(17, "");//V_LC_DOC_NO
			cs.setString(18, "");//V_BL_DOC_NO
			cs.executeQuery();

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("X")) {
			String check = "N";
			String result = "SUCCESS";
			
			cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, "K");//V_TYPE
			cs.setString(3, "");//V_YYYYMM_FR
			cs.setString(4, "");//V_YYYYMM_TO 
			cs.setString(5, "");//V_M_BP_CD 
			cs.setString(6, "");//V_S_BP_CD 
			cs.setString(7, V_YYYYMM);//V_YYYYMM 
			cs.setString(8, "");//V_MVMT_NO
			cs.setString(9, "");//V_ITEM_CD
			cs.setString(10, "");//V_MVMT_MAT_QTY
			cs.setString(11, "");//V_MARGIN
			cs.setString(12, "");//V_AVG_PRC2
			cs.setString(13, "");//V_CFM_YN
			cs.setString(14, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(16, "");//V_ITEM_NM
			cs.setString(17, "");//V_LC_DOC_NO
			cs.setString(18, "");//V_BL_DOC_NO
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(15);
			if (rs.next()) {
				check = rs.getString("CHK");
			}
			
			if(check.equals("Y")){
				cs.setString(2, V_TYPE);//V_TYPE
				cs.executeQuery();
			} else {
				result = "FAIL";
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SYNC2")) {
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
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_SALES_PRC = hashMap.get("INDIVIDUAL_SALES_PRC2") == null ? "" : hashMap.get("INDIVIDUAL_SALES_PRC2").toString();
					String V_AVG_PRC = hashMap.get("AVG_PRC") == null ? "" : hashMap.get("AVG_PRC").toString();
	
					cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_YYYYMM_FR
					cs.setString(4, "");//V_YYYYMM_TO 
					cs.setString(5, "");//V_M_BP_CD 
					cs.setString(6, V_S_BP_CD);//V_S_BP_CD 
					cs.setString(7, V_YYYYMM);//V_YYYYMM 
					cs.setString(8, V_MVMT_NO);//V_MVMT_NO
					cs.setString(9, V_ITEM_CD);//V_ITEM_CD
					cs.setString(10, "");//V_MVMT_MAT_QTY
					cs.setString(11, V_SALES_PRC);//V_MARGIN
					cs.setString(12, V_AVG_PRC);//V_AVG_PRC2
					cs.setString(13, "");//V_CFM_YN
					cs.setString(14, V_USR_ID);//V_USR_ID 		
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(16, "");//V_ITEM_NM
					cs.setString(17, "");//V_LC_DOC_NO
					cs.setString(18, "");//V_BL_DOC_NO
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
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_SALES_PRC = jsondata.get("INDIVIDUAL_SALES_PRC2") == null ? "" : jsondata.get("INDIVIDUAL_SALES_PRC2").toString();
				String V_AVG_PRC = jsondata.get("AVG_PRC") == null ? "" : jsondata.get("AVG_PRC").toString();
	
				cs = conn.prepareCall("call USP_003_S_COG_INSP_STS_TOT_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_YYYYMM_FR
				cs.setString(4, "");//V_YYYYMM_TO 
				cs.setString(5, "");//V_M_BP_CD 
				cs.setString(6, V_S_BP_CD);//V_S_BP_CD 
				cs.setString(7, V_YYYYMM);//V_YYYYMM 
				cs.setString(8, V_MVMT_NO);//V_MVMT_NO
				cs.setString(9, V_ITEM_CD);//V_ITEM_CD
				cs.setString(10, "");//V_MVMT_MAT_QTY
				cs.setString(11, V_SALES_PRC);//V_MARGIN
				cs.setString(12, V_AVG_PRC);//V_AVG_PRC2
				cs.setString(13, "");//V_CFM_YN
				cs.setString(14, V_USR_ID);//V_USR_ID 		
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(16, "");//V_ITEM_NM
				cs.setString(17, "");//V_LC_DOC_NO
				cs.setString(18, "");//V_BL_DOC_NO
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


