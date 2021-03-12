/*
 * File: app/view/MyPanel.js
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

Ext.define('S_DN_PAPER.view.MyPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel',

    requires: [
        'S_DN_PAPER.view.MyPanelViewModel',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Number',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    viewModel: {
        type: 'mypanel'
    },
    itemId: 'mypanel',
    layout: 'fit',
    header: false,
    title: 'Tab 1',

    items: [
        {
            xtype: 'container',
            flex: 1,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'gridpanel',
                    flex: 1,
                    style: 'border: 1px solid lightgray; padding: 5px;',
                    header: false,
                    title: 'My Grid Panel',
                    id: 'myGrid',
                    store: 'MyStore',
                    tbar: [
                            {
                                id: 'gridDelBtn0',
                                text: '',
                                margin: '0 3 0 0',
                                glyph: 'xf056@FontAwesome',
                                iconCls: 'grid-del-btn',
                            },
                            {
                                xtype: 'container',
                                flex: 1
                            },
                        ],
                    columns: [
                        {
                            xtype: 'rownumberer',
                            width: 40
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'V_TYPE',
                            text: 'V_TYPE',
                            hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            dataIndex: 'APPROV_NO',
                            text: '품의번호',
                            hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 400,
                            dataIndex: 'APPROV_NM',
                            text: '품의명'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 100,
                            dataIndex: 'S_BP_CD',
                            text: '매출처'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 250,
                            dataIndex: 'S_BP_NM',
                            text: '매출처명'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'SL_NM',
                            text: '창고'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6; ',
                            width: 130,
                            dataIndex: 'BL_CN_NO',
                            text: 'BL/CN NO',
                            editor: {
                            	xtype: 'textfield'
                            }
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'ITEM_CD',
                            text: '품번'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            dataIndex: 'ITEM_NM',
                            text: '품명'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6; ',
                            width: 150,
                            dataIndex: 'ITEM_NM2',
                            text: '품명(요청서표기용)',
                            editor: {
                            	xtype: 'textfield'
                            }
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 120,
                            dataIndex: 'BRAND',
                            text: 'BRAND'
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            align: 'end',
                            dataIndex: 'DN_BON_QTY',
                            text: '본수',
                            format: '0,000.'
                        }, 
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 120,
                        	dataIndex: 'CUSTOM_REQ_FLAG',
                        	text: '고객사출고'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 120,
                            dataIndex: 'DN_NO',
                            text: 'DN_NO',
                            hidden: true
                        }, 
                        {

                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 120,
                            dataIndex: 'DN_SEQ',
                            text: 'DN_SEQ',
                            hidden: true
                        
                        }
                    ],
                    viewConfig: {
                    	enableTextSelection: true,
                    	getRowClass: function(record, index) {
                            var CUSTOM_REQ_FLAG = record.get('CUSTOM_REQ_FLAG'); 
                            if(CUSTOM_REQ_FLAG == 'Y') {
                            	return 'bg-blue';
                            }
                        },
                    },
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
                        {
                            ptype: 'cellediting'
                        }
                    ],
                	features : [ {
                		ftype : 'summary'
                	} ],
                }
            ]
        }
    ]

});