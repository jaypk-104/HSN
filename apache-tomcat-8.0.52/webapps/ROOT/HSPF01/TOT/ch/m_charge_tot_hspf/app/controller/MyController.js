/*
 * File: app/controller/MyController.js
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

Ext.define('M_CHARGE_TOT_HSPF.controller.MyController', {
    extend: 'Ext.app.Controller',

    onLaunch: function(application) {
    	var H_STEP = document.getElementById("H_STEP").value;
        var H_BAS_NO = document.getElementById("H_BAS_NO").value;
        var H_TYPE = document.getElementById("H_TYPE").value;
        var H_BAS_DOC_NO = document.getElementById("H_BAS_DOC_NO").value;

        if(H_TYPE == 'AUTO'){
        	 Ext.getCmp('V_PR_STEP').setValue(H_STEP);
             Ext.getCmp('V_BAS_NO').setValue(H_BAS_NO);
             
             if(H_STEP =='VL'){
            	 Ext.getCmp('V_LC_DOC_NO').setValue(H_BAS_DOC_NO);
             }else{
            	 Ext.getCmp('V_BL_DOC_NO').setValue(H_BAS_DOC_NO);
             }
             var tbController = M_CHARGE_TOT_HSPF.app.getController("TbButtonController");
     		tbController.selBtnClick();
        }
        
       
    }

});