/*
 * File: app/controller/TbButtonController.js
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

Ext.define('M_PROD_DN_HSPF.controller.TbButtonController', {
    extend: 'Ext.app.Controller',
    stores: ['MyStore'],
    control: {
        "#selBtn": {
            click: 'selBtnClick'
        },
        "#saveBtn": {
            click: 'saveBtnClick'
        },
        "#delBtn": {
            click: 'delBtnClick'
        },
        "#clsBtn": {
            click: 'clsBtnClick'
        },
        "mysearchform textfield[name=search_field]": {
            specialkey: 'tfEnter'
        }
    },

    /* [ MyStore : USP_M_PROD_DN_HSPF ]*/
    
    selBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	store.removeAll();
    	store.load({
    		params: {
    			V_TYPE: 'S',
    			V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_PROD_DN_DT_FR: Ext.getCmp('V_PROD_DN_DT_FR').getValue(),
				V_PROD_DN_DT_TO: Ext.getCmp('V_PROD_DN_DT_TO').getValue(),
				V_S_BP_NM: Ext.getCmp('V_S_BP_NM').getValue(),
    		},
    		callback: function(records,operations,success){
    			Ext.toast({
					  title: ' ',
					  timeout: 1000,
					  html: '조회완료',
					  style: 'text-align: center',
					  align: 't',
					  width: 130,
				});
    		}
    	});
    },

    saveBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
    	var flag = '';
    	var msg = '';
    	
    	if(gridRecord.length > 0) {
    		for(var i=0; i<gridRecord.length; i++) {
    			if(gridRecord[i].data['PROD_DN_NO']==undefined) {
    				flag = 'F';
    				msg = '생산출고번호를 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['PROD_DN_SEQ']==undefined) {
    				flag = 'F';
    				msg = '생산출고순번을 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['S_BP_CD']==undefined) {
    				flag = 'F';
    				msg = '거래처코드를 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['BP_ITEM_CD']==undefined) {
    				flag = 'F';
    				msg = '거래처품목코드를 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['BP_ITEM_NM']==undefined) {
    				flag = 'F';
    				msg = '거래처품목명을 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['PROD_DN_DT']==undefined) {
    				flag = 'F';
    				msg = '생산출고일을 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['LINE_CD']==undefined) {
    				flag = 'F';
    				msg = '공정코드를 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['LINE_NM']==undefined) {
    				flag = 'F';
    				msg = '공정명을 입력하세요.';
    				break;
    			}
    			else if(gridRecord[i].data['DN_QTY']==undefined || gridRecord[i].data['DN_QTY'] == '0') {
    				flag = 'F';
    				msg = '출고수량을 입력하세요.';
    				break;
    			}
    			else {
    				flag = 'T';
					gridRecord[i].set('V_TYPE', 'I');
				}
    		}
    	} else {
    		flag = 'F';
    		msg = '저장할 내역을 선택하세요.';
    	}
    	
    	if(flag == 'T') {
			Ext.Msg.confirm('확인','저장하시겠습니까?', function(button){
				if(button == 'yes') {
					store.sync({
						params: {
							V_TYPE: 'SYNC',
							V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
							V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
						},
						callback: function(records,operations,success){
							store.reload();
							
							Ext.toast({
								  title: ' ',
								  timeout: 1000,
								  html: '저장완료',
								  style: 'text-align: center',
								  align: 't',
								  width: 130,
							});
						}
					});
				}
			});
    	} else {
			Ext.Msg.alert('확인', msg);
		}
    	
    },

    delBtnClick: function(button, e, eOpts) {
        alert('delete');
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
    }

});
