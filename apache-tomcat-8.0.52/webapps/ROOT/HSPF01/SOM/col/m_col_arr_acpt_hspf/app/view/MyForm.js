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

Ext.define('M_COL_ARR_ACPT_HSPF.view.MyForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.myform',

	requires : [ 
		'M_COL_ARR_ACPT_HSPF.view.MyFormViewModel',
		'M_COL_ARR_ACPT_HSPF.view.MyFormViewController',
		'Ext.form.FieldSet', 
		'Ext.form.FieldContainer', 
		'Ext.form.field.Date',
		'Ext.form.field.Text', 
		'Ext.form.field.Number',
	],
	
	controller: 'myform',
	viewModel : {
		type : 'myform'
	},
	margin : '-5 0 0 0',
	padding : '',
	layout : 'auto',
	bodyPadding : '0 10 0 10',
	header : false,
	title : 'MyForm',

	items : [ {
		xtype : 'fieldset',
		height : 150,
		maxHeight : 150,
		minHeight : 150,
		collapsible : true,
		title : '[ SEARCH ]',
		layout : {
			type : 'vbox',
			align : 'stretch',
			pack : 'center',
			padding : 10
		},
		items : [ {
			xtype : 'fieldcontainer',
			flex: 1,
            height: 35,
            maxHeight: 35,
            minHeight: 35,
            width: 400,
			layout : {
				type : 'hbox',
				align : 'stretch'
			},
			items : [ {
                xtype: 'datefield',
                id: 'V_CLS_DT_FR',
                flex: 1,
                maxWidth: 220,
                minWidth: 220,
                width: 220,
                fieldLabel: '정리일',
                labelWidth: 80,
                format: 'Y-m-d',
                listeners : {
                    render : function(datefield) {
                    	var nows = new Date();
                    	nows.setDate(1);
                        datefield.setValue(nows);
                    }	
                },
            },
            {
                xtype: 'datefield',
                id: 'V_CLS_DT_TO',
                flex: 1,
                maxWidth: 140,
                minWidth: 140,
                width: 20,
                fieldLabel: '~',
                labelWidth: 10,
                format: 'Y-m-d',
                listeners : {
                    render : function(datefield) {
                    	var nows = new Date();
                        datefield.setValue(nows);
                    }	
                },
            },
            {
            	xtype: 'combobox',
            	id: 'V_DEPT_CD',
            	margin : '0 0 0 30',
            	margin : '0 0 0 30',
				maxWidth : 220,
				minWidth : 220,
				width : 220,
				fieldLabel : '사업부',
				labelWidth : 80,
                store : Ext.create('Ext.data.Store',{
					fields : ['DTL_NM','DTL_CD'],
					data : [['전체','%'],['일반무역팀','5124'],['철강팀','5128']]
                }),
                displayField: 'DTL_NM',
            	valueField: 'DTL_CD',
            	value: '5124',
            	editable: false,
            	align: 'center',
            	labelAlign: 'right',
//            	labelStyle: 'background-color: #EDEFF5 !important; font-size:12px;',
//                fieldStyle: 'font-size:12px;',
            },
			
			]
		}, {
			xtype : 'fieldcontainer',
			flex: 1,
            height: 35,
            maxHeight: 35,
            minHeight: 35,
            width: 400,
			layout : {
				type : 'hbox',
				align : 'stretch'
			},
			items : [ {
				xtype : 'textfield',
				maxWidth : 220,
				minWidth : 220,
				width : 220,
				fieldLabel : 'LC번호',
				labelWidth : 80,
				id : 'V_LC_DOC_NO',
			}, {
				xtype : 'textfield',
				margin : '0 0 0 30',
				maxWidth : 220,
				minWidth : 220,
				width : 220,
				fieldLabel : 'BL번호',
				labelWidth : 80,
				id : 'V_BL_DOC_NO',
			}, ]
		},]
	} ]

});