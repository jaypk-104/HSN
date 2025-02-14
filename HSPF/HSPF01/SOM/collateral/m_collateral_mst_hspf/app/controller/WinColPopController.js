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

Ext.define('M_COLLATERAL_MST_HSPF.controller.WinColPopController', {
	extend : 'Ext.app.Controller',
	stores : [ 'MyStore', 'ColStore' ],
	control : {
		"#w_colSelBtn" : {
			click : 'w_colSelBtnClick'
		},
		'#w_colRegBtn' : {
			click : 'w_colRegBtnClick'
		},
		'#colGrid' : {
			celldblclick : 'w_colGridDblClick'
		},
		"textfield[name=col_search]" : {
			specialkey : 'tfEnter'
		}
	},

	w_colSelBtnClick : function() {
		var colStore = this.getColStoreStore();
		colStore.load({
			params : {
				V_TYPE : 'P',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_ASGN_DT_FR : Ext.getCmp('V_ASGN_DT_FR').getValue(),
				V_ASGN_DT_TO : Ext.getCmp('V_ASGN_DT_TO').getValue(),
				V_DB_TYPE : 'B',
				V_USE_YN : Ext.getCmp('rbY').getValue() ? 'Y' : Ext.getCmp('rbN').getValue() ? 'N' : ''
			},
			callback : function(records, operations, success) {

			}
		});

	},
	
	w_colRegBtnClick : function() {
		var popWin = Ext.getCmp('WinColPop');
		popWin.destroy();
	},
	
	w_colGridDblClick : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
		Ext.getCmp('V_COLLATERAL_NO').setValue(record.get('COLLATERAL_NO'));

		var store = this.getMyStoreStore();
    	store.removeAll();
    	
    	Ext.Ajax.request({
			url : 'sql/M_COLLATERAL_MST_HSPF.jsp',
			method : 'post',
			params : {
				V_TYPE: 'SH',
    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
    			V_COLLATERAL_NO: Ext.getCmp('V_COLLATERAL_NO').getValue(),
			},
			success : function(response) {
				var res = Ext.JSON.decode(response.responseText).resultList[0];

				if(res != null){
					Ext.getCmp('V_COL_NO').setValue(Ext.getCmp('V_COLLATERAL_NO').getValue());
					Ext.getCmp('V_DEPT_CD').setValue(res.DEPT_CD);
					Ext.getCmp('V_BP_NM').setValue(res.BP_NM);
					Ext.getCmp('V_ASGN_DT').setValue(res.ASGN_DT);
					Ext.getCmp('V_RENEW_DT').setValue(res.RENEW_DT);
					Ext.getCmp('V_EFFECTIVE_DT').setValue(res.EFFECTIVE_DT);
					Ext.getCmp('V_DEL_DT').setValue(res.DEL_DT);
					Ext.getCmp('V_EXPIRY_DT').setValue(res.EXPIRY_DT);
					Ext.getCmp('V_STOCK_NO').setValue(res.STOCK_NO);
					Ext.getCmp('V_WARNT_ORG_NM').setValue(res.WARNT_ORG_NM);
					Ext.getCmp('V_DB_TYPE2').setValue(res.DB_TYPE2);
					Ext.getCmp('V_ASGN_AMT').setValue(res.ASGN_AMT);
					Ext.getCmp('V_REMARK').setValue(res.REMARK);
					
					Ext.getCmp('V_BP_NM').setDisabled(true);
					Ext.getCmp('V_DB_TYPE2').setDisabled(true);
					Ext.getCmp('V_DEPT_CD').setDisabled(true);
					Ext.getCmp('V_ASGN_DT').setDisabled(true);
					Ext.getCmp('V_RENEW_DT').setDisabled(true);
					Ext.getCmp('V_EFFECTIVE_DT').setDisabled(true);
					Ext.getCmp('V_DEL_DT').setDisabled(true);
					Ext.getCmp('V_EXPIRY_DT').setDisabled(true);
//					Ext.getCmp('V_COL_NO').setEditable(false);
					Ext.getCmp('V_STOCK_NO').setEditable(false);
					Ext.getCmp('V_WARNT_ORG_NM').setEditable(false);
					Ext.getCmp('V_ASGN_AMT').setEditable(false);
					Ext.getCmp('V_REMARK').setEditable(false);
					
					Ext.getCmp('saveBtn').setDisabled(true);
				
				// [첫번째 그리드] 조회
				store.load({
		    		params: {
		    			V_TYPE: 'DS',
		    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
		    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
		    			V_COLLATERAL_NO: Ext.getCmp('V_COLLATERAL_NO').getValue(),
		    		},
		    		callback: function(records,operations,success){
		    		}
		    	});

				}
			}
		});
		
		var popWin = Ext.getCmp('WinColPop');
		popWin.destroy();
	},

	tfEnter : function(field, e, eOpts) {
		if (e.getKey() == e.ENTER) {
			this.w_colSelBtnClick();
		}
	}

});
