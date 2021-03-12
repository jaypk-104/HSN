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

	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? ""
				: request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? ""
				: request.getParameter("V_USR_ID").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_NM") == null ? ""
				: request.getParameter("V_BP_NM").toUpperCase();

		//상단
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_B_AUTONUM_PONO_HSPF(?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_COMP_ID
			cs.setString(2, V_COMP_ID);//
			cs.setString(3, V_BP_CD);//V_DN_DT_FR
			cs.setString(4, "");//V_DN_DT_TO
			cs.setString(5, "");//V_DN_DT_TO
			cs.setString(6, "");//V_DN_DT_TO
			cs.setString(7, V_USR_ID);//V_DN_DT_TO
			cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(8);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("PREFIX_NO", rs.getString("PREFIX_NO"));
				subObject.put("DATE_TYPE", rs.getString("DATE_TYPE"));
				subObject.put("DATE_TYPE_NM", rs.getString("DATE_TYPE_NM"));
				subObject.put("LEN_INT", rs.getString("LEN_INT"));

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

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					String V_PREFIX_NO = hashMap.get("PREFIX_NO") == null ? ""
							: hashMap.get("PREFIX_NO").toString();
					String V_DATE_TYPE = hashMap.get("DATE_TYPE") == null ? ""
							: hashMap.get("DATE_TYPE").toString();
					String V_LEN_INT = hashMap.get("LEN_INT") == null ? "" : hashMap.get("LEN_INT").toString();

					cs = conn.prepareCall("call USP_B_AUTONUM_PONO_HSPF(?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_COMP_ID
					cs.setString(2, V_COMP_ID);//
					cs.setString(3, V_BP_CD);//V_DN_DT_FR
					cs.setString(4, V_PREFIX_NO);//V_PREFIX_NO
					cs.setString(5, V_DATE_TYPE);//V_DATE_TYPE
					cs.setString(6, V_LEN_INT);//V_LEN_INT
					cs.setString(7, V_USR_ID);//V_DN_DT_TO
					cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
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
				V_BP_CD = jsondata.get("BP_CD") == null ? "" : jsondata.get("BP_CD").toString();
				String V_PREFIX_NO = jsondata.get("PREFIX_NO") == null ? ""
						: jsondata.get("PREFIX_NO").toString();
				String V_DATE_TYPE = jsondata.get("DATE_TYPE") == null ? ""
						: jsondata.get("DATE_TYPE").toString();
				String V_LEN_INT = jsondata.get("LEN_INT") == null ? "" : jsondata.get("LEN_INT").toString();

				cs = conn.prepareCall("call USP_B_AUTONUM_PONO_HSPF(?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_COMP_ID
				cs.setString(2, V_COMP_ID);//
				cs.setString(3, V_BP_CD);//V_DN_DT_FR
				cs.setString(4, V_PREFIX_NO);//V_PREFIX_NO
				cs.setString(5, V_DATE_TYPE);//V_DATE_TYPE
				cs.setString(6, V_LEN_INT);//V_LEN_INT
				cs.setString(7, V_USR_ID);//V_DN_DT_TO
				cs.registerOutParameter(8, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
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


