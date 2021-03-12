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
	
// 	String strCompId = (String) session.getAttribute("comp_id");
// 	String strId = (String) session.getAttribute("user_id");
	
	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
// 		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_SL_CD = "S002";
// 		String V_COMP_ID = strCompId;
// 		String V_USR_ID = strId;
		
// 		System.out.println("V_TYPE : " + V_TYPE);
		
		//수입검사 결과등록 헤더 조회
		
		if (V_TYPE.equals("HS")) {
			
			
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_DL_FR_DT = request.getParameter("V_DL_FR_DT") == null ? "" : request.getParameter("V_DL_FR_DT").substring(0,10);
			String V_DL_TO_DT = request.getParameter("V_DL_TO_DT") == null ? "" : request.getParameter("V_DL_TO_DT").substring(0,10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_INSP_DT = request.getParameter("V_INSP_DT") == null ? "" : request.getParameter("V_INSP_DT").toUpperCase();
			
			String V_STS_ALL = request.getParameter("V_STS_ALL") == null ? "" : request.getParameter("V_STS_ALL").toUpperCase();
			String V_STS_DLVY = request.getParameter("V_STS_DLVY") == null ? "" : request.getParameter("V_STS_DLVY").toUpperCase();
			String V_STS_WAIT = request.getParameter("V_STS_WAIT") == null ? "" : request.getParameter("V_STS_WAIT").toUpperCase();
			String V_STS_APPROVERWAIT = request.getParameter("V_STS_APPROVERWAIT") == null ? "" : request.getParameter("V_STS_APPROVERWAIT").toUpperCase();
			String V_STS_RESULT = request.getParameter("V_STS_RESULT") == null ? "" : request.getParameter("V_STS_RESULT").toUpperCase();
			
			String V_INSP_FLAG = "";
			//1:交货中,2:等待检查,3:结算中,4:完成
			if(V_STS_ALL.equals("TRUE")){
				V_STS_DLVY = "Y";
				V_STS_WAIT = "Y";
				V_STS_APPROVERWAIT = "Y";
				V_STS_RESULT = "Y";
			}
			else{
				if(V_STS_DLVY.equals("TRUE")){
					V_STS_DLVY = "Y";
				}
				if(V_STS_WAIT.equals("TRUE")){
					V_STS_WAIT = "Y";
				}
				if(V_STS_APPROVERWAIT.equals("TRUE")){
					V_STS_APPROVERWAIT = "Y";
				}
				if(V_STS_RESULT.equals("TRUE")){
					V_STS_RESULT = "Y";
				}
			}
			
			//String V_INSP_FLAG = request.getParameter("V_INSP_FLAG") == null ? "" : request.getParameter("V_INSP_FLAG").toUpperCase();
			//if(V_INSP_DT != null && !V_INSP_DT.equals("")){
			//	V_INSP_DT = V_INSP_DT.substring(0,10);
			//}
			
			cs = conn.prepareCall("{call USP_Q_RESULT_SUPP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "S"); //V_TYPE
			cs.setString(2, V_SL_CD); //V_COMP_ID
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, ""); //V_LOT_NO
			cs.setString(5, V_DL_FR_DT); //V_DL_FR_DT
			cs.setString(6, V_DL_TO_DT); //V_DL_TO_DT
			cs.setString(7, V_ITEM_CD); //V_ITEM_CD
			cs.setString(8, V_ITEM_CD); //V_HSTN_ITEM_CD
			cs.setString(9, V_INSP_DT); //V_INSP_DT
			cs.setString(10, V_INSP_FLAG); //V_INSP_FLAG
			cs.setString(11, "0"); //V_OK_QTY
			cs.setString(12, "0"); //V_BAD_QTY
			cs.setString(13, ""); //V_INSPECTOR
			cs.setString(14, ""); //V_WRITER
			cs.setString(15, ""); //V_WRITERYN
			cs.setString(16, ""); //V_APPROVER
			cs.setString(17, ""); //V_APPROVERYN
			cs.setString(18, V_USR_ID); //V_USR_ID
			cs.setString(19, V_STS_DLVY); //V_STS_WAIT
			cs.setString(20, V_STS_WAIT); //V_STS_WAIT
			cs.setString(21, V_STS_APPROVERWAIT); //V_STS_APPROVERWAIT
			cs.setString(22, V_STS_RESULT); //V_STS_RESULT
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(23);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("OK_QTY", rs.getString("OK_QTY"));
				subObject.put("BAD_QTY", rs.getString("BAD_QTY"));
				subObject.put("INSP_FLAG", rs.getString("INSP_FLAG"));
				subObject.put("INSPDATE", rs.getString("INSP_DT"));
				subObject.put("INSPECTOR", rs.getString("INSPECTOR"));
				subObject.put("SAMPLE_QTY", rs.getString("SAMPLE_QTY"));
				subObject.put("HS_QCM_INS", rs.getString("QCM_INS"));
				subObject.put("WRITER", rs.getString("WRITER"));
				subObject.put("WRITERYN", rs.getString("WRITERYN"));
				subObject.put("APPDATE1", rs.getString("APPDATE1"));
				subObject.put("APPROVER", rs.getString("APPROVER"));
				subObject.put("APPROVERYN", rs.getString("APPROVERYN"));
				subObject.put("APPDATE2", rs.getString("APPDATE2"));
				subObject.put("FILE_CNT", rs.getString("FILE_CNT"));
				
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
		}
		
		// 팝업창 그리드 조회
		else if (V_TYPE.equals("WS")){
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_DLVY_AVL_DT = request.getParameter("V_DLVY_AVL_DT") == null ? "" : request.getParameter("V_DLVY_AVL_DT").toUpperCase();
			V_TYPE = "S";
			
// 			System.out.println("V_COMP_ID: " + V_COMP_ID);
// 			System.out.println("V_USR_ID: " + V_USR_ID);
// 			System.out.println("V_ASN_NO: " + V_ASN_NO);
// 			System.out.println("V_ITEM_CD: " + V_ITEM_CD);
// 			System.out.println("V_LOT_NO: " + V_LOT_NO);
// 			System.out.println("V_DLVY_AVL_DT: " + V_DLVY_AVL_DT);

			cs = conn.prepareCall("{call USP_Q_RESULT_SUPP_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_SL_CD); //V_SL_CD
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD
			cs.setString(5, V_LOT_NO); //V_LOT_NO
			cs.setString(6, ""); //V_INSPSEQ
			cs.setString(7, ""); //V_OBJ_ID
			cs.setString(8, ""); //V_INSPECTOR
			cs.setString(9, ""); //V_RESULT_YN
			cs.setString(10, ""); //V_VALUE1
			cs.setString(11, ""); //V_VALUE2
			cs.setString(12, ""); //V_VALUE3
			cs.setString(13, ""); //V_VALUE4
			cs.setString(14, ""); //V_VALUE5
			cs.setString(15, ""); //V_VALUE6
			cs.setString(16, ""); //V_VALUE7
			cs.setString(17, ""); //V_VALUE8
			cs.setString(18, ""); //V_VALUE9
			cs.setString(19, ""); //V_VALUE10
			cs.setString(20, V_USR_ID); //V_USR_ID
			cs.setString(21, V_DLVY_AVL_DT); //V_USR_ID
			cs.registerOutParameter(22, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(22);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("INSPSEQ", rs.getString("INSPSEQ"));
				subObject.put("OBJ_ID", rs.getString("OBJ_ID"));
				subObject.put("OBJ_DESC", rs.getString("OBJ_DESC"));
				subObject.put("LOW_VAL", rs.getString("LOW_VAL"));
				subObject.put("MID_VAL", rs.getString("MID_VAL"));
				subObject.put("UPP_VAL", rs.getString("UPP_VAL"));
				subObject.put("INSP_STD", rs.getString("INSP_STD"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("QCM_MEA", rs.getString("QCM_MEA"));
				subObject.put("QCM_MEA_NM", rs.getString("QCM_MEA_NM"));
				subObject.put("INSPECTOR", rs.getString("INSPECTOR"));
				subObject.put("RESULT_YN", rs.getString("RESULT_YN"));
				subObject.put("RESULT_YNNM", rs.getString("RESULT_YN"));
				subObject.put("VALUE1", rs.getString("VALUE1"));
				subObject.put("VALUE2", rs.getString("VALUE2"));
				subObject.put("VALUE3", rs.getString("VALUE3"));
				subObject.put("VALUE4", rs.getString("VALUE4"));
				subObject.put("VALUE5", rs.getString("VALUE5"));
				subObject.put("VALUE6", rs.getString("VALUE6"));
				subObject.put("VALUE7", rs.getString("VALUE7"));
				subObject.put("VALUE8", rs.getString("VALUE8"));
				subObject.put("VALUE9", rs.getString("VALUE9"));
				subObject.put("VALUE10", rs.getString("VALUE10"));
				subObject.put("WRITERYN", rs.getString("WRITERYN"));
				subObject.put("COM_DAT", rs.getString("COM_DAT"));

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
		}
		else if (V_TYPE.equals("U")){
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_LOT_NO = request.getParameter("V_LOT_NO") == null ? "" : request.getParameter("V_LOT_NO").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_HSTN_ITEM_CD = request.getParameter("V_HSTN_ITEM_CD") == null ? "" : request.getParameter("V_HSTN_ITEM_CD").toUpperCase();
			String V_DLVY_AVL_DT = request.getParameter("V_DLVY_AVL_DT") == null ? "" : request.getParameter("V_DLVY_AVL_DT").toUpperCase().substring(0,10);
			String V_OK_QTY = request.getParameter("V_OK_QTY") == null ? "0" : request.getParameter("V_OK_QTY").toUpperCase();
			String V_BAD_QTY = request.getParameter("V_BAD_QTY") == null ? "0" : request.getParameter("V_BAD_QTY").toUpperCase();
			String V_INSPECTOR = request.getParameter("V_INSPECTOR") == null ? "" : request.getParameter("V_INSPECTOR").toUpperCase();
			String V_INSP_DT = request.getParameter("V_INSP_DT") == null ? "" : request.getParameter("V_INSP_DT").toUpperCase().substring(0,10);
			String V_WRITER = request.getParameter("V_WRITER") == null ? "" : request.getParameter("V_WRITER").toUpperCase();	
			String V_WRITERYN = request.getParameter("V_WRITERYN") == null ? "" : request.getParameter("V_WRITERYN").toUpperCase();	
			String V_APPROVER = request.getParameter("V_APPROVER") == null ? "" : request.getParameter("V_APPROVER").toUpperCase();	
			String V_APPROVERYN = request.getParameter("V_APPROVERYN") == null ? "" : request.getParameter("V_APPROVERYN").toUpperCase();	

			if(V_WRITERYN.equals("TRUE")){
				V_WRITERYN = "Y";
			}
			else{
				V_WRITERYN = "N";
			}
			
			if(V_APPROVERYN.equals("TRUE")){
				V_APPROVERYN = "Y";
			}
			else{
				V_APPROVERYN = "N";
			}
			
			cs = conn.prepareCall("{call USP_Q_RESULT_SUPP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "I"); //V_TYPE
			cs.setString(2, V_SL_CD); //V_COMP_ID
			cs.setString(3, V_ASN_NO); //V_ASN_NO
			cs.setString(4, V_LOT_NO); //V_LOT_NO
			cs.setString(5, V_DLVY_AVL_DT); //V_DL_FR_DT
			cs.setString(6, ""); //V_DL_TO_DT
			cs.setString(7, V_ITEM_CD); //V_ITEM_CD
			cs.setString(8, V_HSTN_ITEM_CD); //V_HSTN_ITEM_CD
			cs.setString(9, V_INSP_DT); //V_INSP_DT
			cs.setString(10, ""); //V_INSP_FLAG
			cs.setString(11, V_OK_QTY); //V_OK_QTY
			cs.setString(12, V_BAD_QTY); //V_BAD_QTY
			cs.setString(13, V_INSPECTOR); //V_INSPECTOR
			cs.setString(14, V_WRITER); //V_WRITER
			cs.setString(15, V_WRITERYN); //V_WRITERYN
			cs.setString(16, V_APPROVER); //V_APPROVER
			cs.setString(17, V_APPROVERYN); //V_APPROVERYN
			cs.setString(18, V_USR_ID); //V_USR_ID
			cs.setString(19, ""); //V_STS_WAIT
			cs.setString(20, ""); //V_STS_WAIT
			cs.setString(21, ""); //V_STS_APPROVERWAIT
			cs.setString(22, ""); //V_STS_RESULT
			cs.registerOutParameter(23, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			
		}
			
		//팝업 검사결과, 측정값 저장.
		else if (V_TYPE.equals("WU")){
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
					
					String ASN_NO  = hashMap.get("ASN_NO") == null ? "" : hashMap.get("ASN_NO").toString();
					String LOT_NO  = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String ITEM_CD  = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String INSPSEQ  = hashMap.get("INSPSEQ") == null ? "" : hashMap.get("INSPSEQ").toString();
					String OBJ_ID  = hashMap.get("OBJ_ID") == null ? "" : hashMap.get("OBJ_ID").toString();
					String INSPECTOR  = hashMap.get("INSPECTOR") == null ? "" : hashMap.get("INSPECTOR").toString();
					String RESULT_YN  = hashMap.get("RESULT_YN") == null ? "" : hashMap.get("RESULT_YN").toString();
					String VALUE1 = hashMap.get("VALUE1") == null ? "" : (hashMap.get("VALUE1")).toString();
					String VALUE2 = hashMap.get("VALUE2") == null ? "" : (hashMap.get("VALUE2")).toString();
					String VALUE3 = hashMap.get("VALUE3") == null ? "" : (hashMap.get("VALUE3")).toString();
					String VALUE4 = hashMap.get("VALUE4") == null ? "" : (hashMap.get("VALUE4")).toString();
					String VALUE5 = hashMap.get("VALUE5") == null ? "" : (hashMap.get("VALUE5")).toString();
					String VALUE6 = hashMap.get("VALUE6") == null ? "" : (hashMap.get("VALUE6")).toString();
					String VALUE7 = hashMap.get("VALUE7") == null ? "" : (hashMap.get("VALUE7")).toString();
					String VALUE8 = hashMap.get("VALUE8") == null ? "" : (hashMap.get("VALUE8")).toString();
					String VALUE9 = hashMap.get("VALUE9") == null ? "" : (hashMap.get("VALUE9")).toString();
					String VALUE10 = hashMap.get("VALUE10") == null ? "" : (hashMap.get("VALUE10")).toString();
					String V_DLVY_AVL_DT = request.getParameter("V_DLVY_AVL_DT") == null ? "" : request.getParameter("V_DLVY_AVL_DT").toUpperCase().substring(0,10);
					
					V_TYPE = "I";
					
					cs = conn.prepareCall("{call USP_Q_RESULT_SUPP_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, V_TYPE); //V_TYPE
					cs.setString(2, V_SL_CD); //V_SL_CD
					cs.setString(3, ASN_NO); //V_ASN_NO
					cs.setString(4, ITEM_CD); //V_ITEM_CD
					cs.setString(5, LOT_NO); //V_LOT_NO
					cs.setString(6, INSPSEQ); //V_INSPSEQ
					cs.setString(7, OBJ_ID); //V_OBJ_ID
					cs.setString(8, INSPECTOR); //V_INSPECTOR
					cs.setString(9, RESULT_YN); //V_RESULT_YN
					cs.setString(10, VALUE1); //V_VALUE1
					cs.setString(11, VALUE2); //V_VALUE2
					cs.setString(12, VALUE3); //V_VALUE3
					cs.setString(13, VALUE4); //V_VALUE4
					cs.setString(14, VALUE5); //V_VALUE5
					cs.setString(15, VALUE6); //V_VALUE6
					cs.setString(16, VALUE7); //V_VALUE7
					cs.setString(17, VALUE8); //V_VALUE8
					cs.setString(18, VALUE9); //V_VALUE9
					cs.setString(19, VALUE10); //V_VALUE10
					cs.setString(20, V_USR_ID); //V_USR_ID
					cs.setString(21, V_DLVY_AVL_DT); //V_USR_ID
					cs.registerOutParameter(22, com.tmax.tibero.TbTypes.CURSOR);
					
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String ASN_NO  = jsondata.get("ASN_NO") == null ? "" : jsondata.get("ASN_NO").toString();
				String LOT_NO  = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String ITEM_CD  = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String INSPSEQ  = jsondata.get("INSPSEQ") == null ? "" : jsondata.get("INSPSEQ").toString();
				String OBJ_ID  = jsondata.get("OBJ_ID") == null ? "" : jsondata.get("OBJ_ID").toString();
				String INSPECTOR  = jsondata.get("INSPECTOR") == null ? "" : jsondata.get("INSPECTOR").toString();
				String RESULT_YN  = jsondata.get("RESULT_YN") == null ? "" : jsondata.get("RESULT_YN").toString();
				String VALUE1 = jsondata.get("VALUE1") == null ? "" : (jsondata.get("VALUE1")).toString();
				String VALUE2 = jsondata.get("VALUE2") == null ? "" : (jsondata.get("VALUE2")).toString();
				String VALUE3 = jsondata.get("VALUE3") == null ? "" : (jsondata.get("VALUE3")).toString();
				String VALUE4 = jsondata.get("VALUE4") == null ? "" : (jsondata.get("VALUE4")).toString();
				String VALUE5 = jsondata.get("VALUE5") == null ? "" : (jsondata.get("VALUE5")).toString();
				String VALUE6 = jsondata.get("VALUE6") == null ? "" : (jsondata.get("VALUE6")).toString();
				String VALUE7 = jsondata.get("VALUE7") == null ? "" : (jsondata.get("VALUE7")).toString();
				String VALUE8 = jsondata.get("VALUE8") == null ? "" : (jsondata.get("VALUE8")).toString();
				String VALUE9 = jsondata.get("VALUE9") == null ? "" : (jsondata.get("VALUE9")).toString();
				String VALUE10 = jsondata.get("VALUE10") == null ? "" : (jsondata.get("VALUE10")).toString();
				String V_DLVY_AVL_DT = request.getParameter("V_DLVY_AVL_DT") == null ? "" : request.getParameter("V_DLVY_AVL_DT").toUpperCase().substring(0,10);

				V_TYPE = "I";

				cs = conn.prepareCall("{call USP_Q_RESULT_SUPP_DTL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, V_TYPE); //V_TYPE
				cs.setString(2, V_SL_CD); //V_SL_CD
				cs.setString(3, ASN_NO); //V_ASN_NO
				cs.setString(4, ITEM_CD); //V_ITEM_CD
				cs.setString(5, LOT_NO); //V_LOT_NO
				cs.setString(6, INSPSEQ); //V_INSPSEQ
				cs.setString(7, OBJ_ID); //V_OBJ_ID
				cs.setString(8, INSPECTOR); //V_INSPECTOR
				cs.setString(9, RESULT_YN); //V_RESULT_YN
				cs.setString(10, VALUE1); //V_VALUE1
				cs.setString(11, VALUE2); //V_VALUE2
				cs.setString(12, VALUE3); //V_VALUE3
				cs.setString(13, VALUE4); //V_VALUE4
				cs.setString(14, VALUE5); //V_VALUE5
				cs.setString(15, VALUE6); //V_VALUE6
				cs.setString(16, VALUE7); //V_VALUE7
				cs.setString(17, VALUE8); //V_VALUE8
				cs.setString(18, VALUE9); //V_VALUE9
				cs.setString(19, VALUE10); //V_VALUE10
				cs.setString(20, V_USR_ID); //V_USR_ID
				cs.setString(21, V_DLVY_AVL_DT); //V_USR_ID
				cs.registerOutParameter(22, com.tmax.tibero.TbTypes.CURSOR);
				
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


