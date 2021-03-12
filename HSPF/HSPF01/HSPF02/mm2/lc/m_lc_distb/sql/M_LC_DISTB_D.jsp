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
		String V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO").toUpperCase();
		String V_LC_SEQ = request.getParameter("V_LC_SEQ") == null ? "" : request.getParameter("V_LC_SEQ").toUpperCase();
		String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();

// 				System.out.println("V_PO_NO"  + V_PO_NO);

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call DISTR_LC.USP_M_LC_DISTR_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_LC_NO);//V_LC_NO
			cs.setString(4, V_LC_SEQ);//V_LC_SEQ
			cs.setString(5, "");//V_HS_CD
			cs.setString(6, "");//V_ITEM_CD
			cs.setString(7, "");//V_QTY
			cs.setString(8, "");//V_PRICE
			cs.setString(9, "");//V_DOC_AMT
			cs.setString(10, "");//V_LOC_AMT
			cs.setString(11, "");//V_UNIT
			cs.setString(12, "");//V_OVER_TOL
			cs.setString(13, "");//V_UNDER_TOL
			cs.setString(14, "");//V_PO_NO
			cs.setString(15, "");//V_PO_SEQ
			cs.setString(16, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(18, "");//V_COL_NO
			cs.setString(19, "");//V_COL_SEQ
			cs.setString(20, "");//V_CONT_MGM_NO
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(17);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("HS_CD", rs.getString("HS_CD"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("PO_PRC", rs.getString("PO_PRC"));
				subObject.put("PO_AMT", rs.getString("PO_AMT"));
				subObject.put("PO_LOC_AMT", rs.getString("PO_LOC_AMT"));
				subObject.put("UNDER_TOL", rs.getString("UNDER_TOL"));
				subObject.put("OVER_TOL", rs.getString("OVER_TOL"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_SEQ", rs.getString("LC_SEQ"));
				subObject.put("BRAND", rs.getString("BRAND"));
				subObject.put("ORIGIN", rs.getString("ORIGIN"));
				subObject.put("PLANT_NO", rs.getString("PLANT_NO"));
				subObject.put("COL_NO", rs.getString("COL_NO"));
				subObject.put("COL_SEQ", rs.getString("COL_SEQ"));
				subObject.put("COL_TYPE_NM", rs.getString("COL_TYPE_NM"));
				subObject.put("APPROV_NO", rs.getString("APPROV_NO"));
				subObject.put("APPROV_NM", rs.getString("APPROV_NM"));
				subObject.put("CONT_MGM_NO", rs.getString("CONT_MGM_NO"));
				subObject.put("CHARGE_YN", rs.getString("CHARGE_YN"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("SP")) {

			String V_LC_DT_FR = request.getParameter("V_LC_DT_FR") == null ? "" : request.getParameter("V_LC_DT_FR").toString().substring(0, 10);
			String V_LC_DT_TO = request.getParameter("V_LC_DT_TO") == null ? "" : request.getParameter("V_LC_DT_TO").toString().substring(0, 10);
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM").toUpperCase();
			String V_LC_DOC_NO = request.getParameter("V_LC_DOC_NO") == null ? "" : request.getParameter("V_LC_DOC_NO").toUpperCase();

			cs = conn.prepareCall("call DISTR_LC.USP_M_LC_POPUP(?,?,?,?,?,?,?)");
			cs.setString(1, V_LC_DT_FR);//V_LC_DT_FR
			cs.setString(2, V_LC_DT_TO);//V_LC_DT_TO
			cs.setString(3, V_LC_DOC_NO);//V_LC_DOC_NO
			cs.setString(4, V_M_BP_NM);//V_M_BP_NM
			cs.setString(5, V_S_BP_NM);//V_S_BP_NM
			cs.setString(6, V_PO_NO);//V_PO_NO
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("LC_USR_NM", rs.getString("LC_USR_NM"));
				subObject.put("LC_NO", rs.getString("LC_NO"));
				subObject.put("LC_DOC_NO", rs.getString("LC_DOC_NO"));
				subObject.put("OPEN_DT", rs.getString("OPEN_DT"));
				subObject.put("BANK_CD", rs.getString("BANK_CD"));
				subObject.put("BANK_NM", rs.getString("BANK_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("BP_NM"));
				subObject.put("SO_BP_NM", rs.getString("SO_BP_NM"));
				subObject.put("PAY_METH", rs.getString("PAY_METH"));
				subObject.put("PAY_METH_NM", rs.getString("PAY_METH_NM"));
				subObject.put("IN_TERMS", rs.getString("IN_TERMS"));
				subObject.put("IN_TERMS_NM", rs.getString("IN_TERMS_NM"));
				subObject.put("DOC_AMT", rs.getString("DOC_AMT"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("CANCEL_FLAG", rs.getString("CANCEL_FLAG"));
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

			if (!V_TYPE.equals("V")) {
				if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
					JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

					for (int i = 0; i < jsonAr.size(); i++) {
						HashMap hashMap = (HashMap) jsonAr.get(i);
						V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
						V_LC_NO = hashMap.get("LC_NO") == null ? "" : hashMap.get("LC_NO").toString();
						V_LC_SEQ = hashMap.get("LC_SEQ") == null ? "" : hashMap.get("LC_SEQ").toString();
						V_PO_NO = hashMap.get("PO_NO") == null ? "" : hashMap.get("PO_NO").toString();
						String V_PO_SEQ = hashMap.get("PO_SEQ") == null ? "" : hashMap.get("PO_SEQ").toString();
						String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
						String V_PO_QTY = hashMap.get("PO_QTY") == null ? "" : hashMap.get("PO_QTY").toString();
						String V_PO_PRC = hashMap.get("PO_PRC") == null ? "" : hashMap.get("PO_PRC").toString();
						String V_PO_AMT = hashMap.get("PO_AMT") == null ? "" : hashMap.get("PO_AMT").toString();
						String V_PO_LOC_AMT = hashMap.get("PO_LOC_AMT") == null ? "" : hashMap.get("PO_LOC_AMT").toString();
						String V_HS_CD = hashMap.get("HS_CD") == null ? "" : hashMap.get("HS_CD").toString();
						String V_OVER_TOL = hashMap.get("OVER_TOL") == null ? "" : hashMap.get("OVER_TOL").toString();
						String V_UNDER_TOL = hashMap.get("UNDER_TOL") == null ? "" : hashMap.get("UNDER_TOL").toString();
						String V_COL_NO = hashMap.get("COL_NO") == null ? "" : hashMap.get("COL_NO").toString();
						String V_COL_SEQ = hashMap.get("COL_SEQ") == null ? "" : hashMap.get("COL_SEQ").toString();
						String V_CONT_MGM_NO = hashMap.get("CONT_MGM_NO") == null ? "" : hashMap.get("CONT_MGM_NO").toString();

						if (V_TYPE.equals("I")) {
							V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO");
							V_LC_SEQ = (i + 1) + "";
						}

						cs = conn.prepareCall("call DISTR_LC.USP_M_LC_DISTR_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_LC_NO);//V_LC_NO
						cs.setString(4, V_LC_SEQ);//V_LC_SEQ
						cs.setString(5, V_HS_CD);//V_HS_CD
						cs.setString(6, V_ITEM_CD);//V_ITEM_CD
						cs.setString(7, V_PO_QTY);//V_QTY
						cs.setString(8, V_PO_PRC);//V_PRICE
						cs.setString(9, V_PO_AMT);//V_DOC_AMT
						cs.setString(10, V_PO_LOC_AMT);//V_LOC_AMT
						cs.setString(11, "");//V_UNIT
						cs.setString(12, V_OVER_TOL);//V_OVER_TOL
						cs.setString(13, V_UNDER_TOL);//V_UNDER_TOL
						cs.setString(14, V_PO_NO);//V_PO_NO
						cs.setString(15, V_PO_SEQ);//V_PO_SEQ
						cs.setString(16, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(18, V_COL_NO);//V_COL_NO
						cs.setString(19, V_COL_SEQ);//V_COL_SEQ
						cs.setString(20, V_CONT_MGM_NO);//V_CONT_MGM_NO
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
					V_LC_NO = jsondata.get("LC_NO") == null ? "" : jsondata.get("LC_NO").toString();
					V_LC_SEQ = jsondata.get("LC_SEQ") == null ? "" : jsondata.get("LC_SEQ").toString();
					V_PO_NO = jsondata.get("PO_NO") == null ? "" : jsondata.get("PO_NO").toString();
					String V_PO_SEQ = jsondata.get("PO_SEQ") == null ? "" : jsondata.get("PO_SEQ").toString();
					String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
					String V_PO_QTY = jsondata.get("PO_QTY") == null ? "" : jsondata.get("PO_QTY").toString();
					String V_PO_PRC = jsondata.get("PO_PRC") == null ? "" : jsondata.get("PO_PRC").toString();
					String V_PO_AMT = jsondata.get("PO_AMT") == null ? "" : jsondata.get("PO_AMT").toString();
					String V_PO_LOC_AMT = jsondata.get("PO_LOC_AMT") == null ? "" : jsondata.get("PO_LOC_AMT").toString();
					String V_HS_CD = jsondata.get("HS_CD") == null ? "" : jsondata.get("HS_CD").toString();
					String V_OVER_TOL = jsondata.get("OVER_TOL") == null ? "" : jsondata.get("OVER_TOL").toString();
					String V_UNDER_TOL = jsondata.get("UNDER_TOL") == null ? "" : jsondata.get("UNDER_TOL").toString();
					String V_COL_NO = jsondata.get("COL_NO") == null ? "" : jsondata.get("COL_NO").toString();
					String V_COL_SEQ = jsondata.get("COL_SEQ") == null ? "" : jsondata.get("COL_SEQ").toString();
					String V_CONT_MGM_NO = jsondata.get("CONT_MGM_NO") == null ? "" : jsondata.get("CONT_MGM_NO").toString();

					if (V_TYPE.equals("I")) {
						V_LC_NO = request.getParameter("V_LC_NO") == null ? "" : request.getParameter("V_LC_NO");
						V_LC_SEQ = 1 + "";
					}
					// 					System.out.println("V_TYPE_DTL: " + V_TYPE);
					cs = conn.prepareCall("call DISTR_LC.USP_M_LC_DISTR_D(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, V_LC_NO);//V_LC_NO
					cs.setString(4, V_LC_SEQ);//V_LC_SEQ
					cs.setString(5, V_HS_CD);//V_HS_CD
					cs.setString(6, V_ITEM_CD);//V_ITEM_CD
					cs.setString(7, V_PO_QTY);//V_QTY
					cs.setString(8, V_PO_PRC);//V_PRICE
					cs.setString(9, V_PO_AMT);//V_DOC_AMT
					cs.setString(10, V_PO_LOC_AMT);//V_LOC_AMT
					cs.setString(11, "");//V_UNIT
					cs.setString(12, V_OVER_TOL);//V_OVER_TOL
					cs.setString(13, V_UNDER_TOL);//V_UNDER_TOL
					cs.setString(14, V_PO_NO);//V_PO_NO
					cs.setString(15, V_PO_SEQ);//V_PO_SEQ
					cs.setString(16, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(17, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(18, V_COL_NO);//V_COL_NO
					cs.setString(19, V_COL_SEQ);//V_COL_SEQ
					cs.setString(20, V_CONT_MGM_NO);//V_CONT_MGM_NO
					cs.executeQuery();

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
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


