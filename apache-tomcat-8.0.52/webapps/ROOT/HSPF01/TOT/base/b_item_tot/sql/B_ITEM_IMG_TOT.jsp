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
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@include file="/HSPF01/common/DB_Connection.jsp"%>

<%@page import="java.text.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>

<%
	request.setCharacterEncoding("utf-8");
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;

	final String IMG_URL = "http://123.142.124.146/data/B_ITEM_TOT/";
// 	final String IMG_EXT = ".jpg";
	
	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "^" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "^" : request.getParameter("V_COMP_ID").toUpperCase();
		String V_ITEM_CD = request.getParameter("V_ITEM_CD") == null ? "^" : request.getParameter("V_ITEM_CD").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();
		
		//조회
		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_003_B_ITEM_IMG_TOT(?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);//V_TYPE
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
			cs.setString(4, V_USR_ID);//V_USR_ID
			cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(6, "");//V_SEQ
			cs.setString(7, "");//V_IMG_NM
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(5);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("SEQ", rs.getString("SEQ"));
				subObject.put("IMG_NM", rs.getString("IMG_NM"));
				subObject.put("IMAGE", IMG_URL+rs.getString("IMG_NM"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("I")) {
			String V_FILE_NM = "";
			
			if (FileUpload.isMultipartContent(request)) {
				DiskFileUpload fileUpload = new DiskFileUpload();
				fileUpload.setRepositoryPath("/");
				fileUpload.setSizeMax(100 * 1024 * 1024);
				fileUpload.setSizeThreshold(1024 * 50);
				List items = fileUpload.parseRequest(request);
				Iterator iterator = items.iterator();

				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
					if (!item.isFormField() && item.getSize() > 0) {

// 						int pos = item.getName().lastIndexOf(".");
// 						String ext = item.getName().substring(pos);

						V_FILE_NM = item.getName();
						File file = new File("/data/B_ITEM_TOT/" + V_FILE_NM);
// 						File file = new File("D:\\\\TEST\\" + V_FILE_NM);
						
						request.setAttribute("file", file);
						item.write(file);
						item.delete();
 									
						cs = conn.prepareCall("call USP_003_B_ITEM_IMG_TOT(?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_COMP_ID
						cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
						cs.setString(4, V_USR_ID);//V_USR_ID
						cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
						cs.setString(6, "");//V_SEQ
						cs.setString(7, V_FILE_NM);//V_IMG_NM
						cs.executeQuery();
					}
				}
			}
			response.setContentType("text/html");
			
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();
			
		} else if (V_TYPE.equals("SYNC")) {
			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);
					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();
					String V_SEQ = hashMap.get("SEQ") == null ? "" : hashMap.get("SEQ").toString();
					String V_IMG_NM = hashMap.get("IMG_NM") == null ? "" : hashMap.get("IMG_NM").toString();

					cs = conn.prepareCall("call USP_003_B_ITEM_IMG_TOT(?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_COMP_ID
					cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
					cs.setString(4, V_USR_ID);//V_USR_ID
					cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
					cs.setString(6, V_SEQ);//V_SEQ
					cs.setString(7, V_IMG_NM);//V_IMG_NM
					cs.executeQuery();
				}
			} else {
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(jsonData);
				JSONObject jsondata = (JSONObject) obj;
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();
				String V_SEQ = jsondata.get("SEQ") == null ? "" : jsondata.get("SEQ").toString();
				String V_IMG_NM = jsondata.get("IMG_NM") == null ? "" : jsondata.get("IMG_NM").toString();
				
				cs = conn.prepareCall("call USP_003_B_ITEM_IMG_TOT(?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);//V_TYPE
				cs.setString(2, V_COMP_ID);//V_COMP_ID
				cs.setString(3, V_ITEM_CD.trim());//V_ITEM_CD
				cs.setString(4, V_USR_ID);//V_USR_ID
				cs.registerOutParameter(5, com.tmax.tibero.TbTypes.CURSOR);
				cs.setString(6, V_SEQ);//V_SEQ
				cs.setString(7, V_IMG_NM);//V_IMG_NM
				cs.executeQuery();
			}
			
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("success");
			pw.flush();
			pw.close();
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
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


