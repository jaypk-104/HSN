/*
 * File: app/view/MyForm.js
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

Ext.define('M_CHARGE_STEEL.view.MyForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.myform',

    requires: [
        'M_CHARGE_STEEL.view.MySearchFormViewModel',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.ComboBox',
        'Ext.form.field.Date'
    ],

    viewModel: {
        type: 'mysearchform'
    },
    margin: '-5 0 0 0',
    padding: '',
    layout: 'auto',
    bodyPadding: '0 10 0 10',
    header: false,
    title: 'MyForm1',

    items: [
        {
            xtype: 'fieldset',
            cls: 'gridfieldset',
            height: 100,
            maxHeight: 100,
            minHeight: 100,
            collapsible: true,
            title: '[ SEARCH ]',
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
            	        	xtype: 'combobox',
            	        	maxWidth: 230,
            	        	minWidth: 230,
            	        	width: 230,
            	        	fieldLabel: '진행구분',
            	        	id: 'V_PR_STEP',
            	        	labelWidth: 80,
            	        	blankText: '',
            	        	displayField: 'DTL_NM',
            	        	valueField: 'DTL_CD',
            	        	editable: false,
            	        	store: Ext.create('Ext.data.Store',{
            	        		autoLoad: true,
            	        		storeId: 'store1',
            	        		proxy: {
            	        			type: 'ajax',
            	        			extraParams: {
            	        				V_MAST_CD: 'MA15',
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
                                          '<div>{DTL_NM} ({DTL_CD}) </div>'
                                          ],
                                  },
                          fieldStyle: 'background-color: #ffefbb'
            	        },
                        {
                            xtype: 'textfield',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '발생근거번호',
                            labelWidth: 80,
                            name: 'search_field',
                            emptyText: '(Double Click)',
                            id: 'V_BAS_NO',
                            listeners: {
                                afterrender: function(c) {
                                	c.getEl().on('dblclick', function() {
                                		
                                		var width = Ext.getBody().getViewSize().width;
                            			var height = Ext.getBody().getViewSize().height - 200;
                                		
                                		if(Ext.getCmp('V_PR_STEP').getValue() == 'VC') {
                                			var popup = Ext.create("M_CHARGE_STEEL.view.WinCcPop");
                                			popup.setSize(width, height);
                                			popup.center();
                                			popup.show();
                                			
                                			var popStore = Ext.getStore('PopStore');
//                                			popStore.removeAll();
                                			
                                			M_CHARGE_STEEL.app.getController("MyPopController").popSelBtnClick();
                                			
                                		} else if (Ext.getCmp('V_PR_STEP').getValue() == 'VB') {
                                			var popup = Ext.create("M_CHARGE_STEEL.view.WinBlPop");
                                			popup.setSize(width, height);
                                			popup.center();
                                			popup.show();
                                			
                                			var popStore = Ext.getStore('PopStore');
                                			M_CHARGE_STEEL.app.getController("MyPopController").popSelBtnClick();
//                                			popStore.removeAll();
                                			
                                		} else if (Ext.getCmp('V_PR_STEP').getValue() == 'VL') {
                                			var popup = Ext.create("M_CHARGE_STEEL.view.WinLcPop");
                                			popup.setSize(width, height);
                                			popup.center();
                                			popup.show();
                                			
                                			var popStore = Ext.getStore('PopStore');
                                			M_CHARGE_STEEL.app.getController("MyPopController").popSelBtnClick();
//                                			popStore.removeAll();
                                			
                                		} else {
                                			Ext.Msg.alert('확인', '진행구분을 선택하세요.');
                                		}
                            			
                                    });
                                }
                            },
                            fieldStyle: 'background-color: #ffefbb'
                        },
                        {
                            xtype: 'textfield',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: 'L/C번호',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: '',
                            id: 'V_LC_DOC_NO',
//                            hidden: true
                        },
                        {
                            xtype: 'textfield',
                            margin: '0 0 0 30',
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: 'B/L번호',
                            labelWidth: 80,
                            name: 'search_field',
                            blankText: '',
                            id: 'V_BL_DOC_NO'
                        },
                        {
                        	xtype: 'textfield',
                        	margin: '0 0 0 30',
                        	maxWidth: 230,
                        	minWidth: 230,
                        	width: 230,
                        	fieldLabel: '수입번호',
                        	labelWidth: 80,
                        	name: 'search_field',
                        	id: 'V_ID_NO',
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
                    hidden: true,
                    items: [
                        {
                            xtype: 'datefield',
                            flex: 1,
                            maxWidth: 230,
                            minWidth: 230,
                            width: 230,
                            fieldLabel: '발생일',
                            labelWidth: 80,
                            format: 'Y-m-d',
                            altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
                            listeners : {
                                render : function(datefield) {
                                	var nows = new Date();
                                	nows.setDate(1);
                                    datefield.setValue(nows);
                                }	
                            },
                            id: 'V_BAS_DT_FR'
                        },
                        {
                            xtype: 'datefield',
                            flex: 1,
                            maxWidth: 150,
                            minWidth: 150,
                            width: 20,
                            fieldLabel: '~',
                            labelWidth: 10,
                            format: 'Y-m-d',
                            altFormats: 'm/d/Y|n/j/Y|n/j/y|m/j/y|n/d/y|m/j/Y|n/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d|n-j|n/j|Ymd',
                            listeners : {
                                render : function(datefield) {
                                	var nows = new Date();
                                    datefield.setValue(nows);
                                }	
                            },
                            id: 'V_BAS_DT_TO'
                        },
                    ]
                }
            ]
        }
    ]

});