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

Ext.define('A_AR_RECEIPT2.view.MyPanel3', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel3',

    requires: [
        'A_AR_RECEIPT2.view.MyPanelViewModel3',
        'Ext.grid.Panel',
        'Ext.form.FieldSet', 
		'Ext.form.FieldContainer', 
		'Ext.form.field.Date',
		'Ext.form.field.Text',
		'Ext.form.field.TextArea',
		'Ext.form.field.Number',
    ],

    viewModel: {
        type: 'mypanel3'
    },
    layout: 'fit',
    header: false,
    title: 'Tab 3',

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
                    store: 'MyStore2',
                    id: 'myGrid2',
	                tbar: [
	                	{
	        				id : 'gridAddBtn2',
	        				text : '',
	        				margin : '0 3 0 0',
	        				glyph : 'xf055@FontAwesome',
	        				iconCls : 'grid-add-btn',
	        			}, 
	                	{
	        			    id: 'gridDelBtn2',
	        			    text: '',
	        			    margin: '0 3 0 0',
	        			    glyph: 'xf056@FontAwesome',
	        			    iconCls: 'grid-del-btn',
	        			},
//	        			{
//	        				id : 'gridSaveBtn2',
//	        				text : '',
//	        				margin : '0 3 0 0',
//	        				glyph : 'xf0c7@FontAwesome',
//	        				iconCls : 'grid-save-btn',
//	        			},
	                	{
		                      xtype: 'container',
		                      flex: 1
		                },
		                {
		                      xtype: 'button',
		                      glyph: 'xf1c3@FontAwesome',
		                      id: 'xlsxDown2',
		                      cfg: {
		                          type: 'excel07',
		                          ext: 'xlsx'
		                      },
		                      iconCls: 'grid-excel-btn',
		                }
		            ],
                    columns: [ {
        				xtype : 'rownumberer',
        				width : 40
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 114,
        				dataIndex : 'V_TYPE',
        				text : 'V_TYPE',
        				hidden : true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 100,
        				dataIndex : 'DEPT_CD',
        				text : '부서',
        				editor: {
                            xtype: 'combobox',
                            displayField: 'DEPT_NM',
                            valueField: 'DEPT_CD',
                            enableRegEx: true,
                            minChars: 2,
                            queryMode: 'local',
                            store: 'DeptStore',
                            matchFieldWidth: false,
                            listeners: {
                                beforequery: function(record){  
                                    record.query = new RegExp(record.query, 'i');
                                    record.forceAll = true;
                                },
                                focus: function(widget, event, eOpts) {
                                	var DeptStore = Ext.getStore('DeptStore');
                                	DeptStore.reload();
                                },
                            },
                          	listConfig: {
                                itemTpl: [
                                    '<div>[{DEPT_CD}] {DEPT_NM}</div>'
                                ]
                            }
                        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 130,
        				dataIndex : 'DEPT_NM',
        				text : '부서명',
        				renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		            if(Ext.data.StoreManager.lookup('DeptStore').findRecord('DEPT_CD',value) !== null)
        		            {
        		                return Ext.data.StoreManager.lookup('DeptStore').findRecord('DEPT_CD', value).get('DEPT_NM');
        		            }
        		            return value;
        		        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 100,
        				dataIndex : 'COST_CD',
        				text : '코스트센터',
        				editor: {
                            xtype: 'combobox',
                            displayField: 'COST_NM',
                            valueField: 'COST_CD',
                            enableRegEx: true,
                            minChars: 2,
                            queryMode: 'local',
                            store: 'CostStore',
                            matchFieldWidth: false,
                            listeners: {
                                beforequery: function(record){  
                                    record.query = new RegExp(record.query, 'i');
                                    record.forceAll = true;
                                    
                                },
                                focus: function(widget, event, eOpts) {
                                	var CostStore = Ext.getStore('CostStore');
                                	CostStore.proxy.extraParams.V_DEPT_CD = Ext.getCmp('V_DEPT_CD2').getValue();
                                	CostStore.reload();
                                },
                            },
                          	listConfig: {
                                itemTpl: [
                                    '<div>[{COST_CD}] {COST_NM}</div>'
                                ]
                            }
                        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 130,
        				dataIndex : 'COST_NM',
        				text : '코스트센터명',
        				renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		            if(Ext.data.StoreManager.lookup('CostStore').findRecord('COST_CD',value) !== null)
        		            {
        		                return Ext.data.StoreManager.lookup('CostStore').findRecord('COST_CD',value).get('COST_NM');
        		            }
        		            return value;
        		        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 110,
        				dataIndex : 'ACCT_CD',
        				text : '계정',
        				editor: {
                            xtype: 'combobox',
                            displayField: 'ACCT_NM',
                            valueField: 'ACCT_CD',
                            enableRegEx: true,
                            minChars: 2,
                            queryMode: 'local',
                            store: 'PopStore2',
                            matchFieldWidth: false,
                            listeners: {
                                beforequery: function(record){  
                                    record.query = new RegExp(record.query, 'i');
                                    record.forceAll = true;
                                },
                                focus: function(widget, event, eOpts) {
                                	var PopStore2 = Ext.getStore('PopStore2');
                                	PopStore2.reload();
                                },
                            },
                          	listConfig: {
                                itemTpl: [
                                    '<div>[{ACCT_CD}] {ACCT_NM}</div>'
                                ]
                            }
                        },
//        				editor: {
//        					xtype: 'textfield',
//        		            listeners : {
//        						afterrender : function(c) {
//        							this.mon(this.getEl(), 'dblclick', function() {
//	        							var popup = Ext.create("A_AR_RECEIPT2.view.MyWindow2");
//	        							popup.center();
//	        		                    popup.show();
//        							});
//        						}
//        					}
//        				},
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 150,
        				dataIndex : 'ACCT_NM',
        				text : '계정명',
        				renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		            if(Ext.data.StoreManager.lookup('PopStore2').findRecord('ACCT_CD',value) !== null)
        		            {
        		                return Ext.data.StoreManager.lookup('PopStore2').findRecord('ACCT_CD',value).get('ACCT_NM');
        		            }
        		            return value;
        		        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 100,
        				dataIndex : 'DR_CR_FG',
        				text : '차대구분',
        				renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		            if(Ext.data.StoreManager.lookup('storeAC01').findRecord('DTL_CD',value) !==null)
        		            {
        		                return Ext.data.StoreManager.lookup('storeAC01').findRecord('DTL_CD',value).get('DTL_NM');
        		            }
        		            return value;
        		        },
        				exportRenderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		            if(Ext.data.StoreManager.lookup('storeAC01').findRecord('DTL_CD',value) !==null)
        		            {
        		                return Ext.data.StoreManager.lookup('storeAC01').findRecord('DTL_CD',value).get('DTL_NM');
        		            }
        		            return value;
        		        },
        				editor: {
        		    		xtype: 'combobox',
        		    		displayField: 'DTL_NM',
        		    		autoLoadOnValue: true,
        		    		valueField: 'DTL_CD',
        		    		editable: false,
        		    		store: Ext.create('Ext.data.Store',{
        		    			autoLoad: true,
        		    			storeId: 'storeAC01',
        		    			proxy: {
        		    		           type: 'ajax',
        		    		           extraParams: {
        		    		            	V_MAST_CD: 'AC01',
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
        		    		listConfig: {
        		                itemTpl: [
        		                    '<div>{DTL_NM} ({DTL_CD})</div>'
        		                ]
        		            },
        		    	}
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 100,
        				dataIndex : 'CUR',
        				text : '통화',
        				editor: {
        		    		xtype: 'combobox',
        		    		displayField: 'DTL_NM',
        		    		autoLoadOnValue: true,
        		    		valueField: 'DTL_CD',
        		    		editable: false,
        		    		store: Ext.create('Ext.data.Store',{
        		    			autoLoad: true,
        		    			storeId: 'storeBA04',
        		    			proxy: {
        		    		           type: 'ajax',
        		    		           extraParams: {
        		    		            	V_MAST_CD: 'BA04',
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
        		    		listConfig: {
        		                itemTpl: [
        		                    '<div>{DTL_NM} ({DTL_CD})</div>'
        		                ]
        		            },
        		    	}
        			}, {
        				xtype : 'numbercolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 110,
        				align : 'end',
        				dataIndex : 'XCH_RATE',
        				text : '환율',
        				format : '0,000.0000',
        				editor : {
        					xtype : 'numberfield',
        					format : '0,000.00',
        					decimalPrecision : 2,
        					align : 'right'
        				},
        			}, {
        				xtype : 'numbercolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 120,
        				align : 'end',
        				dataIndex : 'DOC_AMT',
        				text : '외화금액',
        				format : '0,000.0000',
        				editor : {
        					xtype : 'numberfield',
        					format : '0,000.00',
        					decimalPrecision : 2,
        					align : 'right'
        				},
        				summaryType: 'sum',
        	            summaryRenderer: function (value, summaryData, dataIndex) {
        		            return "<font color='green'>"+Ext.util.Format.number(value, '0,000.0000')+"<font>"; 
        		        },
        			}, {
        				xtype : 'numbercolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 120,
        				align : 'end',
        				dataIndex : 'LOC_AMT',
        				text : '원화금액',
        				format : '0,000',
        				editor : {
        					xtype : 'numberfield',
        					format : '0,000',
        					align : 'right'
        				},
        				summaryType: 'sum',
        	            summaryRenderer: function (value, summaryData, dataIndex) {
        		            return "<font color='green'>"+Ext.util.Format.number(value, '0,000')+"<font>"; 
        		        },
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 150,
        				dataIndex : 'REMARK',
        				text : '비고',
        				editor: {
        					xtype: 'textfield'
        				},
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				dataIndex : 'CLS_TYPE',
        				text : 'CLS_TYPE',
        				hidden: true,
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				dataIndex : 'SEQ',
        				text : 'SEQ',
        				hidden: true,
        			}, ],
                    viewConfig: {
                    	enableTextSelection: true,
                        },
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        }, {
                			ptype : 'cellediting',
                			clicksToEdit: 1,
                    	    listeners : {
                    	    	afteredit: function(e) {
                					var record = e.grid.getSelection()[0];
                					var field = e.context.field;
                					var val = e.context.value;
                    	    		
                					if(!!!val) return;
                					
                			    	if(field == 'COST_CD') {
                			    		record.set('COST_NM', val);
                            		} else if(field == 'DEPT_CD') {
                            			record.set('DEPT_NM', val);
                            		} else if(field == 'ACCT_CD') {
                            			record.set('ACCT_NM', val);
                            		} 
                			    	
                			    	if(field == 'ACCT_CD') {
                			    		var store3 = Ext.getStore('MyStore3');
                			    		store3.removeAll();
                			    		
                			    		store3.load({
                			        		params: {
                			        			V_TYPE: 'ACCT_REF',
                			        			V_COMP_ID: parent.Ext.getCmp('GCOMP_ID').getValue(),
                			        			V_USR_ID: parent.Ext.getCmp('GUSER_ID').getValue(),
                			        			V_ACCT_CD : val
                			        		},
                			        		callback: function(records,operations,success){
                			        			
                			        		},
                			        	});
                			    	}
                			    	
                			    	if(field == 'CUR' && val == 'KRW'){
                			    		record.set('XCH_RATE', 1);
                			    		record.set('LOC_AMT', Math.round(record.get('DOC_AMT')));
                			    	}
                			    	
                			    	if(field == 'DOC_AMT'){
                			    		record.set('LOC_AMT', Math.round(val * record.get('XCH_RATE')));
                			    	}
                			    	
                			    	if(field == 'XCH_RATE'){
                			    		record.set('LOC_AMT', Math.round(val * record.get('DOC_AMT')));
                			    	}
                			    	
                			    },
                    	    }
                		}
                    ],
                    selModel : {
            			selType : 'checkboxmodel',
            			mode : 'SINGLE',
            			listeners : {
            				
            			}
            		},
                    features : [ {
                		ftype: 'summary',
                        dock: 'bottom'
                	} ]
                },
                {

                    xtype: 'gridpanel',
                    flex: 0.7,
                    style: 'border: 1px solid lightgray; padding: 5px;',
                    header: false,
                    title: 'My Grid Panel',
                    store: 'MyStore3',
                    id: 'myGrid3',
//	                tbar: [
//	                	{
//		                      xtype: 'container',
//		                      flex: 1
//		                },
//		                {
//		                      xtype: 'button',
//		                      glyph: 'xf1c3@FontAwesome',
//		                      id: 'xlsxDown3',
//		                      cfg: {
//		                          type: 'excel07',
//		                          ext: 'xlsx'
//		                      },
//		                      iconCls: 'grid-excel-btn',
//		                }
//		            ],
                    columns: [ {
        				xtype : 'rownumberer',
        				width : 40
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 114,
        				dataIndex : 'V_TYPE',
        				text : 'V_TYPE',
        				hidden : true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 100,
        				dataIndex : 'SEQ',
        				text : 'SEQ',
        				hidden: true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 100,
        				dataIndex : 'ACCT_CD',
        				text : '계정코드',
        				hidden: true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 100,
        				dataIndex : 'DTL_SEQ',
        				text : '순번',
        				hidden: true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 100,
        				dataIndex : 'CTRL_CD',
        				text : '관리항목',
        				hidden: true
        			}, {
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 200,
        				dataIndex : 'CTRL_NM',
        				text : '관리항목명',
        				sortable: false
        			}, 
//        			{
//        				xtype : 'gridcolumn',
//        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
//        				width : 150,
//        				dataIndex : 'CTRL_VAL',
//        				text : '관리항목값',
//        				editor: {
//        					xtype : 'textfield',
//        				}
//        			}, 
        			{
        				xtype : 'widgetcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        				width : 250,
        				dataIndex : 'CTRL_VAL',
        				text : '관리항목값',
        				sortable: false,
        				widget: {
                            xtype: 'combobox',
                            displayField: 'DTL_CD',
                            valueField: 'DTL_CD',
                            listConfig: {
        		                itemTpl: [
        		                    '<div>{DTL_CD} ({DTL_NM})</div>'
        		                ]
        		            },
        		            listeners:{
//        		                change: function(textfield, value, eOpts){
//        		                	if(!!!value) return;
//        		                	
//        		                	var store = textfield.getStore();
//        		                    var record = textfield.getWidgetRecord();
//
//        		                    record.set('CTRL_VAL', value);
//        		                    if(!!store && !!store.findRecord('DTL_CD', value)){
//        		                    	record.set('CTRL_VAL_NM', store.findRecord('DTL_CD', value).get('DTL_NM'));
//        		                    }
//        		                }
        		            	blur: function(component, event, eOpts){
        		            		var value = component.value;
        		                	if(!!!value) return;
        		                	
        		                	var store = component.getStore();
        		                    var record = component.getWidgetRecord();

        		                    record.set('CTRL_VAL', value);
        		                    if(!!store && !!store.findRecord('DTL_CD', value)){
        		                    	record.set('CTRL_VAL_NM', store.findRecord('DTL_CD', value).get('DTL_NM'));
        		                    }
        		            	} 
        		            }
                        },
                        onWidgetAttach: function (col, widget, rec) {
                        	var widgetStore, storeId, V_TYPE;
                        	
                        	if(rec.get('CTRL_CD') == 'BK'){
                        		V_TYPE = 'BANK';
                        	} else if(rec.get('CTRL_CD') == 'F1'){
                        		V_TYPE = 'CUR';
                        	}
                        	
                        	if(!!V_TYPE){
                        		storeId = 'WidgetStore'+rec.get('CTRL_CD');
                        		
                        		if(!!Ext.getStore(storeId) && Ext.getStore(storeId).data.length > 0){
                        			widgetStore = Ext.getStore(storeId);
                        		} else {
                        			widgetStore = Ext.create('Ext.data.Store', {
                            			storeId: storeId,
                                        model: 'A_AR_RECEIPT2.model.MyModel',
                                        proxy: {
                                        	type: 'ajax',
                                            extraParams: {
                            	            	V_TYPE: V_TYPE,
                            	            },	
                                            api: {
                                                read: 'sql/A_COMBOBOX_HSPF.jsp',
                                            },
                                            reader: {
                                            	type: 'json',
                                                rootProperty: 'resultList'
                                            },
                                        },
                                    });
                        		}
                        	}
                        	
                        	if(!!widgetStore){
                        		widget.xtype = 'combobox';
                        		widget.setStore(widgetStore);
                        	} else {
                        		widget.xtype = 'textfield';
                        		widget.setStore(Ext.create('Ext.data.Store', {
                        			data : {DTL_CD: '', DTL_NM: '입력'},
                                }));
                        	}
                        },
        			}, 
        			{
        				xtype : 'gridcolumn',
        				style : 'font-size: 12px; text-align: center; font-weight: bold;',
        				width : 250,
        				dataIndex : 'CTRL_VAL_NM',
        				text : '관리항목값명',
        				sortable: false
        			}, ],
                    viewConfig: {
//                    	enableTextSelection: false,
//                    	sortable : false,
                    },
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        }, {
                			ptype : 'cellediting',
                			clicksToEdit: 1,
                    	    listeners : {
                    	    	afteredit: function(e) {
                    	    		
                    	    	},
                    	    }
                		}
                    ],
                    selModel : {
            			selType : 'checkboxmodel',
            			mode : 'SINGLE',
            			listeners : {
            				
            			}
            		},
                },
            ]
        }
    ]

});