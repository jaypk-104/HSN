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
		String V_CONT_NO = request.getParameter("V_CONT_NO") == null ? "" : request.getParameter("V_CONT_NO");
// 		System.out.println("컨테이너 첨부파일 테스트");
		
		// 서버에 실제 저장된 파일명
			String filename = "";

		// 실제 내보낼 파일명
			String orgfilename = "";
		
		String sql = " select B.FILE_NM, B.FILE_SYS_NM from S_CONTAINER_MST A ";
		sql += " LEFT OUTER jOIN S_CONTAINER_FILE B ON A.CONT_MGM_NO = B.CONT_MGM_NO ";
		sql += " WHERE  B.TYPE = 'R' AND A.CONT_NO = '"  + V_CONT_NO  + "'  ";
		
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			
			filename = rs.getString("FILE_SYS_NM");
			orgfilename = rs.getString("FILE_NM");
			
		}
		
		
		if(filename.equals("")){
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("파일없음");
			pw.flush();
			pw.close();
		}
		else{
			
		
		
		
		
			//로컬
			// 			String savePath = "\\\\123.142.124.137\\aiusr\\webapps\\hsnelec\\ROOT\\aireport\\AIViewer55\\HSPF01\\FILEUPLOAD\\";

			// 			서버
// 			String savePath = "/data/apache/webapps/ROOT/HSPF01_FILE/";
			String savePath = "/data/CONT_FILE/";

			

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
