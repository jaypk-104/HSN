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

Ext.define('I_AUDIT_BARCODE.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'I_AUDIT_BARCODE.view.MyGridViewModel',
        'I_AUDIT_BARCODE.view.MyGridViewController',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.Text',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing',
        'Ext.grid.filters.Filters'
    ],

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
            }
        ]
    },

    controller: 'mygrid',
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
            width: 60
        },
        {
            xtype: 'gridcolumn',
            hidden: true,
            text: 'V_TYPE'
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 112,
            dataIndex: 'GR_DT',
            text: '입고일자',
            align: 'center',
            format:'Y-m-d'
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 150,
        	dataIndex: 'ITEM_CD',
        	text: '품목코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 200,
            dataIndex: 'PAL_BC_NO',
            text: 'PALLET 바코드번호',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 200,
            dataIndex: 'BOX_BC_NO',
            text: 'BOX 바코드번호',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 200,
            dataIndex: 'LOT_BC_NO',
            text: 'LOT 바코드번호',
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'LOT_QTY',
            text: 'LOT 수량',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
            align: 'right'
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'CHECK_YN',
            text: '바코드확인',
            align: 'center'
        }
    ],
    selModel: {
        selType: 'checkboxmodel',
        checkOnly: true,
        listeners: {
            select: 'onCheckboxModelSelect',
            deselect: 'onCheckboxModelDeselect'
        }
    },
    plugins: [
        {
            ptype: 'gridexporter'
        },
        {
            ptype: 'gridfilters'
        }
    ],
    viewConfig: {
      	enableTextSelection: true,
      	columnLines: true,
    },

});