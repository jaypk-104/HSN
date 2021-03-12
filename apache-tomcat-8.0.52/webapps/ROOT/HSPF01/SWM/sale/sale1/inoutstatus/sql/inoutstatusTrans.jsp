<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>
   
    <%
    ResultSet rs = null;
    CallableStatement cs = null;
    try{
    
    	request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
    	String jsonData = URLDecoder.decode(data, "UTF-8");
    	
    	
    	
    	if (jsonData.lastIndexOf("},{") > 0) { //배열일경우(여러개가 체크된 경우)
			JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);
    		for (int i = 0; i < jsonAr.size(); i++) {
				HashMap hashMap = (HashMap) jsonAr.get(i);		
		
				String mast_po_no          = hashMap.get("MAST_PO_NO")       == null ? "" : hashMap.get("MAST_PO_NO").toString();   
				String mast_po_seq          = hashMap.get("MAST_PO_SEQ")       == null ? "" : hashMap.get("MAST_PO_SEQ").toString();   
				String bp_cd          = hashMap.get("BP_CD")       == null ? "" : hashMap.get("BP_CD").toString();   
				String asn_no          = hashMap.get("ASN_NO")       == null ? "" : hashMap.get("ASN_NO").toString();   
				String cont_no          = hashMap.get("CONT_NO")       == null ? "" : hashMap.get("CONT_NO").toString();   
				String item_cd          = hashMap.get("ITEM_CD")       == null ? "" : hashMap.get("ITEM_CD").toString();   
    			String v_usr_id           = request.getParameter("v_usr_id")  == null ? "" : request.getParameter("v_usr_id").toString();
    			/*
    			// 디버깅용
		    	System.out.println(mast_po_no);
		    	System.out.println(mast_po_seq);
		    	System.out.println(bp_cd);
		    	System.out.println(asn_no);
		    	System.out.println(cont_no);
		    	System.out.println(item_cd);
		    	System.out.println(v_usr_id);
		    	*/
		    	
		    	cs = conn.prepareCall("{call USP_S_DN_DELETE(?,?,?,?,?,?,?)}");
				cs.setString(1, mast_po_no);	// 발주번소
				cs.setString(2, mast_po_seq);	// 발주순번
				cs.setString(3, bp_cd);		// 공급사
				cs.setString(4, asn_no);	// ASN번호
				cs.setString(5, cont_no);	// 컨테이너번호
				cs.setString(6, item_cd);	// 아이템 코드
				cs.setString(7, v_usr_id);	// V_USR_ID
				
				cs.execute();
    		}
    	}
   		else{
   			JSONObject jsondata = JSONObject.fromObject(jsonData);
   			
   			String mast_po_no          = jsondata.get("MAST_PO_NO")       == null ? "" : jsondata.get("MAST_PO_NO").toString();   
			String mast_po_seq          = jsondata.get("MAST_PO_SEQ")       == null ? "" : jsondata.get("MAST_PO_SEQ").toString();   
			String bp_cd          = jsondata.get("BP_CD")       == null ? "" : jsondata.get("BP_CD").toString();   
			String asn_no          = jsondata.get("ASN_NO")       == null ? "" : jsondata.get("ASN_NO").toString();   
			String cont_no          = jsondata.get("CONT_NO")       == null ? "" : jsondata.get("CONT_NO").toString();   
			String item_cd          = jsondata.get("ITEM_CD")       == null ? "" : jsondata.get("ITEM_CD").toString();   
   			String v_usr_id           = request.getParameter("v_usr_id")  == null ? "" : request.getParameter("v_usr_id").toString();
   			
   			/*
   			// 디버깅용
	    	System.out.println(mast_po_no);
	    	System.out.println(mast_po_seq);
	    	System.out.println(bp_cd);
	    	System.out.println(asn_no);
	    	System.out.println(cont_no);
	    	System.out.println(item_cd);
	    	System.out.println(v_usr_id);
	    	*/
	    	
	    	cs = conn.prepareCall("{call USP_S_DN_DELETE(?,?,?,?,?,?,?)}");
			cs.setString(1, mast_po_no);	// 발주번소
			cs.setString(2, mast_po_seq);	// 발주순번
			cs.setString(3, bp_cd);		// 공급사
			cs.setString(4, asn_no);	// ASN번호
			cs.setString(5, cont_no);	// 컨테이너번호
			cs.setString(6, item_cd);	// 아이템 코드
			cs.setString(7, v_usr_id);	// V_USR_ID
			
			cs.execute();
   			
   		}
    	
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.flush();
		pw.close();
	}catch(Exception e){
 		e.printStackTrace();
	}finally{
    	if (cs != null)
			try {
				cs.close();
			} catch (SQLException ex) {
			}
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}	  
	  %>