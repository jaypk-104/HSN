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

Ext.define('M_GR_TOT_HSPF.controller.TbButtonController', {
    extend: 'Ext.app.Controller',
    stores: ['MyStore', 'MyStore1'],
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
        "textfield[name=search_field]": {
            specialkey: 'tfEnter'
        },
        "textfield[name=search_field2]": {
        	specialkey: 'tfEnter2'
        }
    },

    selBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	var store1 = this.getMyStore1Store();
		store.removeAll();
		store1.removeAll();
		
		var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
		var ccArr = new Array();
		
		for(var i=0; i<gridRecord.length; i++) {
			if(!ccArr.includes(gridRecord[i].get('CC_NO'))) {
				ccArr.push(gridRecord[i].get('CC_NO'));
			}
		}

		var CC_NO = '\'';
		
		for(var i=0; i<ccArr.length; i++) {
			CC_NO += ccArr[i] +'\',\'';
		}
		
		CC_NO = '(' + CC_NO.substr(0, CC_NO.length -2) + ')'; 
//		console.log(Ext.getCmp('V_BL_DOC_NO2').getValue());
    		
    	//[상단]조회
    	store.load({
    		params: {
    			V_TYPE: 'SH',
    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
    			V_ID_DT_FR: Ext.getCmp('V_ID_DT_FR').getValue(),
    			V_ID_DT_TO: Ext.getCmp('V_ID_DT_TO').getValue(),
    			V_BL_DOC_NO: Ext.getCmp('V_BL_DOC_NO').getValue(),
    			V_M_BP_NM: Ext.getCmp('V_M_BP_NM').getValue(),
    			V_SL_CD: Ext.getCmp('V_SL_CD').getValue(),
    			V_IV_TYPE: Ext.getCmp('V_IV_TYPE').getValue(),
    		},
    		callback: function(records,operations,success){
    			//[하단]조회
//    	    	if(Ext.getCmp('V_BL_DOC_NO2').getValue() != '') {
//    	    		store1.load({
//    	        		params: {
//    	        			V_TYPE: 'SD',
//    	        			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
//    	        			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
//    	        			V_BL_DOC_NO: Ext.getCmp('V_BL_DOC_NO2').getValue(),
//    	        			V_M_BP_NM: Ext.getCmp('V_M_BP_NM2').getValue(),
//    	        			V_CC_NO : CC_NO,
//    	        			V_MVMT_DT_FR: Ext.getCmp('V_MVMT_DT_FR2').getValue(),
//    	        			V_MVMT_DT_TO: Ext.getCmp('V_MVMT_DT_TO2').getValue()
//    	        		},
//    	        		callback: function(records,operations,success){
//    	        			
//    	        		}
//    	        	});
//    	    	}
    	    	
    		}
    	});
    	
    	
    	
    },
    selBtnClick2: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	var store1 = this.getMyStore1Store();
//    	store.removeAll();
    	store1.removeAll();
    	
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();
		var ccArr = new Array();
		
		for(var i=0; i<gridRecord.length; i++) {
			if(!ccArr.includes(gridRecord[i].get('CC_NO'))) {
				ccArr.push(gridRecord[i].get('CC_NO'));
			}
		}

		var CC_NO = '\'';
		
		for(var i=0; i<ccArr.length; i++) {
			CC_NO += ccArr[i] +'\',\'';
		}
		
		CC_NO = '(' + CC_NO.substr(0, CC_NO.length -2) + ')'; 
//		console.log(CC_NO);
    	
    	//[하단]조회
    	if(Ext.getCmp('V_BL_DOC_NO2').getValue() != '') {
    		store1.load({
        		params: {
        			V_TYPE: 'SD',
        			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
        			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
        			V_BL_DOC_NO: Ext.getCmp('V_BL_DOC_NO2').getValue(),
        			V_M_BP_NM: Ext.getCmp('V_M_BP_NM2').getValue(),
        			V_CC_NO : CC_NO,
        			V_MVMT_DT_FR: Ext.getCmp('V_MVMT_DT_FR2').getValue(),
        			V_MVMT_DT_TO: Ext.getCmp('V_MVMT_DT_TO2').getValue()
        		},
        		callback: function(records,operations,success){
        			
        		}
        	});
    	}
    },

    saveBtnClick: function(button, e, eOpts) {
        alert('save');
    },


    clrBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	var store1 = this.getMyStore1Store();
    	
    	store.removeAll();
    	store1.removeAll();

		Ext.getCmp('V_M_BP_NM').setValue('');
		Ext.getCmp('V_BL_DOC_NO').setValue('');
		Ext.getCmp('V_SL_CD').setValue('');
		Ext.getCmp('V_BL_DOC_NO2').setValue('');
		Ext.getCmp('V_M_BP_NM2').setValue('');
		
		Ext.getCmp('gridDelBtn1').setDisabled(false);
		Ext.getCmp('gridSaveBtn').setDisabled(false);
		Ext.getCmp('chargeReCalcBtn').setDisabled(false);
		Ext.getCmp('tempGlCfmBtn').setDisabled(true);
		Ext.getCmp('tempGlCancelBtn').setDisabled(true);
    },
    
    clsBtnClick: function(button, e, eOpts) {
		var tab = parent.Ext.getCmp('myTab');
		var activeTab = tab.getActiveTab();
		var tabIndex = tab.items.indexOf(activeTab);
		tab.remove(tabIndex, true);
	},

    tfEnter: function(field, e, eOpts) {
        	if (e.getKey() == e.ENTER) {
        		this.selBtnClick();
        	}
    },
    
    tfEnter2: function(field, e, eOpts) {
    	if (e.getKey() == e.ENTER) {
    		this.selBtnClick2();
    	}
    }

});
