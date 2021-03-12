/*
 * File: app/controller/RPoRegController.js
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

Ext.define('Y_APPROV_DISTR.controller.MeatPopController', {
    extend: 'Ext.app.Controller',
    stores: ['MeatStore'],
	control : {
		"#w_selBtn" : {
			click : 'w_selBtnClick'
		},
		'#w_regBtn' : {
			click : 'w_regBtnClick'
		},
		'#meatGrid': {
			celldblclick: 'w_popGridDblClick'
		},
		"textfield[name=meat_search]": {
            specialkey: 'tfEnter'
        }
	},
	
	w_selBtnClick: function() {
		var popStore = this.getMeatStoreStore();
		popStore.load({
    		params: {
    			V_TAB_TYPE: 'T1',
    			V_TYPE: 'MEAT',
    			V_SM_NM: Ext.getCmp('V_SM_NM').getValue(),
    			V_BF_TYPE: Ext.getCmp('V_BF_TYPE').getValue(),
    			V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
    		},
    		callback: function(records,operations,success){
    		}
    	});
	
	},
	w_regBtnClick: function() {
		var w_gridRecord = Ext.getCmp('meatGrid').getSelectionModel().getSelection();
		
		var popWin=  Ext.getCmp('MeatPop');
		popWin.destroy();
	},
	w_popGridDblClick : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
		var w_gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection();

		w_gridRecord[0].set('BF_TYPE', record.get('BF_TYPE'));
		w_gridRecord[0].set('LG_TYPE', record.get('LG_TYPE'));
		w_gridRecord[0].set('LG_NM', record.get('LG_NM'));
		w_gridRecord[0].set('SM_TYPE', record.get('SM_TYPE'));
		w_gridRecord[0].set('SM_NM', record.get('SM_NM'));
		w_gridRecord[0].set('ITEM_NM', record.get('SM_TYPE'));
		
		var popWin = Ext.getCmp('MeatPop');
		popWin.destroy();
		
	},
	
	tfEnter: function(field, e, eOpts) {
    	if (e.getKey() == e.ENTER) {
    		this.w_selBtnClick();
    	}
}

});