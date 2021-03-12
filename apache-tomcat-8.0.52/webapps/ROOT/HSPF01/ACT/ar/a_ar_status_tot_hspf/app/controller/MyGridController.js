/*
 * File: app/controller/MyGridController.js
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

Ext.define('A_AR_STATUS_TOT_HSPF.controller.MyGridController', {
	extend : 'Ext.app.Controller',
	stores: ['MyStore','MyStore1','MyStore2','MyStore3'],
	control : {
		"#myGrid" : {
			cellclick : 'myGridClick'
		},
		"#myGrid2" : {
			cellclick : 'myGrid2Click'
		},
		"#xlsxDown" : {
			click : 'xlsxDownClick'
		},
		"#xlsxDown1" : {
			click : 'xlsxDown1Click'
		},
		"#xlsxDown2" : {
			click : 'xlsxDown2Click'
		},
		"#xlsxDown3" : {
			click : 'xlsxDown3Click'
		},
		"#xlsxDown4" : {
			click : 'xlsxDown4Click'
		},
	},
	
	myGridClick : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
    	var gridRecord = Ext.getCmp('myGrid').getSelectionModel().getSelection()[0];
    	var store1 = Ext.getStore('MyStore1');
		store1.removeAll();
		
		if (!!gridRecord.get('AR_NO')) {
			store1.load({
				params : {
					V_TYPE : 'SD1',
					V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
					V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
					V_BS_DT: Ext.getCmp('V_BS_DT').getValue(),
					V_REF_NO : gridRecord.get('AR_NO'),
				},
				callback : function(records, operations, success) {
				}
			});
		}
	},
	
	myGrid2Click : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
    	var gridRecord = Ext.getCmp('myGrid2').getSelectionModel().getSelection()[0];
    	var store3 = Ext.getStore('MyStore3');
		store3.removeAll();
		
		if (!!gridRecord.get('BC_NO')) {
			store3.load({
				params : {
					V_TYPE : 'SD2',
					V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
					V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
					V_BS_DT: Ext.getCmp('V_BS_DT').getValue(),
					V_REF_NO : gridRecord.get('BC_NO'),
				},
				callback : function(records, operations, success) {
				}
			});
		}
	},
	
	xlsxDownClick : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '채권 기준', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},
	
	xlsxDown1Click : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid1');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '미정리예금/어음 기준', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},
	
	xlsxDown2Click : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid2');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '채권 기준 조회', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},
	
	xlsxDown3Click : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid3');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '미정리예금 기준 조회', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},
	
	xlsxDown4Click : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid4');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '부서/거래처 기준', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},

});