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

Ext.define('M_SL_TRANS_DISTR.view.MyPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel',

    requires: [
        'M_SL_TRANS_DISTR.view.MyPanelViewModel',
        'M_SL_TRANS_DISTR.view.MyPanelViewController',
        'Ext.form.Panel',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.Date',
        'Ext.form.field.ComboBox',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Date',
        'Ext.grid.column.Number',
        'Ext.grid.column.Check',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    controller: 'mypanel',
    viewModel: {
        type: 'mypanel'
    },
    itemId: 'mypanel',
    layout: 'fit',
    title: 'Tab 1',
    id: 'tab1',
    
    
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
                    xtype: 'form',
                    layout: 'auto',
                    bodyPadding: '0 10 0 10',
                    header: false,
                    title: 'My Form',
                    items: [
                        {
                            xtype: 'fieldset',
                            height: 150,
                            maxHeight: 150,
                            minHeight: 150,
                            title: '[ Search ]',
                            collapsible: true,
                            layout: {
                                type: 'vbox',
                                align: 'stretch',
                                pack: 'center'
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
                                            xtype: 'textfield',
                                            maxWidth: 250,
                                            minWidth: 250,
                                            width: 250,
                                            fieldLabel: '발주번호',
                                            name: 'search_field1',
                                            id: 'V_PO_NO'
                                        },
                                        {
                                            xtype: 'textfield',
                                            margin: '0 0 0 30',
                                            maxWidth: 230,
                                            minWidth: 230,
                                            width: 230,
                                            fieldLabel: '품의번호',
                                            labelWidth: 80,
                                            name: 'search_field1',
                                            id: 'V_APPROV_NO'
                                        },
                                        {
                                            xtype: 'textfield',
                                            margin: '0 0 0 30',
                                            maxWidth: 230,
                                            minWidth: 230,
                                            width: 230,
                                            fieldLabel: '거래처',
                                            labelWidth: 80,
                                            name: 'search_field1',
                                            id: 'V_BP_NM',
                                            listeners: {
                                                afterrender: function(c) {
                                                	c.getEl().on('dblclick', function() {
                                                		var popup = Ext.create("Popup.view.WinBpPop");
                                                        popup.show();
                                                        
                                                        var store = Ext.getStore('WinBpPopStore');
                                                		store.removeAll();
                                                		
                                                		Ext.getCmp('fieldType').setValue('M_SL_TRANS_DISTR_1_F');
                                                    });
                                                }
                                            }
                                        },
                                        {
                                            xtype: 'textfield',
                                            margin: '0 0 0 30',
                                            maxWidth: 230,
                                            minWidth: 230,
                                            width: 230,
                                            fieldLabel: 'BL번호',
                                            labelWidth: 80,
                                            name: 'search_field1',
                                            id: 'V_BL_DOC_NO',
                                        }
                                    ]
                                },
                                {
                                    xtype: 'fieldcontainer',
                                    flex: 1,
                                    height: 35,
                                    maxHeight: 35,
                                    minHeight: 35,
                                    width: 400,
                                    layout: {
                                        type: 'hbox',
                                        align: 'stretch'
                                    },
                                    items: [
                                        {
                                            xtype: 'datefield',
                                            maxWidth: 250,
                                            minWidth: 250,
                                            width: 250,
                                            fieldLabel: '입고일자',
                                            format: 'Y-m-d',
                                            listeners: {
                                                render: {
                                                    fn: 'onDatefieldRender',
                                                    single: false
                                                }
                                            },
                                            id: 'V_GR_DT_FR'
                                        },
                                        {
                                            xtype: 'datefield',
                                            flex: 1,
                                            maxWidth: 170,
                                            minWidth: 170,
                                            width: 170,
                                            fieldLabel: '~',
                                            labelWidth: 20,
                                            format: 'Y-m-d',
                                            listeners: {
                                                render: 'onDatefieldRender1'
                                            },
                                            id: 'V_GR_DT_TO'
                                        },
                                        {
                                            xtype: 'combobox',
                                            id:'V_FR_SL_CD',
                                            flex: 1,
                                            margin: '0 0 0 30',
                                            maxWidth: 250,
                                            minWidth: 250,
                                            width: 250,
                                            fieldLabel: 'FROM창고',
                                            labelWidth: 80,
                                            value: 'T',
                                    		displayField: 'DTL_NM',
                                    		autoLoadOnValue: true,
                                    		valueField: 'DTL_CD',
                                    		matchFieldWidth: false,
                                            enableRegEx: true,
                                            minChars: 2,
                                            queryMode: 'local',
                                    		store: Ext.create('Ext.data.Store',{
                                    			autoLoad: true,
                                    			storeId: 'storev1',
                                    			proxy: {
                                    		           type: 'ajax',
                                    		           extraParams: {
                                    		            	V_MAST_CD: 'SL_DISTR',
                                    		            	V_GRID: 'N'
                                    		           },	
                                    		           api: {
                                    		               read: '/HSPF01/common/sql/Combobox.jsp'
                                    		           },
                                    		           reader: {
                                    		               type: 'json',
                                    		               rootProperty: 'resultList'
                                    		           }
                                    		       }
                                    		}),
                                    	
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                { 
                    xtype: 'gridpanel',
                    flex: 1,
                    style: 'border: 1px solid lightgray; padding: 5px;',
                    bodyBorder: false,
                    header: false,
                    id: 'myGrid',
                    store: 'MyStore',
                        tbar: [
                               {
                                   xtype: 'container',
                                   flex: 1
                               },
                               {
                             	   xtype: 'button',
                             	   id: 'tempGlCfmBtn',
                             	   margin: '0 3 0 0',
                             	   text: 'ERP전표생성',
                             	   style: 'background-color: white; border: 0.5px solid #3367d6;',
                             	   cls: 'blue-btn',
                             	   listeners: {
                             		   mouseover: function(button, e, eOpts) {
                             		        var theTip = Ext.create('Ext.tip.ToolTip', {
                             		            html: 'ERP 결의전표 생성',
                             		            target: 'tempGlCfmBtn',
                             		            showDelay: 0,
                             		            mouseOffset:[5,5],
                             		            trackMouse: true,
                             		            shadow: false
                             		        });
                             		    }
                             	   },
                                },
                                {
                             	   xtype: 'button',
                             	   id: 'tempGlCancelBtn',
                             	   margin: '0 3 0 0',
                             	   text: 'ERP전표취소',
                             	   style: 'background-color: white; border: 0.5px solid #3367d6;',
                             	   cls: 'blue-btn',
                             	   listeners: {
                             		   mouseover: function(button, e, eOpts) {
                             		        var theTip = Ext.create('Ext.tip.ToolTip', {
                             		            html: 'ERP 결의전표 삭제',
                             		            target: 'tempGlCancelBtn',
                             		            showDelay: 0,
                             		            mouseOffset:[5,5],
                             		            trackMouse: true,
                             		            shadow: false
                             		        });
                             		    }
                             	   },
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
                        	xtype: 'datecolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 100,
                        	dataIndex: 'MVMT_DT',
                        	text: '입고일',
                        	format: 'Y-m-d'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            dataIndex: 'APPROV_NO',
                            text: '품의번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 350,
                            dataIndex: 'APPROV_NM',
                            text: '품의명'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            dataIndex: 'APPROV_SEQ',
                            text: '품의차수'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            dataIndex: 'BL_DOC_NO',
                            text: 'BL번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'M_BP_NM',
                            text: '매입처'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 114,
                        	dataIndex: 'M_BP_CD',
                        	text: 'M_BP_CD',
                        	hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'S_BP_NM',
                            text: '수주처'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 114,
                        	dataIndex: 'S_BP_CD',
                        	text: 'S_BP_CD',
                        	hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'FR_SL_NM',
                            text: 'FROM창고'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 114,
                        	dataIndex: 'FR_SL_CD',
                        	text: 'FR_SL_CD',
                        	hidden: true
                        },
                        {
                            xtype: 'datecolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
                            dataIndex: 'MV_DT',
                            text: '<span style=\'color:red\'>*</span>이고일',
                            format: 'Y-m-d',
                            editor: {
                            	xtype: 'datefield',
                            	format: 'Y-m-d'
                            }
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;  color: #3367d6',
                            text: '<span style=\'color:red\'>*</span>TO창고',
                            dataIndex: 'TO_SL_CD',
                            width: 150,
                            editor: {
                        		xtype: 'combobox',
                        		displayField: 'DTL_NM',
                        		autoLoadOnValue: true,
                        		valueField: 'DTL_CD',
                        		matchFieldWidth: false,
                                enableRegEx: true,
                                minChars: 2,
                                queryMode: 'local',
                        		store: Ext.create('Ext.data.Store',{
                        			autoLoad: true,
                        			storeId: 'sl_combo',
                        			proxy: {
                        		           type: 'ajax',
                        		           extraParams: {
                        		            	V_MAST_CD: 'SL_DISTR',
                        		            	V_GRID: 'Y'
                        		           },	
                        		           api: {
                        		               read: '/HSPF01/common/sql/Combobox.jsp'
                        		           },
                        		           reader: {
                        		               type: 'json',
                        		               rootProperty: 'resultList'
                        		           }
                        		       }
                        		})
                        	},
                            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                                if(Ext.data.StoreManager.lookup('sl_combo').findRecord('DTL_CD',value) !==null)
                                {
                                    return Ext.data.StoreManager.lookup('sl_combo').findRecord('DTL_CD',value).get('DTL_NM');
                                }
                                return value;
                            },
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
                            width: 114,
                            dataIndex: 'MV_BP_CD',
                            text: '<span style=\'color:red\'>*</span>이고업체코드',
                            emptyCellText: '(Double Click)',
                            editor: {
                                xtype: 'textfield',
                                allowBlank: false,
                                editable: false,
                                listeners: {
                                    afterrender: function(c) {
                                    	c.getEl().on('dblclick', function() {
                                    		var popup = Ext.create("Popup.view.WinBpPop");
                                            popup.show();
                                            
                                            var store = Ext.getStore('WinBpPopStore');
                                    		store.removeAll();
                                    		
                                    		Ext.getCmp('fieldType').setValue('M_SL_TRANS_DISTR_1');
//                                    		Ext.getCmp('W_M_BP_CD').setValue(Ext.getCmp('V_M_BP_CD2').getValue());
                                        });
                                    }
                                }
                            }
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;  ',
                        	width: 130,
                        	dataIndex: 'MV_BP_NM',
                        	text: '이고업체'
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
                            align: 'end',
                            dataIndex: 'MV_AMT',
                            text: '<span style=\'color:red\'>*</span>이고료',
                        	format: '0,000.00',
                            editor: {
                            	xtype: 'numberfield',
                            	format: '0,000.00'
                            }
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
                            width: 200,
                            dataIndex: 'MV_VAT_TYPE',
                            text: '<span style=\'color:red\'>*</span>부가세유형',
                            value: 'A',
                            editor: {
                        		xtype: 'combobox',
                        		displayField: 'DTL_NM',
                        		autoLoadOnValue: true,
                        		valueField: 'DTL_CD',
                        		editable: false,
                        		store: Ext.create('Ext.data.Store',{
                        			autoLoad: true,
                        			storeId: 'storev',
                        			proxy: {
                        		           type: 'ajax',
                        		           extraParams: {
                        		            	V_MAST_CD: 'BA05',
                        		            	V_GRID: 'Y'
                        		           },	
                        		           api: {
                        		               read: '/HSPF01/common/sql/Combobox.jsp'
                        		           },
                        		           reader: {
                        		               type: 'json',
                        		               rootProperty: 'resultList'
                        		           }
                        		       }
                        		}),
                        	},
                        	renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                                if(Ext.data.StoreManager.lookup('storev').findRecord('DTL_CD',value) !==null)
                                {
                                    return Ext.data.StoreManager.lookup('storev').findRecord('DTL_CD',value).get('DTL_NM');
                                }
                                return value;
                            },
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'MV_VAT_AMT',
                            text: '부가세금액',
                        	format: '0,000.00',
                        	align: 'right'
                        },
                        {
                            xtype: 'checkcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            text: '판매원가반영유무',
                            dataIndex: 'SALE_YN',
                            width: 120
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 150,
                        	dataIndex: 'TEMP_GL_NO',
                        	text: '전표번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            dataIndex: 'PO_NO',
                            text: '발주번호'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 150,
                        	dataIndex: 'GR_NO',
                        	text: '입고번호'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	text: 'MV_NO',
                        	dataIndex: 'MV_NO',
                        	width: 150,
                        	hidden: true,
                        },
                    ],
                    selModel: {
                        selType: 'checkboxmodel',
                        checkOnly: true,
                        listeners: {
                        	select: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', 'V');
                            	
                            	var store1 = Ext.getStore('MyStore1');
                            	var gridRecord = Ext.getCmp('myGrid').getSelectionModel(); 
                            		
                            	if(record.get('MV_NO') != undefined) {
                            		store1.load({
                        	    		params: {
                        	    			V_TAB_TYPE: 'T1',
                        	    			V_TYPE: 'SD',
                        	    			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
                        	    			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
                        	    			V_PH_NO: record.get('MV_NO')
                        	    		},
                        	    		callback: function(records,operations,success){
                        	    			
                        	    		}
                        	    	});
                            	}
                            	
                            },
                            deselect: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', '');
                            	
                            	var store1 = Ext.getStore('MyStore1');
                            	var gridRecord = Ext.getCmp('myGrid').getSelectionModel(); 
                            	
                            	store1.removeAll();
                            		
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
                        {
                            ptype: 'cellediting',
                            clicksToEdit: 2,
                            listeners: {
                            	edit: function(editor, context, eOpts) {
                            		var selModel = Ext.getCmp('myGrid').getSelectionModel();
                            		selModel.select(context.record, true);
                            		
                            		if ((context.column.dataIndex == 'MV_VAT_TYPE') || (context.column.dataIndex == 'MV_AMT')) {
                            			var MV_AMT = context.record.get('MV_AMT');
                            			var MV_VAT_TYPE = context.record.get('MV_VAT_TYPE');
                            			var MV_VAT_AMT = context.record.get('MV_VAT_AMT');
                        				
                        				if (MV_VAT_TYPE == 'A' || MV_VAT_TYPE == 'B') {
                        					context.record.set('MV_VAT_AMT', MV_AMT * 0.1);
                        				} else {
                        					context.record.set('MV_VAT_AMT', 0);
                        				}
                            		}
                            		
                            	}
                            	}
                        }
                    ]
                },
                {
                	xtype: 'splitter',
                	collapseTarget: 'prev'
                },
                {
                    xtype: 'gridpanel',
                    flex: 0.5,
                    style: 'border: 1px solid lightgray; padding: 5px;',
                    header: false,
                    title: 'My Grid Panel',
                    id: 'myGrid1',
                    store: 'MyStore1',
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
                            width: 114,
                            dataIndex: 'ITEM_CD',
                            text: '품목코드'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 114,
                            dataIndex: 'ITEM_NM',
                            text: '품목명'
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
                        	width: 114,
                        	dataIndex: 'SPEC',
                        	text: '규격'
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            align: 'end',
                            dataIndex: 'STOCK_QTY',
                            text: '현 재고수량',
                            format: '0,000.00'
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            align: 'end',
                            dataIndex: 'BAE_AMT',
                            text: '배분된 이고금액',
                            format: '0,000.00'
                        }
                    ],
                    viewConfig: {
                        enableTextSelection: true,
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
                    ]
                }
            ]
        }
    ]

});