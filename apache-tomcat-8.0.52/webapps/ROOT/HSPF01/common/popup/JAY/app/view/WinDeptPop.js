/*
 * File: app/view/WinBpPop.js
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

Ext.define('Popup.view.WinDeptPop', {
    extend: 'Ext.window.Window',
    alias: 'widget.windeptpop',

    requires: [
        'Popup.view.WinDeptPopViewModel',
        'Popup.view.WinDeptGrid',
        'Ext.form.field.Text',
        'Ext.grid.Panel',
        'Ext.button.Button'
    ],

    viewModel: {
        type: 'windeptpop'
    },
    modal: true,
    height: 434,
    width: 422,
    layout: 'fit',
    bodyPadding: 5,
    id: 'WinDeptPop',
    title: '부서조회',

    items: [
        {
            xtype: 'container',
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'container',
                    flex: 1,
                    height: 45,
                    maxHeight: 45,
                    minHeight: 45,
                    layout: {
                        type: 'hbox',
                        align: 'middle'
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            flex: 1,
                            id: 'W_DEPT_CD',
                            maxWidth: 200,
                            minWidth: 200,
                            width: 200,
                            fieldLabel: '부서코드',
                            labelWidth: 80,
                            name: 'search_field',
                        },
                        {
                            xtype: 'textfield',
                            flex: 1,
                            margins: '',
                            id: 'W_DEPT_NM',
                            maxWidth: 200,
                            minWidth: 200,
                            width: 200,
                            fieldLabel: '부서명',
                            labelAlign: 'right',
                            labelWidth: 80,
                            name: 'search_field',
                        }
                    ]
                },
                {
                    xtype: 'container',
                    flex: 1,
                    layout: 'fit',
                    items: [
                        {
                            xtype: 'windeptgrid'
                        }
                    ]
                },
                {
                    xtype: 'container',
                    flex: 1,
                    margins: '',
                    height: 30,
                    margin: '3 0 0 0',
                    maxHeight: 30,
                    minHeight: 30,
                    layout: {
                        type: 'vbox',
                        align: 'center'
                    },
                    items: [
                        {
                            xtype: 'button',
                            flex: 1,
                            height: 30,
                            id: 'deptSelBtn',
                            maxHeight: 30,
                            minHeight: 30,
                            width: 100,
                            text: '조회'
                        },
                        {
                        	xtype: 'textfield',
                        	flex: 1,
                        	height: 30,
                        	id: 'fieldType',
                        	hidden: true
                        }
                    ]
                }
            ]
        }
    ]

});