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

		//조회
		if (V_TYPE.equals("DS")) {
			String V_Q_ID = request.getParameter("V_Q_ID") == null ? "" : request.getParameter("V_Q_ID").toUpperCase();
			
			cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_Q_ID); //V_Q_ID
			cs.setString(4, ""); //V_Q_SEQ
			cs.setString(5, ""); //V_ITEM_CD
			cs.setString(6, ""); //V_INSP_CD
			cs.setString(7, ""); //V_MIN_QTY
			cs.setString(8, ""); //V_MID_QTY
			cs.setString(9, ""); //V_MAX_QTY
			cs.setString(10, ""); //V_UNIT
			cs.setString(11, ""); //V_INSP_TYPE_CD
			cs.setString(12, ""); //V_INSP_CHECK_CD
			cs.setString(13, ""); //V_IN_QC_TYPE
			cs.setString(14, ""); //V_IM_TYPE
			cs.setString(15, ""); //V_USE_YN
			cs.setString(16, ""); //V_CFM_YN
			cs.setString(17, V_USR_ID); //V_USR_ID
			
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("Q_ID_SEQ", rs.getString("Q_ID_SEQ"));
				subObject.put("INSP_CD", rs.getString("INSP_CD"));
				subObject.put("MIN_QTY", rs.getString("MIN_QTY"));
				subObject.put("MID_QTY", rs.getString("MID_QTY"));
				subObject.put("MAX_QTY", rs.getString("MAX_QTY"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("INSP_TYPE_CD", rs.getString("INSP_TYPE_CD"));
				subObject.put("INSP_CHECK_CD", rs.getString("INSP_CHECK_CD"));
				subObject.put("IN_QC_TYPE", rs.getString("IN_QC_TYPE"));
				subObject.put("IM_TYPE", rs.getString("IM_TYPE"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
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
		}
		else if(V_TYPE.equals("DI")){
			String V_Q_ID = request.getParameter("V_Q_ID") == null ? "" : request.getParameter("V_Q_ID").toUpperCase();
			String count = request.getParameter("count") == null ? "" : request.getParameter("count").toUpperCase();
			int loopCount = Integer.parseInt(count);
			for( int i = 0 ; i < loopCount ; i ++){
				cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_Q_ID); //V_Q_ID
				cs.setString(4, ""); //V_Q_SEQ
				cs.setString(5, ""); //V_ITEM_CD
				cs.setString(6, ""); //V_INSP_CD
				cs.setString(7, ""); //V_MIN_QTY
				cs.setString(8, ""); //V_MID_QTY
				cs.setString(9, ""); //V_MAX_QTY
				cs.setString(10, ""); //V_UNIT
				cs.setString(11, ""); //V_INSP_TYPE_CD
				cs.setString(12, ""); //V_INSP_CHECK_CD
				cs.setString(13, ""); //V_IN_QC_TYPE
				cs.setString(14, ""); //V_IM_TYPE
				cs.setString(15, ""); //V_USE_YN
				cs.setString(16, ""); //V_CFM_YN
				cs.setString(17, V_USR_ID); //V_USR_ID
				
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			
		}
		else if(V_TYPE.equals("DU")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			if (data.contains("%")) {
				data = data.replaceAll("%", "percent");
			} else if (data.contains("/")) {
				data = data.replaceAll("/", ",");
			}
			String jsonData = URLDecoder.decode(data, "UTF-8");
			String V_Q_ID = request.getParameter("V_Q_ID") == null ? "" : request.getParameter("V_Q_ID").toUpperCase();
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String Q_ID_SEQ  = hashMap.get("Q_ID_SEQ") == null ? "" : hashMap.get("Q_ID_SEQ").toString();
					String INSP_CD  = hashMap.get("INSP_CD") == null ? "" : hashMap.get("INSP_CD").toString();
					String MIN_QTY  = hashMap.get("MIN_QTY") == null ? "" : hashMap.get("MIN_QTY").toString();
					String MID_QTY  = hashMap.get("MID_QTY") == null ? "" : hashMap.get("MID_QTY").toString();
					String MAX_QTY  = hashMap.get("MAX_QTY") == null ? "" : hashMap.get("MAX_QTY").toString();
					String UNIT  = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String INSP_TYPE_CD  = hashMap.get("INSP_TYPE_CD") == null ? "" : hashMap.get("INSP_TYPE_CD").toString();
					String INSP_CHECK_CD  = hashMap.get("INSP_CHECK_CD") == null ? "" : hashMap.get("INSP_CHECK_CD").toString();
					String IN_QC_TYPE  = hashMap.get("IN_QC_TYPE") == null ? "" : hashMap.get("IN_QC_TYPE").toString();
					String IM_TYPE  = hashMap.get("IM_TYPE") == null ? "" : hashMap.get("IM_TYPE").toString();
					String USE_YN  = hashMap.get("USE_YN") == null ? "" : hashMap.get("USE_YN").toString();
					String CFM_YN  = hashMap.get("CFM_YN") == null ? "" : hashMap.get("CFM_YN").toString();
					
					
					if(IM_TYPE.equals("Y")){
						IM_TYPE = "1";
					}
					else if(IM_TYPE.equals("Y")){
						IM_TYPE = "0";
					}
					
					if(USE_YN.equals("Y")){
						USE_YN = "1";
					}
					else if(USE_YN.equals("Y")){
						USE_YN = "0";
					}
					
					if(CFM_YN.equals("Y")){
						CFM_YN = "1";
					}
					else if(CFM_YN.equals("Y")){
						CFM_YN = "0";
					}

					if(V_TYPE.equals("DU")){
						cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_COMP_ID);
						cs.setString(3, V_Q_ID); //V_Q_ID
						cs.setString(4, Q_ID_SEQ); //V_Q_SEQ
						cs.setString(5, ""); //V_ITEM_CD
						cs.setString(6, INSP_CD); //V_INSP_CD
						cs.setString(7, MIN_QTY); //V_MIN_QTY
						cs.setString(8, MID_QTY); //V_MID_QTY
						cs.setString(9, MAX_QTY); //V_MAX_QTY
						cs.setString(10, UNIT); //V_UNIT
						cs.setString(11, INSP_TYPE_CD); //V_INSP_TYPE_CD
						cs.setString(12, INSP_CHECK_CD); //V_INSP_CHECK_CD
						cs.setString(13, IN_QC_TYPE); //V_IN_QC_TYPE
						cs.setString(14, IM_TYPE); //V_IM_TYPE
						cs.setString(15, USE_YN); //V_USE_YN
						cs.setString(16, CFM_YN); //V_CFM_YN
						cs.setString(17, V_USR_ID); //V_USR_ID
						
						cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String Q_ID_SEQ  = jsondata.get("Q_ID_SEQ") == null ? "" : jsondata.get("Q_ID_SEQ").toString();
				String INSP_CD  = jsondata.get("INSP_CD") == null ? "" : jsondata.get("INSP_CD").toString();
				String MIN_QTY  = jsondata.get("MIN_QTY") == null ? "" : jsondata.get("MIN_QTY").toString();
				String MID_QTY  = jsondata.get("MID_QTY") == null ? "" : jsondata.get("MID_QTY").toString();
				String MAX_QTY  = jsondata.get("MAX_QTY") == null ? "" : jsondata.get("MAX_QTY").toString();
				String UNIT  = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String INSP_TYPE_CD  = jsondata.get("INSP_TYPE_CD") == null ? "" : jsondata.get("INSP_TYPE_CD").toString();
				String INSP_CHECK_CD  = jsondata.get("INSP_CHECK_CD") == null ? "" : jsondata.get("INSP_CHECK_CD").toString();
				String IN_QC_TYPE  = jsondata.get("IN_QC_TYPE") == null ? "" : jsondata.get("IN_QC_TYPE").toString();
				String IM_TYPE  = jsondata.get("IM_TYPE") == null ? "" : jsondata.get("IM_TYPE").toString();
				String USE_YN  = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();
				String CFM_YN  = jsondata.get("CFM_YN") == null ? "" : jsondata.get("CFM_YN").toString();
				
				
				if(IM_TYPE.equals("Y")){
					IM_TYPE = "1";
				}
				else if(IM_TYPE.equals("Y")){
					IM_TYPE = "0";
				}
				
				if(USE_YN.equals("Y")){
					USE_YN = "1";
				}
				else if(USE_YN.equals("Y")){
					USE_YN = "0";
				}
				
				if(CFM_YN.equals("Y")){
					CFM_YN = "1";
				}
				else if(CFM_YN.equals("Y")){
					CFM_YN = "0";
				}

				if(V_TYPE.equals("DU")){
					cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, V_Q_ID); //V_Q_ID
					cs.setString(4, Q_ID_SEQ); //V_Q_SEQ
					cs.setString(5, ""); //V_ITEM_CD
					cs.setString(6, INSP_CD); //V_INSP_CD
					cs.setString(7, MIN_QTY); //V_MIN_QTY
					cs.setString(8, MID_QTY); //V_MID_QTY
					cs.setString(9, MAX_QTY); //V_MAX_QTY
					cs.setString(10, UNIT); //V_UNIT
					cs.setString(11, INSP_TYPE_CD); //V_INSP_TYPE_CD
					cs.setString(12, INSP_CHECK_CD); //V_INSP_CHECK_CD
					cs.setString(13, IN_QC_TYPE); //V_IN_QC_TYPE
					cs.setString(14, IM_TYPE); //V_IM_TYPE
					cs.setString(15, USE_YN); //V_USE_YN
					cs.setString(16, CFM_YN); //V_CFM_YN
					cs.setString(17, V_USR_ID); //V_USR_ID
					
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			}
		}
		else if(V_TYPE.equals("DD")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			if (data.contains("%")) {
				data = data.replaceAll("%", "percent");
			} else if (data.contains("/")) {
				data = data.replaceAll("/", ",");
			}
			String jsonData = URLDecoder.decode(data, "UTF-8");
			String V_Q_ID = request.getParameter("V_Q_ID") == null ? "" : request.getParameter("V_Q_ID").toUpperCase();
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String Q_ID_SEQ  = hashMap.get("Q_ID_SEQ") == null ? "" : hashMap.get("Q_ID_SEQ").toString();
					String INSP_CD  = hashMap.get("INSP_CD") == null ? "" : hashMap.get("INSP_CD").toString();
					String MIN_QTY  = hashMap.get("MIN_QTY") == null ? "" : hashMap.get("MIN_QTY").toString();
					String MID_QTY  = hashMap.get("MID_QTY") == null ? "" : hashMap.get("MID_QTY").toString();
					String MAX_QTY  = hashMap.get("MAX_QTY") == null ? "" : hashMap.get("MAX_QTY").toString();
					String UNIT  = hashMap.get("UNIT") == null ? "" : hashMap.get("UNIT").toString();
					String INSP_TYPE_CD  = hashMap.get("INSP_TYPE_CD") == null ? "" : hashMap.get("INSP_TYPE_CD").toString();
					String INSP_CHECK_CD  = hashMap.get("INSP_CHECK_CD") == null ? "" : hashMap.get("INSP_CHECK_CD").toString();
					String IN_QC_TYPE  = hashMap.get("IN_QC_TYPE") == null ? "" : hashMap.get("IN_QC_TYPE").toString();
					String IM_TYPE  = hashMap.get("IM_TYPE") == null ? "" : hashMap.get("IM_TYPE").toString();
					String USE_YN  = hashMap.get("USE_YN") == null ? "" : hashMap.get("USE_YN").toString();
					String CFM_YN  = hashMap.get("CFM_YN") == null ? "" : hashMap.get("CFM_YN").toString();

					if(V_TYPE.equals("DD")){
						cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_COMP_ID);
						cs.setString(3, V_Q_ID); //V_Q_ID
						cs.setString(4, Q_ID_SEQ); //V_Q_SEQ
						cs.setString(5, ""); //V_ITEM_CD
						cs.setString(6, INSP_CD); //V_INSP_CD
						cs.setString(7, MIN_QTY); //V_MIN_QTY
						cs.setString(8, MID_QTY); //V_MID_QTY
						cs.setString(9, MAX_QTY); //V_MAX_QTY
						cs.setString(10, UNIT); //V_UNIT
						cs.setString(11, INSP_TYPE_CD); //V_INSP_TYPE_CD
						cs.setString(12, INSP_CHECK_CD); //V_INSP_CHECK_CD
						cs.setString(13, IN_QC_TYPE); //V_IN_QC_TYPE
						cs.setString(14, IM_TYPE); //V_IM_TYPE
						cs.setString(15, USE_YN); //V_USE_YN
						cs.setString(16, CFM_YN); //V_CFM_YN
						cs.setString(17, V_USR_ID); //V_USR_ID
						
						cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String Q_ID_SEQ  = jsondata.get("Q_ID_SEQ") == null ? "" : jsondata.get("Q_ID_SEQ").toString();
				String INSP_CD  = jsondata.get("INSP_CD") == null ? "" : jsondata.get("INSP_CD").toString();
				String MIN_QTY  = jsondata.get("MIN_QTY") == null ? "" : jsondata.get("MIN_QTY").toString();
				String MID_QTY  = jsondata.get("MID_QTY") == null ? "" : jsondata.get("MID_QTY").toString();
				String MAX_QTY  = jsondata.get("MAX_QTY") == null ? "" : jsondata.get("MAX_QTY").toString();
				String UNIT  = jsondata.get("UNIT") == null ? "" : jsondata.get("UNIT").toString();
				String INSP_TYPE_CD  = jsondata.get("INSP_TYPE_CD") == null ? "" : jsondata.get("INSP_TYPE_CD").toString();
				String INSP_CHECK_CD  = jsondata.get("INSP_CHECK_CD") == null ? "" : jsondata.get("INSP_CHECK_CD").toString();
				String IN_QC_TYPE  = jsondata.get("IN_QC_TYPE") == null ? "" : jsondata.get("IN_QC_TYPE").toString();
				String IM_TYPE  = jsondata.get("IM_TYPE") == null ? "" : jsondata.get("IM_TYPE").toString();
				String USE_YN  = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();
				String CFM_YN  = jsondata.get("CFM_YN") == null ? "" : jsondata.get("CFM_YN").toString();

				if(V_TYPE.equals("DD")){
					cs = conn.prepareCall("call USP_Q_BASE_DETAIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, V_Q_ID); //V_Q_ID
					cs.setString(4, Q_ID_SEQ); //V_Q_SEQ
					cs.setString(5, ""); //V_ITEM_CD
					cs.setString(6, INSP_CD); //V_INSP_CD
					cs.setString(7, MIN_QTY); //V_MIN_QTY
					cs.setString(8, MID_QTY); //V_MID_QTY
					cs.setString(9, MAX_QTY); //V_MAX_QTY
					cs.setString(10, UNIT); //V_UNIT
					cs.setString(11, INSP_TYPE_CD); //V_INSP_TYPE_CD
					cs.setString(12, INSP_CHECK_CD); //V_INSP_CHECK_CD
					cs.setString(13, IN_QC_TYPE); //V_IN_QC_TYPE
					cs.setString(14, IM_TYPE); //V_IM_TYPE
					cs.setString(15, USE_YN); //V_USE_YN
					cs.setString(16, CFM_YN); //V_CFM_YN
					cs.setString(17, V_USR_ID); //V_USR_ID
					
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
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


