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

		//조회
		if (V_TYPE.equals("S")) {
			String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "" : request.getParameter("V_ITEM_CD").toUpperCase();
			String V_M_BP_NM = request.getParameter("V_M_BP_NM") == null ? "" : request.getParameter("V_M_BP_NM").toUpperCase();
			String V_QC_TYPE = request.getParameter("V_QC_TYPE") == null ? "" : request.getParameter("V_QC_TYPE").toUpperCase();
			String V_HS_TYPE = request.getParameter("V_HS_TYPE") == null ? "" : request.getParameter("V_HS_TYPE").toUpperCase();
			String V_SUPP_TYPE = request.getParameter("V_SUPP_TYPE") == null ? "" : request.getParameter("V_SUPP_TYPE").toUpperCase();
			if(V_QC_TYPE.equals("T")){
				V_QC_TYPE = "";
			}
			if(V_HS_TYPE.equals("T")){
				V_HS_TYPE = "";
			}
			if(V_SUPP_TYPE.equals("T")){
				V_SUPP_TYPE = "";
			}
			
			cs = conn.prepareCall("call USP_Q_BASE_METHOD(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_COMP_ID);
			cs.setString(3, V_ITEM_CD); //V_ITEM_CD
			cs.setString(4, ""); //V_BP_ITEM_CD
			cs.setString(5, ""); //V_ITEM_NM
			cs.setString(6, ""); //V_ITEM_ACCT
			cs.setString(7, V_QC_TYPE); //V_QC_TYPE
			cs.setString(8, V_HS_TYPE); //V_HS_TYPE
			cs.setString(9, V_SUPP_TYPE); //V_SUPP_TYPE
			cs.setString(10, ""); //V_S_BP_CD
			cs.setString(11, V_M_BP_NM); //V_M_BP_CD
			cs.setString(12, V_USR_ID);
			
			cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(13);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("ITEM_ACCT", rs.getString("ITEM_ACCT"));
				subObject.put("QC_TYPE_NM", rs.getString("QC_TYPE_NM"));
				subObject.put("HS_TYPE_NM", rs.getString("HS_TYPE_NM"));
				subObject.put("SUPP_TYPE_NM", rs.getString("SUPP_TYPE_NM"));
				subObject.put("QC_TYPE", rs.getString("QC_TYPE"));
				subObject.put("HS_TYPE", rs.getString("HS_TYPE"));
				subObject.put("SUPP_TYPE", rs.getString("SUPP_TYPE"));
				subObject.put("S_BP_CD", rs.getString("S_BP_CD"));
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("M_BP_CD", rs.getString("M_BP_CD"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				

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
		else if(V_TYPE.equals("I")){
			request.setCharacterEncoding("utf-8");
			String data = request.getParameter("data");
			if (data.contains("%")) {
				data = data.replaceAll("%", "percent");
			} else if (data.contains("/")) {
				data = data.replaceAll("/", ",");
			}
			String jsonData = URLDecoder.decode(data, "UTF-8");
			
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
				
				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					String ITEM_CD  = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String BP_ITEM_CD  = hashMap.get("BP_ITEM_CD") == null ? "" : hashMap.get("BP_ITEM_CD").toString();
					String ITEM_NM  = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String ITEM_ACCT  = hashMap.get("ITEM_ACCT") == null ? "" : hashMap.get("ITEM_ACCT").toString();
					String QC_TYPE  = hashMap.get("QC_TYPE_NM") == null ? "" : hashMap.get("QC_TYPE_NM").toString();
					String HS_TYPE  = hashMap.get("HS_TYPE_NM") == null ? "" : hashMap.get("HS_TYPE_NM").toString();
					String SUPP_TYPE  = hashMap.get("SUPP_TYPE_NM") == null ? "" : hashMap.get("SUPP_TYPE_NM").toString();
					String S_BP_CD  = hashMap.get("S_BP_CD") == null ? "" : hashMap.get("S_BP_CD").toString();
					String M_BP_CD  = hashMap.get("M_BP_CD") == null ? "" : hashMap.get("M_BP_CD").toString();
					
// 					System.out.println(QC_TYPE);
// 					System.out.println(HS_TYPE);
					
					if(QC_TYPE.equals("입고전")){
						QC_TYPE = "1";
					}
					else if(QC_TYPE.equals("입고후")){
						QC_TYPE = "2";
					}
					if(HS_TYPE.equals("무검사")){
						HS_TYPE = "NONE";
					}
					else if(HS_TYPE.equals("외관검사")){
						HS_TYPE = "OUTSIDE";
					}
					else if(HS_TYPE.equals("샘플검사")){
						HS_TYPE = "SAMPLE";
					}
					
					
					cs = conn.prepareCall("call USP_Q_BASE_METHOD(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_COMP_ID);
					cs.setString(3, ITEM_CD); //V_ITEM_CD
					cs.setString(4, BP_ITEM_CD); //V_BP_ITEM_CD
					cs.setString(5, ITEM_NM); //V_ITEM_NM
					cs.setString(6, ITEM_ACCT); //V_ITEM_ACCT
					cs.setString(7, QC_TYPE); //V_QC_TYPE
					cs.setString(8, HS_TYPE); //V_HS_TYPE
					cs.setString(9, SUPP_TYPE); //V_SUPP_TYPE
					cs.setString(10, S_BP_CD); //V_S_BP_CD
					cs.setString(11, M_BP_CD); //V_M_BP_CD
					cs.setString(12, V_USR_ID);
					
					cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			}
			else{
				JSONObject jsondata = JSONObject.fromObject(jsonData);
				
				String ITEM_CD  = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String BP_ITEM_CD  = jsondata.get("BP_ITEM_CD") == null ? "" : jsondata.get("BP_ITEM_CD").toString();
				String ITEM_NM  = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String ITEM_ACCT  = jsondata.get("ITEM_ACCT") == null ? "" : jsondata.get("ITEM_ACCT").toString();
				String QC_TYPE  = jsondata.get("QC_TYPE_NM") == null ? "" : jsondata.get("QC_TYPE_NM").toString();
				String HS_TYPE  = jsondata.get("HS_TYPE_NM") == null ? "" : jsondata.get("HS_TYPE_NM").toString();
				String SUPP_TYPE  = jsondata.get("SUPP_TYPE_NM") == null ? "" : jsondata.get("SUPP_TYPE_NM").toString();
				String S_BP_CD  = jsondata.get("S_BP_CD") == null ? "" : jsondata.get("S_BP_CD").toString();
				String M_BP_CD  = jsondata.get("M_BP_CD") == null ? "" : jsondata.get("M_BP_CD").toString();
				
// 				System.out.println(QC_TYPE);
// 				System.out.println(HS_TYPE);
				
				if(QC_TYPE.equals("입고전")){
					QC_TYPE = "1";
				}
				else if(QC_TYPE.equals("입고후")){
					QC_TYPE = "2";
				}
				if(HS_TYPE.equals("무검사")){
					HS_TYPE = "NONE";
				}
				else if(HS_TYPE.equals("외관검사")){
					HS_TYPE = "OUTSIDE";
				}
				else if(HS_TYPE.equals("샘플검사")){
					HS_TYPE = "SAMPLE";
				}
				
				
				cs = conn.prepareCall("call USP_Q_BASE_METHOD(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_COMP_ID);
				cs.setString(3, ITEM_CD); //V_ITEM_CD
				cs.setString(4, BP_ITEM_CD); //V_BP_ITEM_CD
				cs.setString(5, ITEM_NM); //V_ITEM_NM
				cs.setString(6, ITEM_ACCT); //V_ITEM_ACCT
				cs.setString(7, QC_TYPE); //V_QC_TYPE
				cs.setString(8, HS_TYPE); //V_HS_TYPE
				cs.setString(9, SUPP_TYPE); //V_SUPP_TYPE
				cs.setString(10, S_BP_CD); //V_S_BP_CD
				cs.setString(11, M_BP_CD); //V_M_BP_CD
				cs.setString(12, V_USR_ID);
				
				cs.registerOutParameter(13, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
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


