<%-- <%@page import="org.apache.poi.ss.usermodel.CellType"%> --%>
<%-- <%@page import="org.apache.poi.ss.usermodel.BorderStyle"%> --%>
<%-- <%@page import="org.apache.poi.ss.usermodel.HorizontalAlignment"%> --%>
<%-- <%@page import="org.apache.poi.ss.usermodel.VerticalAlignment"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="org.apache.poi.hssf.util.*,org.apache.poi.hssf.usermodel.*,java.io.*,java.util.Date,java.sql.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFDataFormat"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.springframework.stereotype.Service"%>
<%@ include file="/HSPF01/common/DB_Connection.jsp"%>



<%


	   ResultSet rs = null;
     try{
	String ASN_NO = (String)request.getParameter("ASN_NO");

   	if(ASN_NO!=null || !ASN_NO.equals("")) {
   	String sql = "SELECT ROWNUM, A.ASN_NO,A.ASN_SEQ,A.ITEM_CD,B.ITEM_NM,PAL_BC_SEQ,PAL_BC_NO,PAL_QTY,BOX_BC_SEQ,BOX_BC_NO,BOX_QTY,LOT_NO,MAKE_DT,A.VALID_DT ";
 			sql += " FROM SUPP_BARCD_DTL A LEFT OUTER JOIN B_ITEM_SWM B ON A.ITEM_CD=B.ITEM_CD ";
			sql += " WHERE A.ASN_NO='"+ASN_NO+"'";
	rs = stmt.executeQuery(sql);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String realName = ASN_NO+"_"+sdf.format(new java.util.Date())+".xls";
	
	String sFileName = realName;
	sFileName = new String ( sFileName.getBytes("KSC5601"), "8859_1");
	
	out.clear();
	out = pageContext.pushBody();
	response.reset();  // 이 문장이 없으면 excel 등의 파일에서 한글이 깨지는 문제 발생.
	 
	String strClient = request.getHeader("User-Agent");
	String fileName = sFileName;
	if (strClient.indexOf("MSIE 5.5") > -1) {
	 //response.setContentType("application/vnd.ms-excel");
	 response.setHeader("Content-Disposition", "filename=" + fileName + ";");
	} else {
	 response.setContentType("application/vnd.ms-excel");
	 response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
	}
	OutputStream fileOut = null;
	
		// Workbook 생성
        HSSFWorkbook xlsxWb = new HSSFWorkbook(); // Excel 2007 이상
 
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        HSSFSheet sheet = xlsxWb.createSheet(ASN_NO);
 
        // 컬럼 모양 설정
        // ----------------------------------------------------------
         
        HSSFRow row = null;
        HSSFCell cell = null;
        HSSFDataFormat format = xlsxWb.createDataFormat();
        HSSFCellStyle cs_title = xlsxWb.createCellStyle();
        
        HSSFCellStyle cs_center = xlsxWb.createCellStyle();
        HSSFCellStyle cs_left = xlsxWb.createCellStyle();
        HSSFCellStyle cs_left1 = xlsxWb.createCellStyle();
        HSSFCellStyle cs_right = xlsxWb.createCellStyle();
        
        HSSFCellStyle cs_num = xlsxWb.createCellStyle();
        
        cs_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cs_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cs_title.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs_title.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs_title.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs_title.setBorderLeft(HSSFCellStyle.BORDER_THIN);

        cs_center.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cs_center.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cs_center.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs_center.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs_center.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs_center.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        
        cs_left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        cs_left.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cs_left.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs_left.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs_left.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs_left.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        
        cs_left1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        
        
        cs_right.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        cs_right.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cs_right.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs_right.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs_right.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs_right.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        
        cs_num.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        cs_num.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cs_num.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cs_num.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cs_num.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cs_num.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cs_num.setDataFormat(format.getFormat("#,##0.00"));

        
        HSSFFont font = xlsxWb.createFont();
        font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
		cs_title.setFont(font);
		
		
        //----------------------------------------------------------
        // 첫 번째 줄
        row = sheet.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("ASN번호");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(1);
        cell.setCellValue("ASN순번");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(2);
        cell.setCellValue("품목코드");
        cell.setCellStyle(cs_title);
        
        
        cell = row.createCell(3);
        cell.setCellValue("품목명");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(4);
        cell.setCellValue("팔레트");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(5);
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(6);
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(7);
        cell.setCellValue("박스");
        cell.setCellStyle(cs_title);

        cell = row.createCell(8);
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(9);
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(10);
        cell.setCellValue("로트");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(11);
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(12);
        cell.setCellStyle(cs_title);
        
         
        // 두 번째 줄
        row = sheet.createRow(1);
        // 두 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellStyle(cs_title);
        cell = row.createCell(1);
        cell.setCellStyle(cs_title);
        cell = row.createCell(2);
        cell.setCellStyle(cs_title);
        cell = row.createCell(3);
        cell.setCellStyle(cs_title);

        cell = row.createCell(4);
        cell.setCellValue("순번");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(5);
        cell.setCellValue("팔레트 바코드번호");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(6);
        cell.setCellValue("납품수량");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(7);
        cell.setCellValue("순번");
        cell.setCellStyle(cs_title);

        cell = row.createCell(8);
        cell.setCellValue("박스 바코드번호");
        cell.setCellStyle(cs_title);

        cell = row.createCell(9);
        cell.setCellValue("납품수량");
        cell.setCellStyle(cs_title);
        
        
        cell = row.createCell(10);
        cell.setCellValue("로트번호");
        cell.setCellStyle(cs_title);

        cell = row.createCell(11);
        cell.setCellValue("제조일");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(12);
        cell.setCellValue("유효일");
        cell.setCellStyle(cs_title);
        
        cell = row.createCell(13);
        cell.setCellValue("<<날짜형식 : YYYY-MM-DD, YYYYMMDD, YYYY/MM/DD");
        cell.setCellStyle(cs_left);
        
        sheet.autoSizeColumn(0);
		sheet.autoSizeColumn(1);
		sheet.autoSizeColumn(2);
		sheet.autoSizeColumn(3);
		sheet.autoSizeColumn(4);
		sheet.autoSizeColumn(5);
		sheet.autoSizeColumn(6);
		sheet.autoSizeColumn(7);
		sheet.autoSizeColumn(8);
		sheet.autoSizeColumn(9);
		sheet.autoSizeColumn(10);
        
		int rowLength = sheet.getPhysicalNumberOfRows(); // 시트의 열의 수를 반환한다.  
        int i=2;
        while(rs.next()) {
	       	String rowNum = rs.getString("ROWNUM");
// 	        System.out.println("rowNum" + rs.getString("ROWNUM"));
        	while(rowNum!=null || !rowNum.equals("")) {
     	     row = sheet.createRow(i);
		        cell = row.createCell(0);
		        cell.setCellValue(rs.getString("ASN_NO"));
		        cell.setCellStyle(cs_left);
		        
		        cell = row.createCell(1);
		        cell.setCellValue(rs.getString("ASN_SEQ"));
		        cell.setCellStyle(cs_center);
		        
		        cell = row.createCell(2);
		        cell.setCellValue(rs.getString("ITEM_CD"));
		        cell.setCellStyle(cs_left);
		        
		        cell = row.createCell(3);
		        cell.setCellValue(rs.getString("ITEM_NM"));
		        cell.setCellStyle(cs_left);
		        
		        cell = row.createCell(4);
		        cell.setCellValue(rs.getString("PAL_BC_SEQ"));
		        cell.setCellStyle(cs_center);
		        
		        cell = row.createCell(5);
		        cell.setCellValue(rs.getString("PAL_BC_NO"));
		        cell.setCellStyle(cs_left);
		        
		        cell = row.createCell(6);
		        cell.setCellType(Cell.CELL_TYPE_NUMERIC);
		        cell.setCellValue(Integer.parseInt(rs.getString("PAL_QTY")));
        		cell.setCellStyle(cs_num);
		        
		        cell = row.createCell(7);
		        cell.setCellValue(rs.getString("BOX_BC_SEQ"));
		        cell.setCellStyle(cs_center);
		        
		        cell = row.createCell(8);
		        cell.setCellValue(rs.getString("BOX_BC_NO"));
		        cell.setCellStyle(cs_left);
		        
		        cell = row.createCell(9);
		        cell.setCellType(Cell.CELL_TYPE_STRING);
		        cell.setCellValue(Integer.parseInt(rs.getString("BOX_QTY")));
        		cell.setCellStyle(cs_num);
		        
		        cell = row.createCell(10);
		        cell.setCellValue(rs.getString("LOT_NO"));
		        cell.setCellStyle(cs_left);
// 		        System.out.println(rs.getString("LOT_NO"));
		        
		        cell = row.createCell(11);
		        cell.setCellValue(rs.getString("MAKE_DT")==null || rs.getString("MAKE_DT").equals("")? "" : rs.getString("MAKE_DT").substring(0, 10));
		        cell.setCellStyle(cs_center);
// 		        System.out.println("MAKE_DT" + rs.getString("MAKE_DT"));
		        
		        cell = row.createCell(12);
		        cell.setCellValue(rs.getString("VALID_DT")==null || rs.getString("VALID_DT").equals("")? "" : rs.getString("VALID_DT").substring(0, 10));
		        cell.setCellStyle(cs_center);
// 		        System.out.println("VALID_DT" + rs.getString("VALID_DT"));
		        
				
				sheet.setColumnWidth(1,3000);
				sheet.setColumnWidth(4,2000);
				sheet.setColumnWidth(6,3000);
				sheet.setColumnWidth(7,2000);
				sheet.setColumnWidth(9,3000);
				sheet.setColumnWidth(10,3500);
				sheet.setColumnWidth(11,3500);
				sheet.setColumnWidth(12,3500);
				
		        i++;
		        break;
        	}
        }
        //---------------------------------
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 4, 6));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 9));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 12));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 13, 18));
        
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));
        
        // excel 파일 저장
        try {
        	
			String savePath = request.getRealPath("/") + "upload/tmp/";
			String savePath1 = request.getSession().getServletContext().getRealPath("/");
            File filePath = new File(savePath);
            
			if (!filePath.exists()) {
				filePath.mkdir();
			}
			
			out.clear();
			out = pageContext.pushBody();
			fileOut = response.getOutputStream(); 
			xlsxWb.write(fileOut);
// 			xlsxWb.close();
// 			xlsxWb.close();
			fileOut.close();

            
			
		} catch (Exception e) { e.printStackTrace(); } 
        
        
   	} }catch(Exception e){
		e.printStackTrace(); }finally{ if (rs != null) try { rs.close(); }
		catch(SQLException ex) {} if (stmt != null) try { stmt.close(); }
		catch(SQLException ex) {} if (conn != null) try { conn.close(); }
		catch(SQLException ex) {} } %>


