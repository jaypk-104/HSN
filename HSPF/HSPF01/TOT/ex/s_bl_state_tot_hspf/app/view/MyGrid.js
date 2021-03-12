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

Ext.define('S_BL_STATE_TOT_HSPF.view.MyGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.myGrid',

    requires: [
        'S_BL_STATE_TOT_HSPF.view.MyGridViewModel',
        'S_BL_STATE_TOT_HSPF.view.MyGridViewController',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.grid.column.Number',
        'Ext.form.field.Number',
        'Ext.grid.column.Date',
        'Ext.form.field.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.RowEditing'
    ],

    config: {
        tbar: [
//            {
//                id: 'gridAddBtn',
//                text: '',
//                margin: '0 3 0 0',
//                glyph: 'xf055@FontAwesome',
//                iconCls: 'grid-add-btn',
//            },
//            {
//                id: 'gridDelBtn',
//                text: '',
//                margin: '0 3 0 0',
//                glyph: 'xf056@FontAwesome',
//                iconCls: 'grid-del-btn'
//            },
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

    controller: 'mygrid',
    viewModel: {
        type: 'mygrid'
    },
    id: 'myGrid',
    style: 'border: 1px solid #659DDC; padding: 5px;',
    bodyBorder: false,
    header: false,
    store: 'MyStore',

    viewConfig : {
		enableTextSelection : true,
	},
	
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
            style: 'text-align: center; font-weight: bold;',
            width: 100,
            dataIndex: 'BP_CD',
            text: '수입자',
            align : 'center',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            width: 200,
            dataIndex: 'BP_NM',
            text: '수입자명',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'BL_NO',
            text: 'B/L관리번호',
            width: 150,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'BL_DOC_NO',
            text: 'B/L번호',
            width: 150,
        },
        {
    		xtype : 'datecolumn',
    		dataIndex : 'LOADING_DT',
    		style : 'text-align: center; font-weight: bold;',
    		text : '선적일',
    		align : 'center',
    		format : 'Y-m-d',
    		width : 100
    	},
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'SALE_TYPE_NM',
            text: '매출유형',
            width: 120,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'ED_DOC_NO',
            text: '통관신고번호',
            width: 150,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'INVOICE_NO',
            text: '인보이스번호',
            width: 150,
        },
        {
    		xtype : 'datecolumn',
    		dataIndex : 'INVOICE_DT',
    		style : 'text-align: center; font-weight: bold;',
    		text : '인보이스일자',
    		align : 'center',
    		format : 'Y-m-d',
    		width : 100
    	},
    	{
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'SALE_GRP_NM',
            text: '수금그룹',
            width: 150,
        },
        {
    		xtype : 'datecolumn',
    		dataIndex : 'IN_PLAN_DT',
    		style : 'text-align: center; font-weight: bold;',
    		text : '결제예정일',
    		align : 'center',
    		format : 'Y-m-d',
    		width : 100
    	},
    	{
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'CUR',
            text: '통화',
            width: 90,
            align : 'center',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'IN_TERMS_NM',
            text: '가격조건',
            width: 150,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'PAY_METH_NM',
            text: '결제방법',
            width: 150,
        },
        {
			xtype : 'gridcolumn',
			dataIndex : 'DOC_AMT',
			style : 'text-align: center; font-weight: bold;',
			align : 'end',
			text : 'B/L금액',
			width : 130,
			format : '0,000.0000',
			renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000.0000');
            },
            summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
        },
        {
			xtype : 'gridcolumn',
			dataIndex : 'LOC_AMT',
			style : 'text-align: center; font-weight: bold;',
			align : 'end',
			text : '자국금액',
			width : 130,
			format : '0,000',
			renderer: function(value) {
            	return Ext.util.Format.number(value, '0,000');
            },
            summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000') + "<font>";
    		},
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'DISCHGE_PORT',
            text: '도착항',
            width: 90,
            align : 'center',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'DIS_PORT_NM',
            text: '도착항명',
            width: 150,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'LOADING_PORT',
            text: '선적항',
            width: 90,
            align : 'center',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'LD_PORT',
            text: '선적항명',
            width: 150,
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'INSRT_USR_NM',
            text: '등록자',
            width: 100,
            align : 'center',
        },
        {
            xtype: 'gridcolumn',
            style: 'text-align: center; font-weight: bold;',
            dataIndex: 'CFM_YN',
            text: '확정',
            width: 90,
            align : 'center',
        },
        {
			xtype : 'gridcolumn',
			dataIndex : 'REMARK',
			style : 'text-align: center; font-weight: bold;',
			text : '비고',
			width : 150,
        },
    ],
    selModel: {
        selType: 'checkboxmodel',
        listeners: {}
    },
    features : [ {
		ftype: 'summary',
        dock: 'bottom'
	} ],
    plugins: [
        {
            ptype: 'gridexporter'
        }, {
    		ptype : 'cellediting',
    	    clicksToEdit: 1,
    	    listeners : {
    	    	
			},
    	}
    ]

});