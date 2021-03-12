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
<%@ include file="/HSPF01/common/DB_Connection137.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	if (conn == null) {
		System.out.println("Tibero DBConnection Fail");
		System.exit(-1);
	}
	if (conn137 == null) {
		System.out.println("Tibero DBConnection Fail");
		System.exit(-1);
	}
	stmt = conn.createStatement();
	stmt137 = conn137.createStatement();
	CallableStatement cs = null;
	JSONObject jsonObject = null;
	JSONArray jsonArray = null;
	JSONObject subObject = null;
	JSONParser parser = new JSONParser();
	ResultSet rs = null;
	String sql = null;
	String B_TYPE = "";
	String data = "";
	/*B_TYPE INFO
	LOGIN : 로그인
	SL : 창고
	LC : LOCATION
	RC : RACK
	BC : 입고바코드정보
	BC2 : 입고취소바코드정보
	GR : 입고
	GR_CAN : 입고취소
	GR2 : 직입고
	REGRBC : 입고반품바코드 조회
	REGR : 입고반품 
	DR1 : 출하지시서정보
	DR1-1 : 출고후 출고지시서 잔량
	DR2 : 출고바코드정보
	DR2-1 : 출고취소바코드정보
	DR3 : 출하지시서정보(직입고)
	DN : 출고
	DN_CAN : 출고취소
	BS : 바코드분할 바코드정보
	BI : 바코드분할
	SM1 : 재고이동 바코드 조회
	SM2 : 재고이동
	REDNBC : 출고반품바코드 조회
	REDN : 출고반품
	BC_STS1 : 출고지시서 확인
	BC_STS2 : 바코드 확인
	STOCK : 재고조사
	SC : 재고조사 리딩 바코드 서버 저장
	STOCK2 : 재고조사 실시간 리딩
	SC2 : 재고조사 실시간 리딩 바코드 서버 저장
	SCGR : 입고예정정보
	--SWM
	BSWMGR : SWM바코드 정보  
	SWMGR : SWM입고
	BSWMDN : SWM바코드 정보
	SWMDN : SWM출고
	POPCONT : SWM출고 컨테이너 팝업
	*/
	try {

		B_TYPE = request.getParameter("B_TYPE");
// 		System.out.println("B_TYPE : " + B_TYPE);
		if (B_TYPE.equals("LOGIN")) {
			String V_USR_ID = null;
// 			String V_PASSWORD = null;

			data = request.getParameter("data");
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
					subObject = new JSONObject();
					subObject.put("RESULT", "YES");
					subObject.put("COMP_ID", rs.getString("COMP_ID"));
					subObject.put("USR_NM", rs.getString("USR_NM"));
					subObject.put("SCM_YN", rs.getString("SCM_YN"));
					subObject.put("SL_CD", rs.getString("SL_CD"));
					subObject.put("SYS_STS", rs.getString("SYS_STS"));
					out.println(subObject);
				}
			}

			/* 창고1 */
		} else if (B_TYPE.equals("SL")) {

			data = request.getParameter("data");

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

			data = request.getParameter("data");

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

			data = request.getParameter("data");
			
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

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BC_NO = j.get("BAR_NO").toString().toUpperCase();

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
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
			}

			out.println(subObject);

		}else if (B_TYPE.equals("BC2")) {

			data = request.getParameter("data");
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
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("FROM_SL_NM", rs.getString("FROM_SL_NM"));
				subObject.put("LC_NM", rs.getString("LC_NM"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("GR_TYPE", rs.getString("GR_TYPE"));
			}

			out.println(subObject);

		} else if (B_TYPE.equals("GR")) {

			data = request.getParameter("data");

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

		}else if (B_TYPE.equals("BSGR2")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_ASN_NO = j.get("ASN_NO").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();

			String V_TYPE = "S";
			
			cs = conn.prepareCall("call USP_DIREC_GR_DN_BARCODE(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ASN_NO);//V_GR_NO
			cs.setString(4, V_GR_DT);//V_DD_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			jsonArray = new JSONArray();
			String STATUS = "";
			String MSG = "";
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				MSG = rs.getString("MSG");
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("LOT_QTY"));
				jsonArray.add(subObject);
			}

			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);
			jsonObject.put("STATUS", STATUS);
			jsonObject.put("MSG", MSG);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("GR2")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_ASN_NO = j.get("ASN_NO").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();

			String V_TYPE = "C";
			
			cs = conn.prepareCall("call USP_DIREC_GR_DN_BARCODE(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ASN_NO);//V_GR_NO
			cs.setString(4, V_GR_DT);//V_DD_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			out.println("{\"RESULT\": \"YES\"}");

		}else if (B_TYPE.equals("GR_CAN")) {

			data = request.getParameter("data");

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

		}else if (B_TYPE.equals("REGRBC")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BC_NO = j.get("BAR_NO").toString().toUpperCase();

			cs = conn.prepareCall("call USP_M_RETURN_BCD(?,?,?,?,?,?)");
			cs.setString(1, "CH");//V_TYPE
			cs.setString(2, "");//V_COMP_ID
			cs.setString(3, "");//V_RE_DT
			cs.setString(4, V_BC_NO);//V_BC_NO
			cs.setString(5, "");//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
			}

			out.println(subObject);

		}else if (B_TYPE.equals("REGR")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BC_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_RE_DT = j.get("RE_DT").toString();
			
			cs = conn.prepareCall("call USP_M_RETURN_BCD(?,?,?,?,?,?)");
			cs.setString(1, V_BC_NO.substring(0, 2));//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_RE_DT);//V_RE_DT
			cs.setString(4, V_BC_NO);//V_BC_NO
			cs.setString(5, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			out.println("{\"RESULT\": \"YES\"}");
		}else if (B_TYPE.equals("DR1")) {

			data = request.getParameter("data");

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
			String MSG = "";
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				MSG = rs.getString("MSG");
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
			jsonObject.put("MSG", MSG);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR1-1")) {/*출고후 출고지시서의 품목잔량을 가져옴*/
			
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_DD_NO   = j.get("DD_NO").toString().toUpperCase();
			String V_ITEM_CD = j.get("ITEM_CD").toString().toUpperCase();
// 			System.out.println(V_DD_NO);
// 			System.out.println(V_ITEM_CD);
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
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR2")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			//System.out.println(B_TYPE);
			//System.out.println(data);
			
			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "BS");
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
			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("FROM_SL_CD", rs.getString("GR_SL_CD"));
				subObject.put("FROM_SL_NM", rs.getString("SL_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR2-1")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "BS2");
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
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();

		}else if (B_TYPE.equals("DR3")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();

			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "DD3");
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

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("SL_NM", rs.getString("TO_SL_NM"));
			}

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();

		} else if (B_TYPE.equals("DN")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_BP_CD = j.get("BP_CD").toString().toUpperCase();
			String V_DN_DT = j.get("DN_DT").toString().toUpperCase();
			String V_TO_SL_CD = j.get("TO_SL_CD").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_DD_NO = j.get("DD_NO").toString().toUpperCase();
			String V_TYPE = V_BAR_NO.substring(0, 2);
		//	System.out.println(B_TYPE);
		//	System.out.println(V_BAR_NO);
			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_DD_NO);
			cs.setString(4, "");
			cs.setString(5, V_DN_DT);
			cs.setString(6, V_BAR_NO);
			cs.setString(7, V_BP_CD);
			cs.setString(8, V_TO_SL_CD);
			cs.setString(9, "");
			cs.setString(10, "");
			cs.setString(11, V_USR_ID);
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(12);
			String BOX_CHK = "";
			while (rs.next()) {
				subObject = new JSONObject();
				BOX_CHK = rs.getString("BOX_CHK");
			}
			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("RESULT", "YES");
			jsonObject.put("BOX_CHK", BOX_CHK);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
			
		}else if (B_TYPE.equals("DN_CAN")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();

			jsonArray = new JSONArray();

			String V_TYPE = "DN_CAN";
		
			cs = conn.prepareCall("call USP_S_DN_BARCODE(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, "");
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
		}else if (B_TYPE.equals("BS")) {
		//바코드 분할 바코드 조회
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			String V_TYPE = "BS";
			
			cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, "");
			cs.setString(2, V_TYPE);
			cs.setString(3, V_BAR_NO);
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
			String STATUS = "";
			String MSG = "";
			jsonArray = new JSONArray();
			while (rs.next()) {
				subObject = new JSONObject();
				STATUS = rs.getString("STATUS");
				MSG    = rs.getString("MSG");
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				jsonArray.add(subObject);
			}
			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("RESULT", "YES");
			jsonObject.put("resultList", jsonArray);
			jsonObject.put("STATUS", STATUS);
			jsonObject.put("MSG", MSG);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("BI")) {
		//바코드 분할
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_ID_DT = j.get("ID_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			String[] barArr = V_BAR_NO.split(",");
			
			String V_TYPE = "BI";
			
			for(int i = 0; i < barArr.length; i++)
			{
				cs = conn.prepareCall("call USP_I_BARCODE_DIVISION(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);
				cs.setString(2, V_TYPE);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, barArr[i]);
				cs.setString(8, "");
				cs.setString(9, V_ID_DT);
				cs.setString(10, "");
				cs.setString(11, V_USR_ID);
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			out.println("{\"RESULT\": \"YES\"}");
		}else if (B_TYPE.equals("SM1")) {
		//재고이동 바코드 조회
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			String V_TYPE = "RS";
			
			cs = conn.prepareCall("call USP_I_STOCK_MOVE_STORAGE(?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, "");
			cs.setString(3, "");
			cs.setString(4, V_BAR_NO);
			cs.setString(5, "");
			cs.setString(6, "");
			cs.setString(7, "");
			cs.setString(8, "");
			cs.setString(9, "");
			cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(10);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("FROM_SL_CD", rs.getString("FROM_SL_CD"));
				subObject.put("FROM_SL_NM", rs.getString("FROM_SL_NM"));
				subObject.put("FROM_LOC", rs.getString("FROM_LOC"));
				subObject.put("FROM_LOC_NM", rs.getString("FROM_LOC_NM"));
				subObject.put("FROM_RACK", rs.getString("FROM_RACK"));
				subObject.put("FROM_RACK_NM", rs.getString("FROM_RACK_NM"));
				subObject.put("QTY", rs.getString("QTY"));
			}
			out.println(subObject);
		}else if (B_TYPE.equals("SM2")) {
		//재고이동
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_MV_DT = j.get("MV_DT").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_ITEM_NO = j.get("ITEM_CD").toString().toUpperCase();
			String V_TO_SL_CD = j.get("TO_SL_CD").toString().toUpperCase();
			String V_TO_LC_CD = j.get("TO_LC_CD").toString().toUpperCase();
			String V_TO_RACK_CD = j.get("TO_RACK_CD").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_TYPE = "";
			jsonObject = new JSONObject();
			if(V_BAR_NO.substring(0, 2).equals("UN")){
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", "MS");
				jsonObject.put("MSG", "팔렛 바코드는 재고이동 할 수 없습니다.");
			}else if (V_BAR_NO.substring(0, 2).equals("MN")){
				cs = conn.prepareCall("call USP_I_STOCK_MOVE_STORAGE(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "MN");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_MV_DT);
				cs.setString(4, V_BAR_NO);
				cs.setString(5, V_ITEM_NO);
				cs.setString(6, V_TO_SL_CD);
				cs.setString(7, V_TO_LC_CD);
				cs.setString(8, V_TO_RACK_CD);
				cs.setString(9, V_USR_ID);
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", "");
				jsonObject.put("MSG", "");
			}else if (V_BAR_NO.substring(0, 2).equals("LN")){
				cs = conn.prepareCall("call USP_I_STOCK_MOVE_STORAGE(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "LN");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_MV_DT);
				cs.setString(4, V_BAR_NO);
				cs.setString(5, V_ITEM_NO);
				cs.setString(6, V_TO_SL_CD);
				cs.setString(7, V_TO_LC_CD);
				cs.setString(8, V_TO_RACK_CD);
				cs.setString(9, V_USR_ID);
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", "");
				jsonObject.put("MSG", "");
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("REDNBC")) {
		//출고반품바코드조회
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			String V_TYPE = "CH";
			
			cs = conn.prepareCall("call USP_S_RETURN_BCD(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, "");
			cs.setString(3, "");
			cs.setString(4, V_BAR_NO);
			cs.setString(5, "");
			cs.setString(6, "");
			cs.setString(7, "");
			cs.setString(8, "");
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("QTY"));
			}
			out.println(subObject);
		}else if (B_TYPE.equals("REDN")) {
		//출고반품
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_RE_DT = j.get("RE_DT").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_SL_CD = j.get("SL_CD").toString().toUpperCase();
			String V_LC_CD = j.get("LC_CD").toString().toUpperCase();
			String V_RACK_CD = j.get("RACK_CD").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_TYPE = "";
			jsonObject = new JSONObject();
			if (V_BAR_NO.substring(0, 2).equals("MN")){
				cs = conn.prepareCall("call USP_S_RETURN_BCD(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "MN");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_RE_DT);
				cs.setString(4, V_BAR_NO);
				cs.setString(5, V_SL_CD);
				cs.setString(6, V_LC_CD);
				cs.setString(7, V_RACK_CD);
				cs.setString(8, V_USR_ID);
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", "");
				jsonObject.put("MSG", "");
			}else if (V_BAR_NO.substring(0, 2).equals("LN")){
				cs = conn.prepareCall("call USP_S_RETURN_BCD(?,?,?,?,?,?,?,?,?)");
				cs.setString(1, "LN");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_RE_DT);
				cs.setString(4, V_BAR_NO);
				cs.setString(5, V_SL_CD);
				cs.setString(6, V_LC_CD);
				cs.setString(7, V_RACK_CD);
				cs.setString(8, V_USR_ID);
				cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", "");
				jsonObject.put("MSG", "");
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("BC_STS1")) {
		//출고지시서 확인
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			jsonObject = new JSONObject();
			cs = conn.prepareCall("call USP_GET_BARCODE_INFO(?,?,?)");
			cs.setString(1, B_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(3);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("RESULT", "YES");
				subObject.put("STATUS", "OK");
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("ITEM_CNT", rs.getString("ITEM_CNT"));
				subObject.put("ITEM_QTY", rs.getString("ITEM_QTY"));
				subObject.put("ITEMJ_CNT", rs.getString("ITEMJ_CNT"));
				subObject.put("ITEMJ_QTY", rs.getString("ITEMJ_QTY"));
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("BC_STS2")) {
		//바코드 확인
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			
			jsonObject = new JSONObject();
			cs = conn.prepareCall("call USP_GET_BARCODE_INFO(?,?,?)");
			cs.setString(1, B_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.registerOutParameter(3, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(3);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("RESULT", "YES");		
				subObject.put("STATUS", rs.getString("STATUS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("LOC_CD", rs.getString("LOC_CD"));
				subObject.put("LOC_NM", rs.getString("LOC_NM"));
				subObject.put("RACK_CD", rs.getString("RACK_CD"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("MVMT_QTY", rs.getString("MVMT_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(subObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("STOCK")) {
		//재고 조사
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			jsonObject = new JSONObject();
			cs = conn.prepareCall("call USP_GET_MVMT_BARCODE_INFO(?,?,?,?,?,?)");
			cs.setString(1, "S");
			cs.setString(2, V_COMP_ID);
			cs.setString(3, "");//LOT_BC_NO
			cs.setString(4, "");//AUDIT_DT
			cs.setString(5, V_USR_ID);
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			
			jsonArray = new JSONArray();
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("LOT_NM", rs.getString("LOT_NM"));
				subObject.put("RACK_NM", rs.getString("RACK_NM"));
				subObject.put("SPLIT_FLG", rs.getString("SPLIT_FLG"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("BC_FLG", rs.getString("BC_FLG"));
				jsonArray.add(subObject);
			}
			jsonObject = new JSONObject();
			jsonObject.put("success", true);
			jsonObject.put("RESULT", "YES");
			jsonObject.put("resultList", jsonArray);
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("SC")) {
		//재고 조사 리딩 바코드 서버 저장
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_AUDIT_DT = j.get("AUDIT_DT").toString().toUpperCase();
			
			try {
				System.out.println("트라이");
				subObject = new JSONObject();
				subObject.put("RESULT", "YES");
				subObject.put("STATUS", "OK");
				out.println(subObject);
			} catch (Exception ex) {
			
			} finally {
				cs = conn.prepareCall("call USP_GET_MVMT_BARCODE_INFO(?,?,?,?,?,?)");
				cs.setString(1, "C");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, V_BAR_NO);//LOT_BC_NO 
				cs.setString(4, V_AUDIT_DT);//AUDIT_DT
				cs.setString(5, V_USR_ID);
				cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			/*
			String[] barArr = V_BAR_NO.split(",");
			for (int i = 0; i < barArr.length; i++) {
				cs = conn.prepareCall("call USP_GET_MVMT_BARCODE_INFO(?,?,?,?,?,?)");
				cs.setString(1, "C");
				cs.setString(2, V_COMP_ID);
				cs.setString(3, barArr[i]);//LOT_BC_NO 
				cs.setString(4, V_AUDIT_DT);//AUDIT_DT
				cs.setString(5, V_USR_ID);
				cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			*/
			
			
		}else if (B_TYPE.equals("STOCK2")) {
		//재고 조사
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_AUDIT_DT = j.get("AUDIT_DT").toString().toUpperCase();
			
			jsonObject = new JSONObject();
			cs = conn.prepareCall("call USP_GET_MVMT_BARCODE_INFO(?,?,?,?,?,?)");
			cs.setString(1, "S2");
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_BAR_NO);//LOT_BC_NO
			cs.setString(4, V_AUDIT_DT);//AUDIT_DT
			cs.setString(5, V_USR_ID);
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			
			String STATUS = "";
			String MSG = "";
			String BAR_CNT = "";
			String BAR_TOT_QTY = "";
			String BOX_BC_NO = "";
			String LOT_BC_NO = "";
			String ITEM_CD = "";
			String ITEM_NM = "";
			String SL_NM = "";
			String LOCATION_NM = "";
			String RACK_NM = "";
			String QTY = "";
			String BC_FLG = "";
			
			jsonArray = new JSONArray();
			
			if(V_BAR_NO.substring(0, 2).equals("MN")){
				while (rs.next()) {
					subObject = new JSONObject();
					STATUS = rs.getString("STATUS");
					MSG = rs.getString("MSG");
					BAR_CNT = rs.getString("BAR_CNT");					
					BAR_TOT_QTY = rs.getString("BAR_TOT_QTY");
					BOX_BC_NO = rs.getString("BOX_BC_NO");
					LOT_BC_NO = rs.getString("LOT_BC_NO");
					ITEM_CD = rs.getString("ITEM_CD");
					ITEM_NM = rs.getString("ITEM_NM");
					SL_NM = rs.getString("SL_NM");
					LOCATION_NM = rs.getString("LC_NM");
					RACK_NM = rs.getString("RACK_NM");
					QTY = rs.getString("QTY");
					BC_FLG = rs.getString("BC_FLG");
				}
				jsonObject = new JSONObject();
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", STATUS);
				jsonObject.put("MSG", MSG);
				jsonObject.put("BAR_CNT", BAR_CNT);
				jsonObject.put("BAR_TOT_QTY", BAR_TOT_QTY);
				jsonObject.put("BOX_BC_NO", BOX_BC_NO);
				jsonObject.put("LOT_BC_NO", LOT_BC_NO);
				jsonObject.put("ITEM_CD", ITEM_CD);
				jsonObject.put("ITEM_NM", ITEM_NM);
				jsonObject.put("SL_NM", SL_NM);
				jsonObject.put("LOCATION_NM", LOCATION_NM);
				jsonObject.put("RACK_NM", RACK_NM);
				jsonObject.put("QTY", QTY);
				jsonObject.put("BC_FLG", BC_FLG);
			}
			else
			{
				while (rs.next()) {
					subObject = new JSONObject();
					STATUS = rs.getString("STATUS");
					MSG = rs.getString("MSG");
					BAR_CNT = rs.getString("BAR_CNT");
					BAR_TOT_QTY = rs.getString("BAR_TOT_QTY");
					subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
					subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
					subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("SL_NM", rs.getString("SL_NM"));
					subObject.put("LOCATION_NM", rs.getString("LC_NM"));
					subObject.put("RACK_NM", rs.getString("RACK_NM"));
					subObject.put("QTY", rs.getString("QTY"));
					subObject.put("BC_FLG", rs.getString("BC_FLG"));
					jsonArray.add(subObject);
				}
				jsonObject = new JSONObject();
				jsonObject.put("success", true);
				jsonObject.put("RESULT", "YES");
				jsonObject.put("STATUS", STATUS);
				jsonObject.put("MSG", MSG);
				jsonObject.put("BAR_CNT", BAR_CNT);
				jsonObject.put("BAR_TOT_QTY", BAR_TOT_QTY);
				jsonObject.put("resultList", jsonArray);
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("SC2")) {
		//재고 조사 리딩 바코드 서버 저장
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			String V_AUDIT_DT = j.get("AUDIT_DT").toString().toUpperCase();
			
			cs = conn.prepareCall("call USP_GET_MVMT_BARCODE_INFO(?,?,?,?,?,?)");
			cs.setString(1, "C2");
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_BAR_NO);//LOT_BC_NO 
			cs.setString(4, V_AUDIT_DT);//AUDIT_DT
			cs.setString(5, V_USR_ID);
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			
			out.println("{\"RESULT\": \"YES\"}");
		}else if (B_TYPE.equals("SCGR")) {
		//입고예정정보
			data = request.getParameter("data");
		
			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);
			
			String V_COMP_ID = j.get("COMP_ID").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_GR_STS = j.get("GR_STS").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			
			cs = conn.prepareCall("call USP_GET_GRSCHEDUL_LIST(?,?,?,?,?,?)");
			cs.setString(1, "S");
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_GR_DT);
			cs.setString(4, V_GR_STS);
			cs.setString(5, V_USR_ID);
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			
			jsonArray = new JSONArray();
			
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BAR_CNT", rs.getString("BAR_CNT"));
				subObject.put("BAR_QTY", rs.getString("BAR_QTY"));
				subObject.put("GR_CNT", rs.getString("GR_CNT"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));
				subObject.put("JCNT", rs.getString("JCNT"));
				subObject.put("JQTY", rs.getString("JQTY"));
				subObject.put("REMARK", rs.getString("REMARK"));
				
				jsonArray.add(subObject);
			}
			
			jsonObject = new JSONObject();
			jsonObject.put("RESULT", "YES");
			jsonObject.put("resultList", jsonArray);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
		}else if (B_TYPE.equals("BSWMGR")) {
			//SWM입고바코드정보
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			
			String V_TYPE = "S";
			
			//cs = conn137.prepareCall("call USP_PDA_SUPP_TO_GR_INSERT(?,?,?,?,?)");
			cs = conn137.prepareCall("call USP_SUPP_TO_GR_INSERT(?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.setString(3, V_USR_ID);//V_USR
			cs.setString(4, V_GR_DT);//V_GR_DT
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("CNT", rs.getString("CNT"));
			}
			out.println(subObject);
		}else if (B_TYPE.equals("SWMGR")) {
			//SWM입고전송
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_GR_DT = j.get("GR_DT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			
			String V_TYPE = "I";
			
			//cs = conn137.prepareCall("call USP_PDA_SUPP_TO_GR_INSERT(?,?,?,?,?)");
			cs = conn137.prepareCall("call USP_SUPP_TO_GR_INSERT(?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.setString(3, V_USR_ID);//V_USR
			cs.setString(4, V_GR_DT);//V_GR_DT
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("MSG", rs.getString("MSG"));
			}
			out.println(subObject);
		}else if (B_TYPE.equals("POPCONT")) {

			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			sql = "SELECT CONT_NO CONT FROM S_CONTAINER_MST where cfm_yn='N' ORDER BY CONT_DT DESC";
			rs = stmt137.executeQuery(sql);

			jsonArray = new JSONArray();

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CONT", rs.getString("CONT"));
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
		}else if (B_TYPE.equals("BSWMDN")) {
			//SWM출고바코드정보
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_DN_DT = j.get("DN_DT").toString().toUpperCase();
			String V_CON_NO = j.get("CONT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			
			String V_TYPE = "S";
			
			//cs = conn137.prepareCall("call USP_PDA_DN_HSNA_INSERT(?,?,?,?,?,?)");
			cs = conn137.prepareCall("call USP_DN_HSNA_INSERT(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.setString(3, V_USR_ID);//V_USR
			cs.setString(4, V_CON_NO);//V_CON_NO
			cs.setString(5, V_DN_DT);//V_DN_DT
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("MSG", rs.getString("MSG"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("CNT", rs.getString("CNT"));
			}
			out.println(subObject);
		}else if (B_TYPE.equals("SWMDN")) {
			//SWM출고전송
			data = request.getParameter("data");

			parser = new JSONParser();
			JSONObject j = (JSONObject) parser.parse(data);

			String V_BAR_NO = j.get("BAR_NO").toString().toUpperCase();
			String V_DN_DT = j.get("DN_DT").toString().toUpperCase();
			String V_CON_NO = j.get("CONT").toString().toUpperCase();
			String V_USR_ID = j.get("USR_ID").toString().toUpperCase();
			
			String V_TYPE = "I";
			
			//cs = conn137.prepareCall("call USP_PDA_DN_HSNA_INSERT(?,?,?,?,?,?)");
				cs = conn137.prepareCall("call USP_DN_HSNA_INSERT(?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_BAR_NO);
			cs.setString(3, V_USR_ID);//V_USR
			cs.setString(4, V_CON_NO);//V_CON_NO
			cs.setString(5, V_DN_DT);//V_DN_DT
			cs.registerOutParameter(6, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(6);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("STS", rs.getString("STS"));
				subObject.put("MSG", rs.getString("MSG"));
			}
			out.println(subObject);
		}
	} catch (Exception e) {
		
			e.printStackTrace();
		
		System.out.println(data);
		System.out.println(B_TYPE);
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

		if (stmt137 != null) try {
			stmt137.close();
		} catch (SQLException ex) {}
		if (conn137 != null) try {
			conn137.close();
		} catch (SQLException ex) {}
	}
%>