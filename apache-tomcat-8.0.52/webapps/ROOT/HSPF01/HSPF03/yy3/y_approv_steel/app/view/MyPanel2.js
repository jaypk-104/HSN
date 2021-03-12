Ext.define('Y_APPROV_STEEL.view.MyPanel2', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel2',

    requires: [
        'Y_APPROV_STEEL.view.MyPanel2ViewModel',
        'Ext.form.Panel',
        'Ext.form.FieldSet',
        'Ext.form.FieldContainer',
        'Ext.form.field.TextArea'
    ],

    viewModel: {
        type: 'mypanel2'
    },
    layout: 'fit',
    title: 'TAB 3',

    items: [
        {
            xtype: 'container',
            flex: 1,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'form',
                    layout: 'auto',
                    bodyPadding: '0 10 0 10',
                    header: false,
                    title: 'My Form',
                    items: [
                        {
                            xtype: 'fieldset',
                            height: 100,
                            maxHeight: 100,
                            minHeight: 100,
                            title: '[ Search ]',
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
                                            xtype: 'textfield',
                                            maxWidth: 250,
                                            minWidth: 250,
                                            width: 250,
                                            fieldLabel: '품의관리번호',
                                            name: 'search_field',
                                            id: 'V_APPROV_MGM_NO3',
                                            emptyText: '(Double Click)',
                                            listeners: {
                                                afterrender: function(c) {
                                                	c.getEl().on('dblclick', function() {
                                                		var popup = Ext.create("Y_APPROV_STEEL.view.WinApprovPop");
                                                        
                                                        popup.setSize(Ext.getBody().getViewSize());
                                                        popup.show();
                                                        
                                                        Y_APPROV_STEEL.app.getController("ApprovPopController").w_approvSelBtnClick();
//                                                        var store = Ext.getStore('PopStore1');
//                                                		store.removeAll();
                                                    });
                                                }
                                            },
                                        fieldStyle: 'background-color: #ffefbb'
                                        },
                                        {
                                        	xtype: 'textfield',
                                        	maxWidth: 250,
                                        	minWidth: 250,
                                        	width: 250,
                                        	fieldLabel: '품의번호',
                                        	name: 'search_field',
                                        	id: 'V_APPROV_NO3',
                                        	margin: '0 0 0 30'
                                        },
                                        {
                                        	xtype: 'textfield',
                                        	maxWidth: 250,
                                        	minWidth: 250,
                                        	width: 250,
                                        	fieldLabel: '품의차수',
                                        	name: 'search_field',
                                        	id: 'V_APPROV_SEQ3',
                                        	margin: '0 0 0 30'
                                        },
                                        {
                                        	xtype: 'textfield',
                                        	maxWidth: 450,
                                        	minWidth: 450,
                                        	width: 450,
                                        	fieldLabel: '품의명',
                                        	name: 'search_field',
                                        	id: 'V_APPROV_NM3',
                                        	margin: '0 0 0 30'
                                        },
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'container',
                    flex: 1,
                    layout: 'fit',
                    items: [
                        {
                            xtype: 'tabpanel',
                            activeTab: 0,
                            id: 'T3',
                            dockedItems: {
                                dock: 'bottom',
                                xtype: 'toolbar',
                                items: [{
                                    text: '내용추가',
                                    glyph: 43,
                                    listeners: {
                                        click: function() {
                                        	var tabPanel = Ext.getCmp('T3');
                                            tab = tabPanel.add({
                                                title: '0' + (tabPanel.items.length + 1),
                                            	layout: 'fit',
                                            	closable : true,
                                                items: [
                                                        {
                                                            xtype: 'panel',
                                                            layout: 'fit',
                                                            items: [
                                                                {
                                                                    xtype: 'container',
                                                                    padding: 10,
                                                                    layout: {
                                                                        type: 'vbox',
                                                                        align: 'stretch'
                                                                    },
                                                                    items: [
                                                                            {
                                                                                xtype: 'textareafield',
                                                                                flex: 1,
                                                                                height: 189,
                                                                                style: 'border: 1px solid lightgray; padding : 5px',
                                                                                width: 844,
                                                                                fieldLabel: '매입',
                                                                                labelStyle: 'text-align: center',
                                                                                value: '1. 거래예정일 : 기안서 결재 완료 후 진행\n\n2. 거래형태 : \n  1) 수입금액 : \n  2) 부대비용 : \n\n3. 대금결제방식 : ',
                                                                                id: 'IV0'+(tabPanel.items.length + 1)
                                                                            },
                                                                            {
                                                                                xtype: 'textareafield',
                                                                                flex: 1,
                                                                                height: 189,
                                                                                style: 'border: 1px solid lightgray; padding : 5px',
                                                                                width: 844,
                                                                                fieldLabel: '매출',
                                                                                labelStyle: 'text-align: center',
                                                                            	value: '1. 대금결제방식 : 출고 전 현금 입금\n\n2. 창고 : ㈜판토스 계약 창고 이용, 소재지 : 광주, 용인, 이천 ',
                                                                            	id: 'SL0'+(tabPanel.items.length + 1)
                                                                            }
                                                                        ]
                                                                }
                                                            ]
                                                        },
                                                    ]
                                            });
                                        tabPanel.setActiveTab(tab);
                                        }
                                    }
                                }]
                            }
                        }
                    ]
                }
            ]
        }
    ]

});