/*
 * File: app/view/MyWindow1.js
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

Ext.define('S_TAX_STEEL.view.MyWindow1', {
    extend: 'Ext.window.Window',
    alias: 'widget.mywindow1',

    requires: [
        'S_TAX_STEEL.view.MyWindowViewModel1',
        'Ext.form.field.Date',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.view.Table',
        'Ext.button.Button'
    ],

    viewModel: {
        type: 'mywindow1'
    },
    height: 548,
    width: 889,
    title: '세금계산서조회',
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    id: 'WinTaxPop',
    dockedItems: [
        {
            xtype: 'container',
            dock: 'top',
            height: 50,
            maxHeight: 50,
            minHeight: 50,
            width: 100,
            layout: {
                type: 'hbox',
                align: 'middle'
            },
            items: [
                {
                    xtype: 'datefield',
                    flex: 1,
                    margins: '',
                    id: 'W_TAX_DT_FR',
                    margin: '0 0 0 30',
                    maxWidth: 250,
                    minWidth: 250,
                    width: 250,
                    fieldLabel: '매출일자',
                    listeners : {
                        render : function(datefield) {
                        	var nows = new Date();
                        	nows.setMonth(nows.getMonth() - 1);
                        	nows.setDate(1);
                            datefield.setValue(nows);
                        }	
                    },
                    format: 'Y-m-d',
                    altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
                },
                {
                    xtype: 'datefield',
                    flex: 1,
                    id: 'W_TAX_DT_TO',
                    maxWidth: 170,
                    minWidth: 170,
                    width: 170,
                    fieldLabel: '~',
                    labelWidth: 15,
                    listeners : {
                        render : function(datefield) {
                        	var nows = new Date();
                            datefield.setValue(nows);
                        }	
                    },
                    format: 'Y-m-d',
                    altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
                    name: 'pop_search'
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    id: 'W_S_BP_NM',
                    maxWidth: 230,
                    minWidth: 230,
                    width: 230,
                    fieldLabel: '매출처',
                    labelAlign: 'right',
                    labelWidth: 80,
                    name: 'pop_search',
                    listeners: {
                        afterrender: function(c) {
                        	c.getEl().on('dblclick', function() {
                    			var popup = Ext.create("Popup.view.WinSBpPop");
                    			popup.show();
                    			
                    			Ext.getCmp('fieldType').setValue('S_TAX_STEEL_W');
                    			var store = Ext.getStore('WinSBpPopStore');
                    			store.removeAll();
                            });
                        }
                    },
                }
            ]
        }
    ],
    items: [
        {
            xtype: 'gridpanel',
            flex: 1,
            header: false,
            title: 'My Grid Panel',
            store: 'PopStore',
            id: 'popGrid',
            columns: [
                {
                    xtype: 'rownumberer'
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'TAX_BILL_NO',
                    text: '세금계산서관리번호',
                    width: 150
                },
                {
                	xtype: 'gridcolumn',
                	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                	dataIndex: 'TAX_DOC_NO',
                	text: '세금계산서번호',
                	width: 150
                },
                {
                    xtype: 'datecolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'ISSUED_DT',
                    text: '발행일자',
                    format: 'Y-m-d',
                    align: 'center'
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'S_BP_CD',
                    text: '매출처코드'
                },
                {
                	xtype: 'gridcolumn',
                	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                	dataIndex: 'S_BP_NM',
                	text: '매출처명',
                    width: 200
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'TAX_BILL_TYPE_NM',
                    text: '매출채권형태'
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    width: 110,
                    dataIndex: 'VAT_INC',
                    text: '부가세포함여부',
                    align: 'center',
                    hidden: true
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'CFM_YN',
                    text: '확정여부',
                    align: 'center',
                    hidden: true
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'TEMP_GL_NO',
                    text: '전표번호',
                    width: 150
                },
                {
                    xtype: 'numbercolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'BILL_LOC_AMT',
                    text: '세금계산서금액',
                    format: '0,000',
                    align: 'end',
                    width: 150
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'TAX_BILL_YN',
                    text: '세금계산서 유무',
                    align: 'center'
                },
                {
                    xtype: 'gridcolumn',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    dataIndex: 'TAX_BILL_SEND_YN',
                    text: '세금계산서 발행 유무',
                    align: 'center'
                },
                {
                	xtype: 'gridcolumn',
                	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                	dataIndex: 'CR_TYPE',
                	text: 'CR_TYPE',
                	align: 'center',
                	hidden: true
                },
                {
                	xtype: 'gridcolumn',
                	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                	dataIndex: 'LOGIS_STATUS',
                	text: '로지스빌 상태',
                	width: 150
                },
            ]
        },
        {
            xtype: 'container',
            height: 50,
            maxHeight: 50,
            minHeight: 50,
            layout: {
                type: 'hbox',
                align: 'middle',
                pack: 'center'
            },
            items: [
                {
                    xtype: 'button',
                    flex: 1,
                    id: 'w_selBtn1',
                    maxWidth: 100,
                    minWidth: 100,
                    width: 100,
                    text: '조회'
                }
            ]
        }
    ]

});