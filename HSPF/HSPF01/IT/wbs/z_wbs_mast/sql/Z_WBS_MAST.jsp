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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_SYS_TYPE = request.getParameter("V_SYS_TYPE") == null ? "" : request.getParameter("V_SYS_TYPE").toUpperCase();
		String V_PGM_NM = request.getParameter("V_PGM_NM") == null ? "" : request.getParameter("V_PGM_NM");
		String V_DEV_USR_NM = request.getParameter("V_DEV_USR_NM") == null ? "" : request.getParameter("V_DEV_USR_NM");
		String V_COMPLETE_YN = request.getParameter("V_COMPLETE_YN") == null ? "" : request.getParameter("V_COMPLETE_YN");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_DEV_PLAN_DT_FR = request.getParameter("V_DEV_PLAN_DT_FR") == null || request.getParameter("V_DEV_PLAN_DT_FR").equals("") ? "" : request.getParameter("V_DEV_PLAN_DT_FR").toString().substring(0, 10);
		String V_DEV_PLAN_DT_TO = request.getParameter("V_DEV_PLAN_DT_TO") == null || request.getParameter("V_DEV_PLAN_DT_TO").equals("") ? "" : request.getParameter("V_DEV_PLAN_DT_TO").toString().substring(0, 10);
		String V_DEV_END_DT_FR = request.getParameter("V_DEV_END_DT_FR") == null || request.getParameter("V_DEV_END_DT_FR").equals("") ? "" : request.getParameter("V_DEV_END_DT_FR").toString().substring(0, 10);
		String V_DEV_END_DT_TO = request.getParameter("V_DEV_END_DT_TO") == null || request.getParameter("V_DEV_END_DT_TO").equals("") ? "" : request.getParameter("V_DEV_END_DT_TO").toString().substring(0, 10);
		
		if(V_SYS_TYPE.equals("T")) V_SYS_TYPE = "";
		if(V_COMPLETE_YN.equals("T")) V_COMPLETE_YN = "";
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_Z_WBS_MAST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_SEQ			
			cs.setString(4, V_DEV_PLAN_DT_FR);//V_DEV_PLAN_DT_FR			
			cs.setString(5, V_DEV_PLAN_DT_TO);//V_DEV_PLAN_DT_TO			
			cs.setString(6, V_DEV_END_DT_FR);//V_DEV_END_DT_FR			
			cs.setString(7, V_DEV_END_DT_TO);//V_DEV_END_DT_TO			
			cs.setString(8, V_SYS_TYPE);	//V_SYS_TYPE
			cs.setString(9, "");//V_MODULE_TYPE
			cs.setString(10, "");//V_PGM_ID
			cs.setString(11, V_PGM_NM);//V_PGM_NM
			cs.setString(12, "");//V_CRUD
			cs.setString(13, "");//V_IF_YN
			cs.setString(14, V_DEV_USR_NM);//V_DEV_USR_NM
			cs.setString(15, "");//V_PRIORITY 
			cs.setString(16, "");//V_REQ_PLAN_DT
			cs.setString(17, "");//V_REQ_END_DT
			cs.setString(18, "");//V_DESIGN_PLAN_DT
			cs.setString(19, "");//V_DESIGN_END_DT
			cs.setString(20, "");//V_DEV_DAY
			cs.setString(21, "");//V_DEV_PLAN_DT
			cs.setString(22, "");//V_DEV_END_DT
			cs.setString(23, "");//V_TEST_PLAN_DT
			cs.setString(24, "");//V_TEST_END_DT
			cs.setString(25, "");//V_VALID_END_DT
			cs.setString(26, "");//V_VALID_USR_NM
			cs.setString(27, V_COMPLETE_YN);//V_COMPLETE_YN
			cs.setString(28, "");//V_REMARK
			cs.setString(29, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(30, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(30);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("SYS_TYPE", rs.getString("SYS_TYPE"));
				subObject.put("MODULE_TYPE", rs.getString("MODULE_TYPE"));
				subObject.put("PGM_ID", rs.getString("PGM_ID"));
				subObject.put("PGM_NM", rs.getString("PGM_NM"));
				subObject.put("CRUD", rs.getString("CRUD"));
				subObject.put("IF_YN", rs.getString("IF_YN"));
				subObject.put("DEV_USR_NM", rs.getString("DEV_USR_NM"));
				subObject.put("PRIORITY", rs.getString("PRIORITY"));
				subObject.put("REQ_PLAN_DT", rs.getString("REQ_PLAN_DT"));
				subObject.put("REQ_END_DT", rs.getString("REQ_END_DT"));
				subObject.put("DESIGN_PLAN_DT", rs.getString("DESIGN_PLAN_DT"));
				subObject.put("DESIGN_END_DT", rs.getString("DESIGN_END_DT"));
				subObject.put("DEV_DAY", rs.getString("DEV_DAY"));
				subObject.put("DEV_PLAN_DT", rs.getString("DEV_PLAN_DT"));
				subObject.put("DEV_END_DT", rs.getString("DEV_END_DT"));
				subObject.put("TEST_PLAN_DT", rs.getString("TEST_PLAN_DT"));
				subObject.put("TEST_END_DT", rs.getString("TEST_END_DT"));
				subObject.put("VALID_END_DT", rs.getString("VALID_END_DT"));		
				subObject.put("VALID_USR_NM", rs.getString("VALID_USR_NM"));
				subObject.put("COMPLETE_YN", rs.getString("COMPLETE_YN"));
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
					
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString().toUpperCase();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					V_SYS_TYPE = hashMap.get("SYS_TYPE") == null ? "" : hashMap.get("SYS_TYPE").toString();
					String V_MODULE_TYPE = hashMap.get("MODULE_TYPE") == null ? "" : hashMap.get("MODULE_TYPE").toString();
					String V_PGM_ID = hashMap.get("PGM_ID") == null ? "" : hashMap.get("PGM_ID").toString();
					V_PGM_NM= hashMap.get("PGM_NM") == null ? "" : hashMap.get("PGM_NM").toString();
					String V_CRUD = hashMap.get("CRUD") == null ? "" : hashMap.get("CRUD").toString();
					String V_IF_YN = hashMap.get("IF_YN") == null || hashMap.get("IF_YN").equals("null") ? "" : hashMap.get("IF_YN").toString();
					V_DEV_USR_NM = hashMap.get("DEV_USR_NM") == null ? "" : hashMap.get("DEV_USR_NM").toString();
					String V_PRIORITY = hashMap.get("PRIORITY") == null || hashMap.get("PRIORITY").equals("null") ? "" : hashMap.get("PRIORITY").toString();
					String V_REQ_PLAN_DT = hashMap.get("REQ_PLAN_DT") == null || hashMap.get("REQ_PLAN_DT").equals("null")? "" : hashMap.get("REQ_PLAN_DT").toString().substring(0, 10);
					String V_REQ_END_DT = hashMap.get("REQ_END_DT") == null || hashMap.get("REQ_END_DT").equals("null") ? "" : hashMap.get("REQ_END_DT").toString().substring(0, 10);
					String V_DESIGN_PLAN_DT = hashMap.get("DESIGN_PLAN_DT") == null || hashMap.get("DESIGN_PLAN_DT").equals("null")? "" : hashMap.get("DESIGN_PLAN_DT").toString().substring(0, 10);
					String V_DESIGN_END_DT = hashMap.get("DESIGN_END_DT") == null || hashMap.get("DESIGN_END_DT").equals("null") ? "" : hashMap.get("DESIGN_END_DT").toString().substring(0, 10);
					String V_DEV_DAY = hashMap.get("DEV_DAY") == null || hashMap.get("DEV_DAY").equals("null") ? "" : hashMap.get("DEV_DAY").toString();
					String V_DEV_PLAN_DT = hashMap.get("DEV_PLAN_DT") == null || hashMap.get("DEV_PLAN_DT").equals("null")? "" : hashMap.get("DEV_PLAN_DT").toString().substring(0, 10);
					String V_DEV_END_DT = hashMap.get("DEV_END_DT") == null || hashMap.get("DEV_END_DT").equals("null")? "" : hashMap.get("DEV_END_DT").toString().substring(0, 10);
					String V_TEST_PLAN_DT = hashMap.get("TEST_PLAN_DT") == null || hashMap.get("TEST_PLAN_DT").equals("null")? "" : hashMap.get("TEST_PLAN_DT").toString().substring(0, 10);
					String V_TEST_END_DT = hashMap.get("TEST_END_DT") == null || hashMap.get("TEST_END_DT").equals("null")? "" : hashMap.get("TEST_END_DT").toString().substring(0, 10);
					String V_VALID_END_DT = hashMap.get("VALID_END_DT") == null || hashMap.get("VALID_END_DT").equals("null")? "" : hashMap.get("VALID_END_DT").toString().substring(0, 10);
					String V_VALID_USR_NM = hashMap.get("VALID_USR_NM") == null ? "" : hashMap.get("VALID_USR_NM").toString();
					V_COMPLETE_YN = hashMap.get("COMPLETE_YN") == null || hashMap.get("COMPLETE_YN").equals("null") ? "" : hashMap.get("COMPLETE_YN").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();

					cs = conn.prepareCall("call USP_Z_WBS_MAST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_SEQ);//V_SEQ
					cs.setString(4, "");//V_DEV_PLAN_DT_FR			
					cs.setString(5, "");//V_DEV_PLAN_DT_TO			
					cs.setString(6, "");//V_DEV_END_DT_FR			
					cs.setString(7, "");//V_DEV_END_DT_TO	
					cs.setString(8, V_SYS_TYPE);//V_SYS_TYPE
					cs.setString(9, V_MODULE_TYPE);//V_MODULE_TYPE
					cs.setString(10, V_PGM_ID);//V_PGM_ID
					cs.setString(11, V_PGM_NM);//V_PGM_NM
					cs.setString(12, V_CRUD);//V_CRUD
					cs.setString(13, V_IF_YN);//V_IF_YN
					cs.setString(14,V_DEV_USR_NM);//V_DEV_USR_NM
					cs.setString(15, V_PRIORITY);//V_PRIORITY 
					cs.setString(16, V_REQ_PLAN_DT);//V_REQ_PLAN_DT
					cs.setString(17, V_REQ_END_DT);//V_REQ_END_DT
					cs.setString(18, V_DESIGN_PLAN_DT);//V_DESIGN_PLAN_DT
					cs.setString(19, V_DESIGN_END_DT);//V_DESIGN_END_DT
					cs.setString(20, V_DEV_DAY);//V_DEV_DAY
					cs.setString(21, V_DEV_PLAN_DT);//V_DEV_PLAN_DT
					cs.setString(22, V_DEV_END_DT);//V_DEV_END_DT
					cs.setString(23, V_TEST_PLAN_DT);//V_TEST_PLAN_DT
					cs.setString(24, V_TEST_END_DT);//V_TEST_END_DT
					cs.setString(25, V_VALID_END_DT);//V_VALID_END_DT
					cs.setString(26, V_VALID_USR_NM);//V_VALID_USR_NM
					cs.setString(27, V_COMPLETE_YN);//V_COMPLETE_YN
					cs.setString(28, V_REMARK);//V_REMARK
					cs.setString(29, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(30, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString().toUpperCase();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				V_SYS_TYPE = jsondata.get("SYS_TYPE") == null ? "" : jsondata.get("SYS_TYPE").toString();
				String V_MODULE_TYPE = jsondata.get("MODULE_TYPE") == null ? "" : jsondata.get("MODULE_TYPE").toString();
				String V_PGM_ID = jsondata.get("PGM_ID") == null ? "" : jsondata.get("PGM_ID").toString();
				V_PGM_NM= jsondata.get("PGM_NM") == null ? "" : jsondata.get("PGM_NM").toString();
				String V_CRUD = jsondata.get("CRUD") == null ? "" : jsondata.get("CRUD").toString();
				String V_IF_YN = jsondata.get("IF_YN") == null || jsondata.get("IF_YN").equals("null") ? "" : jsondata.get("IF_YN").toString();
				V_DEV_USR_NM = jsondata.get("DEV_USR_NM") == null ? "" : jsondata.get("DEV_USR_NM").toString();
				String V_PRIORITY = jsondata.get("PRIORITY") == null || jsondata.get("PRIORITY").equals("null") ? "" : jsondata.get("PRIORITY").toString();
				String V_REQ_PLAN_DT = jsondata.get("REQ_PLAN_DT") == null || jsondata.get("REQ_PLAN_DT").equals("null")? "" : jsondata.get("REQ_PLAN_DT").toString().substring(0, 10);
				String V_REQ_END_DT = jsondata.get("REQ_END_DT") == null || jsondata.get("REQ_END_DT").equals("null") ? "" : jsondata.get("REQ_END_DT").toString().substring(0, 10);
				String V_DESIGN_PLAN_DT = jsondata.get("DESIGN_PLAN_DT") == null || jsondata.get("DESIGN_PLAN_DT").equals("null")? "" : jsondata.get("DESIGN_PLAN_DT").toString().substring(0, 10);
				String V_DESIGN_END_DT = jsondata.get("DESIGN_END_DT") == null || jsondata.get("DESIGN_END_DT").equals("null") ? "" : jsondata.get("DESIGN_END_DT").toString().substring(0, 10);
				String V_DEV_DAY = jsondata.get("DEV_DAY") == null || jsondata.get("DEV_DAY").equals("null") ? "" : jsondata.get("DEV_DAY").toString();
				String V_DEV_PLAN_DT = jsondata.get("DEV_PLAN_DT") == null || jsondata.get("DEV_PLAN_DT").equals("null")? "" : jsondata.get("DEV_PLAN_DT").toString().substring(0, 10);
				String V_DEV_END_DT = jsondata.get("DEV_END_DT") == null || jsondata.get("DEV_END_DT").equals("null")? "" : jsondata.get("DEV_END_DT").toString().substring(0, 10);
				String V_TEST_PLAN_DT = jsondata.get("TEST_PLAN_DT") == null || jsondata.get("TEST_PLAN_DT").equals("null")? "" : jsondata.get("TEST_PLAN_DT").toString().substring(0, 10);
				String V_TEST_END_DT = jsondata.get("TEST_END_DT") == null || jsondata.get("TEST_END_DT").equals("null")? "" : jsondata.get("TEST_END_DT").toString().substring(0, 10);
				String V_VALID_END_DT = jsondata.get("VALID_END_DT") == null || jsondata.get("VALID_END_DT").equals("null")? "" : jsondata.get("VALID_END_DT").toString().substring(0, 10);
				String V_VALID_USR_NM = jsondata.get("VALID_USR_NM") == null ? "" : jsondata.get("VALID_USR_NM").toString();
				V_COMPLETE_YN = jsondata.get("COMPLETE_YN") == null || jsondata.get("COMPLETE_YN").equals("null") ? "" : jsondata.get("COMPLETE_YN").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();

				cs = conn.prepareCall("call USP_Z_WBS_MAST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_SEQ);
				cs.setString(4, "");//V_DEV_PLAN_DT_FR			
				cs.setString(5, "");//V_DEV_PLAN_DT_TO			
				cs.setString(6, "");//V_DEV_END_DT_FR			
				cs.setString(7, "");//V_DEV_END_DT_TO	
				cs.setString(8, V_SYS_TYPE);//V_SYS_TYPE
				cs.setString(9, V_MODULE_TYPE);//V_MODULE_TYPE
				cs.setString(10, V_PGM_ID);//V_PGM_ID
				cs.setString(11, V_PGM_NM);//V_PGM_NM
				cs.setString(12, V_CRUD);//V_CRUD
				cs.setString(13, V_IF_YN);//V_IF_YN
				cs.setString(14,V_DEV_USR_NM);//V_DEV_USR_NM
				cs.setString(15, V_PRIORITY);//V_PRIORITY 
				cs.setString(16, V_REQ_PLAN_DT);//V_REQ_PLAN_DT
				cs.setString(17, V_REQ_END_DT);//V_REQ_END_DT
				cs.setString(18, V_DESIGN_PLAN_DT);//V_DESIGN_PLAN_DT
				cs.setString(19, V_DESIGN_END_DT);//V_DESIGN_END_DT
				cs.setString(20, V_DEV_DAY);//V_DEV_DAY
				cs.setString(21, V_DEV_PLAN_DT);//V_DEV_PLAN_DT
				cs.setString(22, V_DEV_END_DT);//V_DEV_END_DT
				cs.setString(23, V_TEST_PLAN_DT);//V_TEST_PLAN_DT
				cs.setString(24, V_TEST_END_DT);//V_TEST_END_DT
				cs.setString(25, V_VALID_END_DT);//V_VALID_END_DT
				cs.setString(26, V_VALID_USR_NM);//V_VALID_USR_NM
				cs.setString(27, V_COMPLETE_YN);//V_COMPLETE_YN
				cs.setString(28, V_REMARK);//V_REMARK
				cs.setString(29, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(30, com.tmax.tibero.TbTypes.CURSOR);
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


