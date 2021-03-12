/*
 * File: app/view/MyGrid1.js
 *
 * This file was generated by Sencha Architect version 4.2.3.
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

Ext.define('Q_BASE_MASTER.view.MyGrid1', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.mygrid1',

    requires: [
        'Q_BASE_MASTER.view.MyGridViewModel1',
        'Q_BASE_MASTER.view.MyGridViewController1',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter'
    ],

    config: {
        tbar: [
            {
                id: 'gridAddBtn1',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf055@FontAwesome',
                iconCls: 'grid-add-btn'
            },
            {
                id: 'gridDelBtn1',
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
	            id: 'gridSaveBtn1',
	            text: '',
	            margin: '0 3 0 0',
	            glyph: 'xf0c7@FontAwesome',
	            iconCls: 'grid-save-btn'
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
            	margin: '0 3 0 0',
            }
        ]
    },

    controller: 'mygrid1',
    viewModel: {
        type: 'mygrid1'
    },
    id: 'myGrid1',
    style: '',
    bodyBorder: false,
    header: false,
    store: 'MyStore1',

    viewConfig: {
        enableTextSelection: true
    },
    columns: [
        {
            xtype: 'gridcolumn',
            hidden: true,
            text: 'V_TYPE'
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 90,
        	align: 'end',
        	dataIndex: 'Q_ID_SEQ',
        	enableTextSelection: true,
        	exportStyle: {
        		format: 'Currency',
        		alignment: {
        			horizontal: 'Right'
        		}
        	},
        	text: '순서',
        	format: '0,000'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 180,
            sortable: true,
            dataIndex: 'INSP_CD',
            enableTextSelection: true,
            text: '검사항목',
            editor: {
                xtype: 'textfield',
            },
            editor: {
        		xtype: 'combobox',
        		displayField: 'DTL_NM',
        		autoLoadOnValue: true,
        		valueField: 'DTL_CD',
        		editable: false,
        		store: Ext.create('Ext.data.Store',{
        			autoLoad: true,
        			storeId: 'gStore2',
        			proxy: {
        		           type: 'ajax',
        		           extraParams: {
        		            	V_MAST_CD: 'QA03',
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
                if(Ext.data.StoreManager.lookup('gStore2').findRecord('DTL_CD',value) !=null)
                {
                    return Ext.data.StoreManager.lookup('gStore2').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'INSP_CD',
            enableTextSelection: true,
            text: '검사항목코드',
            hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 100,
            align: 'end',
            dataIndex: 'MIN_QTY',
            enableTextSelection: true,
            exportStyle: {
                format: 'Currency',
                alignment: {
                    horizontal: 'Right'
                }
            },
            text: '하한값',
            format: '0,000.00',
            editor: {
                xtype: 'numberfield',
                minValue: 0
            }
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 100,
        	align: 'end',
        	dataIndex: 'MID_QTY',
        	enableTextSelection: true,
        	exportStyle: {
        		format: 'Currency',
        		alignment: {
        			horizontal: 'Right'
        		}
        	},
        	text: '중심값',
        	format: '0,000.00',
        	editor: {
                xtype: 'numberfield',
                minValue: 0
            }
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 100,
        	align: 'end',
        	dataIndex: 'MAX_QTY',
        	enableTextSelection: true,
        	exportStyle: {
        		format: 'Currency',
        		alignment: {
        			horizontal: 'Right'
        		}
        	},
        	text: '상한값',
        	format: '0,000.00',
        	editor: {
                xtype: 'numberfield',
                minValue: 0
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 100,
            sortable: true,
            dataIndex: 'UNIT',
            enableTextSelection: true,
            text: '단위',
            editor: {
                xtype: 'textfield',
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'INSP_TYPE_CD',
            enableTextSelection: true,
            text: '검사기준',
            editor: {
                xtype: 'textfield',
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'INSP_CHECK_CD',
            enableTextSelection: true,
            text: '측정방법',
            editor: {
                xtype: 'textfield',
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'IN_QC_TYPE',
            enableTextSelection: true,
            text: '기본값',
            editor: {
                xtype: 'textfield',
            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'IM_TYPE',
            enableTextSelection: true,
            text: '수입검사대상',
            editor: {
        		xtype: 'combobox',
        		displayField: 'DISPLAY',
        		autoLoadOnValue: true,
        		valueField: 'VALUE',
        		editable: false,
        		store : Ext.create('Ext.data.Store',{
        			storeId: 'StatusGbStore1',
					fields : [ 'DISPLAY', 'VALUE'],
					data : [['Y',1], ['N',0]]
    			}),
        	},
        	renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('StatusGbStore1').findRecord('VALUE',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('StatusGbStore1').findRecord('VALUE',value).get('DISPLAY');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'USE_YN',
            enableTextSelection: true,
            text: '중점관리대상',
            editor: {
        		xtype: 'combobox',
        		displayField: 'DISPLAY',
        		autoLoadOnValue: true,
        		valueField: 'VALUE',
        		editable: false,
        		store : Ext.create('Ext.data.Store',{
        			storeId: 'StatusGbStore2',
					fields : [ 'DISPLAY', 'VALUE'],
					data : [['Y',1], ['N',0]]
    			}),
        	},
        	renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('StatusGbStore2').findRecord('VALUE',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('StatusGbStore2').findRecord('VALUE',value).get('DISPLAY');
                }
                return value;
            },
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 130,
            sortable: true,
            dataIndex: 'CFM_YN',
            enableTextSelection: true,
            text: '사용여부',
            editor: {
        		xtype: 'combobox',
        		displayField: 'DISPLAY',
        		autoLoadOnValue: true,
        		valueField: 'VALUE',
        		editable: false,
        		store : Ext.create('Ext.data.Store',{
        			storeId: 'StatusGbStore3',
					fields : [ 'DISPLAY', 'VALUE'],
					data : [['Y',1], ['N',0]]
    			}),
        	},
        	renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('StatusGbStore3').findRecord('VALUE',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('StatusGbStore3').findRecord('VALUE',value).get('DISPLAY');
                }
                return value;
            },
        }
    ],
    selModel: {
        selType: 'checkboxmodel',
//        checkOnly: true,
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
            clicksToEdit: 1
        }
    ]

});