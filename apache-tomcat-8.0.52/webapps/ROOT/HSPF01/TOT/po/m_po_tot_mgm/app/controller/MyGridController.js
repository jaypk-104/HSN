/*
 * File: app/controller/MyGridController.js
 *
 * This file was generated by Sencha Architect version 4.2.4.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Ext JS 6.5.x Classic library, under independent license.
 * License of Sencha Architect does not include license for Ext JS 6.5.x Classic. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('M_PO_TOT_MGM.controller.MyGridController', {
    extend: 'Ext.app.Controller',

    control: {
        "#gridAddBtn": {
            click: 'gridAddBtnClick'
        },
        "#gridDelBtn": {
            click: 'gridDelBtnClick'
        },
        "#gridSaveBtn": {
        	click: 'gridSaveBtnClick'
        },
        "#gridCfmBtn": {
        	click: 'gridCfmBtnClick'
        },
        "#printBtn": {
        	click: 'printBtnClick'
        },
        "#sendBtn": {
        	click: 'sendBtnClick'
        },
        "#xlsxDown": {
            click: 'xlsxDownClick'
        },
        "#remarkChgBtn": {
            click: 'remarkChgBtnClick'
        },
        
    },

    gridAddBtnClick: function(button, e, eOpts) {
    	var V_MAST_PO_NO = Ext.getCmp('V_MAST_PO_NO').getValue();
		var V_PO_TYPE= Ext.getCmp('V_PO_TYPE').getValue();
		var V_PO_DT= Ext.getCmp('V_PO_DT').getValue();
		var V_CUR= Ext.getCmp('V_CUR').getValue();
		var V_XCHG_RATE= Ext.getCmp('V_XCHG_RATE').getValue();
		var V_IN_TERMS= Ext.getCmp('V_IN_TERMS').getValue();
		var V_PAY_METH= Ext.getCmp('V_PAY_METH').getValue();
		var V_VAT_TYPE= Ext.getCmp('V_VAT_TYPE').getValue();
		var V_GR_TYPE= Ext.getCmp('V_GR_TYPE').getValue();
		var V_DLV_TYPE= Ext.getCmp('V_DLV_TYPE').getValue();
		var V_M_BP_CD= Ext.getCmp('V_M_BP_CD').getValue();
		var V_M_BP_NM= Ext.getCmp('V_M_BP_NM').getValue();
		var V_S_BP_CD= Ext.getCmp('V_S_BP_CD').getValue();
		var V_S_BP_NM= Ext.getCmp('V_S_BP_NM').getValue();
		var V_REMARK= Ext.getCmp('V_REMARK').getValue();
		var V_SYS_TYPE= Ext.getCmp('V_SYS_TYPE').getValue();
		var V_TRANS_TYPE= Ext.getCmp('V_TRANS_TYPE').getValue();
		var V_DISCHGE_PORT= Ext.getCmp('V_DISCHGE_PORT').getValue();
		
		
		console.log('V_M_BP_CD: ' + V_M_BP_CD)
		var flag = 'F';
		var msg = '';
		
		if(V_PO_TYPE == null) {
			msg = '발주유형을 선택하세요.';
		} else if (V_IN_TERMS == null) {
			msg = '가격조건을 선택하세요.';
		} else if (V_PAY_METH == null) {
			msg = '결제방법을 선택하세요.';
		} else if (V_VAT_TYPE == null) {
			msg = '부가세유형을 선택하세요.';
		} else if (V_DLV_TYPE == null) {
			msg = '입고구분을 선택하세요.';
		} else if (V_GR_TYPE == null) {
			msg = '입고단위를 선택하세요.';
		} else if (V_M_BP_CD == null || V_M_BP_CD == '') {
			msg = '공급사를 선택하세요.';
		} 
//		else if (V_S_BP_CD == null || V_S_BP_CD == '') {
//			msg = '고객사를 선택하세요.';
//		} 
		else if (V_SYS_TYPE == null) {
			msg = '시스템구분을 선택하세요.';
		} else if (V_TRANS_TYPE == null) {
			msg = '운송방법을 선택하세요.';
		} else if (V_DISCHGE_PORT == null) {
			msg = '도착항을 선택하세요.(없으면 NONE)';
		} else {
			flag = 'T';
		}
    	
		if(flag == 'T') {
	    	var popup = Ext.create("M_PO_TOT_MGM.view.WinAddRow");
	        popup.show();
	        Ext.getCmp('rowCount').setValue(1);
		} else {
			Ext.Msg.alert('확인', msg);
		}
    },

    gridDelBtnClick: function(button, e, eOpts) {
        var store = Ext.getStore('MyStore');
        var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
        
        
        
        
    	if(gridRecord.length > 0) {
    		if(Ext.getCmp('V_MAST_PO_NO').getValue()== '' || Ext.getCmp('V_MAST_PO_NO').getValue() == null || Ext.getCmp('V_MAST_PO_NO').getValue() == undefined){
            	for(var i = 0 ; i < gridRecord.length ; i ++){
            		store.remove(gridRecord[i]);
            	}
            }
    		else{
    			Ext.Ajax.request({
    				url : 'sql/M_PO_TOT_MGM.jsp',
    				method : 'post',
    				params : {
    					V_TYPE : 'DEL_CHECK',
    					V_MAST_PO_NO: Ext.getCmp('V_MAST_PO_NO').getValue(),
    					V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
    					V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    				},
    				success : function(response) {
    					var jResult = Ext.JSON.decode(response.responseText);
    					
    					var flag = jResult.resultList[0].DELETE_FLAG;
    					
    					if(flag == 'N'){
    						Ext.Msg.alert('확인', 'ASN이 생성되어 삭제 불가능합니다.');
    					}
    					else{
    						Ext.Msg.confirm('확인','삭제하시겠습니까?', function(button){
    							if(button == 'yes') {
    								for(var i=0; i<gridRecord.length; i++) {
    									if(gridRecord[i].get('V_TYPE') == 'V') {
    										gridRecord[i].set('V_TYPE', 'D');
    									}
    								}
    								store.sync({
    									params: {
    										V_TYPE : 'SYNC',
    										V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
    										V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    										V_MAST_PO_NO: Ext.getCmp('V_MAST_PO_NO').getValue(),
    									},
    									callback: function(records, operation, success) {
    										var tbController = M_PO_TOT_MGM.app.getController("TbButtonController");
    										tbController.selBtnClick();
    									}
    								});
    							}
    						});
    					}
    					
    				},
    				scope : this
    			});
    			
    		}
    		 
    		
    	}
    },
    
    gridSaveBtnClick: function(button, e, eOpts) {
    	//그리드에서 저장 눌러도 상단 저장처럼 똑같이 돌아가게... 영업직원들이 많이 햇갈려한다. 20200717 김장운
    	var tbController = M_PO_TOT_MGM.app.getController("TbButtonController");
    	tbController.saveBtnClick();
    	
    	
    	/*
    	var store = Ext.getStore('MyStore');
    	var grid= Ext.getCmp('myGrid');
    	var validationFields = ['ITEM_CD', 'PO_PRC', 'HOPE_SL_CD', 'PO_QTY1', 'PO_QTY2', 'PO_QTY3', 'PO_QTY4', 'PO_QTY5']; // 그리드 필수 컬럼
    	var flag = 'T';
    	var msg = '필수항목이 누락되었습니다.<br>';
    	
    	store.each(function(rec,idx) {
    		if(rec.phantom == true) {
    			rec.set('V_TYPE','I');
    		} else {
    			rec.set('V_TYPE','U');
    		}
    		
    		//그리드 필수값 체크
    		let invalidFields = '';
    		for(var i=0; i<validationFields.length; i++){
    			let validationField = rec.get(validationFields[i]);
    			
    			if(
    					(validationFields[i] == 'PO_QTY1' && !!!rec.get('DLVY_HOPE_DT1'))
    					||(validationFields[i] == 'PO_QTY2' && !!!rec.get('DLVY_HOPE_DT2'))
    					|| (validationFields[i] == 'PO_QTY3' && !!!rec.get('DLVY_HOPE_DT3'))
    					|| (validationFields[i] == 'PO_QTY4' && !!!rec.get('DLVY_HOPE_DT4'))
    					|| (validationFields[i] == 'PO_QTY5' && !!!rec.get('DLVY_HOPE_DT5'))){
    				continue;
    			}
    			
    			if(!!!validationField){
    				let colFullTxt = grid.getColumnManager().getHeaderByDataIndex(validationFields[i]).text;
    				let colTxt = colFullTxt.substring(colFullTxt.lastIndexOf('>')+1, colFullTxt.length); 
    				flag = 'F';
    				invalidFields += colTxt+',';
    			}
    		}
    		if(invalidFields != '') msg += '<br>' + (idx+1) + '행: ' + invalidFields.substring(0, invalidFields.length-1);
    	});
    	
    	if(flag == 'F'){
    		Ext.Msg.alert('확인', msg);
			return;
    	}
    	
    	//GRID Validation - 한번씩 체크가 안됨..
//    	var colMgr = grid.getColumnManager();
//    	for(var i=0; i<grid.getColumns().length; i++){
//    		let dataIdx = colMgr.getColumns()[i].dataIndex;
//    		if(!!!dataIdx && colMgr.getHeaderByDataIndex(dataIdx).hasEditor()){
//    			var colEditor = colMgr.getHeaderByDataIndex(dataIdx).getEditor();
//    			if(!colEditor.column.field.isValid()){
//    				Ext.Msg.alert('확인', '필수값이 누락되었습니다.');
//    				return;
//    			}
//    		}
//    	}
    		
		store.sync({
			params: {
				V_TYPE : 'SYNC',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_MAST_PO_NO: Ext.getCmp('V_MAST_PO_NO').getValue(),
				V_VAT_TYPE: Ext.getCmp('V_VAT_TYPE').getValue(),
				V_S_BP_CD: Ext.getCmp('V_S_BP_CD').getValue(),
			},
			callback: function(records, operation, success) {
				var tbController = M_PO_TOT_MGM.app.getController("TbButtonController");
		    	tbController.selBtnClick();
			}
		});
		*/
    },
    
    gridCfmBtnClick: function(button, e, eOpts) {
    	
    	Ext.Ajax.request({
			url:'sql/M_PO_TOT_MGM.jsp',
			method: 'post',
			params: {
    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
				V_TYPE: "CF", //저장,
				V_MAST_PO_NO: Ext.getCmp('V_MAST_PO_NO').getValue(),
				V_PO_CFM: Ext.getCmp('V_PO_CFM').getValue()
			},
			callback : function(records,operations,success){
				
		    },
		    success : function(response) {
		    	var flag = response.responseText;
		    	
		    	console.log(Ext.getCmp('V_PO_CFM').getValue());
		    	console.log(flag);
		    	
		    	if(Ext.getCmp('V_PO_CFM').getValue()=='Y' && flag == 'F') {
		    		Ext.Msg.alert('확인', '취소할 수 없는 발주입니다. <br>발주의 다음 진행상태(L/C, B/L, 입고, ASN)를 확인하세요.');
		    	} else {
		    		var tbController = M_PO_TOT_MGM.app.getController("TbButtonController");
		    		tbController.selBtnClick();
		    	}
		    }
		});
    },
    
    /* 발주서 출력*/
    printBtnClick: function() {
    	var msg = '';
    	if(Ext.getCmp('V_PO_CFM').getValue() == 'Y'){
    		if(parent.Ext.getCmp('MAIN_SERVER_YN').getValue() == 'Y'){
    			//var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER.jsp?MAST_PO_NO=';
    	    	//var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS.jsp?MAST_PO_NO=';  	
        		var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER.jsp?reportParams=pdfEditable:true,skip_decimal_point:true,pdfsavename:';
    	    	var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS.jsp?reportParams=pdfEditable:true,skip_decimal_point:true,pdfsavename:';  	
    		}
    		else{
    			//var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_TEST.jsp?MAST_PO_NO=';
    	    	//var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS_TEST.jsp?MAST_PO_NO=';    				
    	    	var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_TEST.jsp?reportParams=pdfEditable:true,skip_decimal_point:true,pdfsavename:';
    	    	var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS_TEST.jsp?reportParams=pdfEditable:true,skip_decimal_point:true,pdfsavename:';  	
    		}
        	var url = '';
        	var MAST_PO_NO = '';
        	
        	if(Ext.getCmp('V_MAST_PO_NO').getValue() != '') {
        		MAST_PO_NO = Ext.getCmp('V_MAST_PO_NO').getValue();

        		if(Ext.getCmp('V_PO_TYPE').getValue() == 'DO' || Ext.getCmp('V_PO_TYPE').getValue() == 'MLO') {
        			//url = url_DO + MAST_PO_NO;
        			url = url_DO + MAST_PO_NO + '_' + Ext.getCmp('V_M_BP_NM').rawValue + '&MAST_PO_NO=' + MAST_PO_NO;
        		} else {
        			//url = url_PO + MAST_PO_NO;
        			url = url_PO + MAST_PO_NO + '&MAST_PO_NO=' + MAST_PO_NO;
        		}
        		
        		Ext.Msg.confirm('확인', '발주서를 출력하시겠습니까?', function(button) {
            		if (button == 'yes') {
    					var myWin = new Ext.Window({
    						title : '발주서',
    						html : '<iframe name="xxx" border =0 src="'+url+'" width="100%" height="100%"></iframe>',
    						width : 1000,
    						height : 768,
    						modal : true
    					});
    					myWin.show();
    					myWin.setSize(Ext.getBody().getViewSize());
    					myWin.setPagePosition(0, 0);
            		}
            	})
        	} else {
        		Ext.Msg.alert('확인', '승인상태를 확인하세요.');
        	}
    	}
    	else{
    		Ext.Msg.alert('확인', '발주서는 발주 확정 후 출력 가능합니다.');
    	}
    	
    },
    
    sendBtnClick: function(button, e, eOpts) {
    	
    	if(parent.Ext.getCmp('MAIN_SERVER_YN').getValue() == 'Y'){
			var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER.jsp?MAST_PO_NO=';
	    	var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS.jsp?MAST_PO_NO=';  	
		}
		else{
			var url_DO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_TEST.jsp?MAST_PO_NO=';
	    	var url_PO = 'http://123.142.124.170:8080/aireport/on_server/M_ORDER_PAPER_OVRSS_TEST.jsp?MAST_PO_NO=';    									
		}
    	
    	var MAST_PO_NO = Ext.getCmp('V_MAST_PO_NO').getValue();
		if(Ext.getCmp('V_PO_TYPE').getValue() == 'DO' || Ext.getCmp('V_PO_TYPE').getValue() == 'MLO') {
			url = url_DO + MAST_PO_NO;
		} else {
			url = url_PO + MAST_PO_NO;
		}
    	
		if(Ext.getCmp('V_PO_CFM').getValue() == 'Y') {
			Ext.Msg.confirm('확인', '발주서를 발송하시겠습니까?', function(button) {
	    		if(button == 'yes') {
	    			Ext.Ajax.request({
	    	    		url:'sql/MAIL_FILE_ATTACH.jsp',
	    	    		method: 'post',
	    	    		dataType: 'jsonp',
	    	    		params: {
//	    	    			V_TYPE: 'I', //생성 
	    	    			V_MAST_PO_NO : MAST_PO_NO,
	    	    			V_URL: url
//	    	    			V_SL_CD: Ext.getCmp('V_SL_CD').getValue(),
//	    	    			V_SL_NM: Ext.getCmp('V_SL_NM').getValue(),
//	    	    			V_REGION: Ext.getCmp('V_REGION').getValue(),
//	    	    			V_REF_NO: Ext.getCmp('V_REF_NO').getValue(),
	    	    		},
	    	    		callback : function(records,operations,success){
	    	    			console.log('zzz');
	    	    			
	    	    		},
	    	    	    success : function(response) {
	    	    	    	
	    	    	    },
	    	    		scope: this
	    	    	});
	    		}
	    	});
		} else {
			Ext.Msg.alert('확인', '발주확정 후 발송하세요.');
		}
    	
    },
    xlsxDownClick: function(button, e, eOpts) {
    	
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
    	var grid = Ext.getCmp('myGrid');
    	grid.saveDocumentAs({
            type: 'xlsx',
            title: '발주등록', //엑셀내타이틀
            fileName: currentDate+'.xlsx' //엑셀파일이름
		});
    },
    remarkChgBtnClick: function(button, e, eOpts) {
    	
    	var window = Ext.create('M_PO_TOT_MGM.view.RemarkWindow');
    	window.show();
    },

    
});
