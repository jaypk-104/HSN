/*
 * File: app/controller/TbButtonController.js
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

Ext.define('Q_BASE_MASTER.controller.TbButtonController1', {
    extend: 'Ext.app.Controller',

    control: {
        "#selBtn1": {
            click: 'selBtn1Click'
        },
        "#saveBtn1": {
            click: 'saveBtn1Click'
        },
        "#delBtn1": {
            click: 'delBtn1Click'
        },
        "#clsBtn1": {
            click: 'clsBtn1Click'
        },
        "mysearchform textfield[name=search_field]": {
            specialkey: 'tfEnter'
        },
    },

    selBtn1Click: function(button, e, eOpts) {
        alert('select');
        //    	var store = this.getMyStoreStore();
        //    	store.removeAll();
        //    	store.load({
        //    		params: {
        //    			V_TYPE: 'S',
        //    			V_COMP_ID: Ext.getCmp('V_COMP_ID').getValue(),
        //    			V_COMP_NM: Ext.getCmp('V_COMP_NM').getValue()
        //    		},
        //    		callback: function(records,operations,success){
        //    		}
        //    	})
    },

    saveBtn1Click: function(button, e, eOpts) {
        alert('save');
    },

    delBtn1Click: function(button, e, eOpts) {
        alert('delete');
    },

    clsBtn1Click: function(button, e, eOpts) {
    	var popup = Ext.getCmp('popup');
    	popup.destroy();
    },

    tfEnter: function(field, e, eOpts) {
        	if (e.getKey() == e.ENTER) {
        		this.selBtnClick();
        	}
    },

});