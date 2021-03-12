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
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();

		if (V_TYPE.equals("S")) {

			cs = conn.prepareCall("call DISTR_B_BIZ.USP_B_BIZ_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_BP_CD);//V_BP_CD
			cs.setString(4, V_BP_NM);//V_BP_NM
			cs.setString(5, "");//V_IND_TYPE
			cs.setString(6, "");//V_IND_CLASS
			cs.setString(7, "");//V_ADDRESS
			cs.setString(8, "");//V_TEL_NO
			cs.setString(9, "");//V_FAX_NO
			cs.setString(10, "");//V_REMARK
			cs.setString(11, "");//V_NATION
			cs.setString(12, "");//V_MAIN_ITEM
			cs.setString(13, "");//V_OWN_AMT
			cs.setString(14, "");//V_SALE_AMT
			cs.setString(15, "");//V_CR_DT
			cs.setString(16, "");//V_REGION
			cs.setString(17, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(18);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
				subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
				subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
				subObject.put("ADDRESS", rs.getString("ADDRESS"));
				subObject.put("TEL_NO", rs.getString("TEL_NO"));
				subObject.put("FAX_NO", rs.getString("FAX_NO"));
				subObject.put("REG_NM", rs.getString("REG_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("NATION", rs.getString("NATION"));
				subObject.put("MAIN_ITEM", rs.getString("MAIN_ITEM"));
				subObject.put("CR_DT", rs.getString("CR_DT"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("EVALUATION", rs.getString("EVALUATION"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));
				subObject.put("BILL_AMT", rs.getString("BILL_AMT"));
				subObject.put("CAPITAL_AMT", rs.getString("CAPITAL_AMT"));
				subObject.put("BASE_YEAR", rs.getString("BASE_YEAR"));
				subObject.put("UPDT_DT", rs.getString("UPDT_DT"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("BIZ_TYPE_NM", rs.getString("BIZ_TYPE_NM"));
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
					V_BP_CD = hashMap.get("BP_CD") == null ? "" : hashMap.get("BP_CD").toString();
					V_BP_NM = hashMap.get("BP_NM") == null ? "" : hashMap.get("BP_NM").toString();
					String V_BP_REGNO = hashMap.get("BP_REGNO") == null ? "" : hashMap.get("BP_REGNO").toString();
					String V_IND_TYPE = hashMap.get("IND_TYPE") == null ? "" : hashMap.get("IND_TYPE").toString();
					String V_IND_CLASS = hashMap.get("IND_CLASS") == null ? "" : hashMap.get("IND_CLASS").toString();
					String V_ADDRESS = hashMap.get("ADDRESS") == null ? "" : hashMap.get("ADDRESS").toString();
					String V_TEL_NO = hashMap.get("TEL_NO") == null ? "" : hashMap.get("TEL_NO").toString();
					String V_FAX_NO = hashMap.get("FAX_NO") == null ? "" : hashMap.get("FAX_NO").toString();
					String V_REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String V_NATION = hashMap.get("NATION") == null ? "" : hashMap.get("NATION").toString();
					String V_MAIN_ITEM = hashMap.get("MAIN_ITEM") == null ? "" : hashMap.get("MAIN_ITEM").toString();
					String V_OWN_AMT = hashMap.get("OWN_AMT") == null ? "" : hashMap.get("OWN_AMT").toString();
					String V_SALE_AMT = hashMap.get("SALE_AMT") == null ? "" : hashMap.get("SALE_AMT").toString();
					String V_CR_DT = (hashMap.get("CR_DT") == null || hashMap.get("CR_DT").equals("")) ? "" : hashMap.get("CR_DT").toString().substring(0, 10);
					String V_REGION = hashMap.get("REGION") == null ? "" : hashMap.get("REGION").toString();

					cs = conn.prepareCall("call DISTR_B_BIZ.USP_B_BIZ_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_BP_CD);//V_BP_CD
					cs.setString(4, V_BP_NM);//V_BP_NM
					cs.setString(5, V_IND_TYPE);//V_IND_TYPE
					cs.setString(6, V_IND_CLASS);//V_IND_CLASS
					cs.setString(7, V_ADDRESS);//V_ADDRESS
					cs.setString(8, V_TEL_NO);//V_TEL_NO
					cs.setString(9, V_FAX_NO);//V_FAX_NO
					cs.setString(10, V_REMARK);//V_REMARK
					cs.setString(11, V_NATION);//V_NATION
					cs.setString(12, V_MAIN_ITEM);//V_MAIN_ITEM
					cs.setString(13, V_OWN_AMT);//V_OWN_AMT
					cs.setString(14, V_SALE_AMT);//V_SALE_AMT
					cs.setString(15, V_CR_DT);//V_CR_DT
					cs.setString(16, V_REGION);//V_REGION
					cs.setString(17, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
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
				V_BP_NM = jsondata.get("BP_NM") == null ? "" : jsondata.get("BP_NM").toString();
				String V_BP_REGNO = jsondata.get("BP_REGNO") == null ? "" : jsondata.get("BP_REGNO").toString();
				String V_IND_TYPE = jsondata.get("IND_TYPE") == null ? "" : jsondata.get("IND_TYPE").toString();
				String V_IND_CLASS = jsondata.get("IND_CLASS") == null ? "" : jsondata.get("IND_CLASS").toString();
				String V_ADDRESS = jsondata.get("ADDRESS") == null ? "" : jsondata.get("ADDRESS").toString();
				String V_TEL_NO = jsondata.get("TEL_NO") == null ? "" : jsondata.get("TEL_NO").toString();
				String V_FAX_NO = jsondata.get("FAX_NO") == null ? "" : jsondata.get("FAX_NO").toString();
				String V_REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String V_NATION = jsondata.get("NATION") == null ? "" : jsondata.get("NATION").toString();
				String V_MAIN_ITEM = jsondata.get("MAIN_ITEM") == null ? "" : jsondata.get("MAIN_ITEM").toString();
				String V_OWN_AMT = jsondata.get("OWN_AMT") == null ? "" : jsondata.get("OWN_AMT").toString();
				String V_SALE_AMT = jsondata.get("SALE_AMT") == null ? "" : jsondata.get("SALE_AMT").toString();
				String V_CR_DT = (jsondata.get("CR_DT") == null || jsondata.get("CR_DT").equals("")) ? "" : jsondata.get("CR_DT").toString().substring(0, 10);
				String V_REGION = jsondata.get("REGION") == null ? "" : jsondata.get("REGION").toString();

				cs = conn.prepareCall("call DISTR_B_BIZ.USP_B_BIZ_DISTR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_BP_CD);//V_BP_CD
				cs.setString(4, V_BP_NM);//V_BP_NM
				cs.setString(5, V_IND_TYPE);//V_IND_TYPE
				cs.setString(6, V_IND_CLASS);//V_IND_CLASS
				cs.setString(7, V_ADDRESS);//V_ADDRESS
				cs.setString(8, V_TEL_NO);//V_TEL_NO
				cs.setString(9, V_FAX_NO);//V_FAX_NO
				cs.setString(10, V_REMARK);//V_REMARK
				cs.setString(11, V_NATION);//V_NATION
				cs.setString(12, V_MAIN_ITEM);//V_MAIN_ITEM
				cs.setString(13, V_OWN_AMT);//V_OWN_AMT
				cs.setString(14, V_SALE_AMT);//V_SALE_AMT
				cs.setString(15, V_CR_DT);//V_CR_DT
				cs.setString(16, V_REGION);//V_REGION
				cs.setString(17, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(18, com.tmax.tibero.TbTypes.CURSOR);
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


