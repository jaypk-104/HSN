/*
 * File: app/view/MyPanel1.js
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

Ext.define('M_LC_AMEND_TOT_HSPF.view.MyPanel1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mypanel1',

    requires: [
        'M_LC_AMEND_TOT_HSPF.view.MyPanelViewModel1',
        'Ext.grid.Panel',
        'Ext.grid.column.RowNumberer',
        'Ext.view.Table',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing',
        'Ext.grid.column.Number'
    ],

    viewModel: {
        type: 'mypanel1'
    },
    layout: 'fit',
    title: 'Tab 2',

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
                    xtype: 'gridpanel',
                    flex: 1,
                    style: 'border: 1px solid lightgray; padding: 5px;',
                    header: false,
                    title: 'My Grid Panel',
                    store: 'MyStore2',
                    id: 'myGrid2',
	                tbar: [
	                	{
		                      xtype: 'container',
		                      flex: 1
		                },
		                {
		                      xtype: 'button',
		                      glyph: 'xf1c3@FontAwesome',
		                      id: 'xlsxDown2',
		                      cfg: {
		                          type: 'excel07',
		                          ext: 'xlsx'
		                      },
		                      iconCls: 'grid-excel-btn',
		                }
		            ],
                    columns: [
                        {
                            xtype: 'rownumberer',
                            width: 40
                        },
                        {
                            xtype: 'gridcolumn',
                            hidden: true,
                            text: 'V_TYPE',
                            dataIndex: 'V_TYPE'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            dataIndex: 'PO_NO',
                            enableTextSelection: true,
                            text: '발주번호',
                            width: 150
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'text-align: center; font-weight: bold;',
                            sortable: true,
                            dataIndex: 'PO_SEQ',
                            enableTextSelection: true,
                            text: '발주순번',
                            format: '0,000',
                            align: 'right',
                            width: 100,
                        },
                        {
                        	xtype: 'datecolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'PO_DT',
                        	enableTextSelection: true,
                        	text: '발주일자',
                        	format: 'Y-m-d',
                        	align: 'center'
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            sortable: true,
                            dataIndex: 'M_BP_CD',
                            enableTextSelection: true,
                            text: '매입처',
                            align: 'center',
                            hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            width: 250,
                            sortable: true,
                            dataIndex: 'M_BP_NM',
                            enableTextSelection: true,
                            text: '매입처',
                        },
                        
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'IN_TERMS_NM',
                        	enableTextSelection: true,
                        	text: '가격조건',
                        	width: 250
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'IN_TERMS',
                        	enableTextSelection: true,
                        	text: 'IN_TERMS',
                        	width: 150,
                        	hidden: true
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'PAY_METH_NM',
                        	enableTextSelection: true,
                        	text: '결제방법',
                        	width: 250
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'PAY_METH',
                        	enableTextSelection: true,
                        	text: 'PAY_METH',
                        	width: 150,
                        	hidden: true
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'LC_KIND',
                        	enableTextSelection: true,
                        	text: 'LC_KIND',
                        	width: 150,
                        	hidden: true
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            sortable: true,
                            dataIndex: 'ITEM_CD',
                            enableTextSelection: true,
                            text: '품목코드',
                            width: 120
                        },
                        {
                            xtype: 'gridcolumn',
                            style: 'text-align: center; font-weight: bold;',
                            sortable: true,
                            dataIndex: 'ITEM_NM',
                            enableTextSelection: true,
                            text: '품목명',
                            width: 200
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'UNIT',
                        	enableTextSelection: true,
                        	text: '단위',
                        	width: 80,
                        },
                        {
                        	xtype: 'gridcolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	sortable: true,
                        	dataIndex: 'CUR',
                        	enableTextSelection: true,
                        	text: '화폐단위',
                        	width: 85,
                        },
                        {
                        	xtype: 'numbercolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	dataIndex: 'XCH_RATE',
                        	text: '환율',
                        	format: '0,000.00',
                        	align: 'right',
                        	width: 100
                        },
                        {
                        	xtype: 'numbercolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	dataIndex: 'PO_QTY',
                        	text: '수량',
                        	format: '0,000.00',
                        	align: 'right',
                        	summaryType: 'sum',
                        	summaryRenderer: function (value, summaryData, dataIndex) {
                        		return "<font color='green'>"+Ext.util.Format.number(value, '0,000.00')+"<font>"; 
                        	},
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'text-align: center; font-weight: bold;',
                            dataIndex: 'PO_PRC',
                            text: '단가',
                            format: '0,000.0000',
                            align: 'right',
                        },
                        {
                            xtype: 'numbercolumn',
                            style: 'text-align: center; font-weight: bold;',
                            dataIndex: 'PO_AMT',
                            text: '금액',
                            format: '0,000.0000',
                            align: 'right',
                            summaryType: 'sum',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                	            return "<font color='green'>"+Ext.util.Format.number(value, '0,000.0000')+"<font>"; 
                	        },
                	        width: 130
                        },
                        {
                        	xtype: 'numbercolumn',
                        	style: 'text-align: center; font-weight: bold;',
                        	dataIndex: 'PO_LOC_AMT',
                        	text: '자국금액',
                        	format: '0,000.0000',
                        	align: 'right',
                            summaryType: 'sum',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                	            return "<font color='green'>"+Ext.util.Format.number(value, '0,000.0000')+"<font>"; 
                	        },
                	        width: 130
                        },
                       
                    ],
                    viewConfig: {
                    	enableTextSelection: true,
                    },
                    selModel: {
                        selType: 'checkboxmodel',
                        listeners: {
        					select : function(rowmodel, record, index, eOpts) {
        						var gridRecord = Ext.getCmp('myGrid2').getSelectionModel().getSelection();
        						var selModel = Ext.getCmp('myGrid1').getSelectionModel();
        						var store = Ext.getStore('MyStore2');
        						var store1 = Ext.getStore('MyStore1');
        						var store1Cnt = store1.getCount();
        						
        						var M_BP_CD = record.get('M_BP_CD');
        						var M_BP_CD2 = Ext.getCmp('V_M_BP_CD2').getValue();
        						var PO_NO = Ext.getCmp('V_PO_NO').getValue();
        						var PAY_METH = Ext.getCmp('V_PAY_METH').getValue();
        						var flag = '';
        						var msg = '';
        						
        						record.set('V_TYPE', 'V');

        						if (M_BP_CD2 == '') {
        							flag = 'T';
        							Ext.getCmp('V_M_BP_CD2').setValue(record.get('M_BP_CD'));
        							Ext.getCmp('V_M_BP_NM2').setValue(record.get('M_BP_NM'));
        							Ext.getCmp('V_CUR').setValue(record.get('CUR'));
        							Ext.getCmp('V_XCH_RATE').setValue(record.get('XCH_RATE'));
//        							Ext.getCmp('V_LC_NO').setValue(PO_NO);
//        							Ext.getCmp('V_BANK_CD').setValue(record.get('BANK_CD'));
        							Ext.getCmp('V_PO_NO').setValue(record.get('PO_NO'));
        							Ext.getCmp('V_PAY_METH').setValue(record.get('PAY_METH'));
        							Ext.getCmp('V_IN_TERMS').setValue(record.get('IN_TERMS'));
        							Ext.getCmp('V_LC_KIND').setValue(record.get('LC_KIND'));
        						} else if (M_BP_CD2 != M_BP_CD) {
        							flag = 'F';
        							msg = '동일한 공급사를 선택하세요.';
//        						} else if (PAY_METH != record.get('PAY_METH')) {
//        							flag = 'F';
//        							msg = '결제방법이 일치하지 않습니다.';
//        						} else if (PO_NO != record.get('PO_NO')) {
//        							flag = 'F';
//        							msg = '동일한  발주번호를 선택하세요.';
        						} else {
        							flag = 'T';
        						}

        						if (flag == 'T') {
        							store1.insert(store1Cnt, [ ({
        								V_TYPE : 'V',
        								AMD_FLG : 'U',
        								ITEM_CD : record.get('ITEM_CD'),
        								ITEM_NM : record.get('ITEM_NM'),
        								SPEC : record.get('SPEC'),
        								UNIT : record.get('UNIT'),
        								BE_QTY : 0,
        								AT_QTY : record.get('PO_QTY'),
        								BE_PRICE : 0,
        								AT_PRICE : record.get('PO_PRC'),
        								BE_DOC_AMT : 0,
        								AT_DOC_AMT : record.get('PO_AMT'),
        								BE_LOC_AMT : 0,
        								AT_LOC_AMT : record.get('PO_LOC_AMT'),
        								LC_KIND : record.get('LC_KIND'),
        								LC_DOC_NO : '',
        								LC_NO : '',
        								LC_SEQ : '',
        								PO_NO : record.get('PO_NO'),
        								PO_SEQ : record.get('PO_SEQ'),
        							}) ]);
        						} else {
        							Ext.Msg.alert('확인', msg);
        							selModel.deselect(record, true);
        						}

        					},
        					deselect : function(rowmodel, record, index, eOpts) {
        						var store = Ext.getStore('MyStore2');
        						var store1 = Ext.getStore('MyStore1');
        						var selModel = Ext.getCmp('myGrid2').getSelectionModel();
        						var gridRecord = Ext.getCmp('myGrid2').getSelectionModel().getSelection();

        						store1.each(function(rec, idx) {
        							if (rec.get('PO_NO') == record.get('PO_NO') && rec.get('PO_SEQ') == record.get('PO_SEQ')) {
        								store1.remove(rec);
        							}
        						});

        						// 선택된 정보가 없으면 하단 L/C 정보 BLANK
        						if (store1.getCount() == 0) {
        							var nows = new Date();
        							Ext.getCmp('V_OPEN_DT').setValue(nows);
        							Ext.getCmp('V_AMEND_DT').setValue(nows);
        							Ext.getCmp('V_M_BP_NM2').setValue('');
        							Ext.getCmp('V_M_BP_CD2').setValue('');
        							Ext.getCmp('V_LC_DOC_NO').setValue('');
        							Ext.getCmp('V_LC_NO').setValue('');
        							Ext.getCmp('V_LC_AMEND_SEQ').setValue('');
        							Ext.getCmp('V_BANK_CD').setValue(null);
        							Ext.getCmp('V_CUR').setValue('USD');
        							Ext.getCmp('V_XCH_RATE').setValue(1);
        							
        							Ext.getCmp('V_PO_NO').setValue('');
        							Ext.getCmp('V_PAY_METH').setValue('');
        							Ext.getCmp('V_IN_TERMS').setValue('');
        							Ext.getCmp('V_LC_KIND').setValue('');
        							Ext.getCmp('V_DOC_AMT').setValue('');

        							store1.removeAll();
        						}
        					}
        				}
                    },
                    plugins: [
                        {
                            ptype: 'gridexporter'
                        },
                    ],
                    features : [ {
                		ftype: 'summary',
                        dock: 'bottom'
                	} ]
                },
            ]
        }
    ]

});