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

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

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
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? ""	: request.getParameter("V_USR_ID").toUpperCase();

// 		System.out.println("V_TYPE :" + V_TYPE);

		//상단
		if (V_TYPE.equals("POP_SELECT")) {
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? ""	: request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? ""	: request.getParameter("V_LC_DOC_NO").toUpperCase();

			
			cs = conn.prepareCall("call USP_M_FORWARD_EXCHANGE_REQ_POP_SELECT(?,?,?)");
			cs.setString(1, V_LC_DOC_NO);
			cs.setString(2, V_BL_DOC_NO);
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(3);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("SALE_TYPE_CD", rs.getString("SALE_TYPE_CD"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
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
		else if (V_TYPE.equals("S")) {
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? ""	: request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? ""	: request.getParameter("V_LC_DOC_NO").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? ""	: request.getParameter("V_S_BP_NM").toUpperCase();
			
			
			cs = conn.prepareCall("call USP_M_FORWARD_EXCHANGE_REQ_SELECT(?,?,?,?)");
			cs.setString(1, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(2, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(3, V_S_BP_NM);//V_S_BP_NM
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(4);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("REQ_NO", rs.getString("REQ_NO"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("SALE_TYPE_CD", rs.getString("SALE_TYPE_CD"));
				subObject.put("SALE_TYPE_NM", rs.getString("SALE_TYPE_NM"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("DUE_DT", rs.getString("DUE_DT"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("REQ_DT", rs.getString("REQ_DT"));
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
		else if (V_TYPE.equals("SYNC")) {
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
					String REQ_NO = hashMap.get("REQ_NO") == null ? "" : hashMap.get("REQ_NO").toString();
					String LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
					String BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String DEPT_CD = hashMap.get("DEPT_CD") == null ? "" : hashMap.get("DEPT_CD").toString();
					String S_BP_CD = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String SALE_TYPE_CD = hashMap.get("SALE_TYPE_CD") == null ? "" : hashMap.get("SALE_TYPE_CD").toString();
					String BANK_CD = hashMap.get("BANK_CD") == null ? "" : hashMap.get("BANK_CD").toString();
					String CUR = hashMap.get("CUR") == null ? "" : hashMap.get("CUR").toString();
					String DOC_AMT = hashMap.get("DOC_AMT") == null ? "" : hashMap.get("DOC_AMT").toString();
					String DUE_DT = hashMap.get("DUE_DT") == null ? "" : hashMap.get("DUE_DT").toString();
					String REMARK = hashMap.get("REMARK") == null ? "" : hashMap.get("REMARK").toString();
					String REQ_DT = hashMap.get("REQ_DT") == null ? "" : hashMap.get("REQ_DT").toString();
					
					if(DUE_DT.length() > 10 ){
						DUE_DT = DUE_DT.substring(0,10);
					}
					
					if(REQ_DT.length() > 10 ){
						REQ_DT = REQ_DT.substring(0,10);
					}

					cs = conn.prepareCall("call USP_M_FORWARD_EXCHANGE_REQ_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, REQ_NO);//REQ_NO
					cs.setString(3, LC_NO);//LC_NO
					cs.setString(4, BL_NO);//BL_NO
					cs.setString(5, DEPT_CD);//DEPT_CD
					cs.setString(6, S_BP_CD);//S_BP_CD
					cs.setString(7, SALE_TYPE_CD);//SALE_TYPE_CD
					cs.setString(8, BANK_CD);//BANK_CD
					cs.setString(9, CUR);//CUR
					cs.setString(10, DOC_AMT);//DOC_AMT
					cs.setString(11, DUE_DT);//DUE_DT
					cs.setString(12, REMARK);//REMARK
					cs.setString(13, REQ_DT);//REQ_DT
					cs.setString(14, V_USR_ID);//
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
				String REQ_NO = jsondata.get("REQ_NO") == null ? "" : jsondata.get("REQ_NO").toString();
				String LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
				String BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String DEPT_CD = jsondata.get("DEPT_CD") == null ? "" : jsondata.get("DEPT_CD").toString();
				String S_BP_CD = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String SALE_TYPE_CD = jsondata.get("SALE_TYPE_CD") == null ? "" : jsondata.get("SALE_TYPE_CD").toString();
				String BANK_CD = jsondata.get("BANK_CD") == null ? "" : jsondata.get("BANK_CD").toString();
				String CUR = jsondata.get("CUR") == null ? "" : jsondata.get("CUR").toString();
				String DOC_AMT = jsondata.get("DOC_AMT") == null ? "" : jsondata.get("DOC_AMT").toString();
				String DUE_DT = jsondata.get("DUE_DT") == null ? "" : jsondata.get("DUE_DT").toString();
				String REMARK = jsondata.get("REMARK") == null ? "" : jsondata.get("REMARK").toString();
				String REQ_DT = jsondata.get("REQ_DT") == null ? "" : jsondata.get("REQ_DT").toString();
				
				
				
				if(DUE_DT.length() > 10 ){
					DUE_DT = DUE_DT.substring(0,10);
				}
				
				if(REQ_DT.length() > 10 ){
					REQ_DT = REQ_DT.substring(0,10);
				}
				


				cs = conn.prepareCall("call USP_M_FORWARD_EXCHANGE_REQ_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, REQ_NO);//REQ_NO
				cs.setString(3, LC_NO);//LC_NO
				cs.setString(4, BL_NO);//BL_NO
				cs.setString(5, DEPT_CD);//DEPT_CD
				cs.setString(6, S_BP_CD);//S_BP_CD
				cs.setString(7, SALE_TYPE_CD);//SALE_TYPE_CD
				cs.setString(8, BANK_CD);//BANK_CD
				cs.setString(9, CUR);//CUR
				cs.setString(10, DOC_AMT);//DOC_AMT
				cs.setString(11, DUE_DT);//DUE_DT
				cs.setString(12, REMARK);//REMARK
				cs.setString(13, REQ_DT);//REQ_DT
				cs.setString(14, V_USR_ID);//
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


