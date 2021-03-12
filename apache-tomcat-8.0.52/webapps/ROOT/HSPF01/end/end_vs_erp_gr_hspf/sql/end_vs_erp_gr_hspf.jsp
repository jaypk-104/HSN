<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");
		String V_GR_FR_DT = request.getParameter("V_GR_FR_DT") == null ? "" : request.getParameter("V_GR_FR_DT").substring(0, 10);
		String V_GR_TO_DT = request.getParameter("V_GR_FR_DT") == null ? "" : request.getParameter("V_GR_TO_DT").substring(0, 10);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD");

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_END_VS_ERP_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_GR_FR_DT
			cs.setString(2, V_GR_FR_DT);//V_GR_FR_DT
			cs.setString(3, V_GR_TO_DT);//V_GR_FR_DT
			cs.setString(4, V_M_BP_NM);//V_M_BP_NM
			cs.setString(5, V_ITEM_CD);//V_M_BP_NM
			cs.setString(6, "");//
			cs.setString(7, "");//
			cs.setString(8, "");//
			cs.setString(9, "");//
			cs.setString(10, "");//
			cs.setString(11, "");//
			cs.setString(12, "");//
			cs.setString(13, "");//
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);
			while (rs.next()) {

				subObject = new JSONObject();
				subObject.put("GR_DT", rs.getString("GR_DT"));
				subObject.put("HSPF_GR_TYPE", rs.getString("HSPF_GR_TYPE"));
				subObject.put("HSPF_GR_TYPE_NM", rs.getString("HSPF_GR_TYPE_NM"));
				subObject.put("ERP_GR_TYPE", rs.getString("ERP_GR_TYPE"));
				subObject.put("ERP_GR_TYPE_NM", rs.getString("ERP_GR_TYPE_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("HSPF_QTY", rs.getString("HSPF_QTY"));
				subObject.put("ERP_QTY", rs.getString("ERP_QTY"));
				subObject.put("HSPF_CUR", rs.getString("HSPF_CUR"));
				subObject.put("ERP_CUR", rs.getString("ERP_CUR"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
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

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_GR_DT = hashMap.get("GR_DT") == null ? "" : hashMap.get("GR_DT").toString().substring(0, 10);
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_HSPF_GR_TYPE_NM = hashMap.get("HSPF_GR_TYPE_NM") == null ? "" : hashMap.get("HSPF_GR_TYPE_NM").toString();
					String V_ERP_GR_TYPE_NM = hashMap.get("ERP_GR_TYPE_NM") == null ? "" : hashMap.get("ERP_GR_TYPE_NM").toString();
					String V_M_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String V_HSPF_CUR = hashMap.get("HSPF_CUR") == null ? "" : hashMap.get("HSPF_CUR").toString();
					String V_ERP_CUR = hashMap.get("ERP_CUR") == null ? "" : hashMap.get("ERP_CUR").toString();
					String V_PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();

					cs = conn.prepareCall("call USP_END_VS_ERP_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_GR_FR_DT
					cs.setString(2, V_GR_FR_DT);//V_GR_FR_DT
					cs.setString(3, V_GR_TO_DT);//V_GR_FR_DT
					cs.setString(4, V_M_BP_NM);//V_M_BP_NM
					cs.setString(5, V_ITEM_CD);//V_M_BP_NM
					cs.setString(6, V_GR_DT);//V_M_BP_NM
					cs.setString(7, V_PO_NO);//V_M_BP_NM
					cs.setString(8, V_HSPF_GR_TYPE_NM);//V_M_BP_NM
					cs.setString(9, V_ERP_GR_TYPE_NM);//V_M_BP_NM
					cs.setString(10, V_HSPF_CUR);//V_M_BP_NM
					cs.setString(11, V_ERP_CUR);//V_M_BP_NM
					cs.setString(12, V_M_BP_CD);//V_M_BP_CD
					cs.setString(13, V_PAY_METH);//V_PAY_METH
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(14);

					String V_ERP_GR_TYPE_CD = "";

					while (rs.next()) {
						V_ERP_GR_TYPE_CD = rs.getString("GR_TYPE_CD");
					}

					String sql = "";

					if (V_ERP_GR_TYPE_CD.equals("MLR") || V_ERP_GR_TYPE_CD.equals("DGR") || V_ERP_GR_TYPE_CD.equals("IGR")) {
						e_cs = e_conn.prepareCall("{call USP_HSPF_M_GR_HSPF_UPDATE(?,?,?,?,?,?,?)}");
						e_cs.setString(1, V_PO_NO);
						e_cs.setString(2, V_ITEM_CD);
						e_cs.setString(3, V_ERP_GR_TYPE_CD);
						e_cs.setString(4, V_ERP_CUR);
						e_cs.setString(5, V_M_BP_CD);
						e_cs.setString(6, V_PAY_METH);
						e_cs.setString(7, V_GR_DT);
						e_cs.execute();
					}
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_M_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_GR_DT = jsondata.get("GR_DT") == null ? "" : jsondata.get("GR_DT").toString().substring(0, 10);
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_HSPF_GR_TYPE_NM = jsondata.get("HSPF_GR_TYPE_NM") == null ? "" : jsondata.get("HSPF_GR_TYPE_NM").toString();
				String V_ERP_GR_TYPE_NM = jsondata.get("ERP_GR_TYPE_NM") == null ? "" : jsondata.get("ERP_GR_TYPE_NM").toString();
				String V_HSPF_CUR = jsondata.get("HSPF_CUR") == null ? "" : jsondata.get("HSPF_CUR").toString();
				String V_ERP_CUR = jsondata.get("ERP_CUR") == null ? "" : jsondata.get("ERP_CUR").toString();
				String V_PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();

				cs = conn.prepareCall("call USP_END_VS_ERP_GR_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_GR_FR_DT
				cs.setString(2, V_GR_FR_DT);//V_GR_FR_DT
				cs.setString(3, V_GR_TO_DT);//V_GR_FR_DT
				cs.setString(4, V_M_BP_NM);//V_M_BP_NM
				cs.setString(5, V_ITEM_CD);//V_M_BP_NM
				cs.setString(6, V_GR_DT);//V_M_BP_NM
				cs.setString(7, V_PO_NO);//V_M_BP_NM
				cs.setString(8, V_HSPF_GR_TYPE_NM);//V_M_BP_NM
				cs.setString(9, V_ERP_GR_TYPE_NM);//V_M_BP_NM
				cs.setString(10, V_HSPF_CUR);//V_M_BP_NM
				cs.setString(11, V_ERP_CUR);//V_M_BP_NM
				cs.setString(12, V_M_BP_CD);//V_M_BP_CD
				cs.setString(13, V_PAY_METH);//V_PAY_METH
				cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();


				String V_ERP_GR_TYPE_CD = "";

				rs = (ResultSet) cs.getObject(14);

				while (rs.next()) {
					V_ERP_GR_TYPE_CD = rs.getString("GR_TYPE_CD");
				}

				String sql = "";

				// 				System.out.println(V_ERP_GR_TYPE_CD + "," + V_PO_NO + "," + V_ITEM_CD);

				if (V_ERP_GR_TYPE_CD.equals("MLR") || V_ERP_GR_TYPE_CD.equals("DGR") || V_ERP_GR_TYPE_CD.equals("IGR")) {
					if (V_ERP_GR_TYPE_CD.equals("MLR") || V_ERP_GR_TYPE_CD.equals("DGR") || V_ERP_GR_TYPE_CD.equals("IGR")) {
						e_cs = e_conn.prepareCall("{call USP_HSPF_M_GR_HSPF_UPDATE(?,?,?,?,?,?,?)}");
						e_cs.setString(1, V_PO_NO);
						e_cs.setString(2, V_ITEM_CD);
						e_cs.setString(3, V_ERP_GR_TYPE_CD);
						e_cs.setString(4, V_ERP_CUR);
						e_cs.setString(5, V_M_BP_CD);
						e_cs.setString(6, V_PAY_METH);
						e_cs.setString(7, V_GR_DT);
						e_cs.execute();
					}
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

		//MSSQL
		if (e_cs != null) try {
			e_cs.close();
		} catch (SQLException ex) {}
		if (e_rs != null) try {
			e_rs.close();
		} catch (SQLException ex) {}
		if (e_stmt != null) try {
			e_stmt.close();
		} catch (SQLException ex) {}
		if (e_conn != null) try {
			e_conn.close();
		} catch (SQLException ex) {}
	}
%>



