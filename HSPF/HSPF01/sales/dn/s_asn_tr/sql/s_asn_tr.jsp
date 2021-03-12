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
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>

<%@ page import="org.apache.commons.net.PrintCommandListener"%>
<%@ page import="org.apache.commons.net.ftp.FTP"%>
<%@ page import="org.apache.commons.net.ftp.FTPClient"%>
<%@ page import="org.apache.commons.net.ftp.FTPReply"%>

<%@ page import="com.jcraft.jsch.Channel"%>
<%@ page import="com.jcraft.jsch.ChannelSftp"%>
<%@ page import="com.jcraft.jsch.JSch"%>
<%@ page import="com.jcraft.jsch.JSchException"%>
<%@ page import="com.jcraft.jsch.Session"%>
<%@ page import="com.jcraft.jsch.SftpException"%>

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

		// 		System.out.println("V_CUST_ORDER_NO :" + V_CUST_ORDER_NO);

		if (V_TYPE.equals("S")) {
			String V_DN_DT_FROM = request.getParameter("V_DN_DT_FROM") == null ? "" : request.getParameter("V_DN_DT_FROM").toUpperCase();
			String V_DN_DT_TO = request.getParameter("V_DN_DT_TO") == null ? "" : request.getParameter("V_DN_DT_TO").toUpperCase();
			String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
			String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
			
			if(V_DN_DT_FROM.length() > 10){
				V_DN_DT_FROM = V_DN_DT_FROM.substring(0,10);
			}
			if(V_DN_DT_TO.length() > 10){
				V_DN_DT_TO = V_DN_DT_TO.substring(0,10);
			}
			
			cs = conn.prepareCall("call USP_S_ASN_TR_HSPF(?,?,?,?,?,?,?)");
			cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(2, V_COMP_ID);//V_COMP_ID
			cs.setString(3, V_TYPE);//V_TYPE
			cs.setString(4, V_DN_DT_FROM);//V_DN_DT_FROM
			cs.setString(5, V_DN_DT_TO);//
			cs.setString(6, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(7, V_ITEM_NM);//V_ITEM_NM
			
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(1);
			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("S_BP_NM", rs.getString("S_BP_NM"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("DLVY_HOPE_DT", rs.getString("DLVY_HOPE_DT"));
				subObject.put("DN_DT", rs.getString("DN_DT"));
				subObject.put("M_BP_NM", rs.getString("M_BP_NM"));
				subObject.put("BP_ITEM_CD", rs.getString("BP_ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("SPEC", rs.getString("SPEC"));
				subObject.put("UNIT", rs.getString("UNIT"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("SUPP_REMARK", rs.getString("SUPP_REMARK"));
				subObject.put("REMARK", rs.getString("REMARK"));
				subObject.put("IF_SRM_YN", rs.getString("IF_SRM_YN"));
				subObject.put("DN_NO", rs.getString("DN_NO"));
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
		if (V_TYPE.equals("IF")) {
			
			/*
			String SQL = "";
			SQL =       "SELECT 'ATHS'|| SUBSTR(A.DN_NO, 3) ASN_NO, B.LOT_NO                                                                                                               ";
			SQL +=      "    , 'S001_ATHS'|| SUBSTR(A.DN_NO, 3) || '_' || TO_CHAR(SYSDATE, 'YYYYMMDD_HH24MISS') || SUBSTR( C.FILE_IN_SYSTEM_NM, INSTR(C.FILE_IN_SYSTEM_NM, '.')) TR_FILE_NM";
			SQL +=      "    , C.FILE_NM                                                                                                                                                   ";
			SQL +=      "    , C.FILE_IN_SYSTEM_NM                                                                                                                                         ";
			SQL +=      "FROM S_DN_DIREC_BC_SWM A                                                                                                                                          ";
			SQL +=      "LEFT OUTER JOIN SCM_BARCD_DTL_SWM B ON A.PAL_BC_NO = B.PAL_BC_NO AND A.BOX_BC_NO = B.BOX_BC_NO AND A.LOT_BC_NO = B.LOT_BC_NO                                      ";
			SQL +=      "LEFT OUTER JOIN SCM_ASN_FILE_HSPF C ON B.ASN_NO = C.ASN_NO                                                                                                        ";
			SQL +=      "WHERE A.BP_CD = '04716'                                                                                                                                           ";
			SQL +=      "AND C.FILE_NM IS NOT NULL                                                                                                                                         ";
			SQL +=      "AND NVL(A.IF_SRM_YN,'N') = 'N'                                                                                                                                    ";
			SQL +=      "GROUP BY SUBSTR(A.DN_NO, 3), B.LOT_NO, C.FILE_NM, C.FILE_IN_SYSTEM_NM;                                                                                            ";
			
			rs = stmt.executeQuery(SQL);
			*/
			
			cs = conn.prepareCall("call USP_S_DN_HSTN_FILE_LOG(?,?)");
			cs.registerOutParameter(1, com.tmax.tibero.TbTypes.CURSOR);
			cs.setString(2, V_USR_ID);
			cs.executeQuery();
			rs = (ResultSet) cs.getObject(1);
			
			while (rs.next()) {
				
				File file = new File("/data/HSPF01/" + rs.getString("FILE_IN_SYSTEM_NM"));

				FTPClient ftpClient = new FTPClient();

				ftpClient.setControlEncoding("utf-8");
				String server = "43.254.152.57";  //파일 업로드 할 서버 IP
				int port = 1999;  //파일 업로드 할 서버 포트
			    String username = "hstn_ko";       //사용자 Id
			    String password = "hstnkorea";       //패스워드
//				    String defaultPath = "C:\\OmegaPlus\\upload\\default\\AsnQcUploadFile\\";     // 저장할 경로
//				    String defaultPath = "/";     // 저장할 경로
//					String server = "123.142.124.170";  //파일 업로드 할 서버 IP
//					int port = 21;  //파일 업로드 할 서버 포트
//				    String username = "root";       //사용자 Id
//				    String password = "!qa2ws3ed";       //패스워드
//				    String defaultPath = "/data";     // 저장할 경로

			    ftpClient.connect(server,port);
			    int reply = ftpClient.getReplyCode();
			    
			    if (!FTPReply.isPositiveCompletion(reply)) {
			    	ftpClient.disconnect();
		            throw new Exception("Exception in connecting to FTP Server");
		        }
			    ftpClient.login(username, password);//로그인
			    ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
			    ftpClient.enterLocalPassiveMode();
				
			    InputStream input = new FileInputStream(file);

			    ftpClient.storeFile(rs.getString("TR_FILE_NM"), input);
			    
			    ftpClient.disconnect();
			    
			    
			    
			    /*
			    //여기는 SFTP 방식
			    Session F_session = null;
			    Channel F_channel = null;
			    ChannelSftp F_channelSftp = null;

			    String url = "123.142.124.170"; 
			    String user = "root"; 
			    String password = "!qa2ws3ed";
				String defaultPath = "/data";     // 저장할 경로
//				    String url = "43.254.152.57"; 
//				    String user = "hstn_ko"; 
//				    String password = "hstnkorea";
//				    String defaultPath = "C:\\OmegaPlus\\upload\\default\\AsnQcUploadFile\\";     // 저장할 경로


			    
			    JSch jsch = new JSch();
			    
			    F_session = jsch.getSession(user, url);
			    F_session.setPassword(password);
			    //세션관련 설정정보 설정 
			    java.util.Properties F_config = new java.util.Properties(); 
			    
			    //호스트 정보 검사하지 않는다. 
			    F_config.put("StrictHostKeyChecking", "no"); 
			    F_session.setConfig(F_config); 
			    
			    //접속 
			    F_session.connect(); 
			    
			    //sftp 채널 접속 
			    F_channel = F_session.openChannel("sftp"); 
			    F_channel.connect();
			    
			    F_channelSftp = (ChannelSftp) F_channel;

			    FileInputStream F_in = null;
			    
			    F_in = new FileInputStream(file);
			    F_channelSftp.cd(defaultPath);
			    F_channelSftp.put(F_in,file.getName());

			    F_channelSftp.quit(); 
			    F_session.disconnect();
				*/
				
				
			}
				
			
			
			
		
			URL url1 = new URL("http://123.142.124.155:8088/http/hsn_hstn_asn");
			URLConnection con = url1.openConnection();
			con.setRequestProperty("Accept-Language", "ko-kr,ko;q=0.8,en-us;q=0.5,en;q=0.3");
			con.setDoOutput(true);
			JSONObject anySubObject = new JSONObject();

// 			anySubObject.put("V_DN_NO", "1");
// 			anySubObject.put("V_DN_SEQ", "1");
			anySubObject.put("V_COMP_ID", "HSN");
			anySubObject.put("V_USR_ID", V_USR_ID);
			JSONArray anyArray = new JSONArray();
			anyArray.add(anySubObject);
			JSONObject anyObject = new JSONObject();
			anyObject.put("data", anyArray);
			String parameter = anyObject + "";

			// 			System.out.println(parameter);
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
			//                   System.out.println(result);
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(result);
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



