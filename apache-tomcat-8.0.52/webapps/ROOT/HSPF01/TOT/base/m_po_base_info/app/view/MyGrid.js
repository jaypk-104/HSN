/*
 * File: app/view/MyGrid.js
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

Ext.define('M_PO_BASE_INFO.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'M_PO_BASE_INFO.view.MyGridViewModel',
        'Ext.grid.column.RowNumberer',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing',
        'Ext.grid.filters.Filters',
        'Ext.grid.plugin.Clipboard',
    ],

    config: {
        tbar: [
            {
                id: 'gridAddBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf055@FontAwesome',
                iconCls: 'grid-add-btn',
            },
            {
                id: 'gridDelBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf056@FontAwesome',
                iconCls: 'grid-del-btn',
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
                margin: '0 3 0 0',
            }
        ]
    },

    viewModel: {
        type: 'mygrid'
    },
    style: 'border: 1px solid lightgray; padding: 5px;',
    header: false,
    store: 'MyStore',
    id: 'grid1',
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
            dataIndex: 'M_BP_CD',
            text: '매입처코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 250,
            dataIndex: 'M_BP_NM',
            text: '매입처명',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                valueField: 'M_BP_CD',
                displayField: 'M_BP_NM',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank: false,
                store: 'WinMBpPopStore',
              	listConfig: {
                    itemTpl: [
                        '<div>{M_BP_NM} ({M_BP_CD})</div>'
                    ]
                },
                listeners : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                    change: function(field, newValue, oldValue, eOpts) {
                    	var gridRecord = Ext.getCmp('grid1').getSelectionModel().getSelection();
                    	gridRecord[0].set('M_BP_CD', field.value);
                    }
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('WinMBpPopStore').findRecord('M_BP_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('WinMBpPopStore').findRecord('M_BP_CD',value).get('M_BP_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 114,
            dataIndex: 'PO_TYPE',
            
            text: '발주유형',
            editor: {
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
                	matchFieldWidth: false,
              		autoLoad: true,
              		storeId: 'store3',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'MA02',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store3').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store3').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 150,
            dataIndex: 'IN_TERMS',
            text: '가격조건',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store4',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'MA04',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store4').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store4').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 200,
            dataIndex: 'PAY_METH',
            text: '결제방법',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store5',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'MA03',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store5').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store5').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 80,
            dataIndex: 'CUR',
            text: '화폐단위',
            editor: {
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store6',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store6').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store6').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 200,
            dataIndex: 'VAT_TYPE',
            text: '부가세유형',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store7',
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
              	listConfig: {
                    itemTpl: [
                        '<div>{DTL_NM} ({DTL_CD})</div>'
                    ]
                },
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store7').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store7').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 130,
            dataIndex: 'DLV_TYPE',
            text: '입고구분',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store8',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'MA09',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store8').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store8').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 130,
            dataIndex: 'GR_TYPE',
            text: '입고단위',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store : Ext.create('Ext.data.Store',
                		{
                			id:'store9',
                			autoLoad: true,
                			fields : [ 'DTL_CD', 'DTL_NM' ],
                			data : [[ 'A', '수량' ],[ 'B','바코드' ]]
            		}),
              	listConfig: {
                    itemTpl: [
                        '<div>{DTL_NM} ({DTL_CD})</div>'
                    ]
                },
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store9').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store9').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
        	width: 149,
        	dataIndex: 'SYS_TYPE',
        	text: '시스템구분',
        	editor: {
        		matchFieldWidth: false,
        		xtype: 'combobox',
        		displayField: 'DTL_NM',
        		valueField: 'DTL_CD',
        		enableRegEx: true,
        		minChars: 2,
        		queryMode: 'local',
        		allowBlank:false,
        		store: Ext.create('Ext.data.Store',{
        			autoLoad: true,
        			storeId: 'store12',
        			proxy: {
        				type: 'ajax',
        				extraParams: {
        					V_MAST_CD: 'BZ03',
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
        		listeners   : {
        			beforequery: function(record){  
        				record.query = new RegExp(record.query, 'i');
        				record.forceAll = true;
        			},
        		}
        	},
        	renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
        		if(Ext.data.StoreManager.lookup('store12').findRecord('DTL_CD',value) !==null)
        		{
        			return Ext.data.StoreManager.lookup('store12').findRecord('DTL_CD',value).get('DTL_NM');
        		}
        		return value;
        	},
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 149,
            dataIndex: 'TRANS_TYPE',
            text: '운송방법',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store10',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'BA06',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store10').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store10').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; color: #3367d6',
            width: 149,
            dataIndex: 'DISCHGE_PORT',
            text: '도착항',
            editor: {
            	matchFieldWidth: false,
                xtype: 'combobox',
                displayField: 'DTL_NM',
                valueField: 'DTL_CD',
                enableRegEx: true,
                minChars: 2,
                queryMode: 'local',
                allowBlank:false,
                store: Ext.create('Ext.data.Store',{
              		autoLoad: true,
              		storeId: 'store11',
              		proxy: {
                          type: 'ajax',
                          extraParams: {
                           	V_MAST_CD: 'BA07',
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
                listeners   : {
                    beforequery: function(record){  
                        record.query = new RegExp(record.query, 'i');
                        record.forceAll = true;
                    },
                }
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store11').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store11').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 114,
            dataIndex: 'INSRT_USR_NM',
            text: '최초등록자',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 160,
        	dataIndex: 'INSRT_DT',
        	text: '최초등록일시',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 114,
        	dataIndex: 'UPDT_USR_NM',
        	text: '최종수정자',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 160,
        	dataIndex: 'UPDT_DT',
        	text: '최종수정일시',
        },
    ],
    viewConfig: {
        height: 155
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
            ptype: 'cellediting',
            clicksToEdit: 2,
            clicksToMoveEditor: 1,
//            listeners: {
//            	edit: function(editor, context, eOpts) {
//            		var selModel= Ext.getCmp('grid2').getSelectionModel();
//            		selModel.select(context.record, true);
//            	},
//          	  	beforeedit: function(editor, context, eOpts) {
//          	  		if((context.record.phantom == false) && (context.field == 'DTL_CD')) {
//    					context.cancel = true; 
//    				}
//          	  	},
//           } 
        },
        {
            ptype: 'gridfilters'
        },
        {
            ptype: 'clipboard'
        },
    ]

});