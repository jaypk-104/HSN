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
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_SWM.jsp"%>

<%
	ResultSet rs = null;
	CallableStatement cs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
		
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		String jsonData = URLDecoder.decode(data, "UTF-8");
		String errorMsg = "";
		
		String usr_id = request.getParameter("usr_id");
		String crud = request.getParameter("crud");
		
		if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
			for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);
				String s_req_no = hashMap.get("s_req_no") == null ? "" : hashMap.get("s_req_no").toString();
				String s_req_seq = hashMap.get("s_req_seq") == null ? "" : hashMap.get("s_req_seq").toString();
				String item_cd = hashMap.get("item_cd") == null ? "" : hashMap.get("item_cd").toString();
				String unit = hashMap.get("unit") == null ? "" : hashMap.get("unit").toString();
				String so_qty = hashMap.get("so_qty") == null ? "" : hashMap.get("so_qty").toString();
				String pop_so_prc = hashMap.get("pop_so_prc") == null ? "" : hashMap.get("pop_so_prc").toString();
				String so_amt = hashMap.get("so_amt") == null ? "" : hashMap.get("so_amt").toString();
				String so_loc_amt = hashMap.get("so_amt") == null ? "" : hashMap.get("so_amt").toString();
				String prc_flg = "N";
				String dlvy_hop_dt2 = hashMap.get("dlvy_hop_dt2") == null ? "" : hashMap.get("dlvy_hop_dt2").toString();
				String bp_item_cd = hashMap.get("bp_item_cd") == null ? "" : hashMap.get("bp_item_cd").toString();
				String pop_bp_item_nm = hashMap.get("pop_bp_item_nm") == null ? "" : hashMap.get("pop_bp_item_nm").toString();

				if(dlvy_hop_dt2.length() > 10){
					dlvy_hop_dt2 = dlvy_hop_dt2.substring(0,10);
				}
				
				cs = conn.prepareCall("{call USP_S_REQ_TRANS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "D");
				cs.setString(2, s_req_no);
				cs.setString(3, s_req_seq);
				cs.setString(4, item_cd);
				cs.setString(5, unit);
				cs.setString(6, so_qty);
				cs.setString(7, pop_so_prc);
				cs.setString(8, so_amt);
				cs.setString(9, so_loc_amt);
				cs.setString(10, prc_flg);
				cs.setString(11, "");
				cs.setString(12, usr_id);
				cs.setString(13, dlvy_hop_dt2);
				cs.setString(14, bp_item_cd);
				cs.setString(15, pop_bp_item_nm);
				cs.registerOutParameter(16, Types.VARCHAR);
				
				cs.execute();
				
// 				subObject = new JSONObject();
// 				subObject.put("ret_val", cs.getString(16));
				
// 				jsonObject.put("success", true);
// 				jsonObject.put("resultList", subObject);
				
				
// 				response.setContentType("text/plain; charset=UTF-8");
// 				PrintWriter pw = response.getWriter();
// 				pw.print(jsonObject);
// 				pw.flush();
// 				pw.close();
				
						
			}
			
		} else {
			JSONObject jsondata = JSONObject.fromObject(jsonData);
			
			String s_req_no = jsondata.get("s_req_no") == null ? "" : jsondata.get("s_req_no").toString();
			String s_req_seq = jsondata.get("s_req_seq") == null ? "" : jsondata.get("s_req_seq").toString();
			String item_cd = jsondata.get("item_cd") == null ? "" : jsondata.get("item_cd").toString();
			String unit = jsondata.get("unit") == null ? "" : jsondata.get("unit").toString();
			String so_qty = jsondata.get("so_qty") == null ? "" : jsondata.get("so_qty").toString();
			String pop_so_prc = jsondata.get("pop_so_prc") == null ? "" : jsondata.get("pop_so_prc").toString();
			String so_amt = jsondata.get("so_amt") == null ? "" : jsondata.get("so_amt").toString();
			String so_loc_amt = jsondata.get("so_amt") == null ? "" : jsondata.get("so_amt").toString();
			String prc_flg = "N";
			String dlvy_hop_dt2 = jsondata.get("dlvy_hop_dt2") == null ? "" : jsondata.get("dlvy_hop_dt2").toString();
			String bp_item_cd = jsondata.get("bp_item_cd") == null ? "" : jsondata.get("bp_item_cd").toString();
			String pop_bp_item_nm = jsondata.get("pop_bp_item_nm") == null ? "" : jsondata.get("pop_bp_item_nm").toString();

			if(dlvy_hop_dt2.length() > 10){
				dlvy_hop_dt2 = dlvy_hop_dt2.substring(0,10);
			}
			
			cs = conn.prepareCall("{call USP_S_REQ_TRANS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "D");
			cs.setString(2, s_req_no);
			cs.setString(3, s_req_seq);
			cs.setString(4, item_cd);
			cs.setString(5, unit);
			cs.setString(6, so_qty);
			cs.setString(7, pop_so_prc);
			cs.setString(8, so_amt);
			cs.setString(9, so_loc_amt);
			cs.setString(10, prc_flg);
			cs.setString(11, "");
			cs.setString(12, usr_id);
			cs.setString(13, dlvy_hop_dt2);
			cs.setString(14, bp_item_cd);
			cs.setString(15, pop_bp_item_nm);
			cs.registerOutParameter(16, Types.VARCHAR);
			
			cs.execute();
			
		}
		
		
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
		
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try {
			rs.close();
		} catch (SQLException ex) {}
		if (rs != null) try {
			cs.close();
		} catch (SQLException ex) {}
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

