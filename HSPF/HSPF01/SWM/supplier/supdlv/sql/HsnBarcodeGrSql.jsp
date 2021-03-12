<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
 <%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	ResultSet rs = null;
	ResultSet cfmRs = null;
	ResultSet isRs = null;
	Statement stmt1 = conn.createStatement();
	try {
		//  System.out.println("바코드입고SQL");
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		String sql = null;

		String V_BC_NO = request.getParameter("V_BC_NO");
		//  System.out.println(V_BC_NO);
		String v2 = V_BC_NO.substring(0, 2);
		if (v2.equals("ㅕㅜ")) {
			v2 = "UN";
			V_BC_NO = V_BC_NO.replace("ㅕㅜ", "UN");
		} else if (v2.equals("ㅡㅜ")) {
			v2 = "MN";
			V_BC_NO = V_BC_NO.replace("ㅡㅜ", "MN");
		}
		V_BC_NO = (v2 + V_BC_NO.substring(2)).toUpperCase();

		//  System.out.println("v2 : " + v2);
		String BC_TYPE = null;

		String cfmSql = "SELECT CFM_YN FROM SUPP_BARCD_DTL WHERE PAL_BC_NO='" + V_BC_NO + "' OR BOX_BC_NO='" + V_BC_NO + "'";
		cfmRs = stmt.executeQuery(cfmSql);

		String isSql = "select PAL_BC_NO, BOX_BC_NO from m_supp_to_gr WHERE PAL_BC_NO='" + V_BC_NO + "' OR BOX_BC_NO='" + V_BC_NO + "'";
		isRs = stmt1.executeQuery(isSql);

		String isPalNo = "";
		String isBoxNo = "";
		if (isRs.next()) {
			isPalNo = isRs.getString("PAL_BC_NO");
			isBoxNo = isRs.getString("BOX_BC_NO");
		}
		//  System.out.println("V_BC_NO: " + V_BC_NO);
		//  System.out.println("isPal:" + isPalNo);
		//  System.out.println("isBoxNo:" + isBoxNo);

		if (V_BC_NO.equals(isPalNo) || V_BC_NO.equals(isBoxNo)) {
			subObject = new JSONObject();
			subObject.put("GR_DUP", "DUP");
			jsonArray.add(subObject);
			//  		System.out.println("입고중복");
		} else {
			if (cfmRs.next()) {
				// 			System.out.println("CFM_YN :" + cfmRs.getString("CFM_YN"));
				String CFM_YN = cfmRs.getString("CFM_YN");
				if (cfmRs.getString("CFM_YN").equals("Y")) {
					if (v2.equals("UN")) {
						sql = "SELECT A.ITEM_CD, B.ITEM_NM, SUM(BOX_QTY) BOX_QTY FROM SUPP_BARCD_DTL A, B_ITEM_SWM B ";
						sql += "WHERE A.ITEM_CD=B.ITEM_CD ";
						sql += "AND PAL_BC_NO='" + V_BC_NO + "'";
						sql += "GROUP BY A.ITEM_CD, B.ITEM_NM;";
						BC_TYPE = "PALLET";

					} else if (v2.equals("MN")) {
						sql = "SELECT A.ITEM_CD, B.ITEM_NM, A.BOX_QTY, A.CFM_YN FROM SUPP_BARCD_DTL A, B_ITEM_SWM B ";
						sql += "WHERE A.ITEM_CD=B.ITEM_CD ";
						sql += "AND BOX_BC_NO='" + V_BC_NO + "'";
						BC_TYPE = "BOX";
					}
					rs = stmt.executeQuery(sql);
					while (rs.next()) {
						subObject = new JSONObject();
						// 					System.out.println("rs In");
						// 					System.out.println("rs.get" + rs.getString("ITEM_CD"));

						subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
						subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
						subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
						subObject.put("BC_TYPE", BC_TYPE);
						subObject.put("CFM_YN", CFM_YN);
						subObject.put("V_BC_NO", V_BC_NO);
						jsonArray.add(subObject);
						// 			System.out.println("subObject.get" + subObject);
					}
					jsonObject.put("success", true);
					jsonObject.put("resultList", jsonArray);
					// 			  System.out.println(jsonObject);
				} else if (cfmRs.getString("CFM_YN").equals("N")) {
					subObject = new JSONObject();
					subObject.put("ITEM_CD", "");
					subObject.put("ITEM_NM", "");
					subObject.put("BOX_QTY", "");
					subObject.put("BC_TYPE", "");
					subObject.put("CFM_YN", CFM_YN);
					jsonArray.add(subObject);
				}
			}
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		// 					  System.out.println(jsonObject);
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (isRs != null) try {
			isRs.close();
		} catch (SQLException ex) {}
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (cfmRs != null) try {
			cfmRs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (stmt1 != null) try {
			stmt1.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

