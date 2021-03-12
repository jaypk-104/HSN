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

Ext.define('M_PROD_PLAN_MNTH_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'M_PROD_PLAN_MNTH_HSPF.view.MyGridViewModel',
        'M_PROD_PLAN_MNTH_HSPF.view.MyGridViewController',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.Number',
        'Ext.form.field.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing',
        'Ext.grid.filters.Filters'
    ],

    config: {
        tbar: [
            {
                xtype: 'datefield',
                fieldLabel: '발주요청일',
                margin: '0 3 0 0',
                format: 'YYYY-mm-dd',
                style: 'font-size: 12px'
            },
            {
                id: 'gridPurRequestBtn',
                xtype: 'button',
                text: '발주요청생성',
                margin: '0 3 0 0'
            },
            {
                id: 'gridPurCancelBtn',
                xtype: 'button',
                text: '발주요청취소',
                margin: '0 3 0 0'
            },
            {
                xtype: 'container',
                flex: 1
            },
            {
                xtype: 'button',
                text: 'Export',
                menu: {
                    defaults: {
                        handler: 'gridExportBtn'
                    },
                    items: [
                        {
                            id: 'xlsxDown',
                            text: 'Excel xlsx',
                            cfg: {
                                type: 'excel07',
                                ext: 'xlsx'
                            }
                        },
                        {
                            id: 'xmlDown',
                            text: 'Excel xml',
                            cfg: {
                                type: 'excel03',
                                ext: 'xml'
                            }
                        },
                        {
                            id: 'pdfDown',
                            text: 'PDF',
                            cfg: {
                                type: 'pdf'
                            }
                        }
                    ]
                }
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
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            sortable: true,
            dataIndex: 'BP_CD',
            enableTextSelection: true,
            text: '거래처코드',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '필수 입력사항입니다.'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'BP_NM',
            text: '거래처명',
            editor: {
                xtype: 'textfield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 114,
            dataIndex: 'BP_ITEM_CD',
            text: '판매처 품목코드',
            editor: {
                xtype: 'textfield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 106,
            dataIndex: 'BP_ITEM_NM',
            text: '판매처 품목명',
            editor: {
                xtype: 'textfield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'ITEM_CD',
            text: '품목코드',
            editor: {
                xtype: 'textfield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'ITEM_NM',
            text: '품목명',
            editor: {
                xtype: 'textfield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 124,
            align: 'end',
            dataIndex: 'PRD_PLAN_QTY',
            text: '월간생산계획수량',
            editor: {
                xtype: 'numberfield',
                minValue: 0
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            align: 'center',
            dataIndex: 'PUR_DT',
            text: '발주요청일',
            editor: {
                xtype: 'datefield'
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'PUR_QTY',
            text: '발주요청수량',
            editor: {
                xtype: 'numberfield',
                style: '',
                minValue: 0
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'PRD_NO',
            text: '생산계획번호',
            editor: {
                xtype: 'numberfield',
                style: '',
                minValue: 0
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 11px; text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'PRD_SEQ',
            text: '생산계획순번',
            editor: {
                xtype: 'numberfield',
                style: '',
                minValue: 0
            }
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
            ptype: 'rowediting',
            clicksToEdit: 1,
            clicksToMoveEditor: 1
        },
        {
            ptype: 'gridfilters'
        }
    ]

});