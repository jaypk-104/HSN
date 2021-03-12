<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="java.util.Enumeration"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.net.*"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	if (conn == null) {
		System.out.println("Tibero DBConnection Fail");
		System.exit(-1);
	}
	stmt = conn.createStatement();
	CallableStatement cs = null;
	JSONObject jsonObject = null;
	JSONArray jsonArray = null;
	JSONObject subObject = null;
	JSONParser parser = new JSONParser();
	ResultSet rs = null;
	String sql = null;

	try {

		String B_TYPE = request.getParameter("B_TYPE");
		System.out.println(B_TYPE);

		/* 테스트 */
		if (B_TYPE.equals("LOGIN")) {
			String V_USR_ID = null;
// 			String V_PASSWORD = null;

			String data = request.getParameter("data");
			System.out.println("data" + data);
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			V_USR_ID = j.get("ID").toString().toUpperCase();
// 			V_PASSWORD = j.get("PWD").toString();

			cs = conn.prepareCall("call USP_BARCODE(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, B_TYPE);//B_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, V_USR_ID);//V_USR_ID
			cs.setString(4, "");//V_PASSWORD
			cs.setString(5, "");//V_PASSWORD
			cs.setString(6, "");//V_PASSWORD
			cs.setString(7, "");//V_PASSWORD
			cs.setString(8, "");//V_PASSWORD
			cs.setString(9, "");//V_PASSWORD
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);

			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);

			while (rs.next()) {
				if (rs.getString("COMP_ID").equals("") || rs.getString("COMP_ID").equals("null")) {
					out.println("NO");
				} else {
					out.println("{\"RESULT\": \"YES\",\"COMP_ID\": \"" + rs.getString("COMP_ID") + "\",\"USR_NM\": \"" + rs.getString("USR_NM") + "\"}");
				}
			}

			/* 창고1 */
		} else if (B_TYPE.equals("SL")) {

			String data = request.getParameter("data");
			// 			System.out.println(data);
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String comp_id = j.get("COMP_ID").toString().toUpperCase();

			sql = "SELECT SL_CD, SL_NM FROM B_STORAGE_HSPF WHERE COMP_ID = '" + comp_id + "'";
			rs = stmt.executeQuery(sql);

			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CODE", rs.getString("SL_CD"));
				subObject.put("NAME", rs.getString("SL_NM"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			/* 창고2 */
		} else if (B_TYPE.equals("LC")) {

			String data = request.getParameter("data");

			// 			System.out.println(data);
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String comp_id = j.get("COMP_ID").toString().toUpperCase();
			String sl_cd = j.get("SL_CD").toString().toUpperCase();

			sql = "SELECT B.LC_CD, B.LC_NM FROM B_STORAGE_HSPF A ";
			sql += " LEFT OUTER JOIN B_LOCATION_HSPF B ON A.SL_CD = B.SL_CD ";
			sql += " WHERE A.COMP_ID = ? AND A.SL_CD = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comp_id);
			pstmt.setString(2, sl_cd);
			rs = pstmt.executeQuery();

			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CODE", rs.getString("LC_CD"));
				subObject.put("NAME", rs.getString("LC_NM"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

			/* 랙 */
		} else if (B_TYPE.equals("RC")) {

			String data = request.getParameter("data");
			// 			System.out.println(data);
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String comp_id = j.get("COMP_ID").toString().toUpperCase();
			String sl_cd = j.get("SL_CD").toString().toUpperCase();
			String lc_cd = j.get("LC_CD").toString().toUpperCase();

			sql = "SELECT C.RACK_CD, C.RACK_NM FROM B_STORAGE_HSPF A ";
			sql += " LEFT JOIN B_LOCATION_HSPF B ON A.SL_CD = B.SL_CD ";
			sql += " LEFT JOIN B_RACK_HSPF C ON A.SL_CD = C.SL_CD AND B.SL_CD = C.SL_CD AND B.LC_CD = C.LC_CD ";
			sql += " WHERE A.COMP_ID = ? AND A.SL_CD = ? AND B.LC_CD = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, comp_id);
			pstmt.setString(2, sl_cd);
			pstmt.setString(3, lc_cd);

			rs = pstmt.executeQuery();

			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CODE", rs.getString("RACK_CD"));
				subObject.put("NAME", rs.getString("RACK_NM"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (B_TYPE.equals("BC")) {

			String data = request.getParameter("data");
// 			System.out.println(data);
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BC_NO = j.get("BAR_NO").toString().toUpperCase();
// 			System.out.println(V_BC_NO);

			cs = conn.prepareCall("call USP_M_GR_BARCODE(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "BC");//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_GR_NO
			cs.setString(4, "");//V_GR_DT
			cs.setString(5, V_BC_NO);//V_BC_NO
			cs.setString(6, "");//V_SL_CD
			cs.setString(7, "");//V_LC_CD
			cs.setString(8, "");//V_RACK_NO
			cs.setString(9, "");//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("STATUS", rs.getString("STATUS")); /* GR 입고, DN 출고, NO 바코드없음, OK 정상 */
				subObject.put("ITEM_CD", rs.getString("ITEM_CD")); /* GR 입고, DN 출고, NO 바코드없음, OK 정상 */
				subObject.put("ITEM_NM", rs.getString("ITEM_NM")); /* GR 입고, DN 출고, NO 바코드없음, OK 정상 */
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
			}

// 			System.out.println(subObject);
			out.println(subObject);

		}else if (B_TYPE.equals("BC2")) {

			String data = request.getParameter("data");
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BC_NO = j.get("BAR_NO").toString().toUpperCase();

			cs = conn.prepareCall("call USP_M_GR_BARCODE(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "BC2");//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_GR_NO
			cs.setString(4, "");//V_GR_DT
			cs.setString(5, V_BC_NO);//V_BC_NO
			cs.setString(6, "");//V_SL_CD
			cs.setString(7, "");//V_LC_CD
			cs.setString(8, "");//V_RACK_NO
			cs.setString(9, "");//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("STATUS", rs.getString("STATUS")); /* GR2 입고안됨, DN 출고, NO 바코드없음, OK2 취소가능 */
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("FROM_SL_NM", rs.getString("FROM_SL_NM"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
			}

// 			System.out.println(subObject);
			out.println(subObject);

		} else if (B_TYPE.equals("GR")) {

			String data = request.getParameter("data");
			// 			System.out.println("data" + data);

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_SL_CD = j.get("SL_CD").toString().toUpperCase();
			String V_LC_CD = j.get("LC_CD").toString().toUpperCase();
			String V_RACK_CD = j.get("RACK_CD").toString().toUpperCase();
			String V_GR_NO = "";

			String[] barArr = V_BAR_NO.split(",");
			for (int i = 0; i < barArr.length; i++) {
				if (i == 0) {
					cs = conn.prepareCall("call USP_M_GR_BARCODE_AUTONUM(?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_GR_DT);
					cs.setString(3, V_USR_ID);
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(4);
					while (rs.next()) {
						V_GR_NO = rs.getString("GR_NO");
					}
				}

				// 				System.out.println("V_GR_NO" + V_GR_NO);
				String V_TYPE = barArr[i].substring(0, 2);

				cs = conn.prepareCall("call USP_M_GR_BARCODE(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_GR_NO);//V_GR_NO
				cs.setString(4, V_GR_DT);//V_GR_DT
				cs.setString(5, barArr[i]);//V_BC_NO
				cs.setString(6, V_SL_CD);//V_SL_CD
				cs.setString(7, V_LC_CD);//V_LC_CD
				cs.setString(8, V_RACK_CD);//V_RACK_NO
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

			}

			out.println("{\"RESULT\": \"YES\"}");

		}else if (B_TYPE.equals("GR_CAN")) {

			String data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();

			String V_TYPE = "GR_CAN";
			cs = conn.prepareCall("call USP_M_GR_BARCODE(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, "");//V_GR_NO
			cs.setString(4, "");//V_GR_DT
			cs.setString(5, V_BAR_NO);//V_BC_NO
			cs.setString(6, "");//V_SL_CD
			cs.setString(7, "");//V_LC_CD
			cs.setString(8, "");//V_RACK_NO
			cs.setString(9, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			rs = (ResultSet) cs.getObject(10);
			String STATUS = "";
			String MSG = "";
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				MSG    = rs.getString("MSG");
			}
			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("RESULT", "YES");
			jsonObject.put("STATUS", STATUS);
			jsonObject.put("MSG", MSG);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR1")) {

			String data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "DD");
			cs.setString(2, "");
			cs.setString(3, V_DD_NO);
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, "");
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.setString(10, "");
			cs.setString(11, "");
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			jsonArray = new JSONArray();
			String STATUS = "";
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("FROM_SL_CD", rs.getString("FROM_SL_CD"));
				subObject.put("FROM_SL_NM", rs.getString("FROM_SL_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("DD_QTY", rs.getString("DD_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			jsonObject.put("STATUS", STATUS);

// 			System.out.println(jsonObject);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR1-1")) {/*출고후 출고지시서의 품목잔량을 가져옴*/
			
			String data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_DD_NO   = j.get("DD_NO").toString().toUpperCase();
			String V_ITEM_CD = j.get("ITEM_CD").toString().toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "DD1");
			cs.setString(2, "");
			cs.setString(3, V_DD_NO);
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, "");
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.setString(10, V_ITEM_CD);
			cs.setString(11, "");
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("FROM_SL_CD", rs.getString("FROM_SL_CD"));
				subObject.put("DD_QTY", rs.getString("DD_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			jsonObject.put("STATUS", "OK");

			System.out.println(jsonObject);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR2")) {

			String data = request.getParameter("data");
			System.out.println(data);

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
// 			System.out.println("V_BAR_NO" + V_BAR_NO);

			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "BS");
			cs.setString(2, "");
			cs.setString(3, "");
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, V_BAR_NO);
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.setString(10, "");
			cs.setString(11, "");
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("FROM_SL_CD", rs.getString("GR_SL_CD"));
				subObject.put("FROM_SL_NM", rs.getString("SL_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("STATUS", rs.getString("STATUS")); /*STATUS:  DN 이미출고, NON-GR 입고안됨, NO 바코드없음, OK 정상*/
			}

// 			System.out.println(subObject);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();

		} else if (B_TYPE.equals("DN")) {

			String data = request.getParameter("data");
			System.out.println(data);

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_BP_CD = j.get("BP_CD").toString().toUpperCase();
			String V_DN_DT = j.get("DN_DT").toString().toUpperCase();
// 			String V_FROM_SL_CD = j.get("FROM_SL_CD").toString().toUpperCase();
			String V_TO_SL_CD = j.get("TO_SL_CD").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();
			String V_DN_NO = "";

			String[] barArr = V_BAR_NO.split(",");

			jsonArray = new JSONArray();

			for (int i = 0; i < barArr.length; i++) {
				String V_TYPE = barArr[i].substring(0, 2);

				if (i == 0) {
					cs = conn.prepareCall("call USP_S_DN_BARCODE_AUTONUM(?,?,?,?)");
					cs.setString(1, V_COMP_ID);
					cs.setString(2, V_DN_DT);
					cs.setString(3, V_USR_ID);
					cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					rs = (ResultSet) cs.getObject(4);
					while (rs.next()) {
						V_DN_NO = rs.getString("DN_NO");
					}
				}

				System.out.println(V_TYPE);
				System.out.println(V_DD_NO);
				System.out.println(V_DN_NO);
				System.out.println(V_DN_DT);
				System.out.println(barArr[i]);
				System.out.println(V_BP_CD);
				System.out.println(V_TO_SL_CD);
			
				cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_DD_NO);
				cs.setString(4, V_DN_NO);
				cs.setString(5, V_DN_DT);
				cs.setString(6, barArr[i]);
				cs.setString(7, V_BP_CD);
				cs.setString(8, V_TO_SL_CD);
				cs.setString(9, "");
				cs.setString(10, "");
				cs.setString(11, V_USR_ID);
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();

			}
			out.println("{\"RESULT\": \"YES\"}");
		}else if (B_TYPE.equals("DN_CAN")) {

			String data = request.getParameter("data");
			System.out.println(data);

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();

			jsonArray = new JSONArray();

			String V_TYPE = "DN_CAN";
			System.out.println(V_TYPE);
			System.out.println(V_DD_NO);
			System.out.println(V_BAR_NO);
		
			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_DD_NO);
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, V_BAR_NO);
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.setString(10, "");
			cs.setString(11, V_USR_ID);
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(12);
			String STATUS = "";
			String MSG = "";
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				MSG    = rs.getString("MSG");
			}
			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("RESULT", "YES");
			jsonObject.put("STATUS", STATUS);
			jsonObject.put("MSG", MSG);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}
	} catch (Exception e) {
		e.printStackTrace();
		out.println("{\"RESULT\": \"ERROR\"}");
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (pstmt != null) try {
			pstmt.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (cs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>