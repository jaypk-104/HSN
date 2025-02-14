/*
 * File: app/controller/TbButtonController.js
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

Ext.define('st_tr_reg.controller.TbButtonController', {
    extend: 'Ext.app.Controller',

    stores: [
        'MyStore'
    ],

    control: {
        "#selBtn": {
            click: 'selBtnClick'
        },
        "#saveBtn": {
            click: 'saveBtnClick'
        },
        "#clrBtn": {
            click: 'clrBtnClick'
        },
        "#clsBtn": {
            click: 'clsBtnClick'
        },
        "mysearchform textfield[name=search_field]": {
            specialkey: 'tfEnter'
        },
        "#grPrintBtn": {
        	click: 'grPrintBtnClick'
        },
        "#dnPrintBtn": {
        	click: 'dnPrintBtnClick'
        },
    },

    selBtnClick: function(button, e, eOpts) {
		var store = this.getMyStoreStore();
		store.removeAll();
		store.load({
			params: {
				V_TYPE: 'S',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_M_BP_CD : Ext.getCmp('V_M_BP_CD').getValue(),
				V_S_BP_CD : Ext.getCmp('V_S_BP_CD').getValue(),
				V_GR_DT_FROM : Ext.getCmp('V_GR_DT_FROM').getValue(),
				V_GR_DT_TO : Ext.getCmp('V_GR_DT_TO').getValue(),
				V_DN_DT_FROM : Ext.getCmp('V_DN_DT_FROM').getValue(),
				V_DN_DT_TO : Ext.getCmp('V_DN_DT_TO').getValue(),
				V_PUR_GRP : Ext.getCmp('V_PUR_GRP').getValue(),
			},
			callback: function(records,operations,success){
			}
		})
    },

    saveBtnClick: function(button, e, eOpts) {
    	var store = Ext.getStore('MyStore');
		var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
		var flag = 'F';
		var msg = '데이터를 선택해주세요';
		
		for(var i=0; i<gridRecord.length; i++) {
			if(gridRecord[i].get('V_TYPE') == 'V') {
				if(gridRecord[i].get('DN_NO') != '' && gridRecord[i].get('DN_NO') != null && gridRecord[i].get('DN_NO') != undefined) {
					flag = 'F';
					msg = '입출고된 데이터는 수정이 불가능합니다.';
					break;
				}
				else if(gridRecord[i].get('GR_DT') == '' || gridRecord[i].get('GR_DT') == null || gridRecord[i].get('GR_DT') == undefined) {
					flag = 'F';
					msg = '입고일자를 입력하세요.';
					break;
				}
				else if(gridRecord[i].get('M_BP_CD') == '' || gridRecord[i].get('M_BP_CD') == null || gridRecord[i].get('M_BP_CD') == undefined) {
					flag = 'F';
					msg = '매입처코드를 입력하세요.';
					break;
				}
				else if(gridRecord[i].get('PUR_GRP') == '' || gridRecord[i].get('PUR_GRP') == null || gridRecord[i].get('PUR_GRP') == undefined) {
					flag = 'F';
					msg = '구매그룹을 입력하세요.';
					break;
				}
				else if(gridRecord[i].get('TOTAL_AMT') == '' || gridRecord[i].get('TOTAL_AMT') == null || gridRecord[i].get('TOTAL_AMT') == undefined) {
					flag = 'F';
					msg = '매입 금액을 확인하세요.';
					break;
				}
				else if(gridRecord[i].get('S_BP_CD') == '' || gridRecord[i].get('S_BP_CD') == null || gridRecord[i].get('S_BP_CD') == undefined) {
					flag = 'F';
					msg = '매출처코드를 입력하세요.';
					break;
				}
				else if(gridRecord[i].get('DN_DT') == '' || gridRecord[i].get('DN_DT') == null || gridRecord[i].get('DN_DT') == undefined) {
					flag = 'F';
					msg = '출고일자를 입력하세요.';
					break;
				}
				else if(gridRecord[i].get('DN_TOTAL_AMT') == '' || gridRecord[i].get('DN_TOTAL_AMT') == null || gridRecord[i].get('DN_TOTAL_AMT') == undefined) {
					flag = 'F';
					msg = '매출 금액을 확인하세요.';
					break;
				}
				else if(gridRecord[i].get('IV_DN_NO') == '' || gridRecord[i].get('IV_DN_NO') == null || gridRecord[i].get('IV_DN_NO') == undefined) {
					flag = 'T';
					gridRecord[i].set('V_TYPE', 'I');
				} 
				else {
					flag = 'T';
					gridRecord[i].set('V_TYPE', 'U');
				}
			}
		}
		if(flag == 'T') {
			Ext.Msg.confirm('확인', '저장 하시겠습니까?', function(btn) {
				if (btn == 'yes') {
					store.sync({ 
						params : {
							V_TYPE : 'SYNC',
							V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
							V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
						},
						callback : function(records, operation, success) {
							var tbController = st_tr_reg.app.getController("TbButtonController");
							tbController.selBtnClick();
						}, 
						success: function() {
							
						}
					});
				}
			});
		}
		else{
			Ext.Msg.alert('확인', msg);
		}
		
		
    },

    clrBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
		store.removeAll();
		Ext.getCmp('V_S_BP_NM').setValue('');
		Ext.getCmp('V_S_BP_CD').setValue('');
		Ext.getCmp('V_M_BP_NM').setValue('');
		Ext.getCmp('V_M_BP_CD').setValue('');
		Ext.getCmp('V_PUR_GRP').setValue('');
		
		
		var nows = new Date();
    	nows.setMonth(nows.getMonth() - 1);
		Ext.getCmp('V_GR_DT_FROM').setValue(nows);
		Ext.getCmp('V_DN_DT_FROM').setValue(nows);
		
		nows = new Date();
		Ext.getCmp('V_GR_DT_TO').setValue(nows);
		Ext.getCmp('V_DN_DT_TO').setValue(nows);
		
		
		
    },

    clsBtnClick: function(button, e, eOpts) {
        var tab=parent.Ext.getCmp('myTab');
        var activeTab=tab.getActiveTab();
        var tabIndex=tab.items.indexOf(activeTab);
        tab.remove(tabIndex,true);
    },

    tfEnter: function(field, e, eOpts) {
        	if (e.getKey() == e.ENTER) {
        		this.selBtnClick();
        	}
    },
    grPrintBtnClick: function(button, e, eOpts) {
    	if(Ext.getCmp('V_GR_DT_FROM').getValue() == '' || Ext.getCmp('V_GR_DT_FROM').getValue() == null || Ext.getCmp('V_GR_DT_FROM').getValue() == undefined 
        		|| Ext.getCmp('V_GR_DT_TO').getValue() == '' || Ext.getCmp('V_GR_DT_TO').getValue() == null || Ext.getCmp('V_GR_DT_TO').getValue() == undefined
        	){
        		Ext.Msg.alert('확인', '입고기간을 입력해주세요.');
        	}
    	else{
    		var V_GR_DT_FROM = this.getFormatDate(Ext.getCmp('V_GR_DT_FROM').getValue());
        	var V_GR_DT_TO = this.getFormatDate(Ext.getCmp('V_GR_DT_TO').getValue());
        	var V_GR_DT_FROMTO = V_GR_DT_FROM  + '~' + V_GR_DT_TO;
        	var V_M_BP_CD = Ext.getCmp('V_M_BP_CD').getValue();
        	var V_S_BP_CD = Ext.getCmp('V_S_BP_CD').getValue();
        	if(parent.Ext.getCmp('MAIN_SERVER_YN').getValue() == 'Y'){
        		var myWin=new Ext.Window(
        				{
        					title : '고철 매입',
        					html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/STEEL/ST_TR_REG_GR.jsp?BP_CD='+V_M_BP_CD+'&YY_MMFR=' + V_GR_DT_FROM + '&YY_MMTO=' + V_GR_DT_TO + '&MM=' + V_GR_DT_FROMTO + '&S_BP_CD=' + V_S_BP_CD + '" width="100%" height="100%"></iframe>',
        					width :1000,
        					height:768,
        					modal: true
        				});
        		myWin.show();
        		myWin.setSize(Ext.getBody().getViewSize());
        		myWin.setPagePosition(0, 0);
        		
        	}
        	else{
        		var myWin=new Ext.Window(
        				{
        					title : '고철 매입',
        					html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/STEEL/ST_TR_REG_GR_TEST.jsp?BP_CD='+V_M_BP_CD+'&YY_MMFR=' + V_GR_DT_FROM + '&YY_MMTO=' + V_GR_DT_TO + '&MM=' + V_GR_DT_FROMTO + '" width="100%" height="100%"></iframe>',
        					width :1000,
        					height:768,
        					modal: true
        				});
        		myWin.show();
        		myWin.setSize(Ext.getBody().getViewSize());
        		myWin.setPagePosition(0, 0);
        	}
    	}
    	
    	
    },
    dnPrintBtnClick: function(button, e, eOpts) {
    	if(Ext.getCmp('V_DN_DT_FROM').getValue() == '' || Ext.getCmp('V_DN_DT_FROM').getValue() == null || Ext.getCmp('V_DN_DT_FROM').getValue() == undefined 
    		|| Ext.getCmp('V_DN_DT_TO').getValue() == '' || Ext.getCmp('V_DN_DT_TO').getValue() == null || Ext.getCmp('V_DN_DT_TO').getValue() == undefined
    	){
    		Ext.Msg.alert('확인', '출고기간을 입력해주세요.');
    	}
    	else{
    		var V_DN_DT_FROM = this.getFormatDate(Ext.getCmp('V_DN_DT_FROM').getValue());
        	var V_DN_DT_TO = this.getFormatDate(Ext.getCmp('V_DN_DT_TO').getValue());
        	var V_DN_DT_FROMTO = V_DN_DT_FROM  + '~' + V_DN_DT_TO;
        	var V_S_BP_CD = Ext.getCmp('V_S_BP_CD').getValue();
        	
        	if(parent.Ext.getCmp('MAIN_SERVER_YN').getValue() == 'Y'){
	        	var myWin=new Ext.Window(
	        			{
	        				title : '고철 출고',
	        				html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/STEEL/ST_TR_REG_DN.jsp?BP_CD='+V_S_BP_CD+'&YY_MMFR=' + V_DN_DT_FROM + '&YY_MMTO=' + V_DN_DT_TO + '&MM=' + V_DN_DT_FROMTO + '" width="100%" height="100%"></iframe>',
	        				width :1000,
	        				height:768,
	        				modal: true
	        			});
	        	myWin.show();
	        	myWin.setSize(Ext.getBody().getViewSize());
	        	myWin.setPagePosition(0, 0);
        	}
        	else{
        		var myWin=new Ext.Window(
	        			{
	        				title : '고철 출고',
	        				html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/on_server/STEEL/ST_TR_REG_DN_TEST.jsp?BP_CD='+V_S_BP_CD+'&YY_MMFR=' + V_DN_DT_FROM + '&YY_MMTO=' + V_DN_DT_TO + '&MM=' + V_GR_DT_FROMTO + '" width="100%" height="100%"></iframe>',
	        				width :1000,
	        				height:768,
	        				modal: true
	        			});
	        	myWin.show();
	        	myWin.setSize(Ext.getBody().getViewSize());
	        	myWin.setPagePosition(0, 0);
        	}
    	}
    	
    	
    },
    
    getFormatDate: function(date){
    	var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
    }

});
