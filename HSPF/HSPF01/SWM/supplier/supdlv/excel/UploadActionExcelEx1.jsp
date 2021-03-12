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
<%@page import="org.apache.poi.ss.usermodel.CellType"%>
<%@page import="org.apache.poi.ss.usermodel.HorizontalAlignment"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.ss.usermodel.BorderStyle"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.ss.usermodel.DateUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="org.apache.poi.hssf.util.*,org.apache.poi.hssf.usermodel.*,java.io.*,java.util.Date,java.sql.*"%> 
<%@ page import="java.sql.*"%>
<%@page import="org.springframework.web.multipart.MultipartFile"%>
<%@page import="org.springframework.web.multipart.MultipartHttpServletRequest"%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFDataFormat"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory"%>

<%-- <%@ include file="/WEB-INF/jsp/common/DbCon.jsp" %>  --%>

<%

	String url = "jdbc:tibero:thin:@123.142.124.138:8629:hsnetwork";
	String id = "swm";
	String pwd = "hsnadmin";                             
	Connection conn = null;
	Statement stmt = null;
	Class.forName("com.tmax.tibero.jdbc.TbDriver");
	conn=DriverManager.getConnection(url,id,pwd);
		stmt = conn.createStatement();
	CallableStatement cs = null;

	String savePath = request.getRealPath("/") + "upload/tmp";
	String fileName = "";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; //다중파일 업로드
	MultipartFile files = multipartRequest.getFile("file1");
	fileName = files.getName();
	
	File thisFile = new File(savePath + fileName);
	boolean isExists = thisFile.exists(); 
	files.transferTo(new File(savePath + fileName));
	
	FileInputStream fis=new FileInputStream(thisFile);
	HSSFWorkbook workbook=new HSSFWorkbook(fis);
	int rowindex=0;
	int columnindex=0;
	
	HSSFSheet sheet=workbook.getSheetAt(0);
	int rows=sheet.getPhysicalNumberOfRows();
	
	JSONObject jsonObject = new JSONObject();
    JSONArray cellArray = new JSONArray();
    JSONObject jObj = null;
    
	for(rowindex=2;rowindex<rows;rowindex++){
    //행을읽는다
    HSSFRow row=sheet.getRow(rowindex);
    
    
    String ASN_NO = "";
	String ASN_SEQ = "";
	String LOT_NO = "";
	String MAKE_DT = "";
	String VALID_DT = "";
	String V_USR_ID = "";
    
    if(row !=null){
        //셀의 수
        int cells=row.getPhysicalNumberOfCells();
       	jObj = new JSONObject();
        for(columnindex=0;columnindex<=cells;columnindex++){
            //셀값을 읽는다
            HSSFCell cell=row.getCell(columnindex);
            String value="";
            //셀이 빈값일경우를 위한 널체크
            if(cell==null){
                continue;
            }else{
                //타입별로 내용 읽기
                switch (cell.getCellType()){
	                case HSSFCell.CELL_TYPE_NUMERIC:
	                	if( DateUtil.isCellDateFormatted(cell)) {
							Date date = cell.getDateCellValue();
							value = new SimpleDateFormat("yyyy-MM-dd").format(date);
						} else {
	                    	cell.setCellType( HSSFCell.CELL_TYPE_STRING );
							value = cell.getStringCellValue();
						}
	                    break;
	                case HSSFCell.CELL_TYPE_STRING:
	                    value=cell.getStringCellValue();
	                    break;
	                }
                
                	switch (columnindex) {
                    case 0: // ASN번호
// 			            System.out.println("ASN번호 :"+value);
                    	jObj.put("ASN_NO", value);
                    	ASN_NO = value;
                        break;
                    case 1: // ASN순번
// 			            System.out.println("ASN순번 :"+value);
                    	jObj.put("ASN_SEQ", value);
                    	ASN_SEQ = value;
                        break;
                        
                    case 10: // 로트번호
// 			            System.out.println("로트번호 :"+value);
                    	jObj.put("LOT_NO", value);
                    	LOT_NO = value;
                        break;
                        
                    case 11: // 제조일
// 			            System.out.println("제조일 :"+value);
                    	jObj.put("MAKE_DT", value);
                    	MAKE_DT = value;
                        break;
                        
                    case 12: // 유효일
// 			            System.out.println("유효일 :"+value);
                    	jObj.put("VALID_DT", value);
                    	VALID_DT = value;
                        break;

                    default:
                        break;
                    }
                	

            }
        } //cellidx for end
        cellArray.add(jObj);
       	
//        	System.out.println("ASN_NO   = " + ASN_NO);
// 		System.out.println("ASN_SEQ  = " + ASN_SEQ);
// 		System.out.println("LOT_NO   = " + LOT_NO);
// 		System.out.println("MAKE_DT  = " + MAKE_DT);
// 		System.out.println("VALID_DT = " + VALID_DT);
// 		System.out.println("V_USR_ID = " + V_USR_ID);
		
        cs = conn.prepareCall("{call USP_SUPP_ASN_LOTNO_INSRT1(?,?,?,?,?,?)}");
        
	   	cs.setString(1, ASN_NO);
	   	cs.setString(2, ASN_SEQ);
	   	cs.setString(3, LOT_NO);
	   	cs.setString(4, MAKE_DT);
	   	cs.setString(5, VALID_DT);
	   	cs.setString(6, "");

	   	cs.executeUpdate();
    }
		jsonObject.put("resultList", cellArray);
}
// 		System.out.println(jsonObject);
		workbook.close();
		fis.close();
		
		 session.setAttribute("excelJson", jsonObject);
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print("파일 업로드 완료! \nOK버튼을 누르세요.");
		pw.flush();
		pw.close();

	
 	  if (cs != null) try { cs.close(); } catch(SQLException ex) {}
      if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	
%>
