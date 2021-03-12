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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.reflect.InvocationTargetException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	CallableStatement cs2 = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	String V_PO_NO = "";
	String V_PO_SEQ = "";

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_M_BP_CD = request.getParameter("V_M_BP_CD") == null ? "" : request.getParameter("V_M_BP_CD").toUpperCase();

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call USP_003_M_PO_BASE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//
			cs.setString(3, V_M_BP_CD);//V_MAST_PO_NO
			cs.setString(4, "");//V_PO_USR_NM
			cs.setString(5, "");//V_PO_USR_NM
			cs.setString(6, "");//V_PO_USR_NM
			cs.setString(7, "");//V_PO_USR_NM
			cs.setString(8, "");//V_PO_USR_NM
			cs.setString(9, "");//V_PO_USR_NM
			cs.setString(10, "");//V_PO_USR_NM
			cs.setString(11, "");//V_PO_USR_NM
			cs.setString(12, "");//V_PO_USR_NM
			cs.setString(13, "");//V_PO_USR_NM
			cs.setString(14, "");//V_PO_USR_NM
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("COMP_ID", rs.getString("COMP_ID"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_TYPE_NM", rs.getString("PO_TYPE_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("SYS_TYPE", rs.getString("SYS_TYPE"));
				subObject.put("SYS_TYPE_NM", rs.getString("SYS_TYPE_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
				subObject.put("GR_TYPE_NM", rs.getString("GR_TYPE_NM"));
				subObject.put("DLV_TYPE", rs.getString("DLV_TYPE"));
				subObject.put("DLV_TYPE_NM", rs.getString("DLV_TYPE_NM"));
				subObject.put("VAT_TYPE", rs.getString("VAT_TYPE"));
				subObject.put("VAT_TYPE_NM", rs.getString("VAT_TYPE_NM"));
				subObject.put("TRANS_TYPE", rs.getString("TRANS_TYPE"));
				subObject.put("TRANS_TYPE_NM", rs.getString("TRANS_TYPE_NM"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("DISCHGE_PORT_NM", rs.getString("DISCHGE_PORT_NM"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("DISCHGE_PORT", rs.getString("DISCHGE_PORT"));
				subObject.put("INSRT_USR_ID", rs.getString("INSRT_USR_ID"));
				subObject.put("UPDT_USR_ID", rs.getString("UPDT_USR_ID"));
				subObject.put("INSRT_USR_NM", rs.getString("INSRT_USR_NM"));
				subObject.put("UPDT_USR_NM", rs.getString("UPDT_USR_NM"));
				subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
				subObject.put("UPDT_DT", rs.getString("UPDT_DT"));

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
					String M_BP_CD = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					String PO_TYPE = hashMap.get("PO_TYPE") == null ? "" : hashMap.get("PO_TYPE").toString();
					String IN_TERMS = hashMap.get("IN_TERMS") == null ? "" : hashMap.get("IN_TERMS").toString();
					String PAY_METH = hashMap.get("PAY_METH") == null ? "" : hashMap.get("PAY_METH").toString();
					String CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String VAT_TYPE = hashMap.get("VAT_TYPE") == null ? "" : hashMap.get("VAT_TYPE").toString();
					String DLV_TYPE = hashMap.get("DLV_TYPE") == null ? "" : hashMap.get("DLV_TYPE").toString();
					String SYS_TYPE = hashMap.get("SYS_TYPE") == null ? "" : hashMap.get("SYS_TYPE").toString();
					String GR_TYPE = hashMap.get("GR_TYPE") == null ? "" : hashMap.get("GR_TYPE").toString();
					String TRANS_TYPE = hashMap.get("TRANS_TYPE") == null ? "" : hashMap.get("TRANS_TYPE").toString();
					String DISCHGE_PORT = hashMap.get("DISCHGE_PORT") == null ? "" : hashMap.get("DISCHGE_PORT").toString();

					// 					System.out.println("V_CHG_DLV_DT:"  + V_CHG_DLV_DT);
					cs = conn.prepareCall("call USP_003_M_PO_BASE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//
					cs.setString(3, M_BP_CD);//V_MAST_PO_NO
					cs.setString(4, PO_TYPE);//V_PO_USR_NM
					cs.setString(5, IN_TERMS);//V_PO_USR_NM
					cs.setString(6, PAY_METH);//V_PO_USR_NM
					cs.setString(7, CUR);//V_PO_USR_NM
					cs.setString(8, VAT_TYPE);//V_PO_USR_NM
					cs.setString(9, DLV_TYPE);//V_PO_USR_NM
					cs.setString(10, GR_TYPE);//V_PO_USR_NM
					cs.setString(11, TRANS_TYPE);//V_PO_USR_NM
					cs.setString(12, DISCHGE_PORT);//V_PO_USR_NM
					cs.setString(13, SYS_TYPE);//V_PO_USR_NM
					cs.setString(14, V_USR_ID);//V_PO_USR_NM
					cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

				}
			} else {

				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String M_BP_CD = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				String PO_TYPE = jsondata.get("PO_TYPE") == null ? "" : jsondata.get("PO_TYPE").toString();
				String IN_TERMS = jsondata.get("IN_TERMS") == null ? "" : jsondata.get("IN_TERMS").toString();
				String PAY_METH = jsondata.get("PAY_METH") == null ? "" : jsondata.get("PAY_METH").toString();
				String CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String VAT_TYPE = jsondata.get("VAT_TYPE") == null ? "" : jsondata.get("VAT_TYPE").toString();
				String DLV_TYPE = jsondata.get("DLV_TYPE") == null ? "" : jsondata.get("DLV_TYPE").toString();
				String SYS_TYPE = jsondata.get("SYS_TYPE") == null ? "" : jsondata.get("SYS_TYPE").toString();
				String GR_TYPE = jsondata.get("GR_TYPE") == null ? "" : jsondata.get("GR_TYPE").toString();
				String TRANS_TYPE = jsondata.get("TRANS_TYPE") == null ? "" : jsondata.get("TRANS_TYPE").toString();
				String DISCHGE_PORT = jsondata.get("DISCHGE_PORT") == null ? "" : jsondata.get("DISCHGE_PORT").toString();

				// 					System.out.println("V_CHG_DLV_DT:"  + V_CHG_DLV_DT);
				cs = conn.prepareCall("call USP_003_M_PO_BASE_INFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//
				cs.setString(3, M_BP_CD);//V_MAST_PO_NO
				cs.setString(4, PO_TYPE);//V_PO_USR_NM
				cs.setString(5, IN_TERMS);//V_PO_USR_NM
				cs.setString(6, PAY_METH);//V_PO_USR_NM
				cs.setString(7, CUR);//V_PO_USR_NM
				cs.setString(8, VAT_TYPE);//V_PO_USR_NM
				cs.setString(9, DLV_TYPE);//V_PO_USR_NM
				cs.setString(10, GR_TYPE);//V_PO_USR_NM
				cs.setString(11, TRANS_TYPE);//V_PO_USR_NM
				cs.setString(12, DISCHGE_PORT);//V_PO_USR_NM
				cs.setString(13, SYS_TYPE);//V_PO_USR_NM
				cs.setString(14, V_USR_ID);//V_PO_USR_NM
				cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
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
		if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (cs2 != null)
			try {
				cs2.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>


