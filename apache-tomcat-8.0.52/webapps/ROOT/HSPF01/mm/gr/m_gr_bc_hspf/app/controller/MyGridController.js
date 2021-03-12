/*
 * File: app/controller/MyGridController.js
 *
 * This file was generated by Sencha Architect version 4.2.3.
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

Ext.define('M_GR_BC_HSPF.controller.MyGridController', {
    extend: 'Ext.app.Controller',

    stores: [
        'MyStore'
    ],

    control: {
        "#gridAddBtn": {
            click: 'gridAddBtnClick'
        },
        "#gridDelBtn": {
            click: 'gridDelBtnClick'
        },
        "#gridErpBtn": {
        	click: 'gridErpBtnClick'
        },
        "#xlsxDown": {
            click: 'xlsxDownClick'
        },
    },

    gridAddBtnClick: function(button, e, eOpts) {
        //var popup = Ext.create("B_COMP_HSPF.view.WinAddRow");
        //popup.show();
        //Ext.getCmp('rowCount').setValue(1);
    },

    gridDelBtnClick: function(button, e, eOpts) {
        var store = Ext.getStore('MyStore');
        var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
        var flag = '';
        
        for(var i=0; i<gridRecord.length; i++) {
        	if(gridRecord[i].data['IF_YN']=='Y') {
        		flag = 'F';
        		break;
        	}
        	else if(gridRecord[i].data['V_TYPE']=='V') {
    			gridRecord[i].data['V_TYPE'] = 'D';
    			flag = 'T';
    		}
    	}
        
    	if(gridRecord.length > 0) {
    		if(flag == 'T') {
    			Ext.Msg.confirm('확인','삭제하시겠습니까?', function(button){
        			if(button == 'yes') {
        				
        		    	store.sync({
        					params: {
        						V_TYPE : 'SYNC',
        						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
        					},
        		    		callback: function(records, operation, success) {
        		    			store.reload();
        					}
        		    	});
        			}
        		});
    		} else {
    			Ext.Msg.alert('확인', 'ERP전송 된 바코드입니다. 삭제할 수 없습니다.<br> (ERP연동삭제 개발예정)');
    		}
    	}
    },
    
    gridErpBtnClick: function(button, e, eOpts) {
    	var store = Ext.getStore('MyStore');
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
    	var myMask = new Ext.LoadMask(Ext.getCmp('myGrid') , {msg:"인터페이스 중"});
    	var flag = '';
    	var msg = '';
    	
    	
    	for(var i=0; i<gridRecord.length; i++) {
    		if(gridRecord[i].get('IF_YN')=='Y') {
    			flag = 'F';
    			msg = '이미 전송 된 바코드입니다.';
    		} else {
				gridRecord[i].data['V_TYPE'] = 'IF';
				flag = 'T';
			}
		}
    	
    	
    	if(gridRecord.length > 0) {
    		if(flag =='T') {
    			Ext.Msg.confirm('확인','ERP로 데이터를 전송하시겠습니까?', function(button){
        			if(button == 'yes') {
        				myMask.show();
        				store.sync({
        					params: {
        						V_TYPE : 'SYNC',
        						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
        					},
        					callback: function(records, operation, success) {
        						var response = records.operations[0]._response.responseText;
        						var jsonResult = Ext.JSON.decode(response);
        						
        						var tryCnt = jsonResult.tryCnt;
        						var finCnt = jsonResult.finCnt;
        						var resMSG = jsonResult.resMSG;
        						var resDATE = jsonResult.resDATE;
    							var resString = jsonResult.resString;
    							
    							if(resString == 'SUCCESS') {
    								Ext.Msg.alert('확인', '총 [ ' + finCnt + ' ] 건 전송 완료');
    	    						store.reload();
    	    	    				myMask.hide();
    							} else if (resMSG == 'ERROR'){
    								Ext.Msg.alert('확인', '총 [ ' + tryCnt + ' ] 건 중 [ ' + finCnt + ' ] 건 전송 완료 <br>관리자 문의요망<br>' + resString + '<br>' + resDATE);
    								myMask.hide();
    							} else {
    								Ext.Msg.alert('확인', '인터페이스 오류, 관리자 문의요망<br>' + resString + '<br>' + resDATE);
    								myMask.hide();
    							}
        					}
        				});
        			}
        		});
    		} else {
    			Ext.Msg.alert('확인', msg);
    		}
    	} else {
    		Ext.Msg.alert('확인', '전송할 데이터를 선택하세요.');
    	}
    },

    xlsxDownClick: function(button, e, eOpts) {
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
            	var grid = Ext.getCmp('myGrid');
            	grid.saveDocumentAs({
                    type: 'xlsx',
                    title: 'test', //엑셀내타이틀
                    fileName: currentDate+'.xlsx' //엑셀파일이름
        		});
    },

    xmlDownClick: function(button, e, eOpts) {
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
            	var grid = Ext.getCmp('myGrid');
            	grid.saveDocumentAs({
                    type: 'xml',
                    title: 'test', //엑셀내타이틀
                    fileName: currentDate+'.xml' //엑셀파일이름
        		});
    }

});