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
<%@ include file="/HSPF01/common/DB_Connection_ERP.jsp"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	
	JSONObject anyObject = new JSONObject();
	JSONArray anyArray = new JSONArray();
	JSONObject anySubObject = new JSONObject();

	try {
		
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_SHOW_TYPE = request.getParameter("V_SHOW_TYPE") == null ? "" : request.getParameter("V_SHOW_TYPE").toUpperCase();
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE").toUpperCase();
		String V_EMP_NAME = request.getParameter("V_EMP_NAME") == null ? "" : request.getParameter("V_EMP_NAME").toUpperCase();
// 		System.out.println("V_TYPE : " + V_TYPE);
		
		//통합 매출채권에서 열었을때.
		if(V_SHOW_TYPE.equals("S_BILL_TOT_HSPF")){
			if (V_TYPE.equals("SUPP_S") || V_TYPE.equals("BYR_S")){
				String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
				String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
				
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
				cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, "");//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
					subObject.put("BP_NM", rs.getString("BP_NM"));
					subObject.put("REG_NM", rs.getString("REG_NM"));
					subObject.put("ADDRESS", rs.getString("ADDRESS"));
					subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
					subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
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
			else if (V_TYPE.equals("SUPP_EMP_S") || V_TYPE.equals("BYR_EMP_S") || V_TYPE.equals("MY_INFO")){
				String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
				String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
				cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, "");//V_BILL_NO
				cs.setString(9, V_EMP_NAME);//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("EMP_NAME", rs.getString("EMP_NAME"));
					subObject.put("TEL_NO", rs.getString("TEL_NO"));
					subObject.put("HAND_TEL", rs.getString("HAND_TEL"));
					subObject.put("FAX_NO", rs.getString("FAX_NO"));
					subObject.put("EMAIL", rs.getString("EMAIL"));
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
			else if(V_TYPE.equals("TOT_BILL_INFO")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, "");//V_SUPP_BP_CD
				cs.setString(6, "");//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, V_BILL_NO);//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUPPLY_AMOUNT", rs.getString("TOTAL_BILL_LOC_AMT"));
					subObject.put("TAX", rs.getString("TOTAL_VAT_AMT"));
					subObject.put("PUR_DATE", rs.getString("BILL_DT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("TOTAL_AMOUNT", rs.getString("TOTAL_AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
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
			else if(V_TYPE.equals("TOT_BILL_INFO_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, "");//V_SUPP_BP_CD
				cs.setString(6, "");//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, V_BILL_NO);//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUPPLY_AMOUNT", rs.getString("BILL_LOC_AMT"));
					subObject.put("TAX", rs.getString("VAT_AMT"));
					subObject.put("PUR_DATE", rs.getString("BILL_DT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("TOTAL_AMOUNT", rs.getString("AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("QTY", rs.getString("QTY"));
					subObject.put("PRICE", rs.getString("PRICE"));
					subObject.put("UNIT", rs.getString("UNIT"));
					subObject.put("SPEC", rs.getString("SPEC"));
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
			else if(V_TYPE.equals("SAVE")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
				String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
				String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
				String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
				String A_TYPE = request.getParameter("A_TYPE") == null ? "" : request.getParameter("A_TYPE").toString();
				
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, A_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, V_QTY_YN);//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, V_CUST_CHARGE_NAME1);//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, V_CN_YN);//V_CN_YN 영수/청구
				cs.setString(8, V_REMARK);//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();

			}
			else if(V_TYPE.equals("BILL_S")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
				String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
				String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
				String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
				
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUP_COM_REGNO", rs.getString("SUP_COM_REGNO"));
					subObject.put("SUP_COM_ADDR", rs.getString("SUP_COM_ADDR"));
					subObject.put("SUP_COM_TYPE", rs.getString("SUP_COM_TYPE"));
					subObject.put("SUP_COM_NAME", rs.getString("SUP_COM_NAME"));
					subObject.put("SUP_NAME", rs.getString("SUP_NAME"));
					subObject.put("SUP_COM_CLASSIFY", rs.getString("SUP_COM_CLASSIFY"));
					subObject.put("SUP_EMP_NAME", rs.getString("SUP_EMP_NAME"));
					subObject.put("SUP_EMP_TEL_NO", rs.getString("SUP_EMP_TEL_NO"));
					subObject.put("SUP_EMP_EMAIL", rs.getString("SUP_EMP_EMAIL"));
					subObject.put("BYR_COM_REGNO", rs.getString("BYR_COM_REGNO"));
					subObject.put("BYR_COM_ADDR", rs.getString("BYR_COM_ADDR"));
					subObject.put("BYR_NAME", rs.getString("BYR_NAME"));
					subObject.put("BYR_COM_NAME", rs.getString("BYR_COM_NAME"));
					subObject.put("BYR_COM_TYPE", rs.getString("BYR_COM_TYPE"));
					subObject.put("BYR_COM_CLASSIFY", rs.getString("BYR_COM_CLASSIFY"));
					subObject.put("BYR_EMP_NAME", rs.getString("BYR_EMP_NAME"));
					subObject.put("BYR_EMP_EMAIL", rs.getString("BYR_EMP_EMAIL"));
					subObject.put("BYR_EMP_TEL_NO", rs.getString("BYR_EMP_TEL_NO"));
					subObject.put("SUP_AMOUNT", rs.getString("SUP_AMOUNT"));
					subObject.put("TAX_AMOUNT", rs.getString("TAX_AMOUNT"));
					subObject.put("TOT_AMOUNT", rs.getString("TOT_AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
					subObject.put("ITEM_QTY", rs.getString("ITEM_QTY"));
					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("MONTH", rs.getString("MONTH"));
					subObject.put("DAY", rs.getString("DAY"));
					subObject.put("TAX_DT", rs.getString("TAX_DT"));
					subObject.put("NTS_ISSUE_ID", rs.getString("NTS_ISSUE_ID"));
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
			else if(V_TYPE.equals("SEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
				
				
			}
			else if(V_TYPE.equals("SEND_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					REMARK = rs.getString("REMARK");
					ITEM_REMARK = rs.getString("REMARK");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, SUP_COM_REGNO);
				e_cs.setString(2, SUP_COM_NAME);
				e_cs.setString(3, SUP_NAME);
				e_cs.setString(4, SUP_COM_ADDR);
				e_cs.setString(5, SUP_COM_TYPE);
				e_cs.setString(6, SUP_COM_CLASSIFY);
				e_cs.setString(7, SUP_EMP_NAME);
				e_cs.setString(8, SUP_EMP_TEL_NO);
				e_cs.setString(9, SUP_EMP_EMAIL);
				e_cs.setString(10, BYR_COM_REGNO);
				e_cs.setString(11, BYR_COM_NAME);
				e_cs.setString(12, BYR_NAME);
				e_cs.setString(13, BYR_COM_ADDR);
				e_cs.setString(14, BYR_COM_TYPE);
				e_cs.setString(15, BYR_COM_CLASSIFY);
				e_cs.setString(16, BYR_EMP_NAME);
				e_cs.setString(17, BYR_EMP_TEL_NO);
				e_cs.setString(18, BYR_EMP_EMAIL);
				e_cs.setString(19, TAX_DT);
				e_cs.setString(20, ITEM_TOT_QTY);
				e_cs.setString(21, SUP_AMOUNT);
				e_cs.setString(22, TAX_AMOUNT);
				e_cs.setString(23, TOT_AMOUNT);
				e_cs.setString(24, ITEM_SUP_AMOUNT);
				e_cs.setString(25, ITEM_TAX_AMOUNT);
				e_cs.setString(26, BILL_NO);
				e_cs.setString(27, GUBUN);
				e_cs.setString(28, XML_MSG_ID);
				e_cs.setString(29, XML_MSG_ID2);
				e_cs.setString(30, XML_MSG_ID3);
				e_cs.setString(31, VAT_TYPE);
				e_cs.setString(32, VAT_TYPE2);
				e_cs.setString(33, REMARK);
				e_cs.setString(34, ITEM_REMARK);
				e_cs.setString(35, RFF_GN);
				e_cs.setString(36, "9");
				e_cs.setString(37, "1");
				
				e_cs.execute();
				
				/*
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, SUP_COM_REGNO);
				e_cs.setString(2, SUP_COM_NAME);
				e_cs.setString(3, SUP_NAME);
				e_cs.setString(4, SUP_COM_ADDR);
				e_cs.setString(5, SUP_COM_TYPE);
				e_cs.setString(6, SUP_COM_CLASSIFY);
				e_cs.setString(7, SUP_EMP_NAME);
				e_cs.setString(8, SUP_EMP_TEL_NO);
				e_cs.setString(9, SUP_EMP_EMAIL);
				e_cs.setString(10, BYR_COM_REGNO);
				e_cs.setString(11, BYR_COM_NAME);
				e_cs.setString(12, BYR_NAME);
				e_cs.setString(13, BYR_COM_ADDR);
				e_cs.setString(14, BYR_COM_TYPE);
				e_cs.setString(15, BYR_COM_CLASSIFY);
				e_cs.setString(16, BYR_EMP_NAME);
				e_cs.setString(17, BYR_EMP_TEL_NO);
				e_cs.setString(18, BYR_EMP_EMAIL);
				e_cs.setString(19, TAX_DT);
				e_cs.setString(20, ITEM_TOT_QTY);
				e_cs.setString(21, SUP_AMOUNT);
				e_cs.setString(22, TAX_AMOUNT);
				e_cs.setString(23, TOT_AMOUNT);
				e_cs.setString(24, ITEM_SUP_AMOUNT);
				e_cs.setString(25, ITEM_TAX_AMOUNT);
				e_cs.setString(26, BILL_NO);
				e_cs.setString(27, "SEND");
				e_cs.setString(28, XML_MSG_ID);
				e_cs.setString(29, XML_MSG_ID2);
				e_cs.setString(30, XML_MSG_ID3);
				e_cs.setString(31, VAT_TYPE);
				e_cs.setString(32, VAT_TYPE2);
				e_cs.setString(33, REMARK);
				e_cs.setString(34, ITEM_REMARK);
				e_cs.setString(35, RFF_GN);
				e_cs.setString(36, "9");
				e_cs.setString(37, "1");
				
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "IF_FIN");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_DEL")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
			}
			
			else if(V_TYPE.equals("SEND_RE")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
			}
			
			else if(V_TYPE.equals("SEND_MINUS_AMEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "MINUS");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
// 				rs = e_cs.executeQuery();
/*
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "MINUS_AMEND");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "AMEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
				/*
				rs = e_cs.executeQuery();
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "AMEND_LIST");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
				/*
				rs = e_cs.executeQuery();
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND_LIST");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND_CANCEL")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "CANCEL");
				e_cs.setString(2, "");
				e_cs.setString(3, "");
				e_cs.setString(4, "");
				e_cs.setString(5, "");
				e_cs.setString(6, "");
				e_cs.setString(7, "");
				e_cs.setString(8, "");
				e_cs.setString(9, "");
				e_cs.setString(10, "");
				e_cs.setString(11, "");
				e_cs.setString(12, "");
				e_cs.setString(13, "");
				e_cs.setString(14, "");
				e_cs.setString(15, "");
				e_cs.setString(16, "");
				e_cs.setString(17, "");
				e_cs.setString(18, "");
				e_cs.setString(19, "");
				e_cs.setString(20, "");
				e_cs.setString(21, "");
				e_cs.setString(22, "");
				e_cs.setString(23, "");
				e_cs.setString(24, "");
				e_cs.setString(25, "");
				e_cs.setString(26, "");
				e_cs.setString(27, "");
				e_cs.setString(28, "");
				e_cs.setString(29, "");
				e_cs.setString(30, "");
				e_cs.setString(31, V_BILL_NO);
				e_cs.setString(32, "");
				e_cs.setString(33, "");

				e_cs.execute();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND_CANCEL");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			else if(V_TYPE.equals("AMT_CHECK")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_MSG = "";
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMT_CHECK");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				while (rs.next()) {
					V_MSG = rs.getString("V_MSG");
					
				}
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(V_MSG);
				pw.flush();
				pw.close();

			}
		}
		
		//일반무역
		if(V_SHOW_TYPE.equals("S_TAX_DISTR")){
			if (V_TYPE.equals("SUPP_S") || V_TYPE.equals("BYR_S")){
				String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
				String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
				
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
				cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, "");//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
					subObject.put("BP_NM", rs.getString("BP_NM"));
					subObject.put("REG_NM", rs.getString("REG_NM"));
					subObject.put("ADDRESS", rs.getString("ADDRESS"));
					subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
					subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
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
			else if (V_TYPE.equals("SUPP_EMP_S") || V_TYPE.equals("BYR_EMP_S") || V_TYPE.equals("MY_INFO")){
				String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
				String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
				cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, "");//V_BILL_NO
				cs.setString(9, V_EMP_NAME);//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("EMP_NAME", rs.getString("EMP_NAME"));
					subObject.put("TEL_NO", rs.getString("TEL_NO"));
					subObject.put("HAND_TEL", rs.getString("HAND_TEL"));
					subObject.put("FAX_NO", rs.getString("FAX_NO"));
					subObject.put("EMAIL", rs.getString("EMAIL"));
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
			else if(V_TYPE.equals("S_TAX_DISTR_INFO")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, "");//V_SUPP_BP_CD
				cs.setString(6, "");//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, V_BILL_NO);//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUPPLY_AMOUNT", rs.getString("TOTAL_BILL_LOC_AMT"));
					subObject.put("TAX", rs.getString("TOTAL_VAT_AMT"));
					subObject.put("PUR_DATE", rs.getString("BILL_DT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("TOTAL_AMOUNT", rs.getString("TOTAL_AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
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
			else if(V_TYPE.equals("S_TAX_DISTR_INFO_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
				
				cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_TYPE);//V_TYPE
				cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
				cs.setString(5, "");//V_SUPP_BP_CD
				cs.setString(6, "");//V_BYR_BP_CD
				cs.setString(7, V_USR_ID);//V_USR_ID
				cs.setString(8, V_BILL_NO);//V_BILL_NO
				cs.setString(9, "");//V_EMP_NAME
				cs.executeQuery();

				rs = (ResultSet) cs.getObject(1);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUPPLY_AMOUNT", rs.getString("BILL_LOC_AMT"));
					subObject.put("TAX", rs.getString("VAT_AMT"));
					subObject.put("PUR_DATE", rs.getString("BILL_DT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("TOTAL_AMOUNT", rs.getString("AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("QTY", rs.getString("QTY"));
					subObject.put("PRICE", rs.getString("PRICE"));
					subObject.put("UNIT", rs.getString("UNIT"));
					subObject.put("SPEC", rs.getString("SPEC"));
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
			else if(V_TYPE.equals("SAVE")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
				String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
				String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
				String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
				String A_TYPE = request.getParameter("A_TYPE") == null ? "" : request.getParameter("A_TYPE").toString();
				
				
				cs = conn.prepareCall("call USP_002_DISTR_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, A_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, V_QTY_YN);//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, V_CUST_CHARGE_NAME1);//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, V_CN_YN);//V_CN_YN 영수/청구
				cs.setString(8, V_REMARK);//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				jsonObject.put("success", true);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();

			}
			else if(V_TYPE.equals("BILL_S")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
				String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
				String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
				String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
				
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);

				while (rs.next()) {
					subObject = new JSONObject();
					subObject.put("SUP_COM_REGNO", rs.getString("SUP_COM_REGNO"));
					subObject.put("SUP_COM_ADDR", rs.getString("SUP_COM_ADDR"));
					subObject.put("SUP_COM_TYPE", rs.getString("SUP_COM_TYPE"));
					subObject.put("SUP_COM_NAME", rs.getString("SUP_COM_NAME"));
					subObject.put("SUP_NAME", rs.getString("SUP_NAME"));
					subObject.put("SUP_COM_CLASSIFY", rs.getString("SUP_COM_CLASSIFY"));
					subObject.put("SUP_EMP_NAME", rs.getString("SUP_EMP_NAME"));
					subObject.put("SUP_EMP_TEL_NO", rs.getString("SUP_EMP_TEL_NO"));
					subObject.put("SUP_EMP_EMAIL", rs.getString("SUP_EMP_EMAIL"));
					subObject.put("BYR_COM_REGNO", rs.getString("BYR_COM_REGNO"));
					subObject.put("BYR_COM_ADDR", rs.getString("BYR_COM_ADDR"));
					subObject.put("BYR_NAME", rs.getString("BYR_NAME"));
					subObject.put("BYR_COM_NAME", rs.getString("BYR_COM_NAME"));
					subObject.put("BYR_COM_TYPE", rs.getString("BYR_COM_TYPE"));
					subObject.put("BYR_COM_CLASSIFY", rs.getString("BYR_COM_CLASSIFY"));
					subObject.put("BYR_EMP_NAME", rs.getString("BYR_EMP_NAME"));
					subObject.put("BYR_EMP_EMAIL", rs.getString("BYR_EMP_EMAIL"));
					subObject.put("BYR_EMP_TEL_NO", rs.getString("BYR_EMP_TEL_NO"));
					subObject.put("SUP_AMOUNT", rs.getString("SUP_AMOUNT"));
					subObject.put("TAX_AMOUNT", rs.getString("TAX_AMOUNT"));
					subObject.put("TOT_AMOUNT", rs.getString("TOT_AMOUNT"));
					subObject.put("REMARK", rs.getString("REMARK"));
					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
					subObject.put("ITEM_QTY", rs.getString("ITEM_QTY"));
					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
					subObject.put("MONTH", rs.getString("MONTH"));
					subObject.put("DAY", rs.getString("DAY"));
					subObject.put("TAX_DT", rs.getString("TAX_DT"));
					subObject.put("NTS_ISSUE_ID", rs.getString("NTS_ISSUE_ID"));
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
			else if(V_TYPE.equals("SEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
				
				
			}
			else if(V_TYPE.equals("SEND_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					REMARK = rs.getString("REMARK");
					ITEM_REMARK = rs.getString("REMARK");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, SUP_COM_REGNO);
				e_cs.setString(2, SUP_COM_NAME);
				e_cs.setString(3, SUP_NAME);
				e_cs.setString(4, SUP_COM_ADDR);
				e_cs.setString(5, SUP_COM_TYPE);
				e_cs.setString(6, SUP_COM_CLASSIFY);
				e_cs.setString(7, SUP_EMP_NAME);
				e_cs.setString(8, SUP_EMP_TEL_NO);
				e_cs.setString(9, SUP_EMP_EMAIL);
				e_cs.setString(10, BYR_COM_REGNO);
				e_cs.setString(11, BYR_COM_NAME);
				e_cs.setString(12, BYR_NAME);
				e_cs.setString(13, BYR_COM_ADDR);
				e_cs.setString(14, BYR_COM_TYPE);
				e_cs.setString(15, BYR_COM_CLASSIFY);
				e_cs.setString(16, BYR_EMP_NAME);
				e_cs.setString(17, BYR_EMP_TEL_NO);
				e_cs.setString(18, BYR_EMP_EMAIL);
				e_cs.setString(19, TAX_DT);
				e_cs.setString(20, ITEM_TOT_QTY);
				e_cs.setString(21, SUP_AMOUNT);
				e_cs.setString(22, TAX_AMOUNT);
				e_cs.setString(23, TOT_AMOUNT);
				e_cs.setString(24, ITEM_SUP_AMOUNT);
				e_cs.setString(25, ITEM_TAX_AMOUNT);
				e_cs.setString(26, BILL_NO);
				e_cs.setString(27, GUBUN);
				e_cs.setString(28, XML_MSG_ID);
				e_cs.setString(29, XML_MSG_ID2);
				e_cs.setString(30, XML_MSG_ID3);
				e_cs.setString(31, VAT_TYPE);
				e_cs.setString(32, VAT_TYPE2);
				e_cs.setString(33, REMARK);
				e_cs.setString(34, ITEM_REMARK);
				e_cs.setString(35, RFF_GN);
				e_cs.setString(36, "9");
				e_cs.setString(37, "1");
				
				e_cs.execute();
				
				/*
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, SUP_COM_REGNO);
				e_cs.setString(2, SUP_COM_NAME);
				e_cs.setString(3, SUP_NAME);
				e_cs.setString(4, SUP_COM_ADDR);
				e_cs.setString(5, SUP_COM_TYPE);
				e_cs.setString(6, SUP_COM_CLASSIFY);
				e_cs.setString(7, SUP_EMP_NAME);
				e_cs.setString(8, SUP_EMP_TEL_NO);
				e_cs.setString(9, SUP_EMP_EMAIL);
				e_cs.setString(10, BYR_COM_REGNO);
				e_cs.setString(11, BYR_COM_NAME);
				e_cs.setString(12, BYR_NAME);
				e_cs.setString(13, BYR_COM_ADDR);
				e_cs.setString(14, BYR_COM_TYPE);
				e_cs.setString(15, BYR_COM_CLASSIFY);
				e_cs.setString(16, BYR_EMP_NAME);
				e_cs.setString(17, BYR_EMP_TEL_NO);
				e_cs.setString(18, BYR_EMP_EMAIL);
				e_cs.setString(19, TAX_DT);
				e_cs.setString(20, ITEM_TOT_QTY);
				e_cs.setString(21, SUP_AMOUNT);
				e_cs.setString(22, TAX_AMOUNT);
				e_cs.setString(23, TOT_AMOUNT);
				e_cs.setString(24, ITEM_SUP_AMOUNT);
				e_cs.setString(25, ITEM_TAX_AMOUNT);
				e_cs.setString(26, BILL_NO);
				e_cs.setString(27, "SEND");
				e_cs.setString(28, XML_MSG_ID);
				e_cs.setString(29, XML_MSG_ID2);
				e_cs.setString(30, XML_MSG_ID3);
				e_cs.setString(31, VAT_TYPE);
				e_cs.setString(32, VAT_TYPE2);
				e_cs.setString(33, REMARK);
				e_cs.setString(34, ITEM_REMARK);
				e_cs.setString(35, RFF_GN);
				e_cs.setString(36, "9");
				e_cs.setString(37, "1");
				
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "IF_FIN");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_DEL")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
			}
			
			else if(V_TYPE.equals("SEND_RE")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
				URLConnection con = url1.openConnection();
				con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
				con.setDoOutput(true);

				anySubObject.put("V_BILL_NO", V_BILL_NO);
				anySubObject.put("V_USR_ID", V_USR_ID);
				anyArray.add(anySubObject);
				anyObject.put("data", anyArray);
				String parameter = anyObject + "";

				System.out.println(parameter);

				OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
				wr.write(parameter);
				wr.flush();

				BufferedReader rd = null;

				rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				String line = null;
				String result = null;
				while ((line = rd.readLine()) != null) {
					result = URLDecoder.decode(line, "UTF-8");
				}

				System.out.print(result);

				
				
				jsonObject.put("success", true);
				jsonObject.put("resultList", result);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(jsonObject);
				pw.flush();
				pw.close();
				
			}
			
			else if(V_TYPE.equals("SEND_MINUS_AMEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "MINUS");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
// 				rs = e_cs.executeQuery();
/*
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "MINUS_AMEND");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "AMEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
				/*
				rs = e_cs.executeQuery();
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND_LIST")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "S");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				String SUP_COM_REGNO = "";  //1
				String SUP_COM_NAME = "";  
				String SUP_NAME = "";
				String SUP_COM_ADDR = "";
				String SUP_COM_TYPE = "";	//5
				String SUP_COM_CLASSIFY = "";
				String SUP_EMP_NAME = "";
				String SUP_EMP_TEL_NO = "";
				String SUP_EMP_EMAIL = ""; //9
				
				String BYR_COM_REGNO = ""; //10
				String BYR_COM_NAME = "";
				String BYR_NAME = "";
				String BYR_COM_ADDR = "";
				String BYR_COM_TYPE = "";
				String BYR_COM_CLASSIFY = ""; //15
				String BYR_EMP_NAME = "";
				String BYR_EMP_TEL_NO = "";
				String BYR_EMP_EMAIL = ""; //18
				
				String TAX_DT = ""; //19
				String ITEM_TOT_QTY = "";
				String SUP_AMOUNT = "";
				String TAX_AMOUNT = "";
				String TOT_AMOUNT = ""; //23
				
				String ITEM_NM = "";
				String ITEM_UNIT = "";
				String ITEM_PRICE = "";
				
				String ITEM_SUP_AMOUNT = "0"; //24
				String ITEM_TAX_AMOUNT = "0";
				String BILL_NO = V_BILL_NO;
				String GUBUN = "C";
				String XML_MSG_ID = "" ;
				String XML_MSG_ID2 = "" ;
				String XML_MSG_ID3 = "" ; //30
				
				String VAT_TYPE = "" ;
				String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
				String REMARK = "";
				String ITEM_REMARK = "";
				String RFF_GN = "";
				
				while (rs.next()) {
					SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
					SUP_COM_NAME = rs.getString("SUP_COM_NAME");
					SUP_NAME = rs.getString("SUP_NAME");
					SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
					SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
					SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
					SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
					SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
					SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
					
					BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
					BYR_COM_NAME = rs.getString("BYR_COM_NAME");
					BYR_NAME = rs.getString("BYR_NAME");
					BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
					BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
					BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
					BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
					BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
					BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
					
					TAX_DT = rs.getString("TAX_DT");
					ITEM_TOT_QTY = rs.getString("ITEM_QTY");
					SUP_AMOUNT = rs.getString("SUP_AMOUNT");
					TAX_AMOUNT = rs.getString("TAX_AMOUNT");
					TOT_AMOUNT = rs.getString("TOT_AMOUNT");
					
					ITEM_NM = rs.getString("ITEM_NM");
					ITEM_UNIT = rs.getString("ITEM_UNIT");
					ITEM_PRICE = rs.getString("ITEM_PRICE");
					
					VAT_TYPE = rs.getString("VAT_TYPE");
					
// 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
// 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
// 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
// 					subObject.put("MONTH", rs.getString("MONTH"));
// 					subObject.put("DAY", rs.getString("DAY"));
// 					jsonArray.add(subObject);
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "AMEND_LIST");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);

				e_cs.execute();
				/*
				rs = e_cs.executeQuery();
				while (rs.next()) {
// 					System.out.println(rs.getString("XML_MSG_ID"));
					XML_MSG_ID = rs.getString("XML_MSG_ID");
				}
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "SEND");
				e_cs.setString(2, XML_MSG_ID);
				e_cs.setString(3, SUP_COM_REGNO);
				e_cs.setString(4, SUP_COM_NAME);
				e_cs.setString(5, SUP_NAME);
				e_cs.setString(6, SUP_COM_ADDR);
				e_cs.setString(7, SUP_COM_TYPE);
				e_cs.setString(8, SUP_COM_CLASSIFY);
				e_cs.setString(9, SUP_EMP_NAME);
				e_cs.setString(10, SUP_EMP_TEL_NO);
				e_cs.setString(11, SUP_EMP_EMAIL);
				e_cs.setString(12, BYR_COM_REGNO);
				e_cs.setString(13, BYR_COM_NAME);
				e_cs.setString(14, BYR_NAME);
				e_cs.setString(15, BYR_COM_ADDR);
				e_cs.setString(16, BYR_COM_TYPE);
				e_cs.setString(17, BYR_COM_CLASSIFY);
				e_cs.setString(18, BYR_EMP_NAME);
				e_cs.setString(19, BYR_EMP_TEL_NO);
				e_cs.setString(20, BYR_EMP_EMAIL);
				e_cs.setString(21, TAX_DT);
				e_cs.setString(22, ITEM_TOT_QTY);
				e_cs.setString(23, SUP_AMOUNT);
				e_cs.setString(24, TAX_AMOUNT);
				e_cs.setString(25, TOT_AMOUNT);
				e_cs.setString(26, ITEM_NM);
				e_cs.setString(27, ITEM_UNIT);
				e_cs.setString(28, ITEM_TOT_QTY);
				e_cs.setString(29, ITEM_PRICE);
				e_cs.setString(30, "");
				e_cs.setString(31, BILL_NO);
				e_cs.setString(32, VAT_TYPE);
				e_cs.setString(33, VAT_TYPE2);
				e_cs.execute();
				*/
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND_LIST");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				/*
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print("");
				pw.flush();
				pw.close();
				*/
				
				
			}
			else if(V_TYPE.equals("SEND_AMEND_CANCEL")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				
				e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				e_cs.setString(1, "CANCEL");
				e_cs.setString(2, "");
				e_cs.setString(3, "");
				e_cs.setString(4, "");
				e_cs.setString(5, "");
				e_cs.setString(6, "");
				e_cs.setString(7, "");
				e_cs.setString(8, "");
				e_cs.setString(9, "");
				e_cs.setString(10, "");
				e_cs.setString(11, "");
				e_cs.setString(12, "");
				e_cs.setString(13, "");
				e_cs.setString(14, "");
				e_cs.setString(15, "");
				e_cs.setString(16, "");
				e_cs.setString(17, "");
				e_cs.setString(18, "");
				e_cs.setString(19, "");
				e_cs.setString(20, "");
				e_cs.setString(21, "");
				e_cs.setString(22, "");
				e_cs.setString(23, "");
				e_cs.setString(24, "");
				e_cs.setString(25, "");
				e_cs.setString(26, "");
				e_cs.setString(27, "");
				e_cs.setString(28, "");
				e_cs.setString(29, "");
				e_cs.setString(30, "");
				e_cs.setString(31, V_BILL_NO);
				e_cs.setString(32, "");
				e_cs.setString(33, "");

				e_cs.execute();
				
				cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMEND_CANCEL");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
			}
			
			else if(V_TYPE.equals("AMT_CHECK")){
				String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
				String V_MSG = "";
				cs = conn.prepareCall("call USP_002_DISTR_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
				
				cs.setString(1, V_COMP_ID);//V_COMP_ID
				cs.setString(2, "AMT_CHECK");//V_TYPE
				cs.setString(3, V_BILL_NO);//V_BILL_NO
				cs.setString(4, "");//V_QTY_YN  작성방법
				cs.setString(5, "");//V_AMT_YN 
				cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
				cs.setString(7, "");//V_CN_YN 영수/청구
				cs.setString(8, "");//V_REMARK
				cs.setString(9, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
				
				rs = (ResultSet) cs.getObject(10);
				
				while (rs.next()) {
					V_MSG = rs.getString("V_MSG");
					
				}
				
				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(V_MSG);
				pw.flush();
				pw.close();

			}
		}
		
		
		//철강
				if(V_SHOW_TYPE.equals("S_TAX_STEEL")){
					if (V_TYPE.equals("SUPP_S") || V_TYPE.equals("BYR_S")){
						String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
						String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
						
						
						cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
						
						cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_TYPE);//V_TYPE
						cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
						cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
						cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, "");//V_BILL_NO
						cs.setString(9, "");//V_EMP_NAME
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(1);

						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("BP_REGNO", rs.getString("BP_REGNO"));
							subObject.put("BP_NM", rs.getString("BP_NM"));
							subObject.put("REG_NM", rs.getString("REG_NM"));
							subObject.put("ADDRESS", rs.getString("ADDRESS"));
							subObject.put("IND_TYPE", rs.getString("IND_TYPE"));
							subObject.put("IND_CLASS", rs.getString("IND_CLASS"));
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
					else if (V_TYPE.equals("SUPP_EMP_S") || V_TYPE.equals("BYR_EMP_S") || V_TYPE.equals("MY_INFO")){
						String V_SUPP_BP_CD = request.getParameter("V_SUPP_BP_CD") == null ? "" : request.getParameter("V_SUPP_BP_CD").toUpperCase();
						String V_BYR_BP_CD = request.getParameter("V_BYR_BP_CD") == null ? "" : request.getParameter("V_BYR_BP_CD").toUpperCase();
						
						cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
						
						cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_TYPE);//V_TYPE
						cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
						cs.setString(5, V_SUPP_BP_CD);//V_SUPP_BP_CD
						cs.setString(6, V_BYR_BP_CD);//V_BYR_BP_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, "");//V_BILL_NO
						cs.setString(9, V_EMP_NAME);//V_EMP_NAME
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(1);

						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("EMP_NAME", rs.getString("EMP_NAME"));
							subObject.put("TEL_NO", rs.getString("TEL_NO"));
							subObject.put("HAND_TEL", rs.getString("HAND_TEL"));
							subObject.put("FAX_NO", rs.getString("FAX_NO"));
							subObject.put("EMAIL", rs.getString("EMAIL"));
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
					else if(V_TYPE.equals("S_TAX_STEEL_INFO")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
						
						cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_TYPE);//V_TYPE
						cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
						cs.setString(5, "");//V_SUPP_BP_CD
						cs.setString(6, "");//V_BYR_BP_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, V_BILL_NO);//V_BILL_NO
						cs.setString(9, "");//V_EMP_NAME
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(1);

						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("SUPPLY_AMOUNT", rs.getString("TOTAL_BILL_LOC_AMT"));
							subObject.put("TAX", rs.getString("TOTAL_VAT_AMT"));
							subObject.put("PUR_DATE", rs.getString("BILL_DT"));
							subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
							subObject.put("TOTAL_AMOUNT", rs.getString("TOTAL_AMOUNT"));
							subObject.put("REMARK", rs.getString("REMARK"));
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
					else if(V_TYPE.equals("S_TAX_STEEL_INFO_LIST")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_B_BILL_POP_SELECT(?,?,?,?,?,?,?,?,?)");
						
						cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_TYPE);//V_TYPE
						cs.setString(4, V_SHOW_TYPE);//V_SHOW_TYPE
						cs.setString(5, "");//V_SUPP_BP_CD
						cs.setString(6, "");//V_BYR_BP_CD
						cs.setString(7, V_USR_ID);//V_USR_ID
						cs.setString(8, V_BILL_NO);//V_BILL_NO
						cs.setString(9, "");//V_EMP_NAME
						cs.executeQuery();

						rs = (ResultSet) cs.getObject(1);

						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("SUPPLY_AMOUNT", rs.getString("BILL_LOC_AMT"));
							subObject.put("TAX", rs.getString("VAT_AMT"));
							subObject.put("PUR_DATE", rs.getString("BILL_DT"));
							subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
							subObject.put("TOTAL_AMOUNT", rs.getString("AMOUNT"));
							subObject.put("REMARK", rs.getString("REMARK"));
							subObject.put("QTY", rs.getString("QTY"));
							subObject.put("PRICE", rs.getString("PRICE"));
							subObject.put("UNIT", rs.getString("UNIT"));
							subObject.put("SPEC", rs.getString("SPEC"));
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
					else if(V_TYPE.equals("SAVE")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
						String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
						String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
						String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
						String A_TYPE = request.getParameter("A_TYPE") == null ? "" : request.getParameter("A_TYPE").toString();
						
						
						cs = conn.prepareCall("call USP_001_STEEL_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, A_TYPE);//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, V_QTY_YN);//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, V_CUST_CHARGE_NAME1);//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, V_CN_YN);//V_CN_YN 영수/청구
						cs.setString(8, V_REMARK);//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						jsonObject.put("success", true);

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(jsonObject);
						pw.flush();
						pw.close();

					}
					else if(V_TYPE.equals("BILL_S")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						String V_QTY_YN = request.getParameter("V_QTY_YN") == null ? "" : request.getParameter("V_QTY_YN").toUpperCase();
						String V_CUST_CHARGE_NAME1 = request.getParameter("V_CUST_CHARGE_NAME1") == null ? "" : request.getParameter("V_CUST_CHARGE_NAME1").toUpperCase();
						String V_CN_YN = request.getParameter("V_CN_YN") == null ? "" : request.getParameter("V_CN_YN").toUpperCase();
						String V_REMARK = request.getParameter("V_REMARK") == null ? "" : request.getParameter("V_REMARK").toString();
						
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "S");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);

						while (rs.next()) {
							subObject = new JSONObject();
							subObject.put("SUP_COM_REGNO", rs.getString("SUP_COM_REGNO"));
							subObject.put("SUP_COM_ADDR", rs.getString("SUP_COM_ADDR"));
							subObject.put("SUP_COM_TYPE", rs.getString("SUP_COM_TYPE"));
							subObject.put("SUP_COM_NAME", rs.getString("SUP_COM_NAME"));
							subObject.put("SUP_NAME", rs.getString("SUP_NAME"));
							subObject.put("SUP_COM_CLASSIFY", rs.getString("SUP_COM_CLASSIFY"));
							subObject.put("SUP_EMP_NAME", rs.getString("SUP_EMP_NAME"));
							subObject.put("SUP_EMP_TEL_NO", rs.getString("SUP_EMP_TEL_NO"));
							subObject.put("SUP_EMP_EMAIL", rs.getString("SUP_EMP_EMAIL"));
							subObject.put("BYR_COM_REGNO", rs.getString("BYR_COM_REGNO"));
							subObject.put("BYR_COM_ADDR", rs.getString("BYR_COM_ADDR"));
							subObject.put("BYR_NAME", rs.getString("BYR_NAME"));
							subObject.put("BYR_COM_NAME", rs.getString("BYR_COM_NAME"));
							subObject.put("BYR_COM_TYPE", rs.getString("BYR_COM_TYPE"));
							subObject.put("BYR_COM_CLASSIFY", rs.getString("BYR_COM_CLASSIFY"));
							subObject.put("BYR_EMP_NAME", rs.getString("BYR_EMP_NAME"));
							subObject.put("BYR_EMP_EMAIL", rs.getString("BYR_EMP_EMAIL"));
							subObject.put("BYR_EMP_TEL_NO", rs.getString("BYR_EMP_TEL_NO"));
							subObject.put("SUP_AMOUNT", rs.getString("SUP_AMOUNT"));
							subObject.put("TAX_AMOUNT", rs.getString("TAX_AMOUNT"));
							subObject.put("TOT_AMOUNT", rs.getString("TOT_AMOUNT"));
							subObject.put("REMARK", rs.getString("REMARK"));
							subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
							subObject.put("ITEM_QTY", rs.getString("ITEM_QTY"));
							subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
							subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
							subObject.put("MONTH", rs.getString("MONTH"));
							subObject.put("DAY", rs.getString("DAY"));
							subObject.put("TAX_DT", rs.getString("TAX_DT"));
							subObject.put("NTS_ISSUE_ID", rs.getString("NTS_ISSUE_ID"));
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
					else if(V_TYPE.equals("SEND")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
						URLConnection con = url1.openConnection();
						con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
						con.setDoOutput(true);

						anySubObject.put("V_BILL_NO", V_BILL_NO);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anyArray.add(anySubObject);
						anyObject.put("data", anyArray);
						String parameter = anyObject + "";

						System.out.println(parameter);

						OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
						wr.write(parameter);
						wr.flush();

						BufferedReader rd = null;

						rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
						String line = null;
						String result = null;
						while ((line = rd.readLine()) != null) {
							result = URLDecoder.decode(line, "UTF-8");
						}

						System.out.print(result);

						
						
						jsonObject.put("success", true);
						jsonObject.put("resultList", result);

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(jsonObject);
						pw.flush();
						pw.close();
						
						
						
					}
					else if(V_TYPE.equals("SEND_LIST")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "S");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);
						
						String SUP_COM_REGNO = "";  //1
						String SUP_COM_NAME = "";  
						String SUP_NAME = "";
						String SUP_COM_ADDR = "";
						String SUP_COM_TYPE = "";	//5
						String SUP_COM_CLASSIFY = "";
						String SUP_EMP_NAME = "";
						String SUP_EMP_TEL_NO = "";
						String SUP_EMP_EMAIL = ""; //9
						
						String BYR_COM_REGNO = ""; //10
						String BYR_COM_NAME = "";
						String BYR_NAME = "";
						String BYR_COM_ADDR = "";
						String BYR_COM_TYPE = "";
						String BYR_COM_CLASSIFY = ""; //15
						String BYR_EMP_NAME = "";
						String BYR_EMP_TEL_NO = "";
						String BYR_EMP_EMAIL = ""; //18
						
						String TAX_DT = ""; //19
						String ITEM_TOT_QTY = "";
						String SUP_AMOUNT = "";
						String TAX_AMOUNT = "";
						String TOT_AMOUNT = ""; //23
						
						String ITEM_SUP_AMOUNT = "0"; //24
						String ITEM_TAX_AMOUNT = "0";
						String BILL_NO = V_BILL_NO;
						String GUBUN = "C";
						String XML_MSG_ID = "" ;
						String XML_MSG_ID2 = "" ;
						String XML_MSG_ID3 = "" ; //30
						
						String VAT_TYPE = "" ;
						String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
						String REMARK = "";
						String ITEM_REMARK = "";
						String RFF_GN = "";
						
						while (rs.next()) {
							SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
							SUP_COM_NAME = rs.getString("SUP_COM_NAME");
							SUP_NAME = rs.getString("SUP_NAME");
							SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
							SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
							SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
							SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
							SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
							SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
							
							BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
							BYR_COM_NAME = rs.getString("BYR_COM_NAME");
							BYR_NAME = rs.getString("BYR_NAME");
							BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
							BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
							BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
							BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
							BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
							BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
							
							TAX_DT = rs.getString("TAX_DT");
							ITEM_TOT_QTY = rs.getString("ITEM_QTY");
							SUP_AMOUNT = rs.getString("SUP_AMOUNT");
							TAX_AMOUNT = rs.getString("TAX_AMOUNT");
							TOT_AMOUNT = rs.getString("TOT_AMOUNT");
							
							REMARK = rs.getString("REMARK");
							ITEM_REMARK = rs.getString("REMARK");
							
//		 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
//		 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
//		 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
//		 					subObject.put("MONTH", rs.getString("MONTH"));
//		 					subObject.put("DAY", rs.getString("DAY"));
//		 					jsonArray.add(subObject);
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, SUP_COM_REGNO);
						e_cs.setString(2, SUP_COM_NAME);
						e_cs.setString(3, SUP_NAME);
						e_cs.setString(4, SUP_COM_ADDR);
						e_cs.setString(5, SUP_COM_TYPE);
						e_cs.setString(6, SUP_COM_CLASSIFY);
						e_cs.setString(7, SUP_EMP_NAME);
						e_cs.setString(8, SUP_EMP_TEL_NO);
						e_cs.setString(9, SUP_EMP_EMAIL);
						e_cs.setString(10, BYR_COM_REGNO);
						e_cs.setString(11, BYR_COM_NAME);
						e_cs.setString(12, BYR_NAME);
						e_cs.setString(13, BYR_COM_ADDR);
						e_cs.setString(14, BYR_COM_TYPE);
						e_cs.setString(15, BYR_COM_CLASSIFY);
						e_cs.setString(16, BYR_EMP_NAME);
						e_cs.setString(17, BYR_EMP_TEL_NO);
						e_cs.setString(18, BYR_EMP_EMAIL);
						e_cs.setString(19, TAX_DT);
						e_cs.setString(20, ITEM_TOT_QTY);
						e_cs.setString(21, SUP_AMOUNT);
						e_cs.setString(22, TAX_AMOUNT);
						e_cs.setString(23, TOT_AMOUNT);
						e_cs.setString(24, ITEM_SUP_AMOUNT);
						e_cs.setString(25, ITEM_TAX_AMOUNT);
						e_cs.setString(26, BILL_NO);
						e_cs.setString(27, GUBUN);
						e_cs.setString(28, XML_MSG_ID);
						e_cs.setString(29, XML_MSG_ID2);
						e_cs.setString(30, XML_MSG_ID3);
						e_cs.setString(31, VAT_TYPE);
						e_cs.setString(32, VAT_TYPE2);
						e_cs.setString(33, REMARK);
						e_cs.setString(34, ITEM_REMARK);
						e_cs.setString(35, RFF_GN);
						e_cs.setString(36, "9");
						e_cs.setString(37, "1");
						
						e_cs.execute();
						
						/*
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_SALELIST_BILL_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, SUP_COM_REGNO);
						e_cs.setString(2, SUP_COM_NAME);
						e_cs.setString(3, SUP_NAME);
						e_cs.setString(4, SUP_COM_ADDR);
						e_cs.setString(5, SUP_COM_TYPE);
						e_cs.setString(6, SUP_COM_CLASSIFY);
						e_cs.setString(7, SUP_EMP_NAME);
						e_cs.setString(8, SUP_EMP_TEL_NO);
						e_cs.setString(9, SUP_EMP_EMAIL);
						e_cs.setString(10, BYR_COM_REGNO);
						e_cs.setString(11, BYR_COM_NAME);
						e_cs.setString(12, BYR_NAME);
						e_cs.setString(13, BYR_COM_ADDR);
						e_cs.setString(14, BYR_COM_TYPE);
						e_cs.setString(15, BYR_COM_CLASSIFY);
						e_cs.setString(16, BYR_EMP_NAME);
						e_cs.setString(17, BYR_EMP_TEL_NO);
						e_cs.setString(18, BYR_EMP_EMAIL);
						e_cs.setString(19, TAX_DT);
						e_cs.setString(20, ITEM_TOT_QTY);
						e_cs.setString(21, SUP_AMOUNT);
						e_cs.setString(22, TAX_AMOUNT);
						e_cs.setString(23, TOT_AMOUNT);
						e_cs.setString(24, ITEM_SUP_AMOUNT);
						e_cs.setString(25, ITEM_TAX_AMOUNT);
						e_cs.setString(26, BILL_NO);
						e_cs.setString(27, "SEND");
						e_cs.setString(28, XML_MSG_ID);
						e_cs.setString(29, XML_MSG_ID2);
						e_cs.setString(30, XML_MSG_ID3);
						e_cs.setString(31, VAT_TYPE);
						e_cs.setString(32, VAT_TYPE2);
						e_cs.setString(33, REMARK);
						e_cs.setString(34, ITEM_REMARK);
						e_cs.setString(35, RFF_GN);
						e_cs.setString(36, "9");
						e_cs.setString(37, "1");
						
						e_cs.execute();
						*/
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "IF_FIN");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						/*
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("");
						pw.flush();
						pw.close();
						*/
						
						
					}
					else if(V_TYPE.equals("SEND_DEL")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
						URLConnection con = url1.openConnection();
						con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
						con.setDoOutput(true);

						anySubObject.put("V_BILL_NO", V_BILL_NO);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anyArray.add(anySubObject);
						anyObject.put("data", anyArray);
						String parameter = anyObject + "";

						System.out.println(parameter);

						OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
						wr.write(parameter);
						wr.flush();

						BufferedReader rd = null;

						rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
						String line = null;
						String result = null;
						while ((line = rd.readLine()) != null) {
							result = URLDecoder.decode(line, "UTF-8");
						}

						System.out.print(result);

						
						
						jsonObject.put("success", true);
						jsonObject.put("resultList", result);

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(jsonObject);
						pw.flush();
						pw.close();
						
					}
					
					else if(V_TYPE.equals("SEND_RE")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						URL url1 = new URL("http://123.142.124.155:8088/http/s_tax_send_klnet");
						URLConnection con = url1.openConnection();
						con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
						con.setDoOutput(true);

						anySubObject.put("V_BILL_NO", V_BILL_NO);
						anySubObject.put("V_USR_ID", V_USR_ID);
						anyArray.add(anySubObject);
						anyObject.put("data", anyArray);
						String parameter = anyObject + "";

						System.out.println(parameter);

						OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
						wr.write(parameter);
						wr.flush();

						BufferedReader rd = null;

						rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
						String line = null;
						String result = null;
						while ((line = rd.readLine()) != null) {
							result = URLDecoder.decode(line, "UTF-8");
						}

						System.out.print(result);

						
						
						jsonObject.put("success", true);
						jsonObject.put("resultList", result);

						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(jsonObject);
						pw.flush();
						pw.close();
						
					}
					
					else if(V_TYPE.equals("SEND_MINUS_AMEND")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "S");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);
						
						String SUP_COM_REGNO = "";  //1
						String SUP_COM_NAME = "";  
						String SUP_NAME = "";
						String SUP_COM_ADDR = "";
						String SUP_COM_TYPE = "";	//5
						String SUP_COM_CLASSIFY = "";
						String SUP_EMP_NAME = "";
						String SUP_EMP_TEL_NO = "";
						String SUP_EMP_EMAIL = ""; //9
						
						String BYR_COM_REGNO = ""; //10
						String BYR_COM_NAME = "";
						String BYR_NAME = "";
						String BYR_COM_ADDR = "";
						String BYR_COM_TYPE = "";
						String BYR_COM_CLASSIFY = ""; //15
						String BYR_EMP_NAME = "";
						String BYR_EMP_TEL_NO = "";
						String BYR_EMP_EMAIL = ""; //18
						
						String TAX_DT = ""; //19
						String ITEM_TOT_QTY = "";
						String SUP_AMOUNT = "";
						String TAX_AMOUNT = "";
						String TOT_AMOUNT = ""; //23
						
						String ITEM_NM = "";
						String ITEM_UNIT = "";
						String ITEM_PRICE = "";
						
						String ITEM_SUP_AMOUNT = "0"; //24
						String ITEM_TAX_AMOUNT = "0";
						String BILL_NO = V_BILL_NO;
						String GUBUN = "C";
						String XML_MSG_ID = "" ;
						String XML_MSG_ID2 = "" ;
						String XML_MSG_ID3 = "" ; //30
						
						String VAT_TYPE = "" ;
						String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
						String REMARK = "";
						String ITEM_REMARK = "";
						String RFF_GN = "";
						
						while (rs.next()) {
							SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
							SUP_COM_NAME = rs.getString("SUP_COM_NAME");
							SUP_NAME = rs.getString("SUP_NAME");
							SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
							SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
							SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
							SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
							SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
							SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
							
							BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
							BYR_COM_NAME = rs.getString("BYR_COM_NAME");
							BYR_NAME = rs.getString("BYR_NAME");
							BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
							BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
							BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
							BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
							BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
							BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
							
							TAX_DT = rs.getString("TAX_DT");
							ITEM_TOT_QTY = rs.getString("ITEM_QTY");
							SUP_AMOUNT = rs.getString("SUP_AMOUNT");
							TAX_AMOUNT = rs.getString("TAX_AMOUNT");
							TOT_AMOUNT = rs.getString("TOT_AMOUNT");
							
							ITEM_NM = rs.getString("ITEM_NM");
							ITEM_UNIT = rs.getString("ITEM_UNIT");
							ITEM_PRICE = rs.getString("ITEM_PRICE");
							
							VAT_TYPE = rs.getString("VAT_TYPE");
							
//		 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
//		 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
//		 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
//		 					subObject.put("MONTH", rs.getString("MONTH"));
//		 					subObject.put("DAY", rs.getString("DAY"));
//		 					jsonArray.add(subObject);
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "MINUS");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);

						e_cs.execute();
//		 				rs = e_cs.executeQuery();
		/*
						while (rs.next()) {
//		 					System.out.println(rs.getString("XML_MSG_ID"));
							XML_MSG_ID = rs.getString("XML_MSG_ID");
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "SEND");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);
						e_cs.execute();
						*/
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "MINUS_AMEND");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						/*
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("");
						pw.flush();
						pw.close();
						*/
						
						
					}
					else if(V_TYPE.equals("SEND_AMEND")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "S");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);
						
						String SUP_COM_REGNO = "";  //1
						String SUP_COM_NAME = "";  
						String SUP_NAME = "";
						String SUP_COM_ADDR = "";
						String SUP_COM_TYPE = "";	//5
						String SUP_COM_CLASSIFY = "";
						String SUP_EMP_NAME = "";
						String SUP_EMP_TEL_NO = "";
						String SUP_EMP_EMAIL = ""; //9
						
						String BYR_COM_REGNO = ""; //10
						String BYR_COM_NAME = "";
						String BYR_NAME = "";
						String BYR_COM_ADDR = "";
						String BYR_COM_TYPE = "";
						String BYR_COM_CLASSIFY = ""; //15
						String BYR_EMP_NAME = "";
						String BYR_EMP_TEL_NO = "";
						String BYR_EMP_EMAIL = ""; //18
						
						String TAX_DT = ""; //19
						String ITEM_TOT_QTY = "";
						String SUP_AMOUNT = "";
						String TAX_AMOUNT = "";
						String TOT_AMOUNT = ""; //23
						
						String ITEM_NM = "";
						String ITEM_UNIT = "";
						String ITEM_PRICE = "";
						
						String ITEM_SUP_AMOUNT = "0"; //24
						String ITEM_TAX_AMOUNT = "0";
						String BILL_NO = V_BILL_NO;
						String GUBUN = "C";
						String XML_MSG_ID = "" ;
						String XML_MSG_ID2 = "" ;
						String XML_MSG_ID3 = "" ; //30
						
						String VAT_TYPE = "" ;
						String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
						String REMARK = "";
						String ITEM_REMARK = "";
						String RFF_GN = "";
						
						while (rs.next()) {
							SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
							SUP_COM_NAME = rs.getString("SUP_COM_NAME");
							SUP_NAME = rs.getString("SUP_NAME");
							SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
							SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
							SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
							SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
							SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
							SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
							
							BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
							BYR_COM_NAME = rs.getString("BYR_COM_NAME");
							BYR_NAME = rs.getString("BYR_NAME");
							BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
							BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
							BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
							BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
							BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
							BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
							
							TAX_DT = rs.getString("TAX_DT");
							ITEM_TOT_QTY = rs.getString("ITEM_QTY");
							SUP_AMOUNT = rs.getString("SUP_AMOUNT");
							TAX_AMOUNT = rs.getString("TAX_AMOUNT");
							TOT_AMOUNT = rs.getString("TOT_AMOUNT");
							
							ITEM_NM = rs.getString("ITEM_NM");
							ITEM_UNIT = rs.getString("ITEM_UNIT");
							ITEM_PRICE = rs.getString("ITEM_PRICE");
							
							VAT_TYPE = rs.getString("VAT_TYPE");
							
//		 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
//		 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
//		 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
//		 					subObject.put("MONTH", rs.getString("MONTH"));
//		 					subObject.put("DAY", rs.getString("DAY"));
//		 					jsonArray.add(subObject);
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "AMEND");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);

						e_cs.execute();
						/*
						rs = e_cs.executeQuery();
						while (rs.next()) {
//		 					System.out.println(rs.getString("XML_MSG_ID"));
							XML_MSG_ID = rs.getString("XML_MSG_ID");
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "SEND");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);
						e_cs.execute();
						*/
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "AMEND");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						/*
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("");
						pw.flush();
						pw.close();
						*/
						
						
					}
					else if(V_TYPE.equals("SEND_AMEND_LIST")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "S");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);
						
						String SUP_COM_REGNO = "";  //1
						String SUP_COM_NAME = "";  
						String SUP_NAME = "";
						String SUP_COM_ADDR = "";
						String SUP_COM_TYPE = "";	//5
						String SUP_COM_CLASSIFY = "";
						String SUP_EMP_NAME = "";
						String SUP_EMP_TEL_NO = "";
						String SUP_EMP_EMAIL = ""; //9
						
						String BYR_COM_REGNO = ""; //10
						String BYR_COM_NAME = "";
						String BYR_NAME = "";
						String BYR_COM_ADDR = "";
						String BYR_COM_TYPE = "";
						String BYR_COM_CLASSIFY = ""; //15
						String BYR_EMP_NAME = "";
						String BYR_EMP_TEL_NO = "";
						String BYR_EMP_EMAIL = ""; //18
						
						String TAX_DT = ""; //19
						String ITEM_TOT_QTY = "";
						String SUP_AMOUNT = "";
						String TAX_AMOUNT = "";
						String TOT_AMOUNT = ""; //23
						
						String ITEM_NM = "";
						String ITEM_UNIT = "";
						String ITEM_PRICE = "";
						
						String ITEM_SUP_AMOUNT = "0"; //24
						String ITEM_TAX_AMOUNT = "0";
						String BILL_NO = V_BILL_NO;
						String GUBUN = "C";
						String XML_MSG_ID = "" ;
						String XML_MSG_ID2 = "" ;
						String XML_MSG_ID3 = "" ; //30
						
						String VAT_TYPE = "" ;
						String VAT_TYPE2 = "B" ;  // A: 영수함,  B: 청구함
						String REMARK = "";
						String ITEM_REMARK = "";
						String RFF_GN = "";
						
						while (rs.next()) {
							SUP_COM_REGNO = rs.getString("SUP_COM_REGNO");
							SUP_COM_NAME = rs.getString("SUP_COM_NAME");
							SUP_NAME = rs.getString("SUP_NAME");
							SUP_COM_ADDR = rs.getString("SUP_COM_ADDR");
							SUP_COM_TYPE = rs.getString("SUP_COM_TYPE");
							SUP_COM_CLASSIFY = rs.getString("SUP_COM_CLASSIFY");
							SUP_EMP_NAME = rs.getString("SUP_EMP_NAME");
							SUP_EMP_TEL_NO = rs.getString("SUP_EMP_TEL_NO");
							SUP_EMP_EMAIL = rs.getString("SUP_EMP_EMAIL");
							
							BYR_COM_REGNO = rs.getString("BYR_COM_REGNO");
							BYR_COM_NAME = rs.getString("BYR_COM_NAME");
							BYR_NAME = rs.getString("BYR_NAME");
							BYR_COM_ADDR = rs.getString("BYR_COM_ADDR");
							BYR_COM_TYPE = rs.getString("BYR_COM_TYPE");
							BYR_COM_CLASSIFY = rs.getString("BYR_COM_CLASSIFY");
							BYR_EMP_NAME = rs.getString("BYR_EMP_NAME");
							BYR_EMP_TEL_NO = rs.getString("BYR_EMP_TEL_NO");
							BYR_EMP_EMAIL = rs.getString("BYR_EMP_EMAIL");
							
							TAX_DT = rs.getString("TAX_DT");
							ITEM_TOT_QTY = rs.getString("ITEM_QTY");
							SUP_AMOUNT = rs.getString("SUP_AMOUNT");
							TAX_AMOUNT = rs.getString("TAX_AMOUNT");
							TOT_AMOUNT = rs.getString("TOT_AMOUNT");
							
							ITEM_NM = rs.getString("ITEM_NM");
							ITEM_UNIT = rs.getString("ITEM_UNIT");
							ITEM_PRICE = rs.getString("ITEM_PRICE");
							
							VAT_TYPE = rs.getString("VAT_TYPE");
							
//		 					subObject.put("ITEM_PRICE", rs.getString("ITEM_PRICE"));
//		 					subObject.put("ITEM_UNIT", rs.getString("ITEM_UNIT"));
//		 					subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
//		 					subObject.put("MONTH", rs.getString("MONTH"));
//		 					subObject.put("DAY", rs.getString("DAY"));
//		 					jsonArray.add(subObject);
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "AMEND_LIST");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);

						e_cs.execute();
						/*
						rs = e_cs.executeQuery();
						while (rs.next()) {
//		 					System.out.println(rs.getString("XML_MSG_ID"));
							XML_MSG_ID = rs.getString("XML_MSG_ID");
						}
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "SEND");
						e_cs.setString(2, XML_MSG_ID);
						e_cs.setString(3, SUP_COM_REGNO);
						e_cs.setString(4, SUP_COM_NAME);
						e_cs.setString(5, SUP_NAME);
						e_cs.setString(6, SUP_COM_ADDR);
						e_cs.setString(7, SUP_COM_TYPE);
						e_cs.setString(8, SUP_COM_CLASSIFY);
						e_cs.setString(9, SUP_EMP_NAME);
						e_cs.setString(10, SUP_EMP_TEL_NO);
						e_cs.setString(11, SUP_EMP_EMAIL);
						e_cs.setString(12, BYR_COM_REGNO);
						e_cs.setString(13, BYR_COM_NAME);
						e_cs.setString(14, BYR_NAME);
						e_cs.setString(15, BYR_COM_ADDR);
						e_cs.setString(16, BYR_COM_TYPE);
						e_cs.setString(17, BYR_COM_CLASSIFY);
						e_cs.setString(18, BYR_EMP_NAME);
						e_cs.setString(19, BYR_EMP_TEL_NO);
						e_cs.setString(20, BYR_EMP_EMAIL);
						e_cs.setString(21, TAX_DT);
						e_cs.setString(22, ITEM_TOT_QTY);
						e_cs.setString(23, SUP_AMOUNT);
						e_cs.setString(24, TAX_AMOUNT);
						e_cs.setString(25, TOT_AMOUNT);
						e_cs.setString(26, ITEM_NM);
						e_cs.setString(27, ITEM_UNIT);
						e_cs.setString(28, ITEM_TOT_QTY);
						e_cs.setString(29, ITEM_PRICE);
						e_cs.setString(30, "");
						e_cs.setString(31, BILL_NO);
						e_cs.setString(32, VAT_TYPE);
						e_cs.setString(33, VAT_TYPE2);
						e_cs.execute();
						*/
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "AMEND_LIST");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						/*
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print("");
						pw.flush();
						pw.close();
						*/
						
						
					}
					else if(V_TYPE.equals("SEND_AMEND_CANCEL")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						
						e_cs = e_conn.prepareCall("{call dbo.USP_A_SEND_TAXBILL_AMEND_HSPF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						e_cs.setString(1, "CANCEL");
						e_cs.setString(2, "");
						e_cs.setString(3, "");
						e_cs.setString(4, "");
						e_cs.setString(5, "");
						e_cs.setString(6, "");
						e_cs.setString(7, "");
						e_cs.setString(8, "");
						e_cs.setString(9, "");
						e_cs.setString(10, "");
						e_cs.setString(11, "");
						e_cs.setString(12, "");
						e_cs.setString(13, "");
						e_cs.setString(14, "");
						e_cs.setString(15, "");
						e_cs.setString(16, "");
						e_cs.setString(17, "");
						e_cs.setString(18, "");
						e_cs.setString(19, "");
						e_cs.setString(20, "");
						e_cs.setString(21, "");
						e_cs.setString(22, "");
						e_cs.setString(23, "");
						e_cs.setString(24, "");
						e_cs.setString(25, "");
						e_cs.setString(26, "");
						e_cs.setString(27, "");
						e_cs.setString(28, "");
						e_cs.setString(29, "");
						e_cs.setString(30, "");
						e_cs.setString(31, V_BILL_NO);
						e_cs.setString(32, "");
						e_cs.setString(33, "");

						e_cs.execute();
						
						cs = conn.prepareCall("call USP_TOT_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "AMEND_CANCEL");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}
					else if(V_TYPE.equals("AMT_CHECK")){
						String V_BILL_NO = request.getParameter("V_BILL_NO") == null ? "" : request.getParameter("V_BILL_NO").toUpperCase();
						String V_MSG = "";
						cs = conn.prepareCall("call USP_001_STEEL_TAX_KLNETSEND(?,?,?,?,?,?,?,?,?,?)");
						
						cs.setString(1, V_COMP_ID);//V_COMP_ID
						cs.setString(2, "AMT_CHECK");//V_TYPE
						cs.setString(3, V_BILL_NO);//V_BILL_NO
						cs.setString(4, "");//V_QTY_YN  작성방법
						cs.setString(5, "");//V_AMT_YN 
						cs.setString(6, "");//V_BYR_EMP_NAME  공급받는자 담당자 이름
						cs.setString(7, "");//V_CN_YN 영수/청구
						cs.setString(8, "");//V_REMARK
						cs.setString(9, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(10, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
						
						rs = (ResultSet) cs.getObject(10);
						
						while (rs.next()) {
							V_MSG = rs.getString("V_MSG");
							
						}
						
						response.setContentType("text/plain; charset=UTF-8");
						PrintWriter pw = response.getWriter();
						pw.print(V_MSG);
						pw.flush();
						pw.close();

					}
				}
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
		
		jsonObject.put("success", false);
		jsonObject.put("resultList", e);

		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(jsonObject);
		pw.flush();
		pw.close();
		
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

