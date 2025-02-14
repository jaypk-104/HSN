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

Ext.define('S_M_SL_MGM_DISTR.view.MyPanel1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel1',

    requires: [
        'S_M_SL_MGM_DISTR.view.MyPanelViewModel1',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing',
        'Ext.grid.column.Number'
    ],

    viewModel: {
        type: 'mypanel1'
    },
    layout: 'fit',
    title: 'Tab 2',

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
                    store: 'MyStore1',
                    id: 'myGrid1',
	                tbar: [
	                    {
	                       	id: 'gridSaveBtn1',
	                       	xtype: 'button',
	                       	glyph: 'xf0c7@FontAwesome',
	                      	iconCls: 'grid-save-btn',
	                      	margin: '0 3 0 0'
	                    },
	                    {
	                    	xtype: 'container',
	                    	flex: 1
	                    },
	                   {
                            xtype: 'datefield',
                            maxWidth: 200,
                            minWidth: 200,
                            width: 200,
                            fieldLabel: '전표일자',
                            labelWidth: 60,
                            editable: false,
                            format: 'Y-m-d',
                            id: 'V_TEMP_GL_DT',
                        },
	                    {
	                  	   xtype: 'button',
	                  	   id: 'slIvCfmBtn1',
	                  	   margin: '0 3 0 0',
	                  	   text: 'ERP매입전표생성',
	                  	   style: 'background-color: white; border: 0.5px solid #3367d6;',
	                  	   cls: 'blue-btn',
	                     },
	                     {
		                    	xtype: 'button',
		                    	glyph: 'xf1c3@FontAwesome',
		                    	id: 'xlsxDown1',
		                    	cfg: {
		                    		type: 'excel07',
		                    		ext: 'xlsx'
		                    	},
		                    	iconCls: 'grid-excel-btn',
		                    	hidden : true
		                    },
	                     {
	                  	   xtype: 'button',
	                  	   id: 'slIvCancelBtn1',
	                  	   margin: '0 3 0 0',
	                  	   text: 'ERP전표취소',
	                  	   style: 'background-color: white; border: 0.5px solid #3367d6;',
	                  	   cls: 'blue-btn',
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
                            width: 250,
                            dataIndex: 'SL_NM',
                            text: '창고',
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
                            width: 110,
                            dataIndex: 'M_BP_CD',
                            text: '매입처코드',
                            enableTextSelection: true,
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
                                    		
                                    		Ext.getCmp('fieldType').setValue('B_STORAGE_DISTR_1');
                                        });
                                    }
                                }
                            },
                        	filter: { //필터
                        		type : 'list',
                            },
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 230,
                            dataIndex: 'M_BP_NM',
                            text: '매입처',
                        	filter: { //필터
                        		type : 'list',
                            },
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 110,
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
                            width: 110,
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
                            width: 120,
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
                            width: 150,
                            dataIndex: 'REMARK',
                            text: '비고',
                        },
                    ],
                    /*
                    selModel: {
                        selType: 'checkboxmodel',
                        checkOnly: true,
                        listeners: {
                        	select: function(rowmodel, record, index, eOpts) {
                        		
                        		var store = Ext.getStore('MyStore1');
                        		var selModel= Ext.getCmp('myGrid1').getSelectionModel();
                        		
                				var temp = Ext.getCmp('M_BP_CD').getValue();
                				if(Ext.getCmp('M_BP_CD').getValue() == "" ){   
                					Ext.getCmp('M_BP_CD').setValue(record.get('M_BP_CD'));
                					record.set('V_TYPE', 'V');
                				}else {
                					if(Ext.getCmp('M_BP_CD').getValue() != record.get('M_BP_CD')){
                        				Ext.Msg.alert('확인', '동일한 매입처를 선택하세요.');
                        				selModel.deselect(record, true);
                						}
                    				else{
                    					record.set('V_TYPE', 'V');
                    				}
                				}
                				
                        	},
                        	deselect: function(rowmodel, record, index, eOpts) {
                        		record.set('V_TYPE', '');
                            	var gridRecord = Ext.getCmp('myGrid1').getSelectionModel().getSelection();
                            	if(gridRecord.length == 0 ){
                            		Ext.getCmp('M_BP_CD').setValue('');
                            	} 
                            	
                        	}
                        }
                    }, */
                    
                    selModel: {
                        selType: 'checkboxmodel',
                        hidden : true,
                        listeners: {
                        	select: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', 'V');
                            	
                            	var M_BP_CD = record.get('M_BP_CD');
                            	var store = Ext.getStore('MyStore1');
                            	var selModel= Ext.getCmp('myGrid1').getSelectionModel();
                            	
                            	
                            	if(M_BP_CD != '00000'){
                            	store.each(function(record){
                        			if(M_BP_CD == record.get('M_BP_CD')&& M_BP_CD != undefined) {
                    					selModel.select(record, true);
                        			}
                        		});
                               }
                            },
                            deselect: function(rowmodel, record, index, eOpts) {
                            	record.set('V_TYPE', '');
                            	
                            	var M_BP_CD = record.get('M_BP_CD');
                            	var store = Ext.getStore('MyStore1');
                            	var selModel= Ext.getCmp('myGrid1').getSelectionModel();
                            	 
                            	store.each(function(record){
                        			if(M_BP_CD == record.get('M_BP_CD')&& M_BP_CD != undefined) {
                    					selModel.deselect(record, true);
                        			}
                        		});
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
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        }, {
                    		ptype : 'cellediting',
                    	    clicksToEdit: 1,
                    	    listeners : {
        						afteredit : function(e) {
        							var rec = e.grid.getSelection()[0];
        							var field = e.context.field;
        							var val = e.context.value;
        							if (field == 'SL_AMT' && rec != undefined) {
        								if(val === 0){
        									rec.set('VAT_AMT', 0);
        								} else {
        									var vatAmt = Math.floor(val/10);
            								rec.set('VAT_AMT', vatAmt);
        								}
        							}
        						},
        						beforeedit: function (e, editor) {
        							var rec = editor.record.data;
        							var field = editor.field;

        							if(rec.GL_YN === 'Y'){
        						    	return false;
        							}
        					    	
        					        return true;
        					    }
        					},
                    	}
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