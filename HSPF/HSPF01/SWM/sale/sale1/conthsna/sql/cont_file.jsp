<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@include file="/HSPF01/common/DB_Connection.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ResultSet rs = null;
	CallableStatement cs = null;
	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	JSONObject subObject = null;
	try {
		String V_TYPE = request.getParameter("V_TYPE") == null ? "" : request.getParameter("V_TYPE");
		String V_COMP_ID = request.getParameter("V_COMP_ID") == null ? "" : request.getParameter("V_COMP_ID");
		String V_CONT_NO = request.getParameter("V_CONT_NO") == null ? "" : request.getParameter("V_CONT_NO");
		String V_FILE_TYPE = request.getParameter("V_FILE_TYPE") == null ? "" : request.getParameter("V_FILE_TYPE");
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_FILE_NM = request.getParameter("V_FILE_NM") == null ? "" : request.getParameter("V_FILE_NM");
		String V_FILE_IN_SYSTEM_NM = request.getParameter("V_FILE_IN_SYSTEM_NM") == null ? "" : request.getParameter("V_FILE_IN_SYSTEM_NM");

// 		System.out.println(V_FILE_NM);
		
		/* 파일업로드 */
		if (V_TYPE.equals("I")) {
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

						long curr = System.currentTimeMillis(); // 또는 System.nanoTime();
						SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
						String time = sdf2.format(new Date(curr));
						V_FILE_NM = item.getName();
						V_FILE_IN_SYSTEM_NM = V_CONT_NO + '_' + time + ext;

						// 						System.out.println(V_FILE_IN_SYSTEM_NM);

						//로컬용
						// 						File file = new File("\\\\123.142.124.137\\aiusr\\webapps\\hsnelec\\ROOT\\aireport\\AIViewer55\\HSPF01\\FILEUPLOAD\\" + V_FILE_IN_SYSTEM_NM);

						// 						서버용
						// 						File file = new File("/data/apache/webapps/ROOT/HSPF01_FILE/" + V_FILE_IN_SYSTEM_NM);
						File file = new File("/data/CONT_FILE/" + V_FILE_IN_SYSTEM_NM);
// 						File file = new File("/" + V_FILE_IN_SYSTEM_NM);

						request.setAttribute("file", file);
						item.write(file);
						item.delete();

// 						System.out.println("V_CONT_NO : " + V_CONT_NO);
// 						System.out.println("V_FILE_TYPE : " + V_FILE_TYPE);
// 						System.out.println("V_FILE_NM : " + V_FILE_NM);
// 						System.out.println("V_FILE_IN_SYSTEM_NM : " + V_FILE_IN_SYSTEM_NM);
// 						System.out.println("V_USR_ID : " + V_USR_ID);

						cs = conn.prepareCall("call USP_S_CONTAINER_FILE_SWM(?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);
						cs.setString(2, V_CONT_NO);
						cs.setString(3, V_FILE_TYPE);
						cs.setString(4, V_FILE_NM);
						cs.setString(5, V_FILE_IN_SYSTEM_NM);
						cs.setString(6, V_USR_ID);
						cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
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
		} else if (V_TYPE.equals("D")) {

			//로컬
			// 			String savePath = "\\\\123.142.124.137\\aiusr\\webapps\\hsnelec\\ROOT\\aireport\\AIViewer55\\HSPF01\\FILEUPLOAD\\";

			// 			서버
// 			String savePath = "/data/apache/webapps/ROOT/HSPF01_FILE/";
			String savePath = "/data/CONT_FILE/";

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
		} else if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call USP_S_CONTAINER_FILE_SWM(?,?,?,?,?,?,?)");
			cs.setString(1, V_TYPE);
			cs.setString(2, V_CONT_NO);
			cs.setString(3, V_FILE_TYPE);
			cs.setString(4, "");
			cs.setString(5, "");
			cs.setString(6, "");
			cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(7);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("CONT_NO", rs.getString("CONT_NO"));
				subObject.put("FILE_TYPE", rs.getString("FILE_TYPE"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("FILE_SYS_NM", rs.getString("FILE_SYS_NM"));
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
					V_CONT_NO = hashMap.get("CONT_NO") == null ? "" : hashMap.get("CONT_NO").toString();
					V_FILE_TYPE = hashMap.get("FILE_TYPE") == null ? "" : hashMap.get("FILE_TYPE").toString();
					V_FILE_NM = hashMap.get("FILE_NM") == null ? "" : hashMap.get("FILE_NM").toString();
					V_FILE_IN_SYSTEM_NM = hashMap.get("FILE_SYS_NM") == null ? "" : hashMap.get("FILE_SYS_NM").toString();

					// 					System.out.println("V_TYPE" + V_TYPE);
					// 					System.out.println("V_ASN_NO" + V_ASN_NO);
					// 					System.out.println("V_FILE_NM" + V_FILE_NM);
					// 					System.out.println("V_FILE_IN_SYSTEM_NM" + V_FILE_IN_SYSTEM_NM);

					cs = conn.prepareCall("call USP_S_CONTAINER_FILE_SWM(?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);
					cs.setString(2, V_CONT_NO);
					cs.setString(3, V_FILE_TYPE);
					cs.setString(4, V_FILE_NM);
					cs.setString(5, V_FILE_IN_SYSTEM_NM);
					cs.setString(6, V_USR_ID);
					cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				
				
				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_CONT_NO = jsondata.get("CONT_NO") == null ? "" : jsondata.get("CONT_NO").toString();
				V_FILE_TYPE = jsondata.get("FILE_TYPE") == null ? "" : jsondata.get("FILE_TYPE").toString();
				V_FILE_NM = jsondata.get("FILE_NM") == null ? "" : jsondata.get("FILE_NM").toString();
				V_FILE_IN_SYSTEM_NM = jsondata.get("FILE_SYS_NM") == null ? "" : jsondata.get("FILE_SYS_NM").toString();

// 								System.out.println("V_TYPE : " + V_TYPE);
// 								System.out.println("V_CONT_NO : " + V_CONT_NO);
// 								System.out.println("V_FILE_TYPE : " + V_FILE_TYPE);
// 								System.out.println("V_FILE_IN_SYSTEM_NM : " + V_FILE_IN_SYSTEM_NM);

				cs = conn.prepareCall("call USP_S_CONTAINER_FILE_SWM(?,?,?,?,?,?,?)");
				cs.setString(1, V_TYPE);
				cs.setString(2, V_CONT_NO);
				cs.setString(3, V_FILE_TYPE);
				cs.setString(4, V_FILE_NM);
				cs.setString(5, V_FILE_IN_SYSTEM_NM);
				cs.setString(6, V_USR_ID);
				cs.registerOutParameter(7, com.tmax.tibero.TbTypes.CURSOR);
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
