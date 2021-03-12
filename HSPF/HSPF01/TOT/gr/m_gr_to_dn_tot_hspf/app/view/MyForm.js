/*
 * File: app/view/MyForm.js
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

Ext.define('M_GR_TO_DN_TOT_HSPF.view.MyForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.myform',

    requires: [
        'M_GR_TO_DN_TOT_HSPF.view.MyFormViewModel',
        'M_GR_TO_DN_TOT_HSPF.view.MyFormViewController',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.Date'
    ],

    controller: 'myform',
    viewModel: {
        type: 'myform'
    },
    layout: 'auto',
    bodyPadding: '0 10 0 10',
    header: false,
    title: 'My Form',

    items: [
        {
            xtype: 'fieldset',
            height: 150,
            maxHeight: 150,
            minHeight: 150,
            title: '[ Search ]',
            collapsible: true,
            layout: {
                type: 'vbox',
                align: 'stretch',
                pack: 'center'
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
						    maxWidth: 250,
						    minWidth: 250,
						    width: 250,
						    fieldLabel: '입고일자',
						    labelWidth: 80,
						    format: 'Y-m-d',
						    id: 'V_MVMT_DT_FR',
						    listeners : {
                                render : function(datefield) {
                                	var nows = new Date();
                                	nows.setMonth(0);
                                	nows.setDate(1);
                                    datefield.setValue(nows);
                                }	
                            },
						},
						{
						    xtype: 'datefield',
						    flex: 1,
						    maxWidth: 170,
						    minWidth: 170,
						    width: 170,
						    fieldLabel: '~',
						    labelWidth: 20,
						    format: 'Y-m-d',
						    id: 'V_MVMT_DT_TO',
						    listeners: {
						        render: 'onDatefieldRender1'
						    }
						},
                        {
                            xtype: 'textfield',
                            id: 'V_PO_NO1',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '품의번호',
                            labelWidth: 80,
                            name: 'search_field',
                            hidden: true
//						    margin: '0 0 0 30',
                        },
                        {
                            xtype: 'textfield',
                            id: 'V_LC_DOC_NO',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: 'L/C번호',
                            labelWidth: 80,
                            name: 'search_field'
                        },
                        {
                            xtype: 'textfield',
                            id: 'V_BL_DOC_NO',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: 'B/L번호',
                            labelWidth: 80,
                            name: 'search_field'
                        },
                        {
                            xtype: 'textfield',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '매출처',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: '',
                            emptyText: '(Double Click)',
                            id: 'V_S_BP_NM',
                            hidden: true,
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                            			var popup = Ext.create("Popup.view.WinSBpPop");
                            			popup.show();
                            			
                            			Ext.getCmp('fieldType').setValue('M_GR_TO_DN_DISTR');
                            			var store = Ext.getStore('WinSBpPopStore');
                            			store.removeAll();
                                    });
                                }
                            }
                        },
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
            	        	id: 'V_ITEM_CD',
            	        	maxWidth: 230,
            	        	minWidth: 230,
            	        	width: 230,
            	        	fieldLabel: '품목코드',
            	        	labelWidth: 80,
            	        	name: 'search_field',
            	            emptyText: 'Double Click',
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                                		var popup = Ext.create("Popup.view.WinItemPop");
                                        popup.show();
                                        
                                        var store = Ext.getStore('WinItemPopStore');
                                		store.removeAll();
                                		
                                		Ext.getCmp('W_TYPE').setValue('M_GR_TO_DN_TOT_HSPF');

                                		
                                    });
                                }
                            }
            	        },
            	        {
            	        	xtype: 'textfield',
            	        	id: 'V_ITEM_NM',
            	        	margin: '0 0 0 30',
            	        	maxWidth: 230,
            	        	minWidth: 230,
            	        	width: 230,
            	        	fieldLabel: '품목명',
            	        	labelWidth: 80,
            	        	name: 'search_field',
            	        },
            	        {
                            xtype: 'textfield',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '매입처',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: '',
                            emptyText: '(Double Click)',
                            id: 'V_M_BP_NM',
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                            			var popup = Ext.create("Popup.view.WinMBpPop");
                            			popup.show();
                            			
                            			Ext.getCmp('fieldType').setValue('M_GR_STEEL');
                            			var store = Ext.getStore('WinMBpPopStore');
                            			store.removeAll();
                                    });
                                }
                            }
                        },
                    ]
                }
            ]
        }
    ]

});