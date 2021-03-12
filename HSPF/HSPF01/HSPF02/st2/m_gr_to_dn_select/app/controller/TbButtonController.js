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

Ext.define('M_GR_TO_DN_SELECT.controller.TbButtonController', {
    extend: 'Ext.app.Controller',
    stores: ['MyStore', 'MyStore1','Popup.store.WinMBpPopStore'],
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
        "myform textfield[name=search_field]": {
            specialkey: 'tfEnter'
        },
        "textfield[name=search_field2]": {
        	specialkey: 'tfEnter2'
        }
    },

    selBtnClick: function(button, e, eOpts) {
    	var store = this.getMyStoreStore();
		store.removeAll();

    	var rb1 = Ext.ComponentQuery.query('radiofield[name=rb1]');
    	var V_GR_DN =  rb1[0].getGroupValue();
    	
		store.load({
    		params: {
    			V_TYPE: V_GR_DN,
    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
    			V_BS_FR_DT: Ext.getCmp('V_BS_FR_DT').getValue(),
    			V_BS_TO_DT: Ext.getCmp('V_BS_TO_DT').getValue(),
    			V_APPROV_NM: Ext.getCmp('V_APPROV_NM').getValue(),
    			V_M_BP_NM: Ext.getCmp('V_M_BP_NM').getValue(),
    			V_S_BP_NM: Ext.getCmp('V_S_BP_NM').getValue(),
    			V_BL_DOC_NO: Ext.getCmp('V_BL_DOC_NO').getValue(),
    			V_REGION: Ext.getCmp('V_REGION').getValue(),
    			V_SALE_TYPE: Ext.getCmp('V_SALE_TYPE').getValue(),
    			V_IV_TYPE: Ext.getCmp('V_IV_TYPE').getValue(),
    			V_BF_TYPE: Ext.getCmp('V_BF_TYPE').getValue(),
    			V_ITEM_NM: Ext.getCmp('V_ITEM_NM').getValue(),
    			V_APPROV_NO: Ext.getCmp('V_APPROV_NO').getValue(),
    		},
    		callback: function(records,operations,success){
    			
    		}
		});
    },

	

    delBtnClick: function(button, e, eOpts) {
        alert('delete');
    },

    clsBtnClick: function(button, e, eOpts) {
        alert('close');
    },

    tfEnter: function(field, e, eOpts) {
        	if (e.getKey() == e.ENTER) {
        		this.selBtnClick();
        	}
    },
    onLaunch: function(application) {
    	var BPstore1 = Ext.getStore('WinMBpPopStore');
        BPstore1.load();
        var BPstore2 = Ext.getStore('WinSBpPopStore');
        BPstore2.load();
    }

});