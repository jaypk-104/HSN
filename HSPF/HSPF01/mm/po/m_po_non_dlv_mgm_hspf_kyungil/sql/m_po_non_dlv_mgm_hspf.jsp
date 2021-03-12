<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
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


		//발주미납현황 헤더 조회
		if (V_TYPE.equals("SH")) {
// 			System.out.println("S");
			String V_PO_DT_FR = request.getParameter("V_PO_DT_FR") == null ? "" : request.getParameter("V_PO_DT_FR").substring(0,10);
			String V_PO_DT_TO = request.getParameter("V_PO_DT_TO") == null ? "" : request.getParameter("V_PO_DT_TO").substring(0,10);
			String V_DL_HP_DT_FR = request.getParameter("V_DL_HP_DT_FR") == null ? "" : request.getParameter("V_DL_HP_DT_FR").substring(0,10);
			String V_DL_HP_DT_TO = request.getParameter("V_DL_HP_DT_TO") == null ? "" : request.getParameter("V_DL_HP_DT_TO").substring(0,10);
			String V_DLVY_AVL_DT_FR = request.getParameter("V_DLVY_AVL_DT_FR") == null ? "" : request.getParameter("V_DLVY_AVL_DT_FR").substring(0,10);
			String V_DLVY_AVL_DT_TO = request.getParameter("V_DLVY_AVL_DT_TO") == null ? "" : request.getParameter("V_DLVY_AVL_DT_TO").substring(0,10);
			String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
			String V_BP_NM = request.getParameter("V_BP_NM") == null ? "" : request.getParameter("V_BP_NM").toUpperCase();
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			String V_DLV_YN = request.getParameter("V_DLV_YN") == null ? "" : request.getParameter("V_DLV_YN").toUpperCase();
			String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
			String V_GR_YN = request.getParameter("V_GR_YN") == null ? "" : request.getParameter("V_GR_YN").toUpperCase();
			
			String V_PO_DT_CHECK = request.getParameter("V_PO_DT_CHECK") == null ? "" : request.getParameter("V_PO_DT_CHECK");
			String V_DL_HP_DT_CHECK = request.getParameter("V_DL_HP_DT_CHECK") == null ? "" : request.getParameter("V_DL_HP_DT_CHECK");
			String V_DLVY_AVL_DT_CHECK = request.getParameter("V_DLVY_AVL_DT_CHECK") == null ? "" : request.getParameter("V_DLVY_AVL_DT_CHECK");
			
// 			System.out.println("V_PO_DT_CHECK : " + V_PO_DT_CHECK);
// 			System.out.println("V_DL_HP_DT_CHECK : " + V_DL_HP_DT_CHECK);
// 			System.out.println("V_DLVY_AVL_DT_CHECK : " + V_DLVY_AVL_DT_CHECK);
			
			
			if(V_PO_DT_CHECK.equals("false")){
				V_PO_DT_FR = "2000-01-01";
				V_PO_DT_TO = "3000-01-01";
			}
			if(V_DL_HP_DT_CHECK.equals("false")){
				V_DL_HP_DT_FR = "2000-01-01";
				V_DL_HP_DT_TO = "3000-01-01";
			}
			if(V_DLVY_AVL_DT_CHECK.equals("false")){
				V_DLVY_AVL_DT_FR = "2000-01-01";
				V_DLVY_AVL_DT_TO = "3000-01-01";
			}
			
			if(V_SL_CD.equals("T")){
				V_SL_CD = "";
			}
			
// 			System.out.println(V_BP_NM);
// 			if(V_USR_ID.equals("KYUNGIL")){
				//20201123 김장운. 경일에서 조회하는경우 해외 발주는 ASN만들기 전까지 안보이게 해달라고 요청옴(경일에서는 햇갈린단고 한다).
// 				cs = conn.prepareCall("call USP_M_PO_NON_DLV_MGM_KYUNGIL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 			}
// 			else{
				cs = conn.prepareCall("call USP_M_PO_NON_DLV_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
// 			}
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, V_PO_DT_FR); //V_PO_DT_FR
			cs.setString(4, V_PO_DT_TO); //V_PO_DT_TO
			cs.setString(5, V_DL_HP_DT_FR); //V_DL_HP_DT_FR
			cs.setString(6, V_DL_HP_DT_TO); //V_DL_HP_DT_TO
			cs.setString(7, V_DLVY_AVL_DT_FR); //V_DLVY_AVL_DT_FR
			cs.setString(8, V_DLVY_AVL_DT_TO); //V_DLVY_AVL_DT_TO
			cs.setString(9, V_BP_NM); //V_BP_NM
			cs.setString(10, V_ITEM_CD); //V_ITEM_CD
			cs.setString(11, V_ITEM_NM); //V_ITEM_NM
			cs.setString(12, V_GR_YN); //V_PO_NO  임시로 V_GR_YN 로 사용 20180704 김장운.
			cs.setString(13, ""); //V_PO_SEQ
			cs.setString(14, V_SL_CD); //V_ASN_NO  임시로 V_SL_CD 로 사용. 20180702 김장운.
			cs.setString(15, V_DLV_YN); //V_DLV_YN
			
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("PO_SEQ", rs.getString("PO_SEQ"));
				subObject.put("PO_CFM", rs.getString("PO_CFM"));
				subObject.put("PO_DT", rs.getString("PO_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PO_QTY", rs.getString("PO_QTY"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("DLVY_AVL_QTY", rs.getString("DLVY_AVL_QTY"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("DLVY_AVL_DT", rs.getString("DLVY_AVL_DT"));
				subObject.put("ASN_CNT", rs.getString("ASN_CNT"));
				subObject.put("HOPE_SL_NM", rs.getString("HOPE_SL_NM"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("PO_TYPE", rs.getString("PO_TYPE"));
				subObject.put("PO_USR_NM", rs.getString("PO_USR_NM"));
				subObject.put("GR_QTY", rs.getString("GR_QTY"));

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
		
		//발주미납현황 디테일 조회
		if (V_TYPE.equals("SD")) {
			
 			String V_PO_NO = request.getParameter("V_PO_NO") == null ? "" : request.getParameter("V_PO_NO").toUpperCase();
			String V_PO_SEQ = request.getParameter("V_PO_SEQ") == null ? "" : request.getParameter("V_PO_SEQ").toUpperCase();
			String V_ASN_NO = request.getParameter("V_ASN_NO") == null ? "" : request.getParameter("V_ASN_NO").toUpperCase();
			
			cs = conn.prepareCall("call USP_M_PO_NON_DLV_MGM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE); //V_TYPE
			cs.setString(2, V_COMP_ID); //V_COMP_ID
			cs.setString(3, ""); //V_PO_DT_FR
			cs.setString(4, ""); //V_PO_DT_TO
			cs.setString(5, ""); //V_DL_HP_DT_FR
			cs.setString(6, ""); //V_DL_HP_DT_TO
			cs.setString(7, ""); //V_DLVY_AVL_DT_FR
			cs.setString(8, ""); //V_DLVY_AVL_DT_TO
			cs.setString(9, ""); //V_BP_CD
			cs.setString(10, ""); //V_ITEM_CD
			cs.setString(11, ""); //V_ITEM_NM
			cs.setString(12, V_PO_NO); //V_PO_NO
			cs.setString(13, V_PO_SEQ); //V_PO_SEQ
			cs.setString(14, V_ASN_NO); //V_ASN_NO
			cs.setString(15, ""); //V_DLV_YN
			
			cs.registerOutParameter(16, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(16);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("PAL_BC_NO", rs.getString("PAL_BC_NO"));
				subObject.put("PAL_QTY", rs.getString("PAL_QTY"));
				subObject.put("BOX_BC_NO", rs.getString("BOX_BC_NO"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("LOT_BC_NO", rs.getString("LOT_BC_NO"));
				subObject.put("LOT_QTY", rs.getString("LOT_QTY"));
				subObject.put("LOT_NO", rs.getString("LOT_NO"));
				subObject.put("MAKE_DT", rs.getString("MAKE_DT"));
				subObject.put("VALID_DT", rs.getString("VALID_DT"));

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
	}
%>


