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

Ext.define('M_TR_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'M_TR_HSPF.view.MyGridViewModel',
        'M_TR_HSPF.view.MyGridViewController',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Number',
        'Ext.form.field.Number',
        'Ext.grid.column.Date',
        'Ext.form.field.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing'
    ],

    config: {
        tbar: [
            {
                id: 'm_tr_gridAddBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf055@FontAwesome',
                iconCls: 'grid-add-btn'
            },
            {
                id: 'm_tr_gridDelBtn',
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
            width: 40
        },
        {
            xtype: 'gridcolumn',
            hidden: true,
            text: 'V_TYPE'
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'MAKER',
            text: 'MAKER',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'AGENT',
            text: 'AGENT',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'OFFER_NO',
            text: 'OFFER NO',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 150,
            dataIndex: 'PO_NO',
            text: '발주번호',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 80,
        	align: 'end',
        	dataIndex: 'PO_SEQ',
        	text: '발주순번',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 120,
            dataIndex: 'ITEM_CD',
            text: '품목코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 150,
            dataIndex: 'ITEM_NM',
            text: '품명',
        },
//        {
//            xtype: 'gridcolumn',
//            style: 'text-align: center; font-weight: bold;',
//            width: 100,
//            dataIndex: 'ITEM_GROUP_NM',
//            text: '품목그룹명',
//            editor: {
//                xtype: 'textfield',
//                style: 'text-align:left'
//            }
//        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'IN_TERMS',
            text: '가격조건',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'CUR',
            text: '화폐단위',
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'PRICE',
            text: '단가',
            format: '0,000',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'PO_QTY',
            text: '발주수량',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'QTY',
            text: '세부수량',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'DOC_AMT',
            text: '금액',
            renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.00');
            },
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            format: 'Y-m-d',
            dataIndex: 'RTA',
            text: 'RTA',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 120,
            dataIndex: 'LC_DOC_NO',
            text: 'L/C NO.',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'LC_OPEN_DT',
            text: 'L/C OPEN DATE',
            format: 'Y-m-d',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'ETD',
            text: 'ETD',
            format: 'Y-m-d',
            align: 'center',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'ETA',
            text: 'ETA',
            format: 'Y-m-d',
            align: 'center',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'BL_DT',
            text: 'B/L DATE',
            format: 'Y-m-d',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 120,
            dataIndex: 'BL_DOC_NO',
            text: 'B/L NO.',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'DOC_YN',
            text: '선적서류',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'OBL_YN',
            text: 'O/BL 송부',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'IMPORT_DT',
            text: '입항일',
            format: 'Y-m-d',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'FREE_TIME',
            text: 'FREE TIME',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'OVER_DT',
            text: '초과기간',
            format: 'Y-m-d',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'TAX_YN',
            text: '수입신고',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'IN_REQ_DT',
            text: '입고요청일',
            format: 'Y-m-d',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'GR_DT',
            text: '입고일',
            format: 'Y-m-d',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'SL_CD',
            text: '창고코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 110,
            dataIndex: 'SL_NM',
            text: '창고명',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'FOR_BP_CD',
            text: '포워딩코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'FOR_BP_NM',
            text: '포워딩명',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'PAY_METH',
            text: 'PAY_METH(H)',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 100,
        	dataIndex: 'PAY_METH_NM',
        	text: '결제조건',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'INVOICE_DT',
            text: 'INVOICE DATE',
            format: 'Y-m-d',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'DUE_DT',
            text: 'DUE DATE',
            format: 'Y-m-d',
        },
        {
            xtype: 'datecolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'SEND_DT',
            text: '송금일자',
            format: 'Y-m-d',
        },
        {
            xtype: 'numbercolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'DISTB_AMT',
            text: '부대경비',
            format: '0,000',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'REMARK',
            text: '비고',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 100,
        	dataIndex: 'LC_NO',
        	text: 'LC_NO',
        	editor: {
        		xtype: 'textfield',
        		style: 'text-align:left'
        	}
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 100,
        	dataIndex: 'LC_SEQ',
        	text: 'LC_SEQ',
        	editor: {
        		xtype: 'textfield',
        		style: 'text-align:left'
        	}
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 100,
        	dataIndex: 'BL_NO',
        	text: 'BL_NO',
        	editor: {
        		xtype: 'textfield',
        		style: 'text-align:left'
        	}
        },
        {
        	xtype: 'gridcolumn',
        	style: 'text-align: center; font-weight: bold;',
        	width: 100,
        	dataIndex: 'BL_SEQ',	
        	text: 'BL_SEQ',
        	editor: {
        		xtype: 'textfield',
        		style: 'text-align:left'
        	}
        },
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
    ]

});