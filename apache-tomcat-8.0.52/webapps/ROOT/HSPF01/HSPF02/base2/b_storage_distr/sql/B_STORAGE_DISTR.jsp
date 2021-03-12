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
		String V_SL_DT = request.getParameter("V_SL_DT") == null ? "" : request.getParameter("V_SL_DT").substring(0, 10);
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		String V_SL_NM = request.getParameter("V_SL_NM") == null ? "" : request.getParameter("V_SL_NM").toUpperCase();
		String V_REGION = request.getParameter("V_REGION") == null ? "" : request.getParameter("V_REGION").toUpperCase();
		String V_REF_NO = request.getParameter("V_REF_NO") == null ? "" : request.getParameter("V_REF_NO").toUpperCase();

// 		System.out.println("V_TYPE" + V_TYPE);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_STORAGE_DISTR(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, V_SL_NM);//V_SL_NM
			cs.setString(5, V_SL_DT);//V_SL_DT
			cs.setString(6, "");//V_SL_LOC
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, V_REGION);//V_REGION
			cs.setString(10, V_REF_NO);//V_REF_NO
			cs.executeQuery();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("SL_DT", rs.getString("SL_DT"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
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

		} else if (V_TYPE.equals("SD")) {

			cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_SL_RATE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, "");//V_SL_SEQ
			cs.setString(5, "");//V_SL_TYPE
			cs.setString(6, "");//V_S_BP_CD
			cs.setString(7, "");//V_BF_TYPE
			cs.setString(8, "");//V_GD_AMT
			cs.setString(9, "");//V_JOB_AMT
			cs.setString(10, "");//V_SCALE_AMT
			cs.setString(11, "");//V_CHECK_AMT
			cs.setString(12, "");//V_PORT_AMT
			cs.setString(13, "");//V_REMARK
			cs.setString(14, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(16, "");//V_STIKER_AMT
			cs.setString(17, V_SL_NM);//V_SL_NM
			cs.setString(18, V_REGION);//V_REGION
			cs.setString(19, "");//V_REFRIG
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_SEQ", rs.getString("SL_SEQ"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("REGION_NM", rs.getString("REGION_NM"));
				subObject.put("REF_NO", rs.getString("REF_NO"));
				subObject.put("SL_TYPE", rs.getString("SL_TYPE"));
				subObject.put("SL_TYPE_NM", rs.getString("SL_TYPE_NM"));
				subObject.put("BF_TYPE", rs.getString("BF_TYPE"));
				subObject.put("BF_TYPE_NM", rs.getString("BF_TYPE_NM"));
				subObject.put("GD_AMT", rs.getString("GD_AMT"));
				subObject.put("JOB_AMT", rs.getString("JOB_AMT"));
				subObject.put("STIKER_AMT", rs.getString("STIKER_AMT"));
				subObject.put("SCALE_AMT", rs.getString("SCALE_AMT"));
				subObject.put("CHECK_AMT", rs.getString("CHECK_AMT"));
				if (rs.getString("REGION").equals("9")) {
					subObject.put("PORT_AMT", "(상세보기)");
				} else {
					subObject.put("PORT_AMT", "-");
				}
				subObject.put("TOPORT_AMT", rs.getString("REMARK"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("REFRIG", rs.getString("REFRIG"));
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

		} else if (V_TYPE.equals("I")) {

			cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_STORAGE_DISTR(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_SL_CD);//V_SL_CD
			cs.setString(4, V_SL_NM);//V_SL_NM
			cs.setString(5, V_SL_DT);//V_SL_DT
			cs.setString(6, "");//V_SL_LOC
			cs.setString(7, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, V_REGION);//V_REGION
			cs.setString(10, V_REF_NO);//V_REF_NO
			cs.executeQuery();

		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
// 					System.out.println(  hashMap.get("STIKER_AMT") == null || hashMap.get("STIKER_AMT").equals("null") );
					
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_SL_SEQ = hashMap.get("SL_SEQ") == null ? "" : hashMap.get("SL_SEQ").toString();
					String V_SL_TYPE = hashMap.get("SL_TYPE") == null ? "" : hashMap.get("SL_TYPE").toString();
					String V_S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String V_BF_TYPE = hashMap.get("BF_TYPE") == null ? "" : hashMap.get("BF_TYPE").toString();
					String V_GD_AMT = hashMap.get("GD_AMT") == null || hashMap.get("GD_AMT").equals("null") ? "0" : hashMap.get("GD_AMT").toString();
					String V_JOB_AMT = hashMap.get("JOB_AMT") == null || hashMap.get("JOB_AMT").equals("null") ? "0" : hashMap.get("JOB_AMT").toString();
					String V_STIKER_AMT =  hashMap.get("STIKER_AMT") == null || hashMap.get("STIKER_AMT").equals("null") ? "0" : hashMap.get("STIKER_AMT").toString();
					String V_SCALE_AMT =  hashMap.get("SCALE_AMT") == null || hashMap.get("SCALE_AMT").equals("null") ? "0" : hashMap.get("SCALE_AMT").toString();
					String V_CHECK_AMT =  hashMap.get("CHECK_AMT") == null || hashMap.get("CHECK_AMT").equals("null") ? "0" : hashMap.get("CHECK_AMT").toString();
					// 					String V_PORT_AMT = hashMap.get("PORT_AMT").equals("null") ? "0" : hashMap.get("PORT_AMT").toString();
					String V_PORT_AMT = "0";
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_REFRIG = hashMap.get("REFRIG") == null ? "" : hashMap.get("REFRIG").toString();

					if (V_TYPE.equals("I")) {
						V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
					}

					cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_SL_RATE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_SL_CD);//V_SL_CD
					cs.setString(4, V_SL_SEQ);//V_SL_SEQ
					cs.setString(5, V_SL_TYPE);//V_SL_TYPE
					cs.setString(6, V_S_BP_CD);//V_S_BP_CD
					cs.setString(7, V_BF_TYPE);//V_BF_TYPE
					cs.setString(8, V_GD_AMT);//V_GD_AMT
					cs.setString(9, V_JOB_AMT);//V_JOB_AMT
					cs.setString(10, V_SCALE_AMT);//V_SCALE_AMT
					cs.setString(11, V_CHECK_AMT);//V_CHECK_AMT
					cs.setString(12, V_PORT_AMT);//V_PORT_AMT
					cs.setString(13, V_REMARK);//V_REMARK
					cs.setString(14, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(16, V_STIKER_AMT);//V_CHECK_AMT
					cs.setString(17, V_SL_NM);//V_SL_NM
					cs.setString(18, V_REGION);//V_REGION
					cs.setString(19, V_REFRIG);//V_REFRIG
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_SL_SEQ = jsondata.get("SL_SEQ") == null ? "" : jsondata.get("SL_SEQ").toString();
				String V_SL_TYPE = jsondata.get("SL_TYPE") == null ? "" : jsondata.get("SL_TYPE").toString();
				String V_S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String V_BF_TYPE = jsondata.get("BF_TYPE") == null ? "" : jsondata.get("BF_TYPE").toString();
// 				System.out.println(" V_BF_TYPE " + V_BF_TYPE);
				String V_GD_AMT = jsondata.get("GD_AMT") == null || jsondata.get("GD_AMT").equals("null") ? "0" : jsondata.get("GD_AMT").toString();
				String V_JOB_AMT = jsondata.get("JOB_AMT") == null || jsondata.get("JOB_AMT").equals("null") ? "0" : jsondata.get("JOB_AMT").toString();
				String V_STIKER_AMT = jsondata.get("STIKER_AMT") == null || jsondata.get("STIKER_AMT").equals("null") ? "0" : jsondata.get("STIKER_AMT").toString();
				String V_SCALE_AMT = jsondata.get("SCALE_AMT") == null || jsondata.get("SCALE_AMT").equals("null") ? "0" : jsondata.get("SCALE_AMT").toString();
				String V_CHECK_AMT = jsondata.get("CHECK_AMT") == null || jsondata.get("CHECK_AMT").equals("null") ? "0" : jsondata.get("CHECK_AMT").toString();
				// 				String V_PORT_AMT = jsondata.get("PORT_AMT") == null || jsondata.get("PORT_AMT").equals("null") ? "0" : jsondata.get("PORT_AMT").toString();
				String V_PORT_AMT = "0";
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_REFRIG = jsondata.get("REFRIG") == null ? "" : jsondata.get("REFRIG").toString();

				if (V_TYPE.equals("I")) {
					V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
				}

				cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_SL_RATE_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_SL_CD);//V_SL_CD
				cs.setString(4, V_SL_SEQ);//V_SL_SEQ
				cs.setString(5, V_SL_TYPE);//V_SL_TYPE
				cs.setString(6, V_S_BP_CD);//V_S_BP_CD
				cs.setString(7, V_BF_TYPE);//V_BF_TYPE
				cs.setString(8, V_GD_AMT);//V_GD_AMT
				cs.setString(9, V_JOB_AMT);//V_JOB_AMT
				cs.setString(10, V_SCALE_AMT);//V_SCALE_AMT
				cs.setString(11, V_CHECK_AMT);//V_CHECK_AMT
				cs.setString(12, V_PORT_AMT);//V_PORT_AMT
				cs.setString(13, V_REMARK);//V_REMARK
				cs.setString(14, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(16, V_STIKER_AMT);//V_CHECK_AMT
				cs.setString(17, V_SL_NM);//V_SL_NM
				cs.setString(18, V_REGION);//V_REGION
				cs.setString(19, V_REFRIG);//V_REFRIG
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();

			}
		} else if (V_TYPE.equals("SHIP")) {

			cs = conn.prepareCall("call DISTR_B_STORAGE.USP_B_STORAGE_DISTR(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_SL_CD
			cs.setString(4, "");//V_SL_NM
			cs.setString(5, "");//V_SL_DT
			cs.setString(6, "");//V_SL_LOC
			cs.setString(7, "");//V_USR_ID
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(9, "");//V_REGION
			cs.setString(10, "");//V_REF_NO
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("SU_CD", rs.getString("SU_CD"));
				subObject.put("SECTION_FR", rs.getString("SECTION_FR"));
				subObject.put("SECTION_TO", rs.getString("SECTION_TO"));
				subObject.put("TRUCKING_D", rs.getString("TRUCKING_D"));
				subObject.put("TRUCKING_U", rs.getString("TRUCKING_U"));
				subObject.put("SELECTION", rs.getString("SELECTION"));
				subObject.put("RETIREMENT", rs.getString("RETIREMENT"));
				subObject.put("PENSION", rs.getString("PENSION"));
				subObject.put("WELFARE", rs.getString("WELFARE"));
				subObject.put("MEDICAL", rs.getString("MEDICAL"));
				subObject.put("INDUSTRIAL", rs.getString("INDUSTRIAL"));
				subObject.put("COST_AMOUNT", rs.getString("COST_AMOUNT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
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


