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


		//바코드수정및재발행 조회
		if (V_TYPE.equals("S")) {
// 			System.out.println("SS");
			String V_DLV_DT_FR = request.getParameter("V_DLV_DT_FR") == null ? "" : request.getParameter("V_DLV_DT_FR").substring(0,10);
			String V_DLV_DT_TO = request.getParameter("V_ID_DT_TO") == null ? "" : request.getParameter("V_DLV_DT_TO").substring(0,10);
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
// 			String V_PAL_BC_NO = request.getParameter("V_PAL_BC_NO") == null ? "" : request.getParameter("V_PAL_BC_NO").toUpperCase();
// 			String V_BOX_BC_NO = request.getParameter("V_BOX_BC_NO") == null ? "" : request.getParameter("V_BOX_BC_NO").toUpperCase();
// 			String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO") == null ? "" : request.getParameter("V_LOT_BC_NO").toUpperCase();
			String V_BC_NO = request.getParameter("V_BC_NO") == null ? "" : request.getParameter("V_BC_NO").toUpperCase();
			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			String V_LOT_YN = request.getParameter("V_LOT_YN") == null ? "" : request.getParameter("V_LOT_YN").toUpperCase();
			String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();
			String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();

			
			System.out.println(V_LOT_YN);
			cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID); //V_COMP_ID
			cs.setString(2, V_TYPE); //V_TYPE
			cs.setString(3, V_ITEM_CD); //V_ITEM_CD
			cs.setString(4, V_ITEM_NM); //V_ITEM_NM
			cs.setString(5, V_DLV_DT_FR); //V_DLV_DT_FR
			cs.setString(6, V_DLV_DT_TO); //V_DLV_DT_TO
			cs.setString(7, ""); //V_FR_SL_CD
			cs.setString(8, V_BC_NO); //V_PAL_BC_NO 자리에 V_BC_NO 를 사용해 바코드 통합검색. 20180711 김장운.
			cs.setString(9, ""); //V_BOX_BC_NO
			cs.setString(10, ""); //V_LOT_BC_NO
			cs.setString(11, ""); //V_CHNG_LOT_NO
			cs.setString(12, ""); //V_CHNG_MAKE_DT
			cs.setString(13, ""); //V_CHNG_VALID_DT
			cs.setString(14, V_BL_NO); //V_CHNG_SL_CD 자리에 임시로 V_BL_NO로 사용함. 20180628 김장운.
			cs.setString(15, ""); //V_CHNG_QTY
			cs.setString(16, V_PO_NO); //V_PO_NO
			cs.setString(17, V_ASN_NO); //V_ASN_NO
			cs.setString(18, V_LOT_YN); //V_LOT_YN
			cs.setString(19, V_M_BP_CD); //V_USR_ID  공급사 검색을 위한 임시 변수로 사용
			
			cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(20);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("PAL_QTY", rs.getString("PAL_QTY"));
				subObject.put("REMAIN_QTY", rs.getString("REMAIN_QTY"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("PRINT_CNT", rs.getString("PRINT_CNT"));
				subObject.put("GR_SL_CD", rs.getString("GR_SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("GR_RACK_CD", rs.getString("GR_RACK_CD"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
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
		
		else if (V_TYPE.equals("SYNC")){
			request.setCharacterEncoding("utf-8");
// 			String data = request.getParameter("data");
// 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String V_LOT_BC_NO  = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					String V_CHNG_LOT_NO  = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
					String V_CHNG_MAKE_DT  = hashMap.get("MAKE_DT") == null ? "" : hashMap.get("MAKE_DT").toString().substring(0,10);
					String V_CHNG_VALID_DT  = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0,10);
					
					cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID
					cs.setString(2, V_TYPE); //V_TYPE
					cs.setString(3, ""); //V_ITEM_CD
					cs.setString(4, ""); //V_ITEM_NM
					cs.setString(5, ""); //V_DLV_DT_FR
					cs.setString(6, ""); //V_DLV_DT_TO
					cs.setString(7, ""); //V_FR_SL_CD
					cs.setString(8, ""); //V_PAL_BC_NO
					cs.setString(9, ""); //V_BOX_BC_NO
					cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
					cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
					cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
					cs.setString(14, ""); //V_CHNG_SL_CD
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(16, ""); //V_USR_ID
					cs.setString(17, ""); //V_USR_ID
					cs.setString(18, ""); //V_LOT_YN
					cs.setString(19, ""); //V_USR_ID
					
					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
					
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_LOT_BC_NO  = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
				String V_CHNG_LOT_NO  = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
				String V_CHNG_MAKE_DT  = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString().substring(0,10);
				String V_CHNG_VALID_DT  = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0,10);
				
				if(V_TYPE.equals("U")){
					cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID); //V_COMP_ID
					cs.setString(2, V_TYPE); //V_TYPE
					cs.setString(3, ""); //V_ITEM_CD
					cs.setString(4, ""); //V_ITEM_NM
					cs.setString(5, ""); //V_DLV_DT_FR
					cs.setString(6, ""); //V_DLV_DT_TO
					cs.setString(7, ""); //V_FR_SL_CD
					cs.setString(8, ""); //V_PAL_BC_NO
					cs.setString(9, ""); //V_BOX_BC_NO
					cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
					cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
					cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
					cs.setString(14, ""); //V_CHNG_SL_CD
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(15, ""); //V_CHNG_QTY
					cs.setString(16, ""); //V_USR_ID
					cs.setString(17, ""); //V_USR_ID
					cs.setString(18, ""); //V_LOT_YN
					cs.setString(19, ""); //V_USR_ID
					
					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				
			}
		}
		
// 		//그리드 업데이트.
// 		else if (V_TYPE.equals("U")){
// 			request.setCharacterEncoding("utf-8");
// // 			String data = request.getParameter("data");
// // 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
// 			String[] findList = { "#", "+", "&", "%", " " };
// 			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
// 			String data = request.getParameter("data");
// 			data = StringUtils.replaceEach(data, findList, replList);
// 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
// 			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
// 				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
// 				for (int i = 0; i < jsonAr.size(); i++) {
// 					HashMap hashMap = (HashMap) jsonAr.get(i);
// 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
// 					String V_LOT_BC_NO  = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
// 					String V_CHNG_LOT_NO  = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
// 					String V_CHNG_MAKE_DT  = hashMap.get("MAKE_DT") == null ? "" : hashMap.get("MAKE_DT").toString().substring(0,10);
// 					String V_CHNG_VALID_DT  = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0,10);
					
// 					if(V_TYPE.equals("U")){
// 						cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 						cs.setString(1, V_COMP_ID); //V_COMP_ID
// 						cs.setString(2, V_TYPE); //V_TYPE
// 						cs.setString(3, ""); //V_ITEM_CD
// 						cs.setString(4, ""); //V_ITEM_NM
// 						cs.setString(5, ""); //V_DLV_DT_FR
// 						cs.setString(6, ""); //V_DLV_DT_TO
// 						cs.setString(7, ""); //V_FR_SL_CD
// 						cs.setString(8, ""); //V_PAL_BC_NO
// 						cs.setString(9, ""); //V_BOX_BC_NO
// 						cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
// 						cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
// 						cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
// 						cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
// 						cs.setString(14, ""); //V_CHNG_SL_CD
// 						cs.setString(15, ""); //V_CHNG_QTY
// 						cs.setString(15, ""); //V_CHNG_QTY
// 						cs.setString(15, ""); //V_CHNG_QTY
// 						cs.setString(16, ""); //V_USR_ID
// 						cs.setString(17, ""); //V_USR_ID
// 						cs.setString(18, ""); //V_LOT_YN
// 						cs.setString(19, ""); //V_USR_ID
						
// 						cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
// 						cs.executeQuery();
// 					}
					
// 				}
// 			}
// 			else{
// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
// 				String V_LOT_BC_NO  = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
// 				String V_CHNG_LOT_NO  = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
// 				String V_CHNG_MAKE_DT  = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString().substring(0,10);
// 				String V_CHNG_VALID_DT  = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0,10);
				
// 				System.out.println("asdf0");
// 				if(V_TYPE.equals("U")){
// 					cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 					cs.setString(1, V_COMP_ID); //V_COMP_ID
// 					cs.setString(2, V_TYPE); //V_TYPE
// 					cs.setString(3, ""); //V_ITEM_CD
// 					cs.setString(4, ""); //V_ITEM_NM
// 					cs.setString(5, ""); //V_DLV_DT_FR
// 					cs.setString(6, ""); //V_DLV_DT_TO
// 					cs.setString(7, ""); //V_FR_SL_CD
// 					cs.setString(8, ""); //V_PAL_BC_NO
// 					cs.setString(9, ""); //V_BOX_BC_NO
// 					cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
// 					cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
// 					cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
// 					cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
// 					cs.setString(14, ""); //V_CHNG_SL_CD
// 					cs.setString(15, ""); //V_CHNG_QTY
// 					cs.setString(15, ""); //V_CHNG_QTY
// 					cs.setString(15, ""); //V_CHNG_QTY
// 					cs.setString(16, ""); //V_USR_ID
// 					cs.setString(17, ""); //V_USR_ID
// 					cs.setString(18, ""); //V_LOT_YN
// 					cs.setString(19, ""); //V_USR_ID
					
// 					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
// 					cs.executeQuery();
// 				}
				
// 			}
// 		}
// 		//바코드 출력.
// 		else if (V_TYPE.equals("P")){
// 			request.setCharacterEncoding("utf-8");
			
// 			String[] findList = { "#", "+", "&", "%", " " };
// 			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };
			
// 			String data = request.getParameter("data");
// 			data = StringUtils.replaceEach(data, findList, replList);
// 			String jsonData = URLDecoder.decode(data, "UTF-8");
			
// 			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
// 				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
// 				for (int i = 0; i < jsonAr.size(); i++) {
// 					HashMap hashMap = (HashMap) jsonAr.get(i);
// 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
// 					String V_LOT_BC_NO  = hashMap.get("LOT_BC_NO") == null ? "" : hashMap.get("LOT_BC_NO").toString();
					
// 					if(V_TYPE.equals("P")){
// 						cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 						cs.setString(1, V_COMP_ID); //V_COMP_ID
// 						cs.setString(2, V_TYPE); //V_TYPE
// 						cs.setString(3, ""); //V_ITEM_CD
// 						cs.setString(4, ""); //V_ITEM_NM
// 						cs.setString(5, ""); //V_DLV_DT_FR
// 						cs.setString(6, ""); //V_DLV_DT_TO
// 						cs.setString(7, ""); //V_FR_SL_CD
// 						cs.setString(8, ""); //V_PAL_BC_NO
// 						cs.setString(9, ""); //V_BOX_BC_NO
// 						cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
// 						cs.setString(11, ""); //V_CHNG_LOT_NO
// 						cs.setString(12, ""); //V_CHNG_MAKE_DT
// 						cs.setString(13, ""); //V_CHNG_VALID_DT
// 						cs.setString(14, ""); //V_CHNG_SL_CD
// 						cs.setString(15, ""); //V_CHNG_QTY
// 						cs.setString(16, ""); //V_USR_ID
// 						cs.setString(17, ""); //V_USR_ID
// 						cs.setString(18, ""); //V_LOT_YN
// 						cs.setString(19, ""); //V_USR_ID
						
// 						cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
// 						cs.executeQuery();
// 					}
					
// 				}
// 			}
// 			else{
// 				JSONObject jsondata = JSONObject.fromObject(jsonData);
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
// 				String V_LOT_BC_NO  = jsondata.get("LOT_BC_NO") == null ? "" : jsondata.get("LOT_BC_NO").toString();
// 				System.out.println(V_LOT_BC_NO);
// 				System.out.println(V_TYPE);
// 				if(V_TYPE.equals("P")){
// 					System.out.println(V_LOT_BC_NO);
// 					cs = conn.prepareCall("call USP_I_BARCD_REPRINT2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 					cs.setString(1, V_COMP_ID); //V_COMP_ID
// 					cs.setString(2, V_TYPE); //V_TYPE
// 					cs.setString(3, ""); //V_ITEM_CD
// 					cs.setString(4, ""); //V_ITEM_NM
// 					cs.setString(5, ""); //V_DLV_DT_FR
// 					cs.setString(6, ""); //V_DLV_DT_TO
// 					cs.setString(7, ""); //V_FR_SL_CD
// 					cs.setString(8, ""); //V_PAL_BC_NO
// 					cs.setString(9, ""); //V_BOX_BC_NO
// 					cs.setString(10, V_LOT_BC_NO); //V_LOT_BC_NO
// 					cs.setString(11, ""); //V_CHNG_LOT_NO
// 					cs.setString(12, ""); //V_CHNG_MAKE_DT
// 					cs.setString(13, ""); //V_CHNG_VALID_DT
// 					cs.setString(14, ""); //V_CHNG_SL_CD
// 					cs.setString(15, ""); //V_CHNG_QTY
// 					cs.setString(16, ""); //V_USR_ID
// 					cs.setString(17, ""); //V_USR_ID
// 					cs.setString(18, ""); //V_LOT_YN
// 					cs.setString(19, ""); //V_USR_ID
					
// 					cs.registerOutParameter(20, com.tmax.tibero.TbTypes.CURSOR);
// 					cs.executeQuery();
// 				}
				
// 			}
// 		}
					
			

		
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


