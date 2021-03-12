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

		//바코드 분할 상단 그리드 조회
		if (V_TYPE.equals("SS")) {
// 			System.out.println("SS");
			String V_ID_DT_FR = request.getParameter("V_ID_DT_FR") == null ? "" : request.getParameter("V_ID_DT_FR").substring(0,10);
			String V_ID_DT_TO = request.getParameter("V_ID_DT_TO") == null ? "" : request.getParameter("V_ID_DT_TO").substring(0,10);
			String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
			if (V_SL_CD.equals("T")){
				V_SL_CD = "";
			}
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
			cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, V_TYPE);
			cs.setString(3, V_ITEM_CD); //V_BC_NO  임시로 V_ITEM_CD 로 사용. 20180628 김장운.
			cs.setString(4, V_ID_DT_FR);
			cs.setString(5, V_ID_DT_TO);
			cs.setString(6, V_SL_CD);
			cs.setString(7, V_ITEM_NM); //V_LOT_BC_NO 임시로 V_ITEM_NM 로 사용. 20180628 김장운.
			cs.setString(8, V_BL_NO); //V_ID_NO  임시로 V_BL_NO 로 사용. 20180628 김장운.
			cs.setString(9, ""); //V_ID_DT
			cs.setString(10, ""); //V_CHNG_QTY
			cs.setString(11, ""); //V_CHNG_LOT_NO
			cs.setString(12, ""); //V_CHNG_MAKE_DT
			cs.setString(13, ""); //V_CHNG_VALID_DT
			cs.setString(14, ""); //V_GR_NO
			cs.setString(15, ""); //V_GR_SEQ
			cs.setString(16, V_USR_ID);
			
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ID_NO", rs.getString("ID_NO"));
				subObject.put("ID_SEQ", rs.getString("ID_SEQ"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_BC_QTY", rs.getString("BOX_BC_QTY"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_BC_QTY", rs.getString("LOT_BC_QTY"));
				subObject.put("DIV_YN", rs.getString("DIV_YN"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("DIV_YN", rs.getString("DIV_YN"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("GR_SEQ", rs.getString("GR_SEQ"));

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
		
		// 그리드 클릭시 하단 검색
		else if (V_TYPE.equals("SD")){
			String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO") == null ? "" : request.getParameter("V_LOT_BC_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);
			cs.setString(2, V_TYPE);
			cs.setString(3, ""); //V_BC_NO
			cs.setString(4, ""); //V_ID_DT_FR
			cs.setString(5, ""); //V_ID_DT_TO
			cs.setString(6, ""); //V_SL_CD
			cs.setString(7, V_LOT_BC_NO); //V_LOT_BC_NO
			cs.setString(8, ""); //V_ID_NO
			cs.setString(9, ""); //V_ID_DT
			cs.setString(10, ""); //V_CHNG_QTY
			cs.setString(11, ""); //V_CHNG_LOT_NO
			cs.setString(12, ""); //V_CHNG_MAKE_DT
			cs.setString(13, ""); //V_CHNG_VALID_DT
			cs.setString(14, ""); //V_GR_NO
			cs.setString(15, ""); //V_GR_SEQ
			cs.setString(16, V_USR_ID);
			
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(17);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("TO_BOX_BC_NO", rs.getString("TO_BOX_BC_NO"));
				subObject.put("TO_LOT_BC_NO", rs.getString("TO_LOT_BC_NO"));
				subObject.put("TO_LOT_QTY", rs.getString("TO_LOT_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));

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
		
		//바코드 분할. 아래쪽 그리드에 추가됨
		else if (V_TYPE.equals("DI")){
			String V_LOT_BC_NO = request.getParameter("V_LOT_BC_NO") == null ? "" : request.getParameter("V_LOT_BC_NO").toUpperCase();
			String count = request.getParameter("count") == null ? "" : request.getParameter("count");
			int loopCount = Integer.parseInt(count);
			for( int i = 0 ; i < loopCount ; i ++){
				cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);
				cs.setString(2, V_TYPE);
				cs.setString(3, ""); //V_BC_NO
				cs.setString(4, ""); //V_ID_DT_FR
				cs.setString(5, ""); //V_ID_DT_TO
				cs.setString(6, ""); //V_SL_CD
				cs.setString(7, V_LOT_BC_NO); //V_LOT_BC_NO
				cs.setString(8, ""); //V_ID_NO
				cs.setString(9, ""); //V_ID_DT
				cs.setString(10, ""); //V_CHNG_QTY
				cs.setString(11, ""); //V_CHNG_LOT_NO
				cs.setString(12, ""); //V_CHNG_MAKE_DT
				cs.setString(13, ""); //V_CHNG_VALID_DT
				cs.setString(14, ""); //V_GR_NO
				cs.setString(15, ""); //V_GR_SEQ
				cs.setString(16, V_USR_ID);
				
				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
		}
		
		//아래쪽 그리드 업데이트.
		else if (V_TYPE.equals("DU")){
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
// 					V_TYPE  = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					String TO_LOT_BC_NO  = hashMap.get("TO_LOT_BC_NO") == null ? "" : hashMap.get("TO_LOT_BC_NO").toString();
					String TO_LOT_QTY  = hashMap.get("TO_LOT_QTY") == null ? "" : hashMap.get("TO_LOT_QTY").toString();
					
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_TYPE);
					cs.setString(3, ""); //V_BC_NO
					cs.setString(4, ""); //V_ID_DT_FR
					cs.setString(5, ""); //V_ID_DT_TO
					cs.setString(6, ""); //V_SL_CD
					cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
					cs.setString(8, ""); //V_ID_NO
					cs.setString(9, ""); //V_ID_DT
					cs.setString(10, TO_LOT_QTY); //V_CHNG_QTY
					cs.setString(11, ""); //V_CHNG_LOT_NO
					cs.setString(12, ""); //V_CHNG_MAKE_DT
					cs.setString(13, ""); //V_CHNG_VALID_DT
					cs.setString(14, ""); //V_GR_NO
					cs.setString(15, ""); //V_GR_SEQ
					cs.setString(16, V_USR_ID);
					
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
// 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String TO_LOT_BC_NO  = jsondata.get("TO_LOT_BC_NO") == null ? "" : jsondata.get("TO_LOT_BC_NO").toString();
				String TO_LOT_QTY  = jsondata.get("TO_LOT_QTY") == null ? "" : jsondata.get("TO_LOT_QTY").toString();
				
				cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);
				cs.setString(2, V_TYPE);
				cs.setString(3, ""); //V_BC_NO
				cs.setString(4, ""); //V_ID_DT_FR
				cs.setString(5, ""); //V_ID_DT_TO
				cs.setString(6, ""); //V_SL_CD
				cs.setString(7, TO_LOT_BC_NO); //V_LOT_BC_NO
				cs.setString(8, ""); //V_ID_NO
				cs.setString(9, ""); //V_ID_DT
				cs.setString(10, TO_LOT_QTY); //V_CHNG_QTY
				cs.setString(11, ""); //V_CHNG_LOT_NO
				cs.setString(12, ""); //V_CHNG_MAKE_DT
				cs.setString(13, ""); //V_CHNG_VALID_DT
				cs.setString(14, ""); //V_GR_NO
				cs.setString(15, ""); //V_GR_SEQ
				cs.setString(16, V_USR_ID);
				
				cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
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
					String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO").toUpperCase();
					String V_GR_SEQ = request.getParameter("V_GR_SEQ") == null ? "" : request.getParameter("V_GR_SEQ").toUpperCase();
					
					if(V_TYPE.equals("DC")){
						cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
						cs.setString(11, ""); //V_CHNG_LOT_NO
						cs.setString(12, ""); //V_CHNG_MAKE_DT
						cs.setString(13, ""); //V_CHNG_VALID_DT
						cs.setString(14, V_GR_NO); //V_GR_NO
						cs.setString(15, V_GR_SEQ); //V_GR_SEQ
						cs.setString(16, V_USR_ID);
						
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						V_TYPE = "DL";
						String V_CHNG_LOT_NO  = hashMap.get("LOT_NO") == null ? "" : hashMap.get("LOT_NO").toString();
						String V_CHNG_MAKE_DT  = hashMap.get("MAKE_DT") == null ? "" : hashMap.get("MAKE_DT").toString().substring(0,10);
						String V_CHNG_VALID_DT  = hashMap.get("VALID_DT") == null ? "" : hashMap.get("VALID_DT").toString().substring(0,10);
						
						cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
						cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
						cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
						cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
						cs.setString(14, ""); //V_GR_NO
						cs.setString(15, ""); //V_GR_SEQ
						cs.setString(16, V_USR_ID);
						
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String TO_LOT_BC_NO  = jsondata.get("TO_LOT_BC_NO") == null ? "" : jsondata.get("TO_LOT_BC_NO").toString();
				String V_ID_NO = request.getParameter("V_ID_NO") == null ? "" : request.getParameter("V_ID_NO").toUpperCase();
				String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO").toUpperCase();
				String V_GR_SEQ = request.getParameter("V_GR_SEQ") == null ? "" : request.getParameter("V_GR_SEQ").toUpperCase();
				
				if(V_TYPE.equals("DC")){
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					cs.setString(11, ""); //V_CHNG_LOT_NO
					cs.setString(12, ""); //V_CHNG_MAKE_DT
					cs.setString(13, ""); //V_CHNG_VALID_DT
					cs.setString(14, V_GR_NO); //V_GR_NO
					cs.setString(15, V_GR_SEQ); //V_GR_SEQ
					cs.setString(16, V_USR_ID);
					
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
					
					V_TYPE = "DL";
					String V_CHNG_LOT_NO  = jsondata.get("LOT_NO") == null ? "" : jsondata.get("LOT_NO").toString();
					String V_CHNG_MAKE_DT  = jsondata.get("MAKE_DT") == null ? "" : jsondata.get("MAKE_DT").toString().substring(0,10);
					String V_CHNG_VALID_DT  = jsondata.get("VALID_DT") == null ? "" : jsondata.get("VALID_DT").toString().substring(0,10);
					
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					cs.setString(11, V_CHNG_LOT_NO); //V_CHNG_LOT_NO
					cs.setString(12, V_CHNG_MAKE_DT); //V_CHNG_MAKE_DT
					cs.setString(13, V_CHNG_VALID_DT); //V_CHNG_VALID_DT
					cs.setString(14, ""); //V_GR_NO
					cs.setString(15, ""); //V_GR_SEQ
					cs.setString(16, V_USR_ID);
					
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
				

			}
		}
			
		//아래쪽 그리드 행 삭제.
		else if (V_TYPE.equals("DD")){
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
					String TO_LOT_BC_NO  = hashMap.get("TO_LOT_BC_NO") == null ? "" : hashMap.get("TO_LOT_BC_NO").toString();
					
					if(V_TYPE.equals("DD")){
						cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
						cs.setString(11, ""); //V_CHNG_LOT_NO
						cs.setString(12, ""); //V_CHNG_MAKE_DT
						cs.setString(13, ""); //V_CHNG_VALID_DT
						cs.setString(14, ""); //V_GR_NO
						cs.setString(15, ""); //V_GR_SEQ
						cs.setString(16, V_USR_ID);
						
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
 				V_TYPE  = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String TO_LOT_BC_NO  = jsondata.get("TO_LOT_BC_NO") == null ? "" : jsondata.get("TO_LOT_BC_NO").toString();
				
				if(V_TYPE.equals("DD")){
					cs = conn.prepareCall("call USP_I_BARCODE_DIVISION_WEB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					cs.setString(11, ""); //V_CHNG_LOT_NO
					cs.setString(12, ""); //V_CHNG_MAKE_DT
					cs.setString(13, ""); //V_CHNG_VALID_DT
					cs.setString(14, ""); //V_GR_NO
					cs.setString(15, ""); //V_GR_SEQ
					cs.setString(16, V_USR_ID);
					
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
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


