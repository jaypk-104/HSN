<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
<%@ include file="/HSPF01/common/DB_Connection_ERP_TEMP.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
		String V_GBP_CD = request.getParameter("V_GBP_CD") == null ? "" : request.getParameter("V_GBP_CD").toUpperCase();
		
		
		if (V_TYPE.equals("WS")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_BASE_DT = request.getParameter("V_BASE_DT") == null ? "" : request.getParameter("V_BASE_DT");
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			if(V_BASE_DT.length() > 10){
				V_BASE_DT = V_BASE_DT.substring(0,10);
			}

			
// 			System.out.println(V_TYPE);
// 			System.out.println("V_M_CHARGE_NO : " + V_M_CHARGE_NO);
// 			System.out.println("V_BL_DOC_NO : " + V_BL_DOC_NO);
// 			System.out.println("V_ITEM_NM : " + V_ITEM_NM);
// 			System.out.println("V_BP_CD : " + V_BP_CD);
// 			System.out.println("V_VESSEL_NM : " + V_VESSEL_NM);
// 			System.out.println("V_SHIP_NM : " + V_SHIP_NM);
// 			System.out.println("V_TAX_DT : " + V_TAX_DT);
// 			System.out.println("V_IN_DT : " + V_IN_DT);
			
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_H_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_BASE_DT); //
			cs.setString(4, "00132"); //어짜피 조광만 쓰는거니까 조광 BP_CD 고정으로 넣음.
			cs.setString(5, ""); //
			cs.setString(6, ""); //
			cs.setString(7, ""); //
			cs.setString(8, ""); //
			cs.setInt(9, 0); //
			cs.setString(10,""); //
			cs.setString(11,V_BL_DOC_NO ); //
			cs.setInt(12, 0); // 
			cs.setString(13,""  ); // 
			cs.setString(14,"" ); //
			cs.setInt(15,0); //  
			cs.setString(16,""  ); // 
			cs.setString(17,""  ); // 
			cs.setInt(18,0); // 
			cs.setInt(19,0); // 
			cs.setInt(20,0); // 
			cs.setString(21,""  ); // 
			cs.setInt(22,0); //
			cs.setInt(23,0); // 
			cs.setInt(24,0); //
			cs.setInt(25,0); // 
			cs.setString(26,"" ); //
			cs.setString(27, "" ); // 
			cs.setString(28, V_USR_ID ); // 
			cs.registerOutParameter(29, com.tmax.tibero.TbTypes.CURSOR);
			
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(29);
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("M_CHARGE_NO", rs.getString("M_CHARGE_NO"));
				subObject.put("BASE_DT", rs.getString("BASE_DT"));
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("AV_NM", rs.getString("AV_NM"));
				subObject.put("RK_AMT", rs.getString("RK_AMT"));
				subObject.put("ERP_YN", rs.getString("ERP_YN"));
				subObject.put("PAY_YN", rs.getString("PAY_YN"));
				
				
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
		else if (V_TYPE.equals("BPS")) {
			
			String sql = "select A.BP_CD, A.BP_NM, A.BP_RGST_NO REG_NO, replace(A.BP_RGST_NO, '-', '') REG_NO2 from B_BIZ_PARTNER A ";
				sql += " where len(REPLACE(A.BP_RGST_NO, '-', '')) = 10 ";
// 					sql += " UNION ALL ";
// 					sql += " select ' ' BP_CD, null BP_NM, '&nbsp' BP_RGST_NO ";
// 					sql += " order by BP_CD ";
				   //sql += " LEFT OUTER JOIN M_BP_CHARGE_PARTNER B ON A.BP_CD = B.SELECT_BP_CD ";
				   //sql += " where B.MAST_BP_CD = '"  + G_BP_CD +   "'  order by A.BP_NM";
			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
			e_cs.setString(1, sql); 
			
			rs = e_cs.executeQuery();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DTL_CD", rs.getString("BP_CD"));
				subObject.put("DTL_NM", rs.getString("BP_NM"));
				subObject.put("REG_NO", rs.getString("REG_NO"));
				subObject.put("REG_NO2", rs.getString("REG_NO2"));
				
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
		else if (V_TYPE.equals("W_D_S")) {
			String V_CHARGE_NM = request.getParameter("V_CHARGE_NM") == null ? "" : request.getParameter("V_CHARGE_NM").toUpperCase();
			
			
			String sql = "select A.JNL_CD CHARGE_TYPE, A.JNL_NM CHARGE_NAME  from A_JNL_ITEM A ";
				   sql += " where A.JNL_NM LIKE '%" + V_CHARGE_NM + "%' and JNL_TYPE = 'EC' ";
			e_cs = e_conn.prepareCall("{call dbo.getData(?)}");
			e_cs.setString(1, sql); 
			
			rs = e_cs.executeQuery();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CHARGE_TYPE", rs.getString("CHARGE_TYPE"));
				subObject.put("CHARGE_NAME", rs.getString("CHARGE_NAME"));
				
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
		else if (V_TYPE.equals("CHANGE")) {
			String V_M_CHARGE_NO = request.getParameter("V_M_CHARGE_NO") == null ? "" : request.getParameter("V_M_CHARGE_NO").toUpperCase();
			String V_OLD_CHARGE_TYPE = request.getParameter("V_OLD_CHARGE_TYPE") == null ? "" : request.getParameter("V_OLD_CHARGE_TYPE").toUpperCase();
			String V_NEW_CHARGE_TYPE = request.getParameter("V_NEW_CHARGE_TYPE") == null ? "" : request.getParameter("V_NEW_CHARGE_TYPE").toUpperCase();
			
			cs = conn.prepareCall("{call USP_M_BP_CHARGE_D_CHANGE(?,?,?,?,?)}");
			cs.setString(1, V_TYPE); //
			cs.setString(2, V_M_CHARGE_NO); //
			cs.setString(3, V_OLD_CHARGE_TYPE); //
			cs.setString(4, V_NEW_CHARGE_TYPE); //
			cs.setString(5, V_USR_ID); //
			
			cs.executeQuery();
			
			
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


