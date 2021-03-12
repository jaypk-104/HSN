/*
 * File: app/view/MySearchForm1.js
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

Ext.define('Q_BASE_MASTER.view.MySearchForm1', {
    extend: 'Ext.form.Panel',
    alias: 'widget.mysearchform1',

    requires: [
        'Q_BASE_MASTER.view.MySearchFormViewModel1',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.Text'
    ],

    viewModel: {
        type: 'mysearchform1'
    },
    padding: '',
    layout: 'auto',
    bodyPadding: 10,
    header: false,
    title: 'MyForm',

    items: [
        {
            xtype: 'fieldset',
            cls: 'gridfieldset',
            height: 180,
            maxHeight: 180,
            minHeight: 180,
            title: 'Search',
            layout: {
                type: 'vbox',
                align: 'stretch',
                pack: 'center',
                padding: 10
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
                            id: 'W_BP_NM',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '협력사',
                            labelStyle: 'font-size: 12px',
                            labelWidth: 80,
                            name: 'search_field',
                            fieldStyle: 'background-color: #EEEEEE',
                            readOnly: true,
                            blankText: ''
                        },
                        {
                            xtype: 'textfield',
                            id: 'W_ITEM_CD',
                            margin: '0 0 0 100',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '품목코드',
                            labelStyle: 'font-size: 12px',
                            labelWidth: 80,
                            name: 'search_field',
                            fieldStyle: 'background-color: #EEEEEE',
                            readOnly: true,
                            blankText: ''
                        }
                    ]
                },
                {
                    xtype: 'fieldcontainer',
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            id: 'W_REV_NO',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '개정',
                            labelStyle: 'font-size: 12px',
                            labelWidth: 80,
                            name: 'search_field',
                            fieldStyle: 'background-color: #EEEEEE',
                            readOnly: true,
                            blankText: ''
                        },
                        {
                            xtype: 'textfield',
                            margin: '0 0 0 100',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '개정증가',
                            labelStyle: 'font-size: 12px',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: ''
                        }
                    ]
                },
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
                            fieldLabel: '개정사유',
                            labelStyle: 'font-size: 12px',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: ''
                        }
                    ]
                }
            ]
        }
    ]

});