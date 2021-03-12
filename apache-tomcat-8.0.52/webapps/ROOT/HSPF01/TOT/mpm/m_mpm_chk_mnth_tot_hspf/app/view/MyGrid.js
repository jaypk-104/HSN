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

Ext.define('M_MPM_CHK_MNTH_TOT_HSPF.view.MyGrid', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.myGrid',

	requires : [ 
		'M_MPM_CHK_MNTH_TOT_HSPF.view.MyGridViewModel', 
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
		tbar : [
		//		{
		//			id : 'gridAddBtn',
		//			text : '',
		//			margin : '0 3 0 0',
		//			glyph : 'xf055@FontAwesome',
		//			iconCls : 'grid-add-btn',
		//		}, {
		//			id : 'gridDelBtn',
		//			text : '',
		//			margin : '0 3 0 0',
		//			glyph : 'xf056@FontAwesome',
		//			iconCls : 'grid-del-btn',
		//		}, {
		//			id : 'gridSaveBtn',
		//			xtype : 'button',
		//			glyph : 'xf0c7@FontAwesome',
		//			iconCls : 'grid-save-btn',
		//			margin : '0 3 0 0'
		//		},
		{
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
		xtype : 'numbercolumn',
		dataIndex : 'GR_QTY',
		style : 'text-align: center; font-weight: bold;',
		align : 'end',
		text : '입고수량',
		width : 120,
		format : '0,000.00',
		summaryType : 'sum',
		summaryRenderer : function(value, summaryData, dataIndex) {
			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.00') + "<font>";
		},
	}, {
		xtype : 'numbercolumn',
		dataIndex : 'DN_QTY',
		style : 'text-align: center; font-weight: bold;',
		align : 'end',
		text : '출고수량',
		width : 120,
		format : '0,000.00',
		summaryType : 'sum',
		summaryRenderer : function(value, summaryData, dataIndex) {
			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.00') + "<font>";
		},
	}, ],
	selModel : {
		selType : 'checkboxmodel',
		listeners : {}
	},
	features : [ {
		ftype : 'summary',
		dock : 'bottom'
	} ],
	plugins : [ {
		ptype : 'gridexporter'
	}, {
		ptype : 'cellediting',
		clicksToEdit : 1,
	} ],

});