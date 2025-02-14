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

Ext.define('B_BIZ_EMP.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'B_BIZ_EMP.view.MyGridViewModel',
        'B_BIZ_EMP.view.MyGridViewController',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.ComboBox',
        'Ext.form.field.Number',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing',
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
//                disabled: true
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

    viewConfig: {
        enableTextSelection: true
    },
    columns: [
        {
            xtype: 'rownumberer',
            width: 45
        },
        {
            xtype: 'gridcolumn',
            dataIndex: 'V_TYPE',
            text: 'V_TYPE',
            hidden: true
        },
        {
            xtype: 'gridcolumn',
            dataIndex: 'BP_CD',
            style: 'text-align: center; font-weight: bold;',
            width: 120,
            text: '거래처코드',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                allowOnlyWhitespace: false,
                emptyText:'(Double Click)',
                listeners: {
                    afterrender: function(c) {
                    	c.getEl().on('dblclick', function() {
                			var popup = Ext.create("Popup.view.WinBpPop");
                			popup.show();
                			
                			Ext.getCmp('fieldType').setValue('B_BIZ_EMP');
                			var store = Ext.getStore('WinBpPopStore');
                			store.removeAll();
                        });
                    }
                },
            },
            emptyCellText: '(필수)'
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'BP_NM',
        	style: 'text-align: center; font-weight: bold;',
        	width: 120,
        	text: '거래처명',
        	editor: {
        		xtype: 'textfield',
        		allowBlank: false,
        		allowOnlyWhitespace: false,
        		emptyText:'(Double Click)',
        		listeners: {
                    afterrender: function(c) {
                    	c.getEl().on('dblclick', function() {
                			var popup = Ext.create("Popup.view.WinBpPop");
                			popup.show();
                			
                			Ext.getCmp('fieldType').setValue('B_BIZ_EMP');
                			var store = Ext.getStore('WinBpPopStore');
                			store.removeAll();
                        });
                    }
                },
        	},
        	emptyCellText: '(필수)'
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'EMP_NAME',
        	style: 'text-align: center; font-weight: bold;',
        	width: 120,
        	text: '담당자명',
        	editor: {
        		xtype: 'textfield',
        		allowBlank: false,
        		allowOnlyWhitespace: false,
        	},
        	emptyCellText: '(필수)'
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'TEL_NO',
        	style: 'text-align: center; font-weight: bold;',
        	width: 120,
        	text: '전화번호',
        	editor: {
        		xtype: 'textfield',
        		allowBlank: false,
        		allowOnlyWhitespace: false,
        	},
        	emptyCellText: '(필수)'
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'HAND_TEL',
        	style: 'text-align: center; font-weight: bold;',
        	width: 120,
        	text: '핸드폰번호',
        	editor: {
        		xtype: 'textfield',
        		allowBlank: false,
        		allowOnlyWhitespace: false,
        	},
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'FAX_NO',
        	style: 'text-align: center; font-weight: bold;',
        	width: 120,
        	text: 'FAX번호',
        	editor: {
        		xtype: 'textfield',
        	},
        },
        {
        	xtype: 'gridcolumn',
        	dataIndex: 'EMAIL',
        	style: 'text-align: center; font-weight: bold;',
        	width: 200,
        	text: '이메일주소',
        	editor: {
        		xtype: 'textfield',
        		allowBlank: false,
        		allowOnlyWhitespace: false,
        	},
        	emptyCellText: '(필수)'
        },
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
            ptype: 'clipboard'
        },
        {
            ptype: 'cellediting',
            clicksToEdit: 1,
            clicksToMoveEditor: 1,
            listeners: {
	            //수정후
	            edit: function(editor, context, eOpts) {
	            	var selModel= Ext.getCmp('myGrid').getSelectionModel();
	            	selModel.select(context.record, true);
	            },
	        	beforeedit: function(editor, context) {
	        		if((context.record.phantom == false) 
	        			&& ((context.field == 'BP_CD') || (context.field == 'BP_NM')|| (context.field == 'EMP_NAME'))) {
	        			context.cancel = true;
	        		} else {
	        			context.cancel = false;
	        		}
	            }
            }
        }
    ]

});