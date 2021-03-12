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
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>
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
		String V_GR_DT_FROM = request.getParameter("V_GR_DT_FROM") == null ? "" : request.getParameter("V_GR_DT_FROM").substring(0, 10);
		String V_GR_DT_TO = request.getParameter("V_GR_DT_TO") == null ? "" : request.getParameter("V_GR_DT_TO").substring(0, 10);
		String V_GR_TYPE = request.getParameter("V_GR_TYPE") == null ? "" : request.getParameter("V_GR_TYPE");
		if (V_GR_TYPE.equals("T")) {
			V_GR_TYPE = "";
		}
		String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM");
		String V_GR_SL_CD = request.getParameter("V_GR_SL_CD") == null ? "" : request.getParameter("V_GR_SL_CD");
		if (V_GR_SL_CD.equals("T")) {
			V_GR_SL_CD = "";
		}
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BL_NO = request.getParameter("V_BL_NO") == null ? "" : request.getParameter("V_BL_NO").toUpperCase();
		if (V_TYPE.equals("S")) {
			String V_GR_NO = request.getParameter("V_GR_NO") == null ? "" : request.getParameter("V_GR_NO").toUpperCase();
			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
			cs = conn.prepareCall("call USP_M_GR_MGM_HSPF_SELECT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_GR_NO);//V_GR_NO   
			cs.setString(4, "");//V_GR_SEQ
			cs.setString(5, V_GR_DT_FROM);//V_GR_DT_FROM
			cs.setString(6, V_GR_DT_TO);//V_GR_DT_TO
			cs.setString(7, V_GR_TYPE);//V_GR_TYPE
			cs.setString(8, V_M_BP_NM);//V_M_BP_NM
			cs.setString(9, V_GR_SL_CD);//V_SL_CD
			cs.setString(10, V_ITEM_CD);//V_ITEM_CD
			cs.setString(11, V_ITEM_NM);//V_ITEM_NM
			cs.setString(12, V_PO_NO);//V_PO_NO
			cs.setString(13, V_BL_NO);//V_BL_NO
			cs.setString(14, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(15, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(15);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
				subObject.put("GR_TYPE_NM", rs.getString("GR_TYPE_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("RM_QTY", rs.getString("RM_QTY"));
				subObject.put("CUR", rs.getString("CUR"));
				subObject.put("XCH_RATE", rs.getString("XCH_RATE"));
				subObject.put("GR_PRC", rs.getString("GR_PRC"));
				subObject.put("GR_AMT", rs.getString("GR_AMT"));
				subObject.put("GR_LOC_AMT", rs.getString("GR_LOC_AMT"));
				subObject.put("DISTB_AMT", rs.getString("DISTB_AMT"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("IF_ERP_YN", rs.getString("IF_ERP_YN"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("GR_NO", rs.getString("GR_NO"));
				subObject.put("BARCODE_YN", rs.getString("BARCODE_YN"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("GR_USR_NM", rs.getString("GR_USR_NM"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
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
					String V_GR_NO = hashMap.get("GR_NO") == null ? "" : hashMap.get("GR_NO").toString();
					String V_GR_SEQ = hashMap.get("GR_SEQ") == null ? "" : hashMap.get("GR_SEQ").toString();
					String V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
					String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();

					cs = conn.prepareCall("call USP_M_GR_MGM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_GR_NO);//V_GR_NO
					cs.setString(4, V_GR_SEQ);//V_GR_SEQ
					cs.setString(5, V_GR_DT_FROM);//V_GR_DT_FROM
					cs.setString(6, V_GR_DT_TO);//V_GR_DT_TO
					cs.setString(7, V_GR_TYPE);//V_GR_TYPE
					cs.setString(8, V_M_BP_NM);//V_M_BP_NM
					cs.setString(9, V_GR_SL_CD);//V_SL_CD
					cs.setString(10, V_PO_NO);//V_ITEM_CD -- V_PO_NO
					cs.setString(11, V_PO_SEQ);//V_ITEM_NM -- V_PO_SEQ
					cs.setString(12, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					String status = "";
					rs = (ResultSet) cs.getObject(13);

					while (rs.next()) {
						status = rs.getString("STATUS");
					}

					if (status.equals("SUCCESS")) { //입고삭제성공시
						e_cs = e_conn.prepareCall("{call USP_HSPF_GR_DELETE(?,?,?)}");
						e_cs.setString(1, V_GR_NO);
						e_cs.setString(2, V_PO_NO);
						e_cs.setString(3, V_PO_SEQ);
						e_cs.execute();
					}
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				String V_GR_NO = jsondata.get("GR_NO") == null ? "" : jsondata.get("GR_NO").toString();
				String V_GR_SEQ = jsondata.get("GR_SEQ") == null ? "" : jsondata.get("GR_SEQ").toString();
				String V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
				String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();

				// 				System.out.println("V_PO_NO" + V_PO_NO);
				// 				System.out.println("V_PO_SEQ" + V_PO_SEQ);

				cs = conn.prepareCall("call USP_M_GR_MGM_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_GR_NO);//V_GR_NO
				cs.setString(4, V_GR_SEQ);//V_GR_SEQ
				cs.setString(5, V_GR_DT_FROM);//V_GR_DT_FROM
				cs.setString(6, V_GR_DT_TO);//V_GR_DT_TO
				cs.setString(7, V_GR_TYPE);//V_GR_TYPE
				cs.setString(8, V_M_BP_NM);//V_M_BP_NM
				cs.setString(9, V_GR_SL_CD);//V_SL_CD
				cs.setString(10, V_PO_NO);//V_ITEM_CD -- V_PO_NO
				cs.setString(11, V_PO_SEQ);//V_ITEM_NM -- V_PO_SEQ
				cs.setString(12, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

				String status = "";
				rs = (ResultSet) cs.getObject(13);

				while (rs.next()) {
					status = rs.getString("STATUS");
				}

				if (status.equals("SUCCESS")) { //입고삭제성공시
					e_cs = e_conn.prepareCall("{call USP_HSPF_GR_DELETE(?,?,?)}");
					e_cs.setString(1, V_GR_NO);
					e_cs.setString(2, V_PO_NO);
					e_cs.setString(3, V_PO_SEQ);
					e_cs.execute();
				}

				// 				System.out.println("=================");
				// 				System.out.println("status" + status);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("SUCCESS");
				pw.flush();
				pw.close();

			}
		}
		if (V_TYPE.equals("IF")) {
			URL url1 = new URL("http://123.142.124.155:8088/http/hsn_cmb_gr_to_erp");
			URLConnection con = url1.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);
			JSONObject anySubObject = new JSONObject();
			//                   anySubObject.put("V_GR_NO", "1");
			//                   anySubObject.put("V_GR_SEQ", "1");
			anySubObject.put("V_USR_ID", V_USR_ID);
			JSONArray anyArray = new JSONArray();
			anyArray.add(anySubObject);
			JSONObject anyObject = new JSONObject();
			anyObject.put("data", anyArray);
			String parameter = anyObject + "";
			//                   System.out.println(parameter);
			OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(parameter);
			wr.flush();
			BufferedReader rd = null;
			rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line = null;
			String result = null;
			while ((line = rd.readLine()) != null) {
				result = URLDecoder.decode(line, "UTF-8");
			}
			//                   System.out.println(result);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
			pw.flush();
			pw.close();
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