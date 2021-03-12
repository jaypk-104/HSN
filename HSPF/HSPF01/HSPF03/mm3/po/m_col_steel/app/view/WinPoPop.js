/*
 * File: app/view/WinPoPop.js
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

Ext.define('M_COL_STEEL.view.WinPoPop', {
	extend : 'Ext.window.Window',
	alias : 'widget.winpopop',

	requires : [ 'M_COL_STEEL.view.WinAddRowViewModel1', 'Ext.form.FieldSet', 'Ext.form.field.Date', 'Ext.grid.Panel', 'Ext.view.Table', 'Ext.grid.column.RowNumberer', 'Ext.grid.column.Date', 'Ext.grid.column.Number', 'Ext.form.field.Number', 'Ext.selection.CheckboxModel', 'Ext.grid.plugin.Exporter', 'Ext.button.Button' ],

	viewModel : {
		type : 'winpopop'
	},
	id: 'WinPoPop',
	modal : true,
	height : 567,
	width : 917,
	title : '발주참조',

	layout : {
		type : 'vbox',
		align : 'stretch'
	},
	items : [ {
		xtype : 'container',
		modal : true,
		shim : false,
		padding : 10,
		layout : 'center',
		items : [ {
			xtype : 'fieldset',
			height : 80,
			maxHeight : 80,
			minHeight : 80,
			title : '',
			layout : {
				type : 'hbox',
				align : 'middle'
			},
			items : [

			{
				xtype : 'datefield',
				flex : 1,
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '발주일자',
				labelWidth : 80,
				listeners : {
					render : function(datefield) {
						var nows = new Date('2018-01-01');
//						nows.setDate(1);
						datefield.setValue(nows);
					}
				},
				format : 'Y-m-d',
				altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
				id : 'V_PO_DT_FR',
				name: 'po_search'
			}, {
				xtype : 'datefield',
				maxWidth : 160,
				minWidth : 160,
				width : 160,
				fieldLabel : '~',
				labelWidth : 10,
				listeners : {
					render : function(datefield) {
						var nows = new Date();
						datefield.setValue(nows);
					}
				},
				format : 'Y-m-d',
				altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
				id : 'V_PO_DT_TO',
				name: 'po_search'
			}, {
				xtype : 'textfield',
				flex : 1,
				margin : '0 0 0 30',
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '공급사명',
				labelWidth : 80,
				emptyText : '(Double Click)',
				id : 'W_M_BP_NM',
				name: 'po_search'
			}, {
				xtype : 'textfield',
				flex : 1,
				margin : '0 0 0 30',
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '품의번호',
				labelWidth : 80,
				id : 'W_APPROV_NO',
				name: 'po_search'
			}, {

				xtype : 'textfield',
				flex : 1,
				margin : '0 0 0 30',
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '발주번호',
				labelWidth : 80,
				id : 'W_PO_NO',
				name: 'po_search'
			
			}]
		} ]
	}, {
		xtype : 'container',
		flex : 1,
		layout : 'fit',
		items : [ {
			xtype : 'gridpanel',
			flex : 1,
			style : 'padding: 10px;',
			bodyBorder : false,
			header : false,
			store : 'PopStore',
			id: 'popGrid',
			viewConfig: {
            	enableTextSelection: true,
            	getRowClass: function(record, index) {
                    var PO_CFM = record.get('PO_CFM'); //발주확정유무 
//                    console.log(PO_CFM);
                    if(PO_CFM == 'Y') {
                    	return 'bg-green'
                    }
                },
            },
			columns : [ {
				xtype : 'rownumberer',
				width : 40
			}, {
				xtype : 'gridcolumn',
				hidden : true,
				text : 'V_TYPE'
			}, 
			{
				xtype : 'gridcolumn',
				dataIndex : 'PO_NO',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				enableTextSelection : true,
				text : '발주번호',
				width: 170
			},
			{
				xtype : 'gridcolumn',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				dataIndex : 'APPROV_NO',
				enableTextSelection : true,
				text : '품의번호',
				width: 170
			},{
				xtype : 'gridcolumn',
				dataIndex : 'M_BP_CD',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				enableTextSelection : true,
				text : '매입처',
				hidden: true
			}, {
				xtype : 'gridcolumn',
				dataIndex : 'M_BP_NM',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				enableTextSelection : true,
				text : '매입처',
				width: 250
			},{
				xtype : 'gridcolumn',
				dataIndex : 'S_BP_CD',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				enableTextSelection : true,
				text : '매출처',
				hidden: true
			},{
				xtype : 'gridcolumn',
				dataIndex : 'S_BP_NM',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				enableTextSelection : true,
				text : '매출처',
				width: 250
			},{
				xtype : 'datecolumn',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				dataIndex : 'PO_DT',
				enableTextSelection : true,
				text : '발주일자',
				format : 'Y-m-d',
			}, {
				xtype : 'numbercolumn',
				style : 'text-align: center; font-weight: bold;',
				align : 'end',
				dataIndex : 'PO_AMT',
				enableTextSelection : true,
				text : '발주금액',
				format : '0,000.00',
			},{
				xtype : 'numbercolumn',
				style : 'text-align: center; font-weight: bold;',
				align : 'end',
				dataIndex : 'PO_LOC_AMT',
				enableTextSelection : true,
				text : '발주총금액',
				format : '0,000.00',
				width: 170
			}, {
				xtype : 'gridcolumn',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				dataIndex : 'PO_USR_NM',
				enableTextSelection : true,
				text : '발주자',
			},
			{

				xtype : 'gridcolumn',
				style : 'text-align: center; font-weight: bold;',
				sortable : true,
				dataIndex : 'COL_MGM_NO',
				enableTextSelection : true,
				text : 'COL_MGM_NO',
				hidden: true
			
			}
			],
			plugins : [ {
				ptype : 'gridexporter'
			} ]
		} ]
	} ],
	dockedItems : [ {
		xtype : 'container',
		dock : 'bottom',
		margin : '0 0 3 0',
		width : 100,
		layout : {
			type : 'hbox',
			align : 'middle',
			pack : 'center'
		},
		items : [ {
			xtype : 'button',
			height : 30,
			id : 'w_poSelBtn',
			maxHeight : 30,
			minHeight : 30,
			width : 100,
			text : '조회'
		}, {
			xtype : 'button',
			height : 30,
			id : 'w_poRegBtn',
			margin : '0 0 0 3',
			maxHeight : 30,
			minHeight : 30,
			width : 100,
			text : '선택',
			hidden: true
		} ]
	} ]

});