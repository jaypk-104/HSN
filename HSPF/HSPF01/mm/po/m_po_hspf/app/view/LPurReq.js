/*
 * File: app/view/LPurReq.js
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

Ext.define('M_PO_HSPF.view.LPurReq', {
    extend: 'Ext.container.Container',
    alias: 'widget.lpurreq',

    requires: [
        'M_PO_HSPF.view.LPurReqViewModel',
        'M_PO_HSPF.view.LPurReqViewController',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.Date',
        'Ext.grid.Panel',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.Number',
        'Ext.grid.column.Number',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing'
    ],

    controller: 'lpurreq',
    viewModel: {
        type: 'lpurreq'
    },
    padding: '0 10 0 10',
    width: 500,
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    items: [
        {
            xtype: 'container',
            items: [
                {
                    xtype: 'fieldset',
                    cls: 'gridfieldset',
                    height: 180,
                    maxHeight: 180,
                    minHeight: 180,
                    title: '구매요청정보',
                    layout: {
                        type: 'vbox',
                        align: 'stretch',
                        pack: 'center',
                        padding: 10
                    },
                    items: [
                        {
                            xtype: 'fieldcontainer',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'datefield',
                                    id: 'V_REQ_DT_FR',
                                    maxWidth: 220,
                                    minWidth: 220,
                                    width: 220,
                                    fieldLabel: '요청일자',
                                    labelStyle: 'font-size: 12px',
                                    labelWidth: 80,
                                    name: 'search_field',
                                    format: 'Y-m-d',
                                    listeners : {
                                        render : function(datefield) {
                                        	var nows = new Date();
                                        	nows.setMonth(nows.getMonth()-1);
                                            datefield.setValue(nows);
                                        }	
                                    },
                                },
                                {
                                    xtype: 'datefield',
                                    id: 'V_REQ_DT_TO',
                                    margin: '0 0 0 3',
                                    maxWidth: 150,
                                    minWidth: 150,
                                    width: 150,
                                    fieldLabel: '~',
                                    labelStyle: 'font-size: 12px',
                                    labelWidth: 10,
                                    name: 'search_field',
                                    format: 'Y-m-d',
                                    listeners : {
                                        render : function(datefield) {
                                        	var nows = new Date();
                                        	nows.setMonth(nows.getMonth()+1);
                                            datefield.setValue(nows);
                                        }	
                                    }
                                }
                            ]
                        },
                        {
                            xtype: 'fieldcontainer',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    id: 'V_M_BP_NM',
                                    maxWidth: 220,
                                    minWidth: 220,
                                    width: 220,
                                    fieldLabel: '공급사',
                                    labelStyle: 'font-size: 12px',
                                    labelWidth: 80,
                                    name: 'search_field',
                                    blankText: '',
                                    emptyText: 'Double Click',
                                    listeners: {
                                        afterrender: function(c) {
                                        	c.getEl().on('dblclick', function() {
                                        		var popup = Ext.create("Popup.view.WinMBpPop");
                                                popup.show();
                                                
                                                Ext.getCmp('fieldType').setValue('default');
                                                var store = Ext.getStore('WinMBpPopStore');
                                        		store.removeAll();
                                            });
                                        }
                                    }
                                },
                                {
                                	xtype: 'textfield',
                                	id: 'V_M_BP_CD',
                                	maxWidth: 220,
                                	minWidth: 220,
                                	width: 220,
                                	fieldLabel: 'V_M_BP_CD',
                                	labelStyle: 'font-size: 12px',
                                	labelWidth: 80,
                                	name: 'search_field',
                                	hidden: true
                                }
                            ]
                        },
                        {
                            xtype: 'fieldcontainer',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    flex: 1,
                                    maxWidth: 220,
                                    minWidth: 220,
                                    width: 220,
                                    fieldLabel: '품목코드',
                                    labelWidth: 80,
                                    id: 'V_ITEM_CD',
                                    name: 'search_field',
                                }
                            ]
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'container',
            flex: 1,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
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
                           iconCls: 'grid-del-btn'
                       },
                       {
                           xtype: 'container',
                           flex: 1
                       },
	                    {
	                        id: 'gridPoBtn',
	                        xtype: 'button',
	                        text: '',
	                        width: 50,
	                        glyph: 'xf061@FontAwesome',
	                        iconCls: 'grid-normal-btn'
	                    }
                    ],
                    id: 'myGrid',
                    margin: '-15 -15 0 -15',
                    padding: 10,
                    bodyBorder: false,
                    header: false,
                    store: 'MyStore',
                    viewConfig: {
                        style: ''
                    },
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
                            xtype: 'datecolumn',
                            style: 'text-align: center; font-weight: bold;',
                            align: 'center',
                            dataIndex: 'date',
                            enableTextSelection: true,
                            exportStyle: {
                                format: 'Short Date'
                            },
                            text: '구매요청일',
                            format: 'Y-m-d',
                            editor: {
                                xtype: 'datefield'
                            },
                            dataIndex: 'PUR_DT'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            text: '공급처',
                            editor: {
                                xtype: 'textfield'
                            },
                            dataIndex: 'M_BP_NM',
                            width: 170
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	text: '공급처',
                        	editor: {
                        		xtype: 'textfield'
                        	},
                        	dataIndex: 'M_BP_CD',
                        	hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            text: '품목코드',
                            editor: {
                                xtype: 'textfield'
                            },
                            dataIndex: 'ITEM_CD',
                            width: 150
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            text: '품목명',
                            editor: {
                                xtype: 'textfield'
                            },
                            dataIndex: 'ITEM_NM',
                            width: 200
                        },
                        {
                            xtype: 'numbercolumn',
                            format: '0,000',
                            align: 'right',
                            style: 'text-align: center; font-weight: bold;',
                            text: '요청수량',
                            format: '0,000',
                            align: 'right',
                            editor: {
                                xtype: 'numberfield'
                            },
                            dataIndex: 'PUR_QTY',
                            renderer: function(value) {
                            	return Ext.util.Format.number(value, '0,000.00');
                            }
                        },
                        {
                        	xtype: 'numbercolumn',
                            format: '0,000',
                            align: 'right',
                            style: 'text-align: center; font-weight: bold;',
                            text: '요청잔량',
                            editor: {
                                xtype: 'numberfield'
                            },
                            dataIndex: 'PO_RM_QTY',
                            renderer: function(value) {
                            	return Ext.util.Format.number(value, '0,000.00');
                            }
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            text: '구매요청번호',
                            editor: {
                                xtype: 'numberfield'
                            },
                            dataIndex: 'PUR_NO',
                            width: 150
                            
                        },
                        {
                            xtype: 'numbercolumn',
                            id: 'number2',
                            style: 'text-align: center; font-weight: bold;',
//                            align: 'end',
                            dataIndex: 'number',
                            enableTextSelection: true,
                            exportStyle: {
                                format: 'Currency',
                                alignment: {
                                    horizontal: 'Right'
                                }
                            },
                            text: '구매요청순번',
                            format: '0,000',
                            editor: {
                                xtype: 'numberfield',
                                allowBlank: false,
                                allowExponential: false,
                                minValue: 0
                            },
                            dataIndex: 'PUR_SEQ'
                        },
                    ],
                    selModel: {
                        selType: 'checkboxmodel',
                        listeners: {
                        	select: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', 'V');
                            },
                            deselect: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', '');
                            }
                        }
                    },
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        },
//                        {
//                            ptype: 'rowediting',
//                            clicksToEdit: 1,
//                            clicksToMoveEditor: 1
//                        }
                    ],
                    viewConfig: {
                    	enableTextSelection: true,
                    },
                }
            ]
        }
    ]

});