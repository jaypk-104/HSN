<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/HSPF01/common/DB_SWM.jsp"%>

<%
	ResultSet rs = null;
	try {

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject subObject = null;
		
		
		String bp_cd = request.getParameter("bp_cd");
		String bp_item_cd = request.getParameter("bp_item_cd");
		String item_cd = request.getParameter("item_cd");
		String item_nm = request.getParameter("item_nm");
		String spec = request.getParameter("spec");
		String maker = request.getParameter("maker");
		String bp_item_nm = request.getParameter("bp_item_nm");

		String sql = "select  '' checks,a.item_cd,c.item_nm,stock_unit unit,a.bp_cd,a.bp_item_cd,a.bp_item_nm,0 so_qty ,s_price so_prc ,0 so_amt ";
		sql += " ,spec,maker ";
		sql += " ,a.s_usr_id net_usr_id,b.user_nm net_usr_nm ";
		sql += " ,b.OFFM_TELNO net_usr_tel ";
		sql += " ,b.EMAIL_ADRES NET_USR_mail ";
		sql += "  from s_bp_item_price_swm a  ";
		sql += " inner join b_item_swm c on a.item_cd=c.item_cd ";
		sql += " left outer join LETTNEMPLYRINFO b ";
		sql += " on a.s_usr_id=b.emplyr_id ";
		sql += " inner join  ";
		sql += " (select item_cd,bp_cd,max(valid_fr_dt) valid_fr_dt from s_bp_item_price_swm group by item_cd,bp_cd) d ";
		sql += " on a.item_cd=d.item_cd and a.valid_fr_dt=d.valid_fr_dt and a.bp_Cd=d.bp_Cd ";
		sql += " where 1=1  ";
		sql += " and c.item_nm LIKE  '%" + item_nm + "%'  ";
		sql += " and a.item_cd LIKE  '%" + item_cd + "%'  ";
		sql += " and a.bp_item_cd LIKE  '%" + bp_item_cd + "%'  ";
		sql += " and nvl(a.bp_item_nm, ' ') LIKE  '%" + bp_item_nm + "%'  ";
		sql += " and nvl(c.spec, ' ') LIKE '%" + spec + "%'  ";
		sql += " and nvl(c.maker, ' ') LIKE  '%" + maker + "%'  ";

// 		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			subObject = new JSONObject();
			subObject.put("item_cd", rs.getString("item_cd"));
			subObject.put("item_nm", rs.getString("item_nm"));
			subObject.put("unit", rs.getString("unit"));
			subObject.put("bp_cd", rs.getString("bp_cd"));
			subObject.put("bp_item_cd", rs.getString("bp_item_cd"));
			subObject.put("bp_item_nm", rs.getString("bp_item_nm"));
			subObject.put("so_qty", rs.getString("so_qty"));
			subObject.put("so_prc", rs.getString("so_prc"));
			subObject.put("so_amt", rs.getString("so_amt"));
			subObject.put("spec", rs.getString("spec"));
			subObject.put("maker", rs.getString("maker"));
			subObject.put("net_usr_id", rs.getString("net_usr_id"));
			subObject.put("net_usr_nm", rs.getString("net_usr_nm"));
			subObject.put("net_usr_tel", rs.getString("net_usr_tel"));
			subObject.put("NET_USR_mail", rs.getString("NET_USR_mail"));

			jsonArray.add(subObject);
		}
		jsonObject.put("success", true);
		jsonObject.put("resultList", jsonArray);
		

		// 		System.out.println(jsonString);

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
		if (stmt != null) try {
			stmt.close();
		} catch (SQLException ex) {}
		if (conn != null) try {
			conn.close();
		} catch (SQLException ex) {}
	}
%>

