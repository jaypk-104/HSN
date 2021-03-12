/*
 * File: app/view/MyGrid.js
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

Ext.define('CUS_DN_DAILY.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'CUS_DN_DAILY.view.MyGridViewModel',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Date',
        'Ext.grid.column.Number',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    viewModel: {
        type: 'mygrid'
    },
    style: 'border: 1px solid lightgray; padding: 5px;',
    header: false,
    title: 'My Grid Panel',
    store: 'MyStore',
    id: 'myGrid',
    config: {
        tbar: [
			{
			    id: 'gridAddBtn',
			    text: '',
			    margin: '0 3 0 0',
			    glyph: 'xf055@FontAwesome',
			    iconCls: 'grid-add-btn',
			    disabled: true
			},
			{
			    id: 'gridDelBtn',
			    text: '',
			    margin: '0 3 0 0',
			    glyph: 'xf056@FontAwesome',
			    iconCls: 'grid-del-btn',
			    disabled: true
			},
            {
                xtype: 'container',
                flex: 1
            },
            {
                xtype: 'button',
                glyph: 'xf1c3@FontAwesome',
                id: 'xlsxDown',
                cfg: {
                    type: 'excel07',
                    ext: 'xlsx'
                },
                iconCls: 'grid-excel-btn',
                margin: '0 3 0 0',
                
            }
        ]
    },
    columns: [
        {
            xtype: 'rownumberer',
            width: 40
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 150,
            dataIndex: 'BL_DOC_NO',
            text: 'B/L번호'
        },
        {
            xtype: 'datecolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '출고일',
            dataIndex:'DN_DT',
            format: 'Y-m-d'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'REGION_NM',
            text: '지역',
            align: 'center'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 160,
            dataIndex: 'SL_NM',
            text: '창고명'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            dataIndex: 'ITEM_NM',
            text: '품목명'
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_BOX_QTY',
            text: '출고박스수량',
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_BOX_WGT_UNIT',
            text: '단위중량',
            format: '0,000.00',
            hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_QTY',
            text: '출고요청중량',
            format: '0,000.00',
            width: 120,
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000.00')+"<font>"; 
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_LOC_AMT',
            text: '출고요청금액',
            width: 130,
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            }
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	align: 'end',
        	dataIndex: 'DN_REQ_PRC',
        	text: '출고요청단가',
        	width: 130,
        	format: '0,000.00',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_REAL_QTY',
            text: '계근중량',
            width: 120,
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000.00')+"<font>"; 
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DN_FINAL_AMT',
            text: '실출고금액',
            width: 130,
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
            format: '0,000',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'IN_AMT',
            text: '입금금액',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
            format: '0,000',
            hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'NON_IN_AMT',
            text: '미입금금액',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
            format: '0,000',
            hidden: true
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	align: 'end',
        	dataIndex: 'DIFF_AMT',
        	text: '차이',
        	summaryType: 'sum',
        	summaryRenderer: function(value, summaryData, dataIndex) {
        		return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
        	},
        	format: '0,000',
            tdCls: 'x-change-cell' 	,
//        	hidden: true
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 110,
            dataIndex: 'PLANT_NO',
            text: '공장번호'
        }
    ],
    viewConfig: {
		enableTextSelection : true,
		getRowClass: function(record, index) {
            var DIFF_AMT = record.get('DIFF_AMT'); 
            if(DIFF_AMT < 0) {
            	return 'bold-cell';
            }
        },
	},
    selModel: {
        selType: 'checkboxmodel'
    },
    plugins: [
        {
            ptype: 'gridexporter'
        },
        {
            ptype: 'cellediting'
        }
    ],
    features: [
               {
            	   ftype: 'summary',
                   dock: 'bottom'
               }
            ],

});