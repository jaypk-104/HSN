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

Ext.define('Z_ROLE_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'Z_ROLE_HSPF.view.MyGridViewModel',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.Text',
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
            id: 'ROLE_CD',
            style: 'text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'ROLE_CD',
            enableTextSelection: true,
            text: '롤코드',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '필수 입력사항입니다.'
            }
        },
        {
            xtype: 'gridcolumn',
            id: 'ROLE_NM',
            style: 'text-align: center; font-weight: bold; ',
            sortable: true,
            dataIndex: 'ROLE_NM',
            enableTextSelection: true,
            text: '롤명',
            width: 200,
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '필수 입력사항입니다.'
            }
        },
        {
            xtype: 'gridcolumn',
            id: 'PGM_CNT',
            align: 'right',
            style: 'text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'PGM_CNT',
            enableTextSelection: true,
            text: '프로그램 본수',
            width: 130,
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
            	edit: function(editor, context){
            		var selModel = Ext.getCmp('myGrid').getSelectionModel();
            		selModel.select(context.record, true);
            	}
            }
        }
    ],
});