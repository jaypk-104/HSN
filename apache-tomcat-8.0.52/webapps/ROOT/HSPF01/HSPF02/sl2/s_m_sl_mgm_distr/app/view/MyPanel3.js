/*
 * File: app/view/MyPanel1.js
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

Ext.define('S_M_SL_MGM_DISTR.view.MyPanel3', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel3',

    requires: [
        'S_M_SL_MGM_DISTR.view.MyPanelViewModel3',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing',
        'Ext.grid.column.Number'
    ],

    viewModel: {
        type: 'mypanel3'
    },
    layout: 'fit',
    title: 'Tab 4',

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
                    store: 'MyStore3',
                    id: 'myGrid3',
	                tbar: [
	                	{
		                      xtype: 'container',
		                      flex: 1
		                },
		                {
		    				xtype : 'datefield',
		    				maxWidth : 200,
		    				minWidth : 200,
		    				width : 200,
		    				fieldLabel : '전표일자',
		    				labelWidth : 60,
		    				editable : false,
		    				format : 'Y-m-d',
		    				id : 'V_TEMP_GL_DT2',
		    			}, {
		    				xtype : 'button',
		    				id : 'slBnCfmBtn',
		    				margin : '0 3 0 0',
		    				text : 'ERP전표생성',
		    				style : 'background-color: white; border: 0.5px solid #3367d6;',
		    				cls : 'blue-btn',
		    			}, {
		    				xtype : 'button',
		    				id : 'slBnCancelBtn',
		    				margin : '0 3 0 0',
		    				text : 'ERP전표취소',
		    				style : 'background-color: white; border: 0.5px solid #3367d6;',
		    				cls : 'blue-btn',
		    			},
		                {
		                      xtype: 'button',
		                      glyph: 'xf1c3@FontAwesome',
		                      id: 'xlsxDown3',
		                      cfg: {
		                          type: 'excel07',
		                          ext: 'xlsx'
		                      },
		                      iconCls: 'grid-excel-btn',
		                }
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
                            width: 250,
                            dataIndex: 'BP_NM',
                            text: '매출처',
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            align: 'end',
                            dataIndex: 'SL_AMT',
                            text: '창고료',
                            format: '0,000',
                            summaryType: 'sum',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                	            return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
                	        },
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            align: 'end',
                            dataIndex: 'VAT_AMT',
                            text: '부가세',
                            format: '0,000',
                            summaryType: 'sum',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                	            return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
                	        },
                        }, 
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            align: 'end',
                            dataIndex: 'TOT_AMT',
                            text: '합계',
                            format: '0,000',
                            summaryType: 'sum',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                	            return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
                	        },
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 80,
                            align: 'center',
                            dataIndex: 'GL_YN',
                            text: '전표유무',
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            align: 'center',
                            dataIndex: 'TEMP_GL_NO',
                            text: '전표번호',
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 120,
                        	align: 'center',
                        	dataIndex: 'SALE_ISSUE_DT',
                        	text: '수금만기일',
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 250,
                            dataIndex: 'REMARK',
                            text: '비고',
                        },
                    ],
                    selModel : {
        				selType : 'checkboxmodel',
        				checkOnly : true,
        				listeners : {
        					select : function(rowmodel, record, index, eOpts) {
        						record.set('V_TYPE', 'V');
        					},
        					deselect : function(rowmodel, record, index, eOpts) {
        						record.set('V_TYPE', '');
        					}
        				}
        			},
                    viewConfig: {
                    	enableTextSelection: true,
                        },
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        },
                    ],
                    features : [ {
                		ftype: 'summary',
                        dock: 'bottom'
                	} ]
                },
            ]
        }
    ]

});