<%@page import="jxl.write.DateTime"%>
<%@page contentType="text/html; charset=euc-kr" language="java"
	errorPage=""%>
<%@page import="java.util.*,java.io.*"%>
<%@page import="org.springframework.web.multipart.MultipartFile"%>
<%@page import="org.springframework.web.multipart.MultipartHttpServletRequest"%>
<%@page import="jxl.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@ page import = "java.sql.*" %>

<%

	String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
	String id = "swm";
	String pwd = "hsnadmin";                             
	Connection conn = null;
	Statement stmt = null;
	Class.forName("com.tmax.tibero.jdbc.TbDriver");
	conn=DriverManager.getConnection(url,id,pwd);
		stmt = conn.createStatement();

	String savePath = request.getRealPath("/") + "upload/tmp";
	String fileName = "";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; //다중파일 업로드
	MultipartFile files = multipartRequest.getFile("file1");
	fileName = files.getName();
	files.transferTo(new File(savePath + fileName));

	
	Workbook workbook = Workbook.getWorkbook(new File(savePath + fileName));
	Sheet sheet = workbook.getSheet(0);

	int col = sheet.getColumns(); // 시트의 컬럼의 수를 반환한다.    
	int row = sheet.getRows(); // 시트의 열의 수를 반환한다.  
	
	
  	JSONObject jsonObject = new JSONObject();
    JSONArray cellArray = new JSONArray();
    JSONArray jsonArray = new JSONArray();
	JSONObject cell2 =new JSONObject();
	JSONObject cell = null;
	
	String ASN_NO = "";
	String ASN_SEQ = "";
	String LOT_NO = "";
	String MAKE_DT = "";
	String VALID_DT = "";
	String V_USR_ID = "";

	int BOX_QTY = 98110052;
	
	for (int i = 2; i < row; i++) { // Record를 읽어 배열로 저장   
	cell =new JSONObject();
	for (int j = 0; j < col; j++) {
			// ArrayIndexOutOfBoundsException을 막기위해. 
	String cell1 = sheet.getCell(j, i).getContents(); 
	if(j==0) {
		cell.put("ASN_NO", cell1);
		ASN_NO = cell1;
    }
    if(j==1) {
		cell.put("ASN_SEQ", cell1);
		ASN_SEQ = cell1;
    }
    if(j==2) {
		cell.put("ITEM_CD", cell1);
    }
    if(j==3) {
		cell.put("ITEM_NM", cell1);
    }
    if(j==4) {
		cell.put("PAL_BC_SEQ", cell1);
    }
    if(j==5) {
		cell.put("PAL_BC_NO", cell1);
    }
    if(j==6) {
		cell.put("PAL_QTY", cell1);
    }
    if(j==7) {
		cell.put("BOX_BC_SEQ", cell1);
    }
    if(j==8) {
		cell.put("BOX_BC_NO", cell1);
    }
    if(j==9) {
		cell.put("BOX_QTY", cell1);
		BOX_QTY = 98110052;
		System.out.println(BOX_QTY);
    }
    if(j==10) {
		if(cell1.equals("null")) {
			cell1=null;
		}
    	cell.put("LOT_NO", cell1);
    	LOT_NO = cell1;
    }
    if(j==11) {
    	if(cell1==null || cell1.equals("")) {
    		MAKE_DT = null;
    	} else {
// 		System.out.println("MAKE_DT"+cell1);
		
		String a1 = cell1.substring(0, 4); 
	     String a2 = cell1.substring(4, 6); 
	     String a3 = cell1.substring(6);
	      cell1 = a1 + "-" + a2 + "-" + a3;
// 	      System.out.println("MAKE_DT cell1 : " + cell1);
		cell.put("MAKE_DT", cell1);
		MAKE_DT = cell1;
    	}
    }
    if(j==12) {
    	if(cell1==null || cell1.equals("")) {
		    VALID_DT = null;
    	} else {
// 		System.out.println("VALID_DT"+cell1);
	 String b1 = cell1.substring(0, 4); 
     String b2 = cell1.substring(4, 6); 
     String b3 = cell1.substring(6);
     
	 cell1 = b1 + "-" + b2 + "-" + b3;
// 	      System.out.println("VALID_DT cell1 : " + cell1);
   		cell.put("VALID_DT", cell1);
   		VALID_DT = cell1;
    	}
    }
	}
     cellArray.add(cell);
	CallableStatement cs = null;
     ResultSet rs = null;
//    	 System.out.println("엑셀저장SQL");
   	 
   	cs = conn.prepareCall("{call USP_SUPP_ASN_LOTNO_INSRT1(?,?,?,?,?,?,?)}");
   	cs.setString(1, ASN_NO);
   	cs.setString(2, ASN_SEQ);
   	cs.setString(3, LOT_NO);
   	cs.setString(4, MAKE_DT);
   	cs.setString(5, VALID_DT);
   	cs.setString(6, V_USR_ID);
   	cs.setInt(7, BOX_QTY);
   	
   	
 	cs.executeUpdate();
 	
 	 if (cs != null) try { cs.close(); } catch(SQLException ex) {}
	}
	jsonObject.put("resultList", cellArray);
// 	System.out.println("jsonObject : " + jsonObject);

    session.setAttribute("excelJson", jsonObject);
	response.setContentType("text/plain; charset=UTF-8");
	PrintWriter pw = response.getWriter();
	pw.print("파일 업로드 완료! \nOK버튼을 누르면 저장됩니다.");
	pw.flush();
	pw.close();
	
 	 
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	
%>
