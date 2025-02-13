/*
 * File: app/view/MySearchForm.js
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

Ext.define('M_GR_BC_RET_HSPF.view.MySearchForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.mysearchform',

    requires: [
        'M_GR_BC_RET_HSPF.view.MySearchFormViewModel',
        'Ext.form.FieldSet',
        'Ext.form.field.Date',
        'Ext.form.RadioGroup',
        'Ext.form.field.Radio'
    ],

    viewModel: {
        type: 'mysearchform'
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
            height: 120,
            maxHeight: 120,
            minHeight: 120,
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
                            xtype: 'datefield',
                            id: 'V_RE_DT_FR',
                            maxWidth: 230,
                            minWidth: 230,
                            style: '',
                            width: 230,
                            fieldLabel: '반품일자',
                            labelWidth: 90,
                            name: 'search_field',
                            editable: false,
                            format: 'Y-m-d',
                            listeners : {
                                render : function(datefield) {
                                	var nows = new Date();
                                	nows.setMonth(nows.getMonth()-1);
                                    datefield.setValue(nows);
                                }	
                            },
                        },
                        {
                            xtype: 'datefield',
                            id: 'V_RE_DT_TO',
                            maxWidth: 150,
                            minWidth: 150,
                            style: '',
                            width: 150,
                            fieldLabel: '~',
                            labelWidth: 10,
                            name: 'search_field',
                            editable: false,
                            format: 'Y-m-d',
                            listeners : {
                                render : function(datefield) {
                                	var nows = new Date();
                                    datefield.setValue(nows);
                                }	
                            },
                        },
                        {
                            xtype: 'textfield',
                            flex: 1,
                            margin: '0 0 0 60',
                            id: 'V_ITEM_CD',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '품목코드',
                            labelWidth: 80,
                            name: 'search_field',
                            emptyText: '(Double Click)',
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                                		var popup = Ext.create("Popup.view.WinItemPop");
                                        popup.show();
                                        
                                        var store = Ext.getStore('WinItemPopStore');
                                		store.removeAll();
                                		
                                		Ext.getCmp('W_TYPE').setValue('M_GR_BC_RET_HSPF');
                                		
                                    });
                                }
                            }
                        }
                    ]
                },
                {
                    xtype: 'fieldcontainer',
                    hidden: true,
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            flex: 1,
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '반품고객사',
                            labelWidth: 90,
                            id: 'V_S_BP_NM',
                            name: 'search_field',
                            emptyText: '(Double Click)',
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                                			var popup = Ext.create("Popup.view.WinSBpPop");
                                			popup.show();
                                			
                                			Ext.getCmp('fieldType').setValue('M_GR_BC_RET_HSPF');
                                			var store = Ext.getStore('WinSBpPopStore');
                                			store.removeAll();
                                    });
                                }
                            },
                        },
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            margin: '0 0 0 60',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '재출고유무',
                            labelWidth: 80,
                            id: 'radio1',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    boxLabel: 'Y',
                                    name: 'rb1', 
                                    inputValue: 'Y' 
                                },
                                {
                                    xtype: 'radiofield',
                                    margin: '0 0 0 -30',
                                    boxLabel: 'N',
                                	name: 'rb1', 
                                	inputValue: 'N',
                                	checked: true
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            margin: '0 0 0 -20',
                            maxWidth: 250,
                            minWidth: 250,
                            width: 250,
                            fieldLabel: '입고반품유무',
                            labelWidth: 90,
                            id: 'radio2',
                            items: [
                                    {
                                        xtype: 'radiofield',
                                        boxLabel: 'Y',
                                        name: 'rb2', 
                                        inputValue: 'Y' 
                                    },
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 0 0 -30',
                                        boxLabel: 'N',
                                    	name: 'rb2', 
                                    	inputValue: 'N',
                                    	checked: true
                                    }
                                ]
                        }
                    ]
                }
            ]
        }
    ]

});