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

Ext.define('M_PO_PLAN_LOCAL_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'M_PO_PLAN_LOCAL_HSPF.view.MyGridViewModel',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Number',
        'Ext.form.field.Number',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    config: {
        tbar: [
            {
                id: 'gridAddBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf055@FontAwesome',
                iconCls: 'grid-add-btn'
            },
            {
                id: 'gridDelBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf056@FontAwesome',
                iconCls: 'grid-del-btn'
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

    viewModel: {
        type: 'mygrid'
    },
    id: 'myGrid',
    style: 'border: 1px solid #659DDC; padding: 5px;',
    bodyBorder: false,
    header: false,
    store: 'MyStore',

    columns: [
        {
            xtype: 'rownumberer',
            width: 40
        },
        {
            xtype: 'gridcolumn',
            hidden: true,
            text: 'V_TYPE'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'ITEM_CD',
            enableTextSelection: true,
            text: '품목코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            dataIndex: 'ITEM_NM',
            enableTextSelection: true,
            text: '품목명',
            width: 130,
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'M_BP_CD',
            enableTextSelection: true,
            text: '납품처코드',
            width: 100
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'BP_NM',
            enableTextSelection: true,
            text: '납품처명',
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 113,
            sortable: true,
            dataIndex: 'BP_ITEM_CD',
            enableTextSelection: true,
            text: '거래처품목코드',
        },
        {
            xtype: 'gridcolumn',
            id: 'BP_ITEM_NM',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'BP_ITEM_NM',
            enableTextSelection: true,
            text: '거래처품목명',
            width: 130
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'M_USAGE',
            enableTextSelection: true,
            text: '월소요량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'D_USAGE',
            enableTextSelection: true,
            text: '일소요량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'SAFE_QTY',
            enableTextSelection: true,
            text: '안전재고량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'MIN_PO_QTY',
            enableTextSelection: true,
            text: '최소발주량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'AVG_DN_QTY',
            enableTextSelection: true,
            text: '월평균출고량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
            width: 130
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'STOCK_QTY',
            enableTextSelection: true,
            text: '현재고',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'datecolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'STOCK_DAY',
            enableTextSelection: true,
            text: '재고일수',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'PO_QTY',
            enableTextSelection: true,
            text: '발주량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            }
        },
        {
            xtype: 'datecolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'NEW_DLV_DT',
            enableTextSelection: true,
            text: '최신납기예정일',
            align: 'center',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'NEW_DLV_QTY',
            enableTextSelection: true,
            text: '최신납기예정수량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
            width: 130
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'FT_DN_QTY',
            enableTextSelection: true,
            text: '출고예정수량',
            align: 'right',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
            width: 130
        }
    ],
    selModel: {
        selType: 'checkboxmodel',
        mode: 'SINGLE'
    },
    plugins: [
        {
            ptype: 'gridexporter'
        },
        {
            ptype: 'cellediting'
        }
    ]

});