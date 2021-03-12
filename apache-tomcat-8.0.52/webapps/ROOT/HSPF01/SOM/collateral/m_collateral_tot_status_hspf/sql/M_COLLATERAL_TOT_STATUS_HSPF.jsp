<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
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
		String V_DEPT_CD = request.getParameter("V_DEPT_CD") == null ? "" : request.getParameter("V_DEPT_CD").toUpperCase();
		String V_BP_CD = request.getParameter("V_BP_CD") == null ? "" : request.getParameter("V_BP_CD").toUpperCase();
		String V_ASGN_DT_FR = request.getParameter("V_ASGN_DT_FR") == null ? "" : request.getParameter("V_ASGN_DT_FR").substring(0, 10);
		String V_ASGN_DT_TO = request.getParameter("V_ASGN_DT_TO") == null ? "" : request.getParameter("V_ASGN_DT_TO").substring(0, 10);
		String V_DOC_NO = request.getParameter("V_DOC_NO") == null ? "" : request.getParameter("V_DOC_NO").toUpperCase();
		String V_DOC_TYPE_CD = request.getParameter("V_DOC_TYPE_CD") == null ? "" : request.getParameter("V_DOC_TYPE_CD").toUpperCase();
		String V_FILE_NM = request.getParameter("V_FILE_NM") == null ? "" : request.getParameter("V_FILE_NM").toUpperCase();
		String V_FILE_IN_SYSTEM_NM = request.getParameter("V_FILE_IN_SYSTEM_NM") == null ? "" : request.getParameter("V_FILE_IN_SYSTEM_NM").toUpperCase();
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_STATUS_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");

			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, V_ASGN_DT_FR);//V_ASGN_DT_FR 
			cs.setString(4, V_ASGN_DT_TO);//V_ASGN_DT_TO 		
			cs.setString(5, V_DEPT_CD);//V_DEPT_CD 		
			cs.setString(6, V_BP_CD);//V_BP_CD 		
			cs.setString(7, "");//V_DOC_NO 	
			cs.setString(8, "");//V_DOC_TYPE_CD 	
			cs.setString(9, "");//V_FILE_NM
			cs.setString(10, "");//V_FILE_IN_SYSTEM_NM 			
			cs.setString(11, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("DEPT_NM", rs.getString("DEPT_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("COLLATERAL_NO", rs.getString("COLLATERAL_NO"));
				subObject.put("ASGN_DT", rs.getString("ASGN_DT"));
				subObject.put("RENEW_DT", rs.getString("RENEW_DT"));
				subObject.put("EFFECTIVE_DT", rs.getString("EFFECTIVE_DT"));
				subObject.put("EXPIRY_DT", rs.getString("EXPIRY_DT"));
				subObject.put("ASGN_AMT", rs.getString("ASGN_AMT"));
				subObject.put("WARNT_ORG_NM", rs.getString("WARNT_ORG_NM"));
				subObject.put("STOCK_NO", rs.getString("STOCK_NO"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("DB_TYPE2", rs.getString("DB_TYPE2"));
				subObject.put("DB_TYPE2_NM", rs.getString("DB_TYPE2_NM"));
				subObject.put("DB_PROGRESS", rs.getString("DB_PROGRESS"));
				subObject.put("DB_DOC_TYPE", rs.getString("DB_DOC_TYPE"));
				subObject.put("DB_DOC_TYPE_NM", rs.getString("DB_DOC_TYPE_NM"));
				subObject.put("DOC_NO", rs.getString("DOC_NO"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("CHK_A", rs.getString("CHK_A"));
				subObject.put("CHK_B", rs.getString("CHK_B"));
				subObject.put("CHK_C", rs.getString("CHK_C"));

				subObject.put("B1", rs.getString("B1"));
				subObject.put("B2", rs.getString("B2"));
				subObject.put("B3", rs.getString("B3"));
				subObject.put("B4", rs.getString("B4"));
				subObject.put("B5", rs.getString("B5"));
				subObject.put("B6", rs.getString("B6"));
				subObject.put("B7", rs.getString("B7"));
				subObject.put("B8", rs.getString("B8"));

				subObject.put("C1", rs.getString("C1"));
				subObject.put("C2", rs.getString("C2"));
				subObject.put("C3", rs.getString("C3"));
				subObject.put("C4", rs.getString("C4"));
				subObject.put("C5", rs.getString("C5"));
				subObject.put("C6", rs.getString("C6"));
				subObject.put("C7", rs.getString("C7"));

				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();

		} else if (V_TYPE.equals("PI")) {
			if (FileUpload.isMultipartContent(request)) {
				DiskFileUpload fileUpload = new DiskFileUpload();
				fileUpload.setRepositoryPath("/");
				fileUpload.setSizeMax(100 * 1024 * 1024);
				fileUpload.setSizeThreshold(1024 * 50);
				List items = fileUpload.parseRequest(request);
				Iterator iterator = items.iterator();

				V_FILE_NM = "";
				V_FILE_IN_SYSTEM_NM = "";

				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
					if (!item.isFormField() && item.getSize() > 0) {

						int pos = item.getName().lastIndexOf(".");
						String ext = item.getName().substring(pos);

						long curr = System.currentTimeMillis();
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
						String time = sdf2.format(new Date(curr));
						V_FILE_NM = item.getName();
						V_FILE_IN_SYSTEM_NM = V_DOC_NO + '_' + time + ext;

						System.out.println(V_FILE_IN_SYSTEM_NM);

						// 로컬용
						File file = new File("\\\\192.168.123.236\\Users\\FILE_UPLOAD\\" + V_FILE_IN_SYSTEM_NM);

						// 서버용
// 						File file = new File("/data/HSPF01/" + V_FILE_IN_SYSTEM_NM);

						request.setAttribute("file", file);
						item.write(file);
						item.delete();

						cs = conn.prepareCall("call USP_004_M_COLLATERAL_STATUS_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_COMP_ID 		
						cs.setString(2, V_TYPE);//V_TYPE
						cs.setString(3, "");//V_ASGN_DT_FR 
						cs.setString(4, "");//V_ASGN_DT_TO 		
						cs.setString(5, V_DEPT_CD);//V_DEPT_CD 		
						cs.setString(6, V_BP_CD);//V_BP_CD 		
						cs.setString(7, V_DOC_NO);//V_DOC_NO 	
						cs.setString(8, V_DOC_TYPE_CD);//V_DOC_TYPE_CD 	
						cs.setString(9, V_FILE_NM);//V_FILE_NM 		
						cs.setString(10, V_FILE_IN_SYSTEM_NM);//V_FILE_IN_SYSTEM_NM
						cs.setString(11, V_USR_ID);//V_USR_ID 		
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						jsonObject.put("success", true);
						PrintWriter pw = response.getWriter();
						pw.print(jsonObject);
						pw.flush();
						pw.close();

					}
				}
			}
			response.setContentType("text/html");

			/* 파일다운로드 */
		} else if (V_TYPE.equals("P")) {

			//로컬
			String savePath = "\\\\192.168.123.236\\Users\\FILE_UPLOAD\\";

			// 서버
// 			String savePath = "/data/HSPF01/";

			// 서버에 실제 저장된 파일명
			String filename = V_FILE_IN_SYSTEM_NM;

			// 실제 내보낼 파일명
			String orgfilename = V_FILE_NM;

			InputStream in = null;
			OutputStream os = null;
			File file = null;
			boolean skip = false;
			String client = "";

			try {

				// 파일을 읽어 스트림에 담기
				try {
					file = new File(savePath, filename);
					in = new FileInputStream(file);
				} catch (FileNotFoundException fe) {
					skip = true;
				}

				client = request.getHeader("User-Agent");

				// 파일 다운로드 헤더 지정
				response.reset();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Description", "JSP Generated Data");

				if (!skip) {

					// IE
					if (client.indexOf("MSIE") != -1) {
						response.setHeader("Content-Disposition", "attachment; filename=" + new String(orgfilename.getBytes("KSC5601"), "ISO8859_1"));

					} else {
						// 한글 파일명 처리
						orgfilename = new String(orgfilename.getBytes("utf-8"), "iso-8859-1");

						response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
						response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
					}

					response.setHeader("Content-Length", "" + file.length());

					out.clear();
					out = pageContext.pushBody();

					os = response.getOutputStream();
					byte b[] = new byte[(int) file.length()];
					int leng = 0;

					while ((leng = in.read(b)) > 0) {
						os.write(b, 0, leng);
					}
				}
				in.close();
				os.close();
			} finally {
				if (stmt != null) try {
					stmt.close();
				} catch (SQLException ex) {}
				if (conn != null) try {
					conn.close();
				} catch (SQLException ex) {}
			}

			/*파일목록조회*/
		} else if (V_TYPE.equals("PS")) {
			cs = conn.prepareCall("call USP_004_M_COLLATERAL_STATUS_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_COMP_ID 		
			cs.setString(2, V_TYPE);//V_TYPE
			cs.setString(3, "");//V_ASGN_DT_FR 
			cs.setString(4, "");//V_ASGN_DT_TO 		
			cs.setString(5, "");//V_DEPT_CD 		
			cs.setString(6, "");//V_BP_CD 		
			cs.setString(7, V_DOC_NO);//V_DOC_NO 	
			cs.setString(8, V_DOC_TYPE_CD);//V_DOC_TYPE_CD 	
			cs.setString(9, V_FILE_NM);//V_FILE_NM 			
			cs.setString(10, V_FILE_IN_SYSTEM_NM);//V_FILE_IN_SYSTEM_NM
			cs.setString(11, V_USR_ID);//V_USR_ID 		
			cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(12);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DOC_NO", rs.getString("DOC_NO"));
				subObject.put("DOC_TYPE_CD", rs.getString("DOC_TYPE_CD"));
				subObject.put("DOC_TYPE_NM", rs.getString("DOC_TYPE_NM"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("DEPT_CD", rs.getString("DEPT_CD"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("FILE_IN_SYSTEM_NM", rs.getString("FILE_IN_SYSTEM_NM"));
				subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
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
		/*파일삭제*/
		else if (V_TYPE.equals("SYNC")) {

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
					V_DOC_NO = hashMap.get("DOC_NO") == null ? "" : hashMap.get("DOC_NO").toString();
					V_DOC_TYPE_CD = hashMap.get("DOC_TYPE_CD") == null ? "" : hashMap.get("DOC_TYPE_CD").toString();
					V_FILE_NM = hashMap.get("FILE_NM") == null ? "" : hashMap.get("FILE_NM").toString();
					V_FILE_IN_SYSTEM_NM = hashMap.get("FILE_IN_SYSTEM_NM") == null ? "" : hashMap.get("FILE_IN_SYSTEM_NM").toString();

					cs = conn.prepareCall("call USP_004_M_COLLATERAL_STATUS_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_COMP_ID 		
					cs.setString(2, V_TYPE);//V_TYPE
					cs.setString(3, "");//V_ASGN_DT_FR 
					cs.setString(4, "");//V_ASGN_DT_TO 		
					cs.setString(5, "");//V_DEPT_CD 		
					cs.setString(6, "");//V_BP_CD 		
					cs.setString(7, V_DOC_NO);//V_DOC_NO 	
					cs.setString(8, V_DOC_TYPE_CD);//V_DOC_TYPE_CD 	
					cs.setString(9, V_FILE_NM);//V_FILE_NM
					cs.setString(10, V_FILE_IN_SYSTEM_NM);//V_FILE_IN_SYSTEM_NM
					cs.setString(11, V_USR_ID);//V_USR_ID 		
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_DOC_NO = jsondata.get("DOC_NO") == null ? "" : jsondata.get("DOC_NO").toString();
				V_DOC_TYPE_CD = jsondata.get("DOC_TYPE_CD") == null ? "" : jsondata.get("DOC_TYPE_CD").toString();
				V_FILE_NM = jsondata.get("FILE_NM") == null ? "" : jsondata.get("FILE_NM").toString();
				V_FILE_IN_SYSTEM_NM = jsondata.get("FILE_IN_SYSTEM_NM") == null ? "" : jsondata.get("FILE_IN_SYSTEM_NM").toString();

				cs = conn.prepareCall("call USP_004_M_COLLATERAL_STATUS_HSPF(?,?,?,?,?,?,?,?,?,?,?,?)");
				cs.setString(1, V_COMP_ID);//V_COMP_ID 		
				cs.setString(2, V_TYPE);//V_TYPE
				cs.setString(3, "");//V_ASGN_DT_FR 
				cs.setString(4, "");//V_ASGN_DT_TO 		
				cs.setString(5, "");//V_DEPT_CD 		
				cs.setString(6, "");//V_BP_CD 		
				cs.setString(7, V_DOC_NO);//V_DOC_NO 	
				cs.setString(8, V_DOC_TYPE_CD);//V_DOC_TYPE_CD 	
				cs.setString(9, V_FILE_NM);//V_FILE_NM
				cs.setString(10, V_FILE_IN_SYSTEM_NM);//V_FILE_IN_SYSTEM_NM 		
				cs.setString(11, V_USR_ID);//V_USR_ID 		
				cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
				cs.executeQuery();
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


