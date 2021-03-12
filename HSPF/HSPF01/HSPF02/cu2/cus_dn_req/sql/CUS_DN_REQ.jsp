<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.mail.BodyPart"%>
<%@ page import="javax.mail.Multipart"%>

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
		String V_SL_CD = request.getParameter("V_SL_CD") == null ? "" : request.getParameter("V_SL_CD").toUpperCase();
		String V_S_BP_CD = request.getParameter("V_S_BP_CD") == null ? "" : request.getParameter("V_S_BP_CD").toUpperCase();
		String V_ITEM_NM = request.getParameter("V_ITEM_NM") == null ? "" : request.getParameter("V_ITEM_NM").toUpperCase();
		String V_BL_DOC_NO = request.getParameter("V_BL_DOC_NO") == null ? "" : request.getParameter("V_BL_DOC_NO").toUpperCase();
		String V_SP_TYPE = request.getParameter("V_SP_TYPE") == null ? "" : request.getParameter("V_SP_TYPE").toUpperCase();

		if (V_TYPE.equals("S")) {
			cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN_REQ(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cs.setString(1, V_COMP_ID);//V_TYPE
			cs.setString(2, V_TYPE);//V_COMP_ID
			cs.setString(3, V_S_BP_CD);//V_SL_CD
			cs.setString(4, V_BL_DOC_NO);//V_BL_DOC_NO
			cs.setString(5, V_ITEM_NM);//V_SL_DT
			cs.setString(6, V_SL_CD);//V_SL_LOC
			cs.setString(7, "");//""
			cs.setString(8, "");//""
			cs.setString(9, "");//V_REF_NO
			cs.setString(10, "");//V_REF_NO
			cs.setString(11, "");//V_REF_NO
			cs.setString(12, "");//V_REF_NO
			cs.setString(13, V_USR_ID);//V_REF_NO
			cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
			cs.executeQuery();

			rs = (ResultSet) cs.getObject(14);

			while (rs.next()) {
				subObject = new JSONObject();
				subObject.put("BL_DOC_NO", rs.getString("BL_DOC_NO"));
				subObject.put("IN_DT", rs.getString("IN_DT"));
				subObject.put("OWN_DT", rs.getString("OWN_DT"));
				subObject.put("REGION", rs.getString("REGION"));
				subObject.put("SL_CD", rs.getString("SL_CD"));
				subObject.put("SL_NM", rs.getString("SL_NM"));
				subObject.put("ITEM_CD", rs.getString("ITEM_CD"));
				subObject.put("ITEM_NM", rs.getString("ITEM_NM"));
				subObject.put("BOX_QTY", rs.getString("BOX_QTY"));
				subObject.put("BOX_WGT_UNIT", rs.getString("BOX_WGT_UNIT"));
				subObject.put("QTY", rs.getString("QTY"));
				subObject.put("CC_REQ_YN", rs.getString("CC_REQ_YN"));
				subObject.put("CC_YN", rs.getString("CC_YN"));
				subObject.put("DN_REQ_BOX_QTY", rs.getString("DN_REQ_BOX_QTY"));
				subObject.put("DN_QTY", rs.getString("DN_QTY"));
				subObject.put("DN_REQ_DT", rs.getString("DN_REQ_DT"));
				subObject.put("BL_NO", rs.getString("BL_NO"));
				subObject.put("BL_SEQ", rs.getString("BL_SEQ"));
				subObject.put("MVMT_NO", rs.getString("MVMT_NO"));
				jsonArray.add(subObject);
			}

			jsonObject.put("success", true);
			jsonObject.put("resultList", jsonArray);

			// 						System.out.println(jsonObject);

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

			// 			System.out.println(jsonData);

			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					V_TYPE = hashMap.get("V_TYPE") == null ? "" : hashMap.get("V_TYPE").toString();
					V_SL_CD = hashMap.get("SL_CD") == null ? "" : hashMap.get("SL_CD").toString();
					String V_BL_NO = hashMap.get("BL_NO") == null ? "" : hashMap.get("BL_NO").toString();
					String V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null || hashMap.get("DN_QTY").equals("null") ? "0" : Math.round(Double.parseDouble(hashMap.get("DN_QTY").toString()) * 100) / 100.0 + "";
					String V_DN_BOX_QTY = hashMap.get("DN_REQ_BOX_QTY") == null || hashMap.get("DN_REQ_BOX_QTY").equals("null") ? "0" : hashMap.get("DN_REQ_BOX_QTY").toString();
					String V_DN_REQ_DT = hashMap.get("DN_REQ_DT") == null ? "" : hashMap.get("DN_REQ_DT").toString().substring(0, 10);
					String V_ITEM_CD = hashMap.get("ITEM_CD") == null ? "" : hashMap.get("ITEM_CD").toString();

					if (V_SP_TYPE.equals("DN_REQ")) {
						cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN_REQ(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);//V_TYPE
						cs.setString(2, V_TYPE);//V_COMP_ID
						cs.setString(3, V_S_BP_CD);//V_SL_CD
						cs.setString(4, "");//V_BL_DOC_NO
						cs.setString(5, V_ITEM_NM);//V_SL_DT
						cs.setString(6, V_SL_CD);//V_SL_LOC
						cs.setString(7, V_BL_NO);//V_BL_NO
						cs.setString(8, V_BL_SEQ);//V_BL_SEQ
						cs.setString(9, V_MVMT_NO);//V_MVMT_NO
						cs.setString(10, V_DN_QTY);//V_DN_QTY
						cs.setString(11, V_DN_BOX_QTY);//V_DN_BOX_QTY
						cs.setString(12, V_DN_REQ_DT);//V_DN_REQ_DT
						cs.setString(13, V_USR_ID);//V_REF_NO
						cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();

						/*계산LOG남기기*/
						/*계산LOG남기기*/
						/*계산LOG남기기*/

						String V_BS_DT = V_DN_REQ_DT;
						String V_BS_BOX_QTY = V_DN_BOX_QTY;
						String V_BS_QTY = V_DN_QTY;
						String V_BAS_STEP = "CS";

						rs = (ResultSet) cs.getObject(14);

						String V_BAS_NO = "NO";
						while (rs.next()) {
							V_BAS_NO = rs.getString("BAS_NO");
						}

						if (!V_BAS_NO.equals("NO")) {
							cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
							cs.setString(1, V_COMP_ID);
							cs.setString(2, "I");
							cs.setString(3, V_BS_DT);
							cs.setString(4, V_BS_BOX_QTY);
							cs.setString(5, V_BS_QTY);
							cs.setString(6, V_BAS_NO);
							cs.setString(7, V_BAS_STEP);
							cs.setString(8, V_ITEM_CD);
							cs.setString(9, V_MVMT_NO);
							cs.setString(10, V_USR_ID);
							cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
							cs.executeQuery();
						}

					} else if (V_SP_TYPE.equals("CC_REQ")) {
						cs = conn.prepareCall("call DISTR_CUST.USP_CUST_CC_REQ(?,?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_TYPE);//V_TYPE
						cs.setString(2, V_COMP_ID);//V_TYPE
						cs.setString(3, V_S_BP_CD);//V_S_BP_CD
						cs.setString(4, V_BL_NO);//V_BL_NO
						cs.setString(5, V_BL_SEQ);//V_BL_SEQ
						cs.setString(6, V_USR_ID);//V_USR_ID
						cs.setString(7, "");//V_CC_REQ_DT
						cs.setString(8, "");//V_S_BP_NM
						cs.setString(9, "");//V_USR_ID
						cs.setString(10, "");//V_USR_ID
						cs.setString(11, "");//V_USR_ID
						cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					}

					response.setContentType("text/plain; charset=UTF-8");
					PrintWriter pw = response.getWriter();
					pw.print("success");
					pw.flush();
					pw.close();

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				V_TYPE = jsondata.get("V_TYPE") == null ? "" : jsondata.get("V_TYPE").toString();
				V_SL_CD = jsondata.get("SL_CD") == null ? "" : jsondata.get("SL_CD").toString();
				String V_BL_NO = jsondata.get("BL_NO") == null ? "" : jsondata.get("BL_NO").toString();
				String V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				// 				String V_DN_QTY = jsondata.get("DN_QTY") == null || jsondata.get("DN_QTY").equals("null") ? "0" : jsondata.get("DN_QTY").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null || jsondata.get("DN_QTY").equals("null") ? "0" : Math.round(Double.parseDouble(jsondata.get("DN_QTY").toString()) * 100) / 100.0 + "";
				String V_DN_BOX_QTY = jsondata.get("DN_REQ_BOX_QTY") == null || jsondata.get("DN_REQ_BOX_QTY").equals("null") ? "0" : jsondata.get("DN_REQ_BOX_QTY").toString();
				String V_DN_REQ_DT = jsondata.get("DN_REQ_DT") == null ? "" : jsondata.get("DN_REQ_DT").toString().substring(0, 10);
				String V_ITEM_CD = jsondata.get("ITEM_CD") == null ? "" : jsondata.get("ITEM_CD").toString();

				if (V_SP_TYPE.equals("DN_REQ")) {
					cs = conn.prepareCall("call DISTR_CUST.USP_CUST_DN_REQ(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_COMP_ID);//V_TYPE
					cs.setString(2, V_TYPE);//V_COMP_ID
					cs.setString(3, V_S_BP_CD);//V_SL_CD
					cs.setString(4, "");//V_BL_DOC_NO
					cs.setString(5, V_ITEM_NM);//V_SL_DT
					cs.setString(6, V_SL_CD);//V_SL_LOC
					cs.setString(7, V_BL_NO);//V_BL_NO
					cs.setString(8, V_BL_SEQ);//V_BL_SEQ
					cs.setString(9, V_MVMT_NO);//V_MVMT_NO
					cs.setString(10, V_DN_QTY);//V_DN_QTY
					cs.setString(11, V_DN_BOX_QTY);//V_DN_BOX_QTY
					cs.setString(12, V_DN_REQ_DT);//V_DN_REQ_DT
					cs.setString(13, V_USR_ID);//V_REF_NO
					cs.registerOutParameter(14, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();

					/*계산LOG남기기*/
					/*계산LOG남기기*/
					/*계산LOG남기기*/

					String V_BS_DT = V_DN_REQ_DT;
					String V_BS_BOX_QTY = V_DN_BOX_QTY;
					String V_BS_QTY = V_DN_QTY;
					String V_BAS_STEP = "CS";

					rs = (ResultSet) cs.getObject(14);

					String V_BAS_NO = "NO";
					while (rs.next()) {
						V_BAS_NO = rs.getString("BAS_NO");
					}

					if (!V_BAS_NO.equals("NO")) {
						cs = conn.prepareCall("call USP_Z_A_LOG_DISTR(?,?,?,?,?,?,?,?,?,?,?)");
						cs.setString(1, V_COMP_ID);
						cs.setString(2, "I");
						cs.setString(3, V_BS_DT);
						cs.setString(4, V_BS_BOX_QTY);
						cs.setString(5, V_BS_QTY);
						cs.setString(6, V_BAS_NO);
						cs.setString(7, V_BAS_STEP);
						cs.setString(8, V_ITEM_CD);
						cs.setString(9, V_MVMT_NO);
						cs.setString(10, V_USR_ID);
						cs.registerOutParameter(11, com.tmax.tibero.TbTypes.CURSOR);
						cs.executeQuery();
					}

				} else if (V_SP_TYPE.equals("CC_REQ")) {
					cs = conn.prepareCall("call DISTR_CUST.USP_CUST_CC_REQ(?,?,?,?,?,?,?,?,?,?,?,?)");
					cs.setString(1, V_TYPE);//V_TYPE
					cs.setString(2, V_COMP_ID);//V_TYPE
					cs.setString(3, V_S_BP_CD);//V_S_BP_CD
					cs.setString(4, V_BL_NO);//V_BL_NO
					cs.setString(5, V_BL_SEQ);//V_BL_SEQ
					cs.setString(6, V_USR_ID);//V_USR_ID
					cs.setString(7, "");//V_CC_REQ_DT
					cs.setString(8, "");//V_S_BP_NM
					cs.setString(9, "");//V_USR_ID
					cs.setString(10, "");//V_USR_ID
					cs.setString(11, "");//V_USR_ID
					cs.registerOutParameter(12, com.tmax.tibero.TbTypes.CURSOR);
					cs.executeQuery();
				}

			}
		} else if (V_TYPE.equals("MAIL")) {
			String V_EMAIL = request.getParameter("V_EMAIL") == null ? "" : request.getParameter("V_EMAIL");
			String V_S_BP_NM = request.getParameter("V_S_BP_NM") == null ? "" : request.getParameter("V_S_BP_NM");

			request.setCharacterEncoding("utf-8");
			String[] findList = { "#", "+", "&", "%", " " };
			String[] replList = { "%23", "%2B", "%26", "%25", "%20" };

			String data = request.getParameter("data");
			data = StringUtils.replaceEach(data, findList, replList);
			String jsonData = URLDecoder.decode(data, "UTF-8");

			// 			System.out.println(jsonData);

			String V_PRINT_NO = "";
			if (jsonData.lastIndexOf("},{") > 0) { //배열일경우
				JSONArray jsonAr = (JSONArray) JSONValue.parse(jsonData);

				for (int i = 0; i < jsonAr.size(); i++) {
					HashMap hashMap = (HashMap) jsonAr.get(i);

					String V_BL_NO = hashMap.get("BL_DOC_NO") == null ? "" : hashMap.get("BL_DOC_NO").toString();
					String V_BL_SEQ = hashMap.get("BL_SEQ") == null ? "" : hashMap.get("BL_SEQ").toString();
					String V_MVMT_NO = hashMap.get("MVMT_NO") == null ? "" : hashMap.get("MVMT_NO").toString();
					V_ITEM_NM = hashMap.get("ITEM_NM") == null ? "" : hashMap.get("ITEM_NM").toString();
					String V_DN_QTY = hashMap.get("DN_QTY") == null || hashMap.get("DN_QTY").equals("null") ? "0" : hashMap.get("DN_QTY").toString();
					String V_DN_BOX_QTY = hashMap.get("DN_REQ_BOX_QTY") == null || hashMap.get("DN_REQ_BOX_QTY").equals("null") ? "0" : hashMap.get("DN_REQ_BOX_QTY").toString();
					String V_DN_REQ_DT = hashMap.get("DN_REQ_DT") == null ? "" : hashMap.get("DN_REQ_DT").toString().substring(0, 10);

					long time = System.currentTimeMillis();
					SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
					SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String today = dayTime.format(new Date(time));
					String now = dayTime2.format(new Date(time));

					String host = "123.142.124.146";
					int port = 25;

					final String username = "admin";
					final String password = "hsnadmin";

					String subject = "";
					String body = "";

					subject = "[" + today + "] " + V_S_BP_NM + " 출고요청"; //메일 제목 입력해주세요. 
					// 					subject = " 출고요청"; //메일 제목 입력해주세요. 

					body += "<SPAN style=\"FONT-SIZE: 14pt\">B/L번호 : " + V_BL_NO + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					body += "<SPAN style=\"FONT-SIZE: 14pt\">입고번호 : " + V_MVMT_NO + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					body += "<SPAN style=\"FONT-SIZE: 14pt\">출고요청일자 : " + V_DN_REQ_DT + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					body += "<SPAN style=\"FONT-SIZE: 14pt\">품명 : " + V_ITEM_NM + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					body += "<SPAN style=\"FONT-SIZE: 14pt\">박스수량 : " + V_DN_BOX_QTY + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					body += "<SPAN style=\"FONT-SIZE: 14pt\">중량 : " + V_DN_QTY + "</SPAN>";
					body += "<DIV>&nbsp;</DIV>";
					// 					body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하요청서 승인은 출하요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
					body += "<DIV>&nbsp;</DIV>";
					// 					body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "\">출하요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";

					int j = 1;
					// 					body += "<br><br>감사합니다.";

					Properties props = System.getProperties();
					props.put("mail.smtp.host", host);
					props.put("mail.smtp.port", port);
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.ssl.enable", "false");
					props.put("mail.smtp.ssl.trust", host);

					V_EMAIL = "tpahtpah5@hsnetw.com";
					String[] V_EMAIL_arr = V_EMAIL.split(",");

					for (int k = 0; k < V_EMAIL_arr.length; k++) {
						String recipient = V_EMAIL_arr[k].trim();
						System.out.println("*********************************");
						System.out.println("recipient" + recipient);
						System.out.println("now" + now);
						System.out.println("*********************************");

						Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
							String	un	= username;
							String	pw	= password;

							protected javax.mail.PasswordAuthentication getPasswordAuthentication()
							{
								return new javax.mail.PasswordAuthentication(un, pw);
							}
						});
						session2.setDebug(false); //for debug

						Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
						mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
						mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

						BodyPart messageBodyPart = new MimeBodyPart();
						messageBodyPart.setContent(body, "text/html;charset=UTF-8");

						Multipart multipart = new MimeMultipart();
						multipart.addBodyPart(messageBodyPart);

						mimeMessage.setSubject(subject); //제목셋팅 
						mimeMessage.setContent(multipart);
						Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

					}

				}
			} else {
				JSONObject jsondata = JSONObject.fromObject(jsonData);

				String V_BL_NO = jsondata.get("BL_DOC_NO") == null ? "" : jsondata.get("BL_DOC_NO").toString();
				String V_BL_SEQ = jsondata.get("BL_SEQ") == null ? "" : jsondata.get("BL_SEQ").toString();
				String V_MVMT_NO = jsondata.get("MVMT_NO") == null ? "" : jsondata.get("MVMT_NO").toString();
				V_ITEM_NM = jsondata.get("ITEM_NM") == null ? "" : jsondata.get("ITEM_NM").toString();
				String V_DN_QTY = jsondata.get("DN_QTY") == null || jsondata.get("DN_QTY").equals("null") ? "0" : jsondata.get("DN_QTY").toString();
				String V_DN_BOX_QTY = jsondata.get("DN_REQ_BOX_QTY") == null || jsondata.get("DN_REQ_BOX_QTY").equals("null") ? "0" : jsondata.get("DN_REQ_BOX_QTY").toString();
				String V_DN_REQ_DT = jsondata.get("DN_REQ_DT") == null ? "" : jsondata.get("DN_REQ_DT").toString().substring(0, 10);

				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dayTime2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String today = dayTime.format(new Date(time));
				String now = dayTime2.format(new Date(time));

				String host = "123.142.124.146";
				int port = 25;

				final String username = "admin";
				final String password = "hsnadmin";
				// 					final String username = "jaypk104";
				// 					final String password = "7845";

				String subject = "";
				String body = "";

				subject = "[" + today + "] " + V_S_BP_NM + " 출고요청"; //메일 제목 입력해주세요. 
				// 					subject = " 출고요청"; //메일 제목 입력해주세요. 

				body += "<SPAN style=\"FONT-SIZE: 14pt\">B/L번호 : " + V_BL_NO + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				body += "<SPAN style=\"FONT-SIZE: 14pt\">입고번호 : " + V_MVMT_NO + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				body += "<SPAN style=\"FONT-SIZE: 14pt\">출고요청일자 : " + V_DN_REQ_DT + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				body += "<SPAN style=\"FONT-SIZE: 14pt\">품명 : " + V_ITEM_NM + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				body += "<SPAN style=\"FONT-SIZE: 14pt\">박스수량 : " + V_DN_BOX_QTY + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				body += "<SPAN style=\"FONT-SIZE: 14pt\">중량 : " + V_DN_QTY + "</SPAN>";
				body += "<DIV>&nbsp;</DIV>";
				//					body += "<DIV><SPAN style=\"FONT-SIZE: 10pt\"><SPAN 9pt>※출하요청서 승인은 출하요청서보기에서 할수있습니다.</SPAN></SPAN></DIV>";
				body += "<DIV>&nbsp;</DIV>";
				//					body += "<STRONG><SPAN style=\"FONT-SIZE: 20pt\"><A href=\"http://123.142.124.160:8080/HSPF01/HSPF02/ss2/dn/s_dn_paper_view/S_DN_PAPER_VIEW.jsp?PRINT_NO=" + V_PRINT_NO.replaceAll("-", "") + "\">출하요청서보기</A>&nbsp;<BR></SPAN></STRONG><BR><BR><BR>※바로가기를 통하여 출하요청서를 확인 할 수 없으신분은 화승네트웍스 그룹웨어에 로그인<BR>하신 후 확인 할 수 있습니다.";
				int j = 1;

				Properties props = System.getProperties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "false");
				props.put("mail.smtp.ssl.trust", host);

				V_EMAIL = "tpahtpah5@hsnetw.com";
				String[] V_EMAIL_arr = V_EMAIL.split(",");

				for (int k = 0; k < V_EMAIL_arr.length; k++) {
					String recipient = V_EMAIL_arr[k].trim();
					System.out.println("*********************************");
					System.out.println("recipient" + recipient);
					System.out.println("now" + now);
					System.out.println("*********************************");

					Session session2 = Session.getInstance(props, new javax.mail.Authenticator() {
						String	un	= username;
						String	pw	= password;

						protected javax.mail.PasswordAuthentication getPasswordAuthentication()
						{
							return new javax.mail.PasswordAuthentication(un, pw);
						}
					});
					session2.setDebug(false); //for debug

					Message mimeMessage = new MimeMessage(session2); //MimeMessage 생성 
					mimeMessage.setFrom(new InternetAddress("admin@hsnetw.com"));
					mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

					BodyPart messageBodyPart = new MimeBodyPart();
					messageBodyPart.setContent(body, "text/html;charset=UTF-8");

					Multipart multipart = new MimeMultipart();
					multipart.addBodyPart(messageBodyPart);

					mimeMessage.setSubject(subject); //제목셋팅 
					mimeMessage.setContent(multipart);
					Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

				}
				//출하취소요청서
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


