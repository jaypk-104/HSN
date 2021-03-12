<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
		String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_CLS_DT_FR = request.getParameter("V_CLS_DT_FR") == null ? "" : request.getParameter("V_CLS_DT_FR").toUpperCase();
		String V_CLS_DT_TO = request.getParameter("V_CLS_DT_TO") == null ? "" : request.getParameter("V_CLS_DT_TO").toUpperCase();
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		if(V_CLS_DT_FR.length() > 10){
			V_CLS_DT_FR = V_CLS_DT_FR.substring(0,10);
		}
		if(V_CLS_DT_TO.length() > 10){
			V_CLS_DT_TO = V_CLS_DT_TO.substring(0,10);
		}
		
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_004_M_COL_ARR_ACPT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_CLS_DT_FR);//V_CLS_DT_FR 
			cs.setString(4, V_CLS_DT_TO);//V_CLS_DT_TO 
			cs.setString(5, V_DEPT_CD);//V_DEPT_CD 
			cs.setString(6, V_LC_DOC_NO);//V_LC_DOC_NO 
			cs.setString(7, V_BL_DOC_NO);//V_BL_DOC_NO 
			cs.setString(8, V_USR_ID);//V_USR_ID 
			cs.setString(9, "");// V_MAST_DB_NO
			cs.setString(10, "");//V_USE_DT
			cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(11);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("MAST_DB_NO", rs.getString("MAST_DB_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("DN_BOX_QTY", rs.getString("DN_BOX_QTY"));
				subObject.put("BL_BOX_QTY", rs.getString("BL_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("COL_TITLE", rs.getString("COL_TITLE"));
				subObject.put("COL_AMT", rs.getString("COL_AMT"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("TEMP_GL_NO", rs.getString("TEMP_GL_NO"));
				subObject.put("USE_YN", rs.getString("USE_YN"));
				subObject.put("USE_DT", rs.getString("USE_DT"));
// 				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("GSAVE")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
// 			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						String MAST_DB_NO = hashMap.get("MAST_DB_NO") == null ? "" : hashMap.get("MAST_DB_NO").toString();
						String USE_YN = hashMap.get("USE_YN") == null ? "" : hashMap.get("USE_YN").toString();
						String USE_DT = hashMap.get("USE_DT") == null ? "" : hashMap.get("USE_DT").toString();
						String BL_DOC_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
						
						if (USE_DT.length() > 10){
							USE_DT = USE_DT.substring(0,10);
						}

						cs = conn.prepareCall("call USP_004_M_COL_ARR_ACPT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");
						if (USE_YN.equals("true")){
							V_TYPE = "C";
						}
						else{
							V_TYPE = "D";
						}
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_CLS_DT_FR 
						cs.setString(4, "");//V_CLS_DT_TO 
						cs.setString(5, "");//V_DEPT_CD 
						cs.setString(6, "");//V_LC_DOC_NO 
						cs.setString(7, BL_DOC_NO);//V_BL_DOC_NO 
						cs.setString(8, V_USR_ID);//V_USR_ID 
						cs.setString(9, MAST_DB_NO);// V_MAST_DB_NO
						cs.setString(10, USE_DT);//V_USE_DT
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("success");
						pw.flush();
						pw.close();

					}
				} else {
// 					JSONObject jsondata = JSONObject.fromObject(jsonData);
					JSONParser parser = new JSONParser();
					Object obj = parser.parse(jsonData);
					JSONObject jsondata = (JSONObject) obj;
					
					String MAST_DB_NO = jsondata.get("MAST_DB_NO") == null ? "" : jsondata.get("MAST_DB_NO").toString();
					String USE_YN = jsondata.get("USE_YN") == null ? "" : jsondata.get("USE_YN").toString();
					String USE_DT = jsondata.get("USE_DT") == null ? "" : jsondata.get("USE_DT").toString();
					String BL_DOC_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
					
					if (USE_DT.length() > 10){
						USE_DT = USE_DT.substring(0,10);
					}
					
					if (USE_YN.equals("true")){
						V_TYPE = "C";
					}
					else{
						V_TYPE = "D";
					}
					
// 					System.out.println("MAST_DB_NO : " + MAST_DB_NO);
// 					System.out.println("USE_YN : " + USE_YN);
// 					System.out.println("USE_DT : " + USE_DT);

					cs = conn.prepareCall("call USP_004_M_COL_ARR_ACPT_HSPF(?,?,?,?,?,?,?,?,?,?,?)");

					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_CLS_DT_FR 
					cs.setString(4, "");//V_CLS_DT_TO 
					cs.setString(5, "");//V_DEPT_CD 
					cs.setString(6, "");//V_LC_DOC_NO 
					cs.setString(7, BL_DOC_NO);//V_BL_DOC_NO 
					cs.setString(8, V_USR_ID);//V_USR_ID 
					cs.setString(9, MAST_DB_NO);// V_MAST_DB_NO
					cs.setString(10, USE_DT);//V_USE_DT
					cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			
		} else if (V_TYPE.equals("ID") || V_TYPE.equals("DD")) {

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


