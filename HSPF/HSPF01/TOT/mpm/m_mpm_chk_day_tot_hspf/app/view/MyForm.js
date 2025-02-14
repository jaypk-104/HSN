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

Ext.define('M_MPM_CHK_DAY_TOT_HSPF.view.MyForm', {
	extend : 'Ext.form.Panel',
	alias : 'widget.myform',

	requires : [ 
		'M_MPM_CHK_DAY_TOT_HSPF.view.MyFormViewModel',
		'M_MPM_CHK_DAY_TOT_HSPF.view.MyFormViewController',
		'Ext.form.FieldSet', 
		'Ext.form.FieldContainer', 
		'Ext.form.field.Date',
		'Ext.form.field.Text', 
		'Ext.form.field.Number',
	],

	controller : 'myform',
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
		height : 120,
		maxHeight : 120,
		minHeight : 120,
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
			flex : 1,
			height : 35,
			maxHeight : 35,
			minHeight : 35,
			width : 400,
			layout : {
				type : 'hbox',
				align : 'stretch'
			},
			items : [ {
				xtype : 'datefield',
				flex : 1,
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '조회일자',
				labelWidth : 80,
				format : 'Y-m-d',
				listeners : {
					render : function(datefield) {
						var nows = new Date();
						nows.setDate(1);
						datefield.setValue(nows);
					}
				},
				id : 'V_DT_FR',
				name : 'search_field',
			}, {
				xtype : 'datefield',
				flex : 1,
				maxWidth : 150,
				minWidth : 150,
				width : 20,
				fieldLabel : '~',
				labelWidth : 10,
				format : 'Y-m-d',
				listeners : {
					render : function(datefield) {
						var nows = new Date();
						datefield.setValue(nows);
					}
				},
				id : 'V_DT_TO',
				name : 'search_field',
			}, {
				xtype : 'textfield',
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '품목코드',
				labelWidth : 80,
				blankText : '',
				margin : '0 0 0 30',
				id : 'V_ITEM_CD',
			}, {
				xtype : 'textfield',
				maxWidth : 230,
				minWidth : 230,
				width : 230,
				fieldLabel : '품목명',
				labelWidth : 80,
				blankText : '',
				margin : '0 0 0 30',
				id : 'V_ITEM_NM',
			}, {
				xtype : 'combobox',
				margin: '0 0 0 30',
				maxWidth: 230,
                minWidth: 230,
                width: 230,
				fieldLabel : '계열사구분',
				labelWidth : 80,
				value : '',
				id : 'V_BP_CD',
				displayField : 'DTL_NM',
				valueField : 'DTL_CD',
				editable: false,
				store : Ext.create('Ext.data.Store', {
					fields : [ 'DTL_CD', 'DTL_NM' ],
					data : [ {
						"DTL_CD" : "",
						"DTL_NM" : "전체"
					}, {
						"DTL_CD" : "00002",
						"DTL_NM" : "(주)화승소재"
					}, {
						"DTL_CD" : "00007",
						"DTL_NM" : "(주)화승알앤에이"
					} ]
				}),
			}, ]
		}, ]
	} ]

});