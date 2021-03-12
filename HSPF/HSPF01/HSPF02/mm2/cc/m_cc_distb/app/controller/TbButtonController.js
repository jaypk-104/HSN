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

Ext.define('M_CC_DISTB.controller.TbButtonController', {
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
        }
    },

    selBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
    	var store1 = this.getMyStore1Store();
    	
    	store.removeAll();
		store1.removeAll();
		
		//[상단]B/L조회
    	store.load({
    		params: {
    			V_TYPE: 'SH',
    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
    			V_BL_DT_FR: Ext.getCmp('V_BL_DT_FR').getValue(),
    			V_BL_DT_TO: Ext.getCmp('V_BL_DT_TO').getValue(),
    			V_BF_DT_FR: Ext.getCmp('V_BF_DT_FR').getValue(),
    			V_BF_DT_TO: Ext.getCmp('V_BF_DT_TO').getValue(),
    			V_M_BP_NM: Ext.getCmp('V_M_BP_NM').getValue(),
    			V_BL_DOC_NO: Ext.getCmp('V_BL_DOC_NO').getValue(),
    			V_SL_CD: Ext.getCmp('V_SL_CD').getValue(),
    		},
    		callback: function(records,operations,success){
    			
    		}
    	});
    	
//    	[하단]CC조회
    	if((Ext.getCmp('V_CC_NO').getValue() != '')) {
        	Ext.Ajax.request({
    			url : 'sql/M_CC_DISTB_H.jsp',
    			method : 'post',
    			params: {
    				V_TYPE: 'S',
        			V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
    				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    				V_CC_NO : Ext.getCmp('V_CC_NO').getValue(),
    			},
    			success: function(response) {
    				var res = Ext.JSON.decode(response.responseText).resultList[0];
    				
    				Ext.getCmp('V_BL_DOC_NO2').setValue(res.BL_DOC_NO);
    				Ext.getCmp('V_DISCHGE_PORT').setValue(res.DISCHGE_PORT);
    				Ext.getCmp('V_ID_NO').setValue(res.ID_NO);
    				Ext.getCmp('V_ID_DT').setValue(res.ID_DT);
    				Ext.getCmp('V_TAX_CUSTOM').setValue(res.TAX_CUSTOM);
    				Ext.getCmp('V_XCH_RATE').setValue(res.XCH_RATE);
    				Ext.getCmp('V_FORWARD_XCH').setValue(res.FORWARD_XCH);
    				Ext.getCmp('V_TOTAL_QTY').setValue(res.TOTAL_QTY);
    				Ext.getCmp('V_M_BP_NM2').setValue(res.M_BP_NM);
    				Ext.getCmp('V_M_BP_CD2').setValue(res.M_BP_CD);
    				Ext.getCmp('V_IN_TERMS').setValue(res.IN_TERMS);
    				Ext.getCmp('V_PAY_METH').setValue(res.PAY_METH);
        			Ext.getCmp('V_CUR').setValue(res.CUR);
        			Ext.getCmp('V_XCH_RATE').setValue(res.XCH_RATE);
    		    	
        			store1.load({
    		    		params: {
    		    			V_TYPE: 'S',
    		    			V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
    						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    	    				V_CC_NO : Ext.getCmp('V_CC_NO').getValue(),
    		    		},
    		    		callback: function(records,operations,success){
    		    		}
    		    	});
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

		Ext.getCmp('V_CC_NO').setValue('');
		Ext.getCmp('V_BL_DOC_NO2').setValue('');
		Ext.getCmp('V_DISCHGE_PORT').setValue('PUS');
		Ext.getCmp('V_TAX_CUSTOM').setValue('PU');
		Ext.getCmp('V_ID_NO').setValue('');
		Ext.getCmp('V_ID_USR').setValue('');
		Ext.getCmp('V_M_BP_NM2').setValue('');
		Ext.getCmp('V_M_BP_CD2').setValue('');
		var nows = new Date();
		Ext.getCmp('V_ID_DT').setValue(nows);
		Ext.getCmp('V_TOTAL_QTY').setValue(0);
		Ext.getCmp('V_IN_TERMS').setValue(null);
		Ext.getCmp('V_PAY_METH').setValue(null);
		Ext.getCmp('V_CUR').setValue('USD');
		Ext.getCmp('V_FORWARD_XCH').setValue('');
//		Ext.getCmp('V_XCH_RATE').setValue(1);
		
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
    }

});