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

Ext.define('B_COMP_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'B_COMP_HSPF.view.MyGridViewModel',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.ComboBox',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing'
    ],

    config: {
        tbar: [
            {
                id: 'gridAddBtn',
                text: '',
                margin: '0 3 0 0',
                glyph: 'xf055@FontAwesome',
                iconCls: 'grid-add-btn'
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

    viewModel: {
        type: 'mygrid'
    },
    id: 'myGrid',
    style: 'border: 1px solid #659DDC; padding: 5px;',
    bodyBorder: false,
    header: false,
    store: 'MyStore',
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
            xtype: 'gridcolumn',
            id: 'COMP_ID',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'COMP_ID',
            enableTextSelection: true,
            text: '회사코드',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
            }
        },
        {
            xtype: 'gridcolumn',
            id: 'COMP_NM',
            maxWidth: 250,
            minWidth: 250,
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 250,
            sortable: true,
            dataIndex: 'COMP_NM',
            enableTextSelection: true,
            text: '회사명',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
            }
        },
        {
            xtype: 'gridcolumn',
            id: 'COMP_TYPE',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            dataIndex: 'COMP_TYPE',
            text: '회사유형',
            width: 120,
            editor: {
                xtype: 'combobox',
                autoLoadOnValue: true,
                allowBlank: false,
                store: Ext.create('Ext.data.Store',{
            		autoLoad: true,
            		storeId: 'store1',
            		proxy: {
                        type: 'ajax',
                        extraParams: {
                         	V_MAST_CD: 'BA01',
                         	V_GRID: 'Y',
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
            	editable: false,
            	displayField: 'DTL_NM',
    		    valueField : 'DTL_CD',
    		    mode: 'local',
            },
            renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
                if(Ext.data.StoreManager.lookup('store1').findRecord('DTL_CD',value) !==null)
                {
                    return Ext.data.StoreManager.lookup('store1').findRecord('DTL_CD',value).get('DTL_NM');
                }
                return value;
            },
        }
    ],
    selModel: {
        selType: 'checkboxmodel',
        checkOnly: true,
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
            clicksToEdit: 1,
            listeners: {
                //수정전
            	beforeedit: function(editor, context, eOpts) {
            		var cm = this.grid.getView().getHeaderCt().getGridColumns();
            		if(context.record.data.COMP_ID!=undefined) {
            			cm[3].setEditor(null);
            		} else {
	                  	//회사코드
	                  	cm[3].setEditor({
	                          xtype: 'textfield',
	                          allowBlank: false,
	                  	});
            		}
            	},
	          //수정후
        		edit: function(editor, context, eOpts) {
		          	var selModel= Ext.getCmp('myGrid').getSelectionModel();
		          	selModel.select(context.record, true);
	          }
         }
        }
    ]

});