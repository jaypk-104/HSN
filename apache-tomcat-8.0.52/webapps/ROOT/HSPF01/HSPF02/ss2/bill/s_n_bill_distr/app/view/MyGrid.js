/*
 * File: app/view/MyGrid.js
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

Ext.define('S_N_BILL_DISTR.view.MyGrid', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.myGrid',

	requires : [ 
		'S_N_BILL_DISTR.view.MyGridViewModel', 
		'Ext.view.Table', 
		'Ext.grid.column.RowNumberer', 
		'Ext.grid.column.Number', 
		'Ext.grid.column.Date', 
		'Ext.selection.CheckboxModel', 
		'Ext.grid.plugin.Exporter', 
		'Ext.grid.plugin.CellEditing' 
	],

	viewModel : {
		type : 'mygrid'
	},

	id : 'myGrid',
	store : 'MyStore',
	style : 'border: 1px solid lightgray; padding: 5px;',
	title : 'My Grid Panel',
	header : false,

	config : {
		tbar : [ {
			id : 'gridAddBtn',
			text : '',
			margin : '0 3 0 0',
			glyph : 'xf055@FontAwesome',
			iconCls : 'grid-add-btn',
			hidden: true
		}, {
			id : 'gridDelBtn',
			text : '',
			margin : '0 3 0 0',
			glyph : 'xf056@FontAwesome',
			iconCls : 'grid-del-btn',
			hidden: true
		}, {
			id : 'gridSaveBtn',
			xtype : 'button',
			glyph : 'xf0c7@FontAwesome',
			iconCls : 'grid-save-btn',
			margin : '0 3 0 0',
			hidden: true
		}, {
			xtype : 'container',
			flex : 1
		}, {
			xtype : 'button',
			glyph : 'xf1c3@FontAwesome',
			id : 'xlsxDown',
			cfg : {
				type : 'excel07',
				ext : 'xlsx'
			},
			iconCls : 'grid-excel-btn',
			margin : '0 3 0 0',
		} ]
	},

	viewConfig : {
		enableTextSelection : true,
	},

	columns : [ {
		xtype : 'rownumberer',
		width : 40
	}, {
		xtype : 'gridcolumn',
		text : 'V_TYPE',
		hidden : true,
	}, {
		xtype : 'datecolumn',
		dataIndex : 'DN_DT',
		style : 'text-align: center; font-weight: bold;',
		text : '출고일',
		align : 'center',
		format : 'Y-m-d',
		width : 120
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'ITS_NO',
		style : 'text-align: center; font-weight: bold;',
		text : '출고번호',
		width : 150,
		hidden: true
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'SALE_TYPE',
		style : 'text-align: center; font-weight: bold;',
		text : '출고유형',
		align : 'center',
		width : 100,
		hidden : true
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'SALE_TYPE_NM',
		style : 'text-align: center; font-weight: bold;',
		text : '출고유형',
		width : 120,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'S_BP_CD',
		style : 'text-align: center; font-weight: bold;',
		text : '판매처',
		align : 'center',
		width : 100,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'S_BP_NM',
		style : 'text-align: center; font-weight: bold;',
		text : '판매처명',
		width : 200,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'ITEM_CD',
		style : 'text-align: center; font-weight: bold;',
		text : '품목코드',
		width : 120,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'ITEM_NM',
		style : 'text-align: center; font-weight: bold;',
		text : '품목명',
		width : 200,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'UNIT',
		style : 'text-align: center; font-weight: bold;',
		text : '단위',
		align : 'center',
		width : 100,
	}, {
		xtype : 'numbercolumn',
		dataIndex : 'DN_QTY',
		style : 'text-align: center; font-weight: bold;',
		align : 'end',
		text : '출고수량',
		width : 120,
		format : '0,000',
		summaryType : 'sum',
		summaryRenderer : function(value, summaryData, dataIndex) {
			return "<font color='green'>" + Ext.util.Format.number(value, '0,000') + "<font>";
		},
	}, {
		xtype : 'numbercolumn',
		dataIndex : 'N_BILL_QTY',
		style : 'text-align: center; font-weight: bold;',
		align : 'end',
		text : '미매출수량',
		width : 120,
		format : '0,000',
		summaryType : 'sum',
		summaryRenderer : function(value, summaryData, dataIndex) {
			return "<font color='green'>" + Ext.util.Format.number(value, '0,000') + "<font>";
		},
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'DN_NO',
		style : 'text-align: center; font-weight: bold;',
		text : '출하번호',
		width : 150,
	}, {
		xtype : 'numbercolumn',
		dataIndex : 'DN_SEQ',
		style : 'text-align: center; font-weight: bold;',
		text : '출하순번',
		align : 'end',
		format : '0,000',
		width : 100,
	}, {
		xtype : 'gridcolumn',
		dataIndex : 'REMARK',
		style : 'text-align: center; font-weight: bold;',
		text : '비고',
		width : 200,
	}, ],
	selModel : {
		selType : 'checkboxmodel',
		listeners : {}
	},
	features : [ {
		ftype: 'summary',
        dock: 'bottom'
	} ],
	plugins : [ {
		ptype : 'gridexporter'
	}, {
		ptype : 'cellediting',
		clicksToEdit : 1,
	// listeners : {
	// beforeedit : function(e, editor) {
	// if (e.grid.selection.data.V_TYPE === 'V') {
	// return false;
	// }
	//
	// return true;
	// }
	// }
	} ],

});