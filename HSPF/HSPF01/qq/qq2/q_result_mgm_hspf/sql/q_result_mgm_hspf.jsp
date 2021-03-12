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
		
		//수입검사 결과등록 헤더 조회
		if (V_TYPE.equals("S")) {
// 			System.out.println("SS");
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_DL_FR_DT = request.getParameter("V_DL_FR_DT") == null ? "" : request.getParameter("V_DL_FR_DT").substring(0,10);
			String V_DL_TO_DT = request.getParameter("V_DL_TO_DT") == null ? "" : request.getParameter("V_DL_TO_DT").substring(0,10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_INSP_DT = request.getParameter("V_INSP_DT") == null ? "" : request.getParameter("V_INSP_DT").toUpperCase();
			
			if(V_INSP_DT != null && !V_INSP_DT.equals("")){
				V_INSP_DT = V_INSP_DT.substring(0,10);
			}
			cs = conn.prepareCall("call USP_Q_RESULT_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, V_BP_CD); //V_BP_CD
			cs.setString(5, V_DL_FR_DT); //V_DL_FR_DT
			cs.setString(6, V_DL_TO_DT); //V_DL_TO_DT
			cs.setString(7, V_ITEM_CD); //V_ITEM_CD
			cs.setString(8, ""); //V_LOT_NO
			cs.setString(9, ""); //V_Q_RS_NO
			cs.setString(10, ""); //V_OK_QTY
			cs.setString(11, ""); //V_BAD_QTY
			cs.setString(12, ""); //V_INSP_USR_ID
			cs.setString(13, V_INSP_DT); //V_INSP_DT
			cs.setString(14, V_USR_ID); //V_USR_ID
			
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("LOT_ETC", rs.getString("LOT_ETC"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("INSP_YN", rs.getString("INSP_YN"));
				subObject.put("INSP_DT", rs.getString("INSP_DT"));
				subObject.put("INSP_USR_ID", rs.getString("INSP_USR_ID"));
				subObject.put("OK_QTY", rs.getString("OK_QTY"));
				subObject.put("BAD_QTY", rs.getString("BAD_QTY"));
				subObject.put("QC_TYPE_NM", rs.getString("QC_TYPE_NM"));
				subObject.put("HS_TYPE_NM", rs.getString("HS_TYPE_NM"));
				subObject.put("Q_RS_NO", rs.getString("Q_RS_NO"));

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
		
		// 팝업창 그리드 조회
		else if (V_TYPE.equals("WS")){
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			V_TYPE = "S";
			cs = conn.prepareCall("call USP_Q_RESULT_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, ""); //V_Q_RS_NO
			cs.setString(5, ""); //V_Q_RS_SEQ
			cs.setString(6, ""); //V_Q_RST_VAL
			cs.setString(7, ""); //V_Q1_VAL
			cs.setString(8, ""); //V_Q2_VAL
			cs.setString(9, ""); //V_Q3_VAL
			cs.setString(10, ""); //V_Q4_VAL
			cs.setString(11, ""); //V_Q5_VAL
			cs.setString(12, ""); //V_Q6_VAL
			cs.setString(13, ""); //V_Q7_VAL
			cs.setString(14, ""); //V_Q8_VAL
			cs.setString(15, ""); //V_Q9_VAL
			cs.setString(16, ""); //V_10_VAL
			cs.setString(17, ""); //V_REMARK
			cs.setString(18, ""); //V_USR_ID
			
			cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(19);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("Q_ID_SEQ", rs.getString("Q_ID_SEQ"));
				subObject.put("INSP_CD", rs.getString("INSP_CD"));
				subObject.put("INSP_NM", rs.getString("INSP_NM"));
				subObject.put("MIN_QTY", rs.getString("MIN_QTY"));
				subObject.put("MID_QTY", rs.getString("MID_QTY"));
				subObject.put("MAX_QTY", rs.getString("MAX_QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("INSP_TYPE_CD", rs.getString("INSP_TYPE_CD"));
				subObject.put("BP_TYPE", rs.getString("BP_TYPE"));
				subObject.put("Q_RST_VAL", rs.getString("Q_RST_VAL"));
				subObject.put("Q1_VAL", rs.getString("Q1_VAL"));
				subObject.put("Q2_VAL", rs.getString("Q2_VAL"));
				subObject.put("Q3_VAL", rs.getString("Q3_VAL"));
				subObject.put("Q4_VAL", rs.getString("Q4_VAL"));
				subObject.put("Q5_VAL", rs.getString("Q5_VAL"));
				subObject.put("Q6_VAL", rs.getString("Q6_VAL"));
				subObject.put("Q7_VAL", rs.getString("Q7_VAL"));
				subObject.put("Q8_VAL", rs.getString("Q8_VAL"));
				subObject.put("Q9_VAL", rs.getString("Q9_VAL"));
				subObject.put("Q10_VAL", rs.getString("Q10_VAL"));
				subObject.put("REMARK", rs.getString("REMARK"));

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
		
		//더블클릭시 검사일자가 없을때 저장 프로세스
		else if (V_TYPE.equals("I")){
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_Q_RESULT_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, ""); //V_BP_CD
			cs.setString(5, ""); //V_DL_FR_DT
			cs.setString(6, ""); //V_DL_TO_DT
			cs.setString(7, V_ITEM_CD); //V_ITEM_CD
			cs.setString(8, V_LOT_NO); //V_LOT_NO
			cs.setString(9, ""); //V_Q_RS_NO
			cs.setString(10, ""); //V_OK_QTY
			cs.setString(11, ""); //V_BAD_QTY
			cs.setString(12, ""); //V_INSP_USR_ID
			cs.setString(13, ""); //V_INSP_DT
			cs.setString(14, V_USR_ID); //V_USR_ID
			
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("Q_RS_NO", rs.getString(1));

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
		
		//
		else if (V_TYPE.equals("U")){
			String V_OK_QTY = request.getParameter("V_OK_QTY") == null ? "" : request.getParameter("V_OK_QTY").toUpperCase();
			String V_BAD_QTY = request.getParameter("V_BAD_QTY") == null ? "" : request.getParameter("V_BAD_QTY").toUpperCase();
			String V_INSP_USR_ID = request.getParameter("V_INSP_USR_ID") == null ? "" : request.getParameter("V_INSP_USR_ID").toUpperCase();
			String V_INSP_DT = request.getParameter("V_INSP_DT") == null ? "" : request.getParameter("V_INSP_DT").toUpperCase().substring(0,10);
			String V_Q_RS_NO = request.getParameter("V_Q_RS_NO") == null ? "" : request.getParameter("V_Q_RS_NO").toUpperCase();
// 			System.out.println("asdf");
// 			System.out.println(V_OK_QTY);
// 			System.out.println(V_BAD_QTY);
// 			System.out.println(V_INSP_USR_ID);
// 			System.out.println(V_INSP_DT);
// 			System.out.println(V_Q_RS_NO);
			
			
			cs = conn.prepareCall("call USP_Q_RESULT_HDR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, ""); //V_ASN_NO
			cs.setString(4, ""); //V_BP_CD
			cs.setString(5, ""); //V_DL_FR_DT
			cs.setString(6, ""); //V_DL_TO_DT
			cs.setString(7, ""); //V_ITEM_CD
			cs.setString(8, ""); //V_LOT_NO
			cs.setString(9, V_Q_RS_NO); //V_Q_RS_NO
			cs.setString(10, V_OK_QTY); //V_OK_QTY
			cs.setString(11, V_BAD_QTY); //V_BAD_QTY
			cs.setString(12, V_INSP_USR_ID); //V_INSP_USR_ID
			cs.setString(13, V_INSP_DT); //V_INSP_DT
			cs.setString(14, V_USR_ID); //V_USR_ID
			
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			
		}
			
		//팝업 검사결과, 측정값 저장.
		else if (V_TYPE.equals("WU")){
			String V_Q_RS_NO = request.getParameter("V_Q_RS_NO") == null ? "" : request.getParameter("V_Q_RS_NO").toUpperCase();
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
// 			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					
					String Q_ID_SEQ  = hashMap.get("Q_ID_SEQ") == null ? "" : hashMap.get("Q_ID_SEQ").toString();
					String Q_RST_VAL  = hashMap.get("Q_RST_VAL") == null ? "" : hashMap.get("Q_RST_VAL").toString();
					String Q1_VAL = hashMap.get("Q1_VAL") == null ? "" : (hashMap.get("Q1_VAL")).toString();
					String Q2_VAL = hashMap.get("Q2_VAL") == null ? "" : (hashMap.get("Q2_VAL")).toString();
					String Q3_VAL = hashMap.get("Q3_VAL") == null ? "" : (hashMap.get("Q3_VAL")).toString();
					String Q4_VAL = hashMap.get("Q4_VAL") == null ? "" : (hashMap.get("Q4_VAL")).toString();
					String Q5_VAL = hashMap.get("Q5_VAL") == null ? "" : (hashMap.get("Q5_VAL")).toString();
					String Q6_VAL = hashMap.get("Q6_VAL") == null ? "" : (hashMap.get("Q6_VAL")).toString();
					String Q7_VAL = hashMap.get("Q7_VAL") == null ? "" : (hashMap.get("Q7_VAL")).toString();
					String Q8_VAL = hashMap.get("Q8_VAL") == null ? "" : (hashMap.get("Q8_VAL")).toString();
					String Q9_VAL = hashMap.get("Q9_VAL") == null ? "" : (hashMap.get("Q9_VAL")).toString();
					String Q10_VAL = hashMap.get("Q10_VAL") == null ? "" : (hashMap.get("Q10_VAL")).toString();
					String REMARK = hashMap.get("REMARK") == null ? "" : (hashMap.get("REMARK")).toString();
					
					V_TYPE = "U";
					
					cs = conn.prepareCall("call USP_Q_RESULT_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_COMP_ID); //V_COMP_ID
					cs.setString(3, ""); //V_ASN_NO
					cs.setString(4, V_Q_RS_NO); //V_Q_RS_NO
					cs.setString(5, Q_ID_SEQ); //V_Q_RS_SEQ
					cs.setString(6, Q_RST_VAL); //V_Q_RST_VAL
					cs.setString(7, Q1_VAL); //V_Q1_VAL
					cs.setString(8, Q2_VAL); //V_Q2_VAL
					cs.setString(9, Q3_VAL); //V_Q3_VAL
					cs.setString(10, Q4_VAL); //V_Q4_VAL
					cs.setString(11, Q5_VAL); //V_Q5_VAL
					cs.setString(12, Q6_VAL); //V_Q6_VAL
					cs.setString(13, Q7_VAL); //V_Q7_VAL
					cs.setString(14, Q8_VAL); //V_Q8_VAL
					cs.setString(15, Q9_VAL); //V_Q9_VAL
					cs.setString(16, Q10_VAL); //V_10_VAL
					cs.setString(17, REMARK); //V_REMARK
					cs.setString(18, V_USR_ID); //V_USR_ID
					
					cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String Q_ID_SEQ  = jsondata.get("Q_ID_SEQ") == null ? "" : jsondata.get("Q_ID_SEQ").toString();
				String Q_RST_VAL  = jsondata.get("Q_RST_VAL") == null ? "" : jsondata.get("Q_RST_VAL").toString();
				String Q1_VAL = jsondata.get("Q1_VAL") == null ? "" : jsondata.get("Q1_VAL").toString();
				String Q2_VAL = jsondata.get("Q2_VAL") == null ? "" : jsondata.get("Q2_VAL").toString();
				String Q3_VAL = jsondata.get("Q3_VAL") == null ? "" : jsondata.get("Q3_VAL").toString();
				String Q4_VAL = jsondata.get("Q4_VAL") == null ? "" : jsondata.get("Q4_VAL").toString();
				String Q5_VAL = jsondata.get("Q5_VAL") == null ? "" : jsondata.get("Q5_VAL").toString();
				String Q6_VAL = jsondata.get("Q6_VAL") == null ? "" : jsondata.get("Q6_VAL").toString();
				String Q7_VAL = jsondata.get("Q7_VAL") == null ? "" : jsondata.get("Q7_VAL").toString();
				String Q8_VAL = jsondata.get("Q8_VAL") == null ? "" : jsondata.get("Q8_VAL").toString();
				String Q9_VAL = jsondata.get("Q9_VAL") == null ? "" : jsondata.get("Q9_VAL").toString();
				String Q10_VAL = jsondata.get("Q10_VAL") == null ? "" : jsondata.get("Q10_VAL").toString();
				String REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				
				V_TYPE = "U";
				
				cs = conn.prepareCall("call USP_Q_RESULT_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_COMP_ID); //V_COMP_ID
				cs.setString(3, ""); //V_ASN_NO
				cs.setString(4, V_Q_RS_NO); //V_Q_RS_NO
				cs.setString(5, Q_ID_SEQ); //V_Q_RS_SEQ
				cs.setString(6, Q_RST_VAL); //V_Q_RST_VAL
				cs.setString(7, Q1_VAL); //V_Q1_VAL
				cs.setString(8, Q2_VAL); //V_Q2_VAL
				cs.setString(9, Q3_VAL); //V_Q3_VAL
				cs.setString(10, Q4_VAL); //V_Q4_VAL
				cs.setString(11, Q5_VAL); //V_Q5_VAL
				cs.setString(12, Q6_VAL); //V_Q6_VAL
				cs.setString(13, Q7_VAL); //V_Q7_VAL
				cs.setString(14, Q8_VAL); //V_Q8_VAL
				cs.setString(15, Q9_VAL); //V_Q9_VAL
				cs.setString(16, Q10_VAL); //V_10_VAL
				cs.setString(17, REMARK); //V_REMARK
				cs.setString(18, V_USR_ID); //V_USR_ID
				
				cs.registerOutParameter(19, com.tmax.tibero.TbTypes.CURSOR);
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


