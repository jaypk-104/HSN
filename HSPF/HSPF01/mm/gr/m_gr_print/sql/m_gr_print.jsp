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
		


		//바코드 분할 상단
		if (V_TYPE.equals("S")) {
// 			System.out.println("SS");
			String V_AVL_DT_FR = request.getParameter("V_AVL_DT_FR") == null ? "" : request.getParameter("V_AVL_DT_FR").substring(0,10);
			String V_AVL_DT_TO = request.getParameter("V_AVL_DT_TO") == null ? "" : request.getParameter("V_AVL_DT_TO").substring(0,10);
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_HOPE_SL_CD = request.getParameter("V_HOPE_SL_CD") == null ? "" : request.getParameter("V_HOPE_SL_CD").toUpperCase();
			if(V_HOPE_SL_CD.equals("T")){
				V_HOPE_SL_CD = "";
			}
			
			cs = conn.prepareCall("call USP_M_GR_PRINT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_BP_CD); //V_BP_CD
			cs.setString(4, V_ITEM_CD); //V_ITEM_CD
			cs.setString(5, V_AVL_DT_FR); //V_AVL_DT_FR
			cs.setString(6, V_AVL_DT_TO); //V_AVL_DT_TO
			cs.setString(7, V_HOPE_SL_CD); //V_HOPE_SL_CD
			cs.setString(8, V_USR_ID); //V_USR_ID
			cs.setString(9, ""); //V_MD_NO 출고지시번호
			cs.setString(10, ""); //V_PO_NO
			cs.setString(11, ""); //V_PO_SEQ
			cs.setString(12, ""); //V_ASN_NO
			
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PRINT_NO", rs.getString("PRINT_NO"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("PRINT_YN", rs.getString("PRINT_YN"));

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
		
		
		//지시번호 채번
		else if (V_TYPE.equals("N")){
// 			String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO") == null ? "" : request.getParameter("V_LOT_BC_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_GR_PRINT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, ""); //V_BP_CD
			cs.setString(4, ""); //V_ITEM_CD
			cs.setString(5, ""); //V_AVL_DT_FR
			cs.setString(6, ""); //V_AVL_DT_TO
			cs.setString(7, ""); //V_HOPE_SL_CD
			cs.setString(8, V_USR_ID); //V_USR_ID
			cs.setString(9, ""); //V_MD_NO 출고지시번호
			cs.setString(10, ""); //V_PO_NO
			cs.setString(11, ""); //V_PO_SEQ
			cs.setString(12, ""); //V_ASN_NO
			
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("V_MD_NO", rs.getString(1));

				jsonArray.add(subObject);
			}
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonArray);
			pw.flush();
			pw.close();
		}
		
		//출력버튼 누르고 채번 후 업데이트.
		else if (V_TYPE.equals("I")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_MD_NO = request.getParameter("V_MD_NO") == null ? "" : request.getParameter("V_MD_NO");
					String PO_NO  = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String PO_SEQ  = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String ASN_NO  = hashMap.get("ASN_NO") == null ? "" : hashMap.get("ASN_NO").toString();
					
					if(V_TYPE.equals("I")){
						cs = conn.prepareCall("call USP_M_GR_PRINT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_COMP_ID);
						cs.setString(3, ""); //V_BP_CD
						cs.setString(4, ""); //V_ITEM_CD
						cs.setString(5, ""); //V_AVL_DT_FR
						cs.setString(6, ""); //V_AVL_DT_TO
						cs.setString(7, ""); //V_HOPE_SL_CD
						cs.setString(8, V_USR_ID); //V_USR_ID
						cs.setString(9, V_MD_NO); //V_MD_NO 출고지시번호
						cs.setString(10, PO_NO); //V_PO_NO
						cs.setString(11, PO_SEQ); //V_PO_SEQ
						cs.setString(12, ASN_NO); //V_ASN_NO
						
						cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String V_MD_NO = request.getParameter("V_MD_NO") == null ? "" : request.getParameter("V_MD_NO");
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String PO_NO  = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String PO_SEQ  = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String ASN_NO  = jsondata.get("ASN_NO") == null ? "" : jsondata.get("ASN_NO").toString();
				
				if(V_TYPE.equals("I")){
					cs = conn.prepareCall("call USP_M_GR_PRINT(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, ""); //V_BP_CD
					cs.setString(4, ""); //V_ITEM_CD
					cs.setString(5, ""); //V_AVL_DT_FR
					cs.setString(6, ""); //V_AVL_DT_TO
					cs.setString(7, ""); //V_HOPE_SL_CD
					cs.setString(8, V_USR_ID); //V_USR_ID
					cs.setString(9, V_MD_NO); //V_MD_NO 출고지시번호
					cs.setString(10, PO_NO); //V_PO_NO
					cs.setString(11, PO_SEQ); //V_PO_SEQ
					cs.setString(12, ASN_NO); //V_ASN_NO
					
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				
			}
		}
			
		//바코드 분할 확정.
		else if (V_TYPE.equals("DC")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String TO_LOT_BC_NO  = hashMap.get("TO_LOT_BC_NO") == null ? "" : hashMap.get("TO_LOT_BC_NO").toString();
					String V_ID_NO = request.getParameter("V_ID_NO") == null ? "" : request.getParameter("V_ID_NO").toUpperCase();
					
					if(V_TYPE.equals("DC")){
						cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);
						cs.setString(2, V_TYPE);
						cs.setString(3, ""); //V_BC_NO
						cs.setString(4, ""); //V_ID_DT_FR
						cs.setString(5, ""); //V_ID_DT_TO
						cs.setString(6, ""); //V_SL_CD
						cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
						cs.setString(8, V_ID_NO); //V_ID_NO
						cs.setString(9, ""); //V_ID_DT
						cs.setString(10, ""); //V_CHNG_QTY
						cs.setString(11, V_USR_ID);
						
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String TO_LOT_BC_NO  = jsondata.get("TO_LOT_BC_NO") == null ? "" : jsondata.get("TO_LOT_BC_NO").toString();
				String V_ID_NO = request.getParameter("V_ID_NO") == null ? "" : request.getParameter("V_ID_NO").toUpperCase();
				
				if(V_TYPE.equals("DC")){
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_TYPE);
					cs.setString(3, ""); //V_BC_NO
					cs.setString(4, ""); //V_ID_DT_FR
					cs.setString(5, ""); //V_ID_DT_TO
					cs.setString(6, ""); //V_SL_CD
					cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(8, V_ID_NO); //V_ID_NO
					cs.setString(9, ""); //V_ID_DT
					cs.setString(10, ""); //V_CHNG_QTY
					cs.setString(11, V_USR_ID);
					
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				

			}
		}
			
		//아래쪽 그리드 행 삭제.
		else if (V_TYPE.equals("DD")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String TO_LOT_BC_NO  = hashMap.get("TO_LOT_BC_NO") == null ? "" : hashMap.get("TO_LOT_BC_NO").toString();
					
					if(V_TYPE.equals("DD")){
						cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);
						cs.setString(2, V_TYPE);
						cs.setString(3, ""); //V_BC_NO
						cs.setString(4, ""); //V_ID_DT_FR
						cs.setString(5, ""); //V_ID_DT_TO
						cs.setString(6, ""); //V_SL_CD
						cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
						cs.setString(8, ""); //V_ID_NO
						cs.setString(9, ""); //V_ID_DT
						cs.setString(10, ""); //V_CHNG_QTY
						cs.setString(11, V_USR_ID);
						
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String TO_LOT_BC_NO  = jsondata.get("TO_LOT_BC_NO") == null ? "" : jsondata.get("TO_LOT_BC_NO").toString();
				
				if(V_TYPE.equals("DD")){
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_TYPE);
					cs.setString(3, ""); //V_BC_NO
					cs.setString(4, ""); //V_ID_DT_FR
					cs.setString(5, ""); //V_ID_DT_TO
					cs.setString(6, ""); //V_SL_CD
					cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(8, ""); //V_ID_NO
					cs.setString(9, ""); //V_ID_DT
					cs.setString(10, ""); //V_CHNG_QTY
					cs.setString(11, V_USR_ID);
					
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				
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


