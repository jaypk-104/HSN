<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_PO_DT_FROM = request.getParameter("V_PO_DT_FROM") == null ? "" : request.getParameter("V_PO_DT_FROM").substring(0, 10);
		String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0, 10);
		String V_PO_TYPE = request.getParameter("V_PO_TYPE") == null ? "" : request.getParameter("V_PO_TYPE");
		if (V_PO_TYPE.equals("T")) {
			V_PO_TYPE = "";
		}
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD");
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");
		String V_GR_DT = request.getParameter("V_GR_DT") == null ? "" : request.getParameter("V_GR_DT").substring(0, 10);
		String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO");
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO");
		String V_GR_SL_CD = request.getParameter("V_GR_SL_CD") == null ? "" : request.getParameter("V_GR_SL_CD");
		if (V_GR_SL_CD.equals("T")) {
			V_GR_SL_CD = "";
		}

		// 		System.out.println("V_PO_DT_FROM" + V_PO_DT_FROM);
		// 		System.out.println("V_PO_DT_TO" + V_PO_DT_TO);

		//왼쪽발주조회(입고대상조회)
		if (V_TYPE.equals("RS")) {
			cs = conn.prepareCall("call USP_M_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_PO_DT_FROM);//V_PO_DT_FR
			cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
			cs.setString(5, V_M_BP_CD);//V_M_BP_CD
			cs.setString(6, V_M_BP_NM);//V_M_BP_NM
			cs.setString(7, V_PO_TYPE);//V_PO_TYPE
			cs.setString(8, V_BL_NO);//V_PO_NO 임시로 BL_NO 로 사용. 20180628 김장운.
			cs.setString(9, "");//V_PO_SEQ
			cs.setString(10, "");//V_BAR_YN
			cs.setString(11, "");//V_GR_NO
			cs.setString(12, "");//V_IN_DT
			cs.setString(13, "");//V_IN_QTY
			cs.setString(14, V_GR_SL_CD);//V_GR_SL_CD   
			cs.setString(15, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_DT", rs.getString("PO_DT").substring(0, 10));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_REMAIN_QTY", rs.getString("PO_REMAIN_QTY"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("BAR_YN", rs.getString("BAR_YN"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("HOPE_SL_CD", rs.getString("HOPE_SL_CD"));
				subObject.put("HOPE_SL_NM", rs.getString("HOPE_SL_NM"));
				subObject.put("DLV_TYPE_NM", rs.getString("DLV_TYPE_NM"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
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

			// 	입고등록채번
		} else if (V_TYPE.equals("SYNC")) {
			// 			System.out.println("syncin");

			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {

					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();

					//입고번호채번
					if (i == 0 && V_TYPE.equals("LI")) {
						cs = conn.prepareCall("call USP_M_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, "HI");//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_PO_DT_FROM);//V_PO_DT_FR
						cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
						cs.setString(5, V_M_BP_CD);//V_M_BP_CD
						cs.setString(6, V_M_BP_NM);//V_M_BP_NM
						cs.setString(7, "");//V_PO_TYPE
						cs.setString(8, "");//V_PO_NO
						cs.setString(9, "");//V_PO_SEQ
						cs.setString(10, "");//V_BAR_YN
						cs.setString(11, "");//V_GR_NO
						cs.setString(12, V_GR_DT);//V_GR_DT
						cs.setString(13, "");//V_IN_QTY
						cs.setString(14, "");//V_IN_SL_CD
						cs.setString(15, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(16);
						while (rs.next()) {
							V_GR_NO = rs.getString("GR_NO");
						}
					}

					String V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
					String V_GR_QTY = hashMap.get("GR_QTY") == null ? "" : hashMap.get("GR_QTY").toString();
					V_GR_SL_CD = hashMap.get("HOPE_SL_CD") == null ? "" : hashMap.get("HOPE_SL_CD").toString();

					cs = conn.prepareCall("call USP_M_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PO_DT_FROM);//V_PO_DT_FR
					cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
					cs.setString(5, V_M_BP_CD);//V_M_BP_CD
					cs.setString(6, V_M_BP_NM);//V_M_BP_NM
					cs.setString(7, "");//V_PO_TYPE
					cs.setString(8, V_PO_NO);//V_PO_NO
					cs.setString(9, V_PO_SEQ);//V_PO_SEQ
					cs.setString(10, "");//V_BAR_YN
					cs.setString(11, V_GR_NO);//V_GR_NO
					cs.setString(12, V_GR_DT);//V_IN_DT
					cs.setString(13, V_GR_QTY);//V_IN_QTY
					cs.setString(14, V_GR_SL_CD);//V_IN_SL_CD
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				// 				System.out.println("V_TYPE" + V_TYPE);
				//입고번호채번
				if (V_TYPE.equals("LI")) {
					cs = conn.prepareCall("call USP_M_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, "HI");//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_PO_DT_FROM);//V_PO_DT_FR
					cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
					cs.setString(5, V_M_BP_CD);//V_M_BP_CD
					cs.setString(6, V_M_BP_NM);//V_M_BP_NM
					cs.setString(7, "");//V_PO_TYPE
					cs.setString(8, "");//V_PO_NO
					cs.setString(9, "");//V_PO_SEQ
					cs.setString(10, "");//V_BAR_YN
					cs.setString(11, "");//V_GR_NO
					cs.setString(12, V_GR_DT);//V_GR_DT
					cs.setString(13, "");//V_IN_QTY
					cs.setString(14, "");//V_IN_SL_CD
					cs.setString(15, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(16);
					while (rs.next()) {
						V_GR_NO = rs.getString("GR_NO");
					}
				}

				String V_DR_QTY = jsondata.get("DR_QTY") == null ? "" : jsondata.get("DR_QTY").toString();
				String V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
				String V_GR_QTY = jsondata.get("GR_QTY") == null ? "" : jsondata.get("GR_QTY").toString();
				V_GR_SL_CD = jsondata.get("HOPE_SL_CD") == null ? "" : jsondata.get("HOPE_SL_CD").toString();

				cs = conn.prepareCall("call USP_M_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_PO_DT_FROM);//V_PO_DT_FR
				cs.setString(4, V_PO_DT_TO);//V_PO_DT_TO
				cs.setString(5, V_M_BP_CD);//V_M_BP_CD
				cs.setString(6, V_M_BP_NM);//V_M_BP_NM
				cs.setString(7, "");//V_PO_TYPE
				cs.setString(8, V_PO_NO);//V_PO_NO
				cs.setString(9, V_PO_SEQ);//V_PO_SEQ
				cs.setString(10, "");//V_BAR_YN
				cs.setString(11, V_GR_NO);//V_GR_NO
				cs.setString(12, V_GR_DT);//V_IN_DT
				cs.setString(13, V_GR_QTY);//V_IN_QTY
				cs.setString(14, V_GR_SL_CD);//V_IN_SL_CD
				cs.setString(15, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
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




