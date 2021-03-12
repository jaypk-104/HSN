/*
 * File: app/controller/MyGridController.js
 *
 * This file was generated by Sencha Architect version 4.2.2.
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

Ext.define('S_DD_CFM_HSPF.controller.MyGridController', {
    extend: 'Ext.app.Controller',

    control: {
        "#gridAddBtn": {
            click: 'gridAddBtnClick'
        },
        "#gridDelBtn": {
            click: 'gridDelBtnClick'
        },
        "#cfmBtn": {
        	click: 'cfmBtnClick'
        },
        "#xlsxDown": {
            click: 'xlsxDownClick'
        },
        "#shipPrintBtn": {
        	click: 'shipPrintBtnClick'
        },
        "#dnTaxPrintBtn": {
        	click: 'dnTaxPrintBtnClick'
        }
    },

    gridAddBtnClick: function(button, e, eOpts) {
        //var popup = Ext.create("B_COMP_HSPF.view.WinAddRow");
        //popup.show();
        //Ext.getCmp('rowCount').setValue(1);
    },

    gridDelBtnClick: function(button, e, eOpts) {
        var store = Ext.getStore('MyStore');
            	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();

            	if(gridRecord.length > 0) {
            		Ext.Msg.confirm('확인','삭제하시겠습니까?', function(button){
            			if(button == 'yes') {
            				for(var i=0; i<gridRecord.length; i++) {
            		    		if(gridRecord[i].data['V_TYPE']=='V') {
            		    			gridRecord[i].data['V_TYPE'] = 'D';
            		    		}
            		    	}
            		    	store.sync({
            					params: {
            						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
            					},
            		    		callback: function(records, operation, success) {
            		    			store.reload();
            					}
            		    	});
            			}
            		});
            	}
    },

    cfmBtnClick: function(button, e, eOpts) {
    	var store = Ext.getStore('MyStore');
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
    	
    	if(gridRecord.length > 0) {
    		Ext.Msg.confirm('확인','확정하시겠습니까?', function(button){
    			if(button == 'yes') {
    				for(var i=0; i<gridRecord.length; i++) {
    					if(gridRecord[i].data['V_TYPE']=='V') {
    						if(gridRecord[i].data['END_YN'] == 'Y') {
    							gridRecord[i].data['V_TYPE'] = 'CF_N';
    						} else {
    							gridRecord[i].data['V_TYPE'] = 'CF';
    						}
    					}
    				}
    				store.sync({
    					params: {
    						V_TYPE: 'SYNC',
							V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
							V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    					},
    					callback: function(records, operation, success) {
    						store.reload();
    					}
    				});
    			}
    		});
    	}
    },

    xlsxDownClick: function(button, e, eOpts) {
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
            	var grid = Ext.getCmp('myGrid');
            	grid.saveDocumentAs({
                    type: 'xlsx',
                    title: '출고지시배차및확정', //엑셀내타이틀
                    fileName: currentDate+'.xlsx' //엑셀파일이름
        		});
    },
    
    shipPrintBtnClick: function(button, e, eOpts) {
    	var store = Ext.getStore('MyStore');
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
    	if(gridRecord[0].data['END_YN'] == 'Y'){
    		var myWin=new Ext.Window(
    				{
    					title : '출하지도서',
    					html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/SHIP_PRINT.jsp?V_TYPE=S&V_DD_NO='+gridRecord[0].data['DD_NO']+'&V_REQ_TEXT='+gridRecord[0].data['DD_NO']+'" width="100%" height="100%"></iframe>',
    					width :1000,
    					height:768,
    					modal: true
    				});
    		myWin.show();
    		myWin.setSize(Ext.getBody().getViewSize());
    		myWin.setPagePosition(0, 0);
    	}
    	else{
    		Ext.Msg.alert('확인', '확정된 품목을 선택해주세요.');
    	}
    },
    
    dnTaxPrintBtnClick: function(button, e, eOpts) {
    	var store = Ext.getStore('MyStore');
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
//    	if(gridRecord[0].data['END_YN'] == 'Y'){
    		var myWin=new Ext.Window(
    				{
    					title : '출고거래명세서',
    					html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/DN_TAX_PRINT.jsp?V_TYPE=S&DD_NO='+gridRecord[0].data['DD_NO']+'&BP_CD='+ '00000' +'" width="100%" height="100%"></iframe>',
    					width :1000,
    					height:768,
    					modal: true
    				});
    		myWin.show();
    		myWin.setSize(Ext.getBody().getViewSize());
    		myWin.setPagePosition(0, 0);
//    	}
//    	else{
//    		Ext.Msg.alert('확인', '확정된 품목을 선택해주세요.');
//    	}
    }

});