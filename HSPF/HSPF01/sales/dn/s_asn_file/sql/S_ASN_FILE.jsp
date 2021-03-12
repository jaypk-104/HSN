<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="HSPLATFORM.DbConn"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>


<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.nio.file.Path"%>
<%@ page import="java.nio.file.Paths"%>
<%@ page import="java.util.zip.ZipEntry"%>
<%@ page import="java.util.zip.ZipOutputStream"%>


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
		String V_USR_ID = request.getParameter("V_USR_ID") == null ? "" : request.getParameter("V_USR_ID");
		String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");
		String V_FILE_DT_FR = request.getParameter("V_FILE_DT_FR") == null ? "" : request.getParameter("V_FILE_DT_FR").substring(0, 10);
		String V_FILE_DT_TO = request.getParameter("V_FILE_DT_TO") == null ? "" : request.getParameter("V_FILE_DT_TO").substring(0, 10);
		// 		String V_ARR = request.getParameter("V_ARR") == null ? "" : request.getParameter("V_ARR");

		if (V_TYPE.equals("FILE")) {

			String[] V_ARR = request.getParameterValues("V_ARR");

			Random rd = new Random();
			String savePath = "/data/HSPF01/zip/";
			String zipFileName = "fa1" + rd.nextInt() + ".zip";

			String[] files = new String[V_ARR.length];

			for (int i = 0; i < V_ARR.length; i++) {
// 				System.out.println(V_ARR[i]);
				files[i] = "/data/HSPF01/" + V_ARR[i];
			}

			byte[] buf = new byte[4096];

			try {

				ZipOutputStream out1 = new ZipOutputStream(new FileOutputStream(savePath + zipFileName));
// 				System.out.println("zip파일 생성 성공, 경로+파일 = " + savePath + zipFileName);

				for (int i = 0; i < files.length; i++) {

					FileInputStream in = new FileInputStream(files[i]);
					Path p = Paths.get(files[i]);
					String fileName = p.getFileName().toString();

					ZipEntry ze = new ZipEntry(fileName);
					out1.putNextEntry(ze);
					int len;
					while ((len = in.read(buf)) > 0) {
						out1.write(buf, 0, len);
					}
					out1.closeEntry();
					in.close();
				}

				out1.close();

// 				System.out.println("zipFileName" + zipFileName);

				response.setContentType("text/plain; charset=UTF-8");
				PrintWriter pw = response.getWriter();
				pw.print(zipFileName);
				pw.flush();
				pw.close();

			} catch (IOException e) {
				e.printStackTrace();
			}

		} else if (V_TYPE.equals("FD")) {
			String savePath = "/data/HSPF01/zip/";
			String V_FILE_NM = request.getParameter("V_FILE_NM");

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
					file = new File(savePath, V_FILE_NM);
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

		} else {
			cs = conn.prepareCall("call USP_ASN_FILE(?,?,?,?)");
			cs.setString(1, V_FILE_DT_FR);//V_TYPE
			cs.setString(2, V_FILE_DT_TO);//V_COMP_ID
			cs.setString(3, V_S_BP_NM);//V_S_BP_CD
			cs.registerOutParameter(4, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			
			rs = (ResultSet) cs.getObject(4);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("DN_NO", rs.getString("DN_NO"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("BP_CD", rs.getString("BP_CD"));
				subObject.put("BP_NM", rs.getString("BP_NM"));
				subObject.put("TO_SL_CD", rs.getString("TO_SL_CD"));
				subObject.put("TO_SL_NM", rs.getString("TO_SL_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("PO_NO", rs.getString("PO_NO"));
				subObject.put("ASN_NO", rs.getString("ASN_NO"));
				subObject.put("FILE_NM", rs.getString("FILE_NM"));
				subObject.put("FILE_IN_SYSTEM_NM", rs.getString("FILE_IN_SYSTEM_NM"));
				subObject.put("INSRT_DT", rs.getString("INSRT_DT"));
				subObject.put("INSRT_USR", rs.getString("INSRT_USR"));
				jsonArray.add(subObject);

			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 			System.out.println(jsonObject);

			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(jsonObject);
			pw.flush();
			pw.close();
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



