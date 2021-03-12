/*
 * File: app/controller/WinAddRowController.js
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

Ext.define('M_LC_AMEND_TOT_HSPF.controller.WinAddRowController', {
    extend: 'Ext.app.Controller',

    control: {
        "#addRowBtn": {
            click: 'addRowBtnClick'
        }
    },

    addRowBtnClick: function(button, e, eOpts) {
        var store1 = Ext.getStore('MyStore1');
        var count = store1.getCount();
        var rowCount = Number(Ext.getCmp('rowCount').getValue());

        for(var i=0; i<rowCount; i++) {
        	count = count + 1;
        	var rec = Ext.create('M_LC_AMEND_TOT_HSPF.model.MyModel', {
        		AMD_FLG: 'I'
        	});
        	store1.insert(count-1, rec);
        }

        var win = Ext.WindowManager.getActive();
        if(win){
             win.close();
        }
    }

});