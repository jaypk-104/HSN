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
		String V_YYYYMMDD = request.getParameter("V_YYYYMMDD") == null ? "" : request.getParameter("V_YYYYMMDD").replace("-", "").substring(0, 8);
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_M_IMP_CHK_TP_TOT_HSPF(?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
			cs.setString(4, V_ITEM_CD);//V_ITEM_CD
			cs.setString(5, V_ITEM_NM);//V_ITEM_NM
			cs.setString(6, "");//V_SL_CD
			cs.setString(7, "");//V_QTY
			cs.setString(8, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(9);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("YYYYMMDD", rs.getString("YYYYMMDD"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("W211_ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("W212_ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("W213_ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("W214_ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("W215_ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("W211_QTY", rs.getString("W211_QTY"));
				subObject.put("W212_QTY", rs.getString("W212_QTY"));
				subObject.put("W213_QTY", rs.getString("W213_QTY"));
				subObject.put("W214_QTY", rs.getString("W214_QTY"));
				subObject.put("W215_QTY", rs.getString("W215_QTY"));
				subObject.put("TOT_QTY", rs.getString("TOT_QTY"));
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
			
			String V_SL_CD = "";

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_YYYYMMDD = hashMap.get("YYYYMMDD") == null ? "" : hashMap.get("YYYYMMDD").toString().replace("-", "").substring(0, 8);
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					
					String V_W211_ITEM_CD = hashMap.get("W211_ITEM_CD") == null ? "" : hashMap.get("W211_ITEM_CD").toString();
					String V_W212_ITEM_CD = hashMap.get("W212_ITEM_CD") == null ? "" : hashMap.get("W212_ITEM_CD").toString();
					String V_W213_ITEM_CD = hashMap.get("W213_ITEM_CD") == null ? "" : hashMap.get("W213_ITEM_CD").toString();
					String V_W214_ITEM_CD = hashMap.get("W214_ITEM_CD") == null ? "" : hashMap.get("W214_ITEM_CD").toString();
					String V_W215_ITEM_CD = hashMap.get("W215_ITEM_CD") == null ? "" : hashMap.get("W215_ITEM_CD").toString();
					String V_W211_QTY = hashMap.get("W211_QTY") == null ? "0" : hashMap.get("W211_QTY").toString();
					String V_W212_QTY = hashMap.get("W212_QTY") == null ? "0" : hashMap.get("W212_QTY").toString();
					String V_W213_QTY = hashMap.get("W213_QTY") == null ? "0" : hashMap.get("W213_QTY").toString();
					String V_W214_QTY = hashMap.get("W214_QTY") == null ? "0" : hashMap.get("W214_QTY").toString();
					String V_W215_QTY = hashMap.get("W215_QTY") == null ? "0" : hashMap.get("W215_QTY").toString();
					
					cs = conn.prepareCall("call USP_003_M_IMP_CHK_TP_TOT_HSPF(?,?,?,?,?,?,?,?,?)");
					
					if(V_TYPE.equals("I")){
						if(!V_W211_ITEM_CD.equals("") && Double.parseDouble(V_W211_QTY) > 0){
							V_SL_CD = "W211";
							callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W211_ITEM_CD, V_SL_CD, V_W211_QTY, V_USR_ID);
						}
						if(!V_W212_ITEM_CD.equals("") && Double.parseDouble(V_W212_QTY) > 0){
							V_SL_CD = "W212";
							callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W212_ITEM_CD, V_SL_CD, V_W212_QTY, V_USR_ID);
						}
						if(!V_W213_ITEM_CD.equals("") && Double.parseDouble(V_W213_QTY) > 0){
							V_SL_CD = "W213";
							callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W213_ITEM_CD, V_SL_CD, V_W213_QTY, V_USR_ID);
						}
						if(!V_W214_ITEM_CD.equals("") && Double.parseDouble(V_W214_QTY) > 0){
							V_SL_CD = "W214";
							callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W214_ITEM_CD, V_SL_CD, V_W214_QTY, V_USR_ID);
						}
						if(!V_W215_ITEM_CD.equals("") && Double.parseDouble(V_W215_QTY) > 0){
							V_SL_CD = "W215";
							callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W215_ITEM_CD, V_SL_CD, V_W215_QTY, V_USR_ID);
						}
					} else if(V_TYPE.equals("U")){
						if(Double.parseDouble(V_W211_QTY) < 0) V_W211_QTY = "0";
						if(Double.parseDouble(V_W212_QTY) < 0) V_W212_QTY = "0";
						if(Double.parseDouble(V_W213_QTY) < 0) V_W213_QTY = "0";
						if(Double.parseDouble(V_W214_QTY) < 0) V_W214_QTY = "0";
						if(Double.parseDouble(V_W215_QTY) < 0) V_W215_QTY = "0";
						
						V_SL_CD = "W211";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W211_QTY, V_USR_ID);
						V_SL_CD = "W212";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W212_QTY, V_USR_ID);
						V_SL_CD = "W213";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W213_QTY, V_USR_ID);
						V_SL_CD = "W214";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W214_QTY, V_USR_ID);
						V_SL_CD = "W215";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W215_QTY, V_USR_ID);
					}
					
					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_YYYYMMDD = jsondata.get("YYYYMMDD") == null ? "" : jsondata.get("YYYYMMDD").toString().replace("-", "").substring(0, 8);
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				
				String V_W211_ITEM_CD = jsondata.get("W211_ITEM_CD") == null ? "" : jsondata.get("W211_ITEM_CD").toString();
				String V_W212_ITEM_CD = jsondata.get("W212_ITEM_CD") == null ? "" : jsondata.get("W212_ITEM_CD").toString();
				String V_W213_ITEM_CD = jsondata.get("W213_ITEM_CD") == null ? "" : jsondata.get("W213_ITEM_CD").toString();
				String V_W214_ITEM_CD = jsondata.get("W214_ITEM_CD") == null ? "" : jsondata.get("W214_ITEM_CD").toString();
				String V_W215_ITEM_CD = jsondata.get("W215_ITEM_CD") == null ? "" : jsondata.get("W215_ITEM_CD").toString();
				String V_W211_QTY = jsondata.get("W211_QTY") == null ? "0" : jsondata.get("W211_QTY").toString();
				String V_W212_QTY = jsondata.get("W212_QTY") == null ? "0" : jsondata.get("W212_QTY").toString();
				String V_W213_QTY = jsondata.get("W213_QTY") == null ? "0" : jsondata.get("W213_QTY").toString();
				String V_W214_QTY = jsondata.get("W214_QTY") == null ? "0" : jsondata.get("W214_QTY").toString();
				String V_W215_QTY = jsondata.get("W215_QTY") == null ? "0" : jsondata.get("W215_QTY").toString();
				
				cs = conn.prepareCall("call USP_003_M_IMP_CHK_TP_TOT_HSPF(?,?,?,?,?,?,?,?,?)");
				
				if(V_TYPE.equals("I")){
					if(!V_W211_ITEM_CD.equals("") && Double.parseDouble(V_W211_QTY) > 0){
						V_SL_CD = "W211";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W211_ITEM_CD, V_SL_CD, V_W211_QTY, V_USR_ID);
					}
					if(!V_W212_ITEM_CD.equals("") && Double.parseDouble(V_W212_QTY) > 0){
						V_SL_CD = "W212";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W212_ITEM_CD, V_SL_CD, V_W212_QTY, V_USR_ID);
					}
					if(!V_W213_ITEM_CD.equals("") && Double.parseDouble(V_W213_QTY) > 0){
						V_SL_CD = "W213";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W213_ITEM_CD, V_SL_CD, V_W213_QTY, V_USR_ID);
					}
					if(!V_W214_ITEM_CD.equals("") && Double.parseDouble(V_W214_QTY) > 0){
						V_SL_CD = "W214";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W214_ITEM_CD, V_SL_CD, V_W214_QTY, V_USR_ID);
					}
					if(!V_W215_ITEM_CD.equals("") && Double.parseDouble(V_W215_QTY) > 0){
						V_SL_CD = "W215";
						callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_W215_ITEM_CD, V_SL_CD, V_W215_QTY, V_USR_ID);
					}
				} else if(V_TYPE.equals("U")){
					if(Double.parseDouble(V_W211_QTY) < 0) V_W211_QTY = "0";
					if(Double.parseDouble(V_W212_QTY) < 0) V_W212_QTY = "0";
					if(Double.parseDouble(V_W213_QTY) < 0) V_W213_QTY = "0";
					if(Double.parseDouble(V_W214_QTY) < 0) V_W214_QTY = "0";
					if(Double.parseDouble(V_W215_QTY) < 0) V_W215_QTY = "0";
					
					V_SL_CD = "W211";
					callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W211_QTY, V_USR_ID);
					V_SL_CD = "W212";
					callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W212_QTY, V_USR_ID);
					V_SL_CD = "W213";
					callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W213_QTY, V_USR_ID);
					V_SL_CD = "W214";
					callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W214_QTY, V_USR_ID);
					V_SL_CD = "W215";
					callProcedure(cs, V_COMP_ID, V_TYPE, V_YYYYMMDD, V_ITEM_CD, V_SL_CD, V_W215_QTY, V_USR_ID);
				}
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("success");
				pw.flush();
				pw.close();
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

<%!
	void callProcedure(CallableStatement cs, String V_COMP_ID, String V_TYPE, String V_YYYYMMDD, String V_ITEM_CD, String V_SL_CD, String V_QTY, String V_USR_ID) throws Exception {
		cs.setString(1, V_COMP_ID);//V_COMP_ID 		
		cs.setString(2, V_TYPE);//V_TYPE
		cs.setString(3, V_YYYYMMDD);//V_YYYYMMDD
		cs.setString(4, V_ITEM_CD);//V_ITEM_CD
		cs.setString(5, "");//V_ITEM_NM
		cs.setString(6, V_SL_CD);//V_SL_CD
		cs.setString(7, V_QTY);//V_QTY
		cs.setString(8, V_USR_ID);//V_USR_ID
		cs.registerOutParameter(9, com.tmax.tibero.TbTypes.CURSOR);
		cs.executeQuery();
	}
%>


