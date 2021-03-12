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

Ext.define('M_BL_TOTAL_STEEL.view.MyGrid1', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid1',

    requires: [
        'M_BL_TOTAL_STEEL.view.MyGridViewModel1',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Date',
        'Ext.grid.column.Number',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    viewModel: {
        type: 'mygrid1'
    },
    style: 'border: 1px solid lightgray; padding: 5px;',
    header: false,
    title: 'My Grid Panel',
    id: 'myGrid1',
    store: 'MyStore1',
//    tbar: [
//           {
//               xtype: 'container',
//               flex: 1
//           },
//           {
//               xtype: 'button',
//               glyph: 'xf1c3@FontAwesome',
//               id: 'xlsxDown1',
//               cfg: {
//                   type: 'excel07',
//                   ext: 'xlsx'
//               },
//               iconCls: 'grid-excel-btn',
//           }
//       ],
    columns: [
        {
            xtype: 'rownumberer',
            width: 40
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '유형',
            align : 'center',
            dataIndex: 'M_TYPE',
            hidden : true
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '매입처',
            width: 250,
            dataIndex: 'M_BP_NM',
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '브랜드',
            width: 160,
            dataIndex: 'BRAND',
            hidden: true,
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '공장번호',
            width: 80,
            dataIndex: 'TEMP',
            hidden: true
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '품목명',
            width: 150,
            dataIndex: 'ITEM_NM',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	text: '품목코드',
        	width: 170,
        	dataIndex: 'ITEM_CD',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'BL_BOX_QTY',
            text: '박스수량',
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'BL_QTY',
            text: '총중량',
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'LOC_AMT',
            text: '물품액',
            width: 150,
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'DISTB_AMT',
            text: '부대비용',
            format: '0,000',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'M_LOC_AMT',
            text: '매입원가',
            width: 150,
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'M_PRC_AMT',
            text: '1KG 단가',
            format: '0,000',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'GR_BOX_QTY',
            text: '재고박스',
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'GR_QTY',
            text: '재고수량',
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            align: 'end',
            dataIndex: 'GR_AMT',
            text: '재고금액',
            width: 150,
            format: '0,000',
            summaryType: 'sum',
            summaryRenderer: function(value, summaryData, dataIndex) {
                return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
            },
        },
    ],
    viewConfig: {
        height: 155,
    	enableTextSelection: true,
    },
//    selModel: {
//        selType: 'checkboxmodel'
//    },
    plugins: [
        {
            ptype: 'gridexporter'
        },
//        {
//            ptype: 'cellediting'
//        }
    ],
    features: [
        {
     	   ftype: 'summary',
            dock: 'bottom'
        }
     ],
        
});