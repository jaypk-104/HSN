/*
 * File: app/view/MyGrid1.js
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

Ext.define('M_GR_TOT_HSPF.view.MyGrid1', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.mygrid1',

    requires: [
        'M_GR_TOT_HSPF.view.MyGrid1ViewModel',
        'Ext.view.Table',
        'Ext.grid.column.RowNumberer',
        'Ext.form.field.Text',
        'Ext.grid.column.Date',
        'Ext.grid.column.Number',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.Exporter',
        'Ext.grid.plugin.CellEditing'
    ],

    config: {
        tbar: [
               {
                   id: 'gridAddBtn1',
                   text: '',
                   margin: '0 3 0 0',
                   glyph: 'xf055@FontAwesome',
                   iconCls: 'grid-add-btn',
                   disabled: true
               },
               {
                   id: 'gridDelBtn1',
                   text: '',
                   margin: '0 3 0 0',
                   glyph: 'xf056@FontAwesome',
                   iconCls: 'grid-del-btn',
//                   disabled: true
               },
               {
                  	id: 'gridSaveBtn',
                  	xtype: 'button',
                  	glyph: 'xf0c7@FontAwesome',
                  	iconCls: 'grid-save-btn',
                  	margin: '0 3 0 0'
              },
              {
           	   xtype: 'button',
           	   id: 'chargeReCalcBtn',
           	   margin: '0 3 0 0',
           	   text: '부대경비재배부',
   	           	style: 'background-color: white; border: 0.5px solid #3367d6;',
   	           	cls: 'blue-btn',
              },
              {
            	  xtype: 'button',
            	  id: 'chargeUpdateBtn',
            	  margin: '0 3 0 0',
            	  text: '경비수정',
            	  style: 'background-color: white; border: 0.5px solid #3367d6;',
            	  cls: 'blue-btn',
              },
               {
                   xtype: 'container',
                   flex: 1
               },
               {
             	   xtype: 'button',
             	   id: 'tempGlCfmBtn',
             	   margin: '0 3 0 0',
             	   text: 'ERP전표생성',
             	   style: 'background-color: white; border: 0.5px solid #3367d6;',
             	   cls: 'blue-btn',
             	   listeners: {
             		   mouseover: function(button, e, eOpts) {
             		        var theTip = Ext.create('Ext.tip.ToolTip', {
             		            html: 'ERP 결의전표 생성',
             		            target: 'tempGlCfmBtn',
             		            showDelay: 0,
             		            mouseOffset:[5,5],
             		            trackMouse: true,
             		            shadow: false
             		        });
             		    }
             	   },
             	   disabled: true
                },
                {
             	   xtype: 'button',
             	   id: 'tempGlCancelBtn',
             	   margin: '0 3 0 0',
             	   text: 'ERP전표취소',
             	   style: 'background-color: white; border: 0.5px solid #3367d6;',
             	   cls: 'blue-btn',
             	   listeners: {
             		   mouseover: function(button, e, eOpts) {
             		        var theTip = Ext.create('Ext.tip.ToolTip', {
             		            html: 'ERP 결의전표 삭제',
             		            target: 'tempGlCancelBtn',
             		            showDelay: 0,
             		            mouseOffset:[5,5],
             		            trackMouse: true,
             		            shadow: false
             		        });
             		    }
             	   },
             	   disabled: true
                },
               {
                   xtype: 'button',
                   glyph: 'xf1c3@FontAwesome',
                   id: 'xlsxDown1',
                   cfg: {
                       type: 'excel07',
                       ext: 'xlsx'
                   },
                   iconCls: 'grid-excel-btn',
               }
           ]
    },

    viewModel: {
        type: 'mygrid1'
    },
    id: 'myGrid1',
    style: 'border: 1px solid #659DDC; padding: 5px;',
    bodyBorder: false,
    header: false,
    store: 'MyStore1',

    columns: [
        {
            xtype: 'rownumberer',
            width: 40
        },
        {
            xtype: 'gridcolumn',
            hidden: true,
            text: 'V_TYPE',
            hidden: true
        },
        {
            xtype: 'datecolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold; ',
            dataIndex: 'MVMT_DT',
            text: '입고일',
            format: 'Y-m-d',
            align:'center',
//            editor: {
//            	xtype: 'datefield',
//            	format: 'Y-m-d',
//            }
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'MVMT_NO',
            enableTextSelection: true,
            text: '입고번호',
            width: 170
        },
        {
            xtype: 'gridcolumn',
            id: 'string16',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'IV_TYPE_NM',
            enableTextSelection: true,
            text: '입고형태',
            align: 'center'
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'M_BP_NM',
            enableTextSelection: true,
            text: '매입처',
            width: 170
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	sortable: true,
        	dataIndex: 'BL_DOC_NO',
        	enableTextSelection: true,
        	text: 'B/L번호',
        	width: 170
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'ITEM_CD',
            enableTextSelection: true,
            width: 120,
            text: '품목코드',
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'ITEM_NM',
            enableTextSelection: true,
            text: '품목명',
            width: 170
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'SPEC',
            enableTextSelection: true,
            text: '규격',
            hidden: true
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'UNIT',
            enableTextSelection: true,
            text: '단위',
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	sortable: true,
        	dataIndex: 'CUR',
        	enableTextSelection: true,
        	text: '화폐단위',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: 'BOX수량',
            align: 'end',
            format: '0,000.00',
            dataIndex: 'BOX_QTY',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.00') + "<font>";
    		},
    		hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '단위중량',
            align: 'end',
            format: '0,000.00',
            dataIndex: 'BOX_WGT_UNIT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.00') + "<font>";
    		},
    		hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '총 중량',
            align: 'end',
            format: '0,000.00',
            dataIndex: 'QTY',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.00') + "<font>";
    		}
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;  ',
        	text: '가단가유무',
        	dataIndex: 'TEMP_PRC_YN',
        	align: 'center',
        	width: 80,
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '단가',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'PRICE'
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '금액',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'DOC_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
    		width: 130
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            sortable: true,
            dataIndex: 'SL_NM',
            enableTextSelection: true,
            text: '창고',
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	text: '선적환율',
        	align: 'end',
        	format: '0,000.00',
        	dataIndex: 'XCHG_RT',
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            text: '선적자국금액',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'LOC_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
    		width: 130
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	text: '선물환율',
        	align: 'end',
        	format: '0,000.00',
        	dataIndex: 'FORWARD_XCH_RT',
        	hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: '선물환율자국금액',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'FORWARD_XCH_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
    		width: 130,
    		hidden: true
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: 'L/C오픈비',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'LC_OPEN_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
    		width: 130
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 124,
        	text: 'L/C어멘드비',
        	align: 'end',
        	format: '0,000.0000',
        	dataIndex: 'LC_AMEND_AMT',
        	summaryType : 'sum',
        	summaryRenderer : function(value, summaryData, dataIndex) {
        		return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
        	}
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 124,
        	text: '보험료',
        	align: 'end',
        	format: '0,000.0000',
        	dataIndex: 'INSUR_AMT',
        	summaryType : 'sum',
        	summaryRenderer : function(value, summaryData, dataIndex) {
        		return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
        	}
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 124,
        	text: '통관료',
        	align: 'end',
        	format: '0,000.0000',
        	dataIndex: 'TONG_AMT',
        	summaryType : 'sum',
        	summaryRenderer : function(value, summaryData, dataIndex) {
        		return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
        	}
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: '관세',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'GWAN_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		},
    		width: 130
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: '인수수수료',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'INSU_AMT',

    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		}
        },
        {
            xtype: 'numbercolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: '기타경비',
            align: 'end',
            format: '0,000.0000',
            dataIndex: 'ETC_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		}
        },
        {
        	xtype: 'numbercolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 124,
        	text: '경비 합계',
        	align: 'end',
        	format: '0,000.0000',
        	dataIndex: 'TOTAL_AMT',
    		summaryType : 'sum',
    		summaryRenderer : function(value, summaryData, dataIndex) {
    			return "<font color='green'>" + Ext.util.Format.number(value, '0,000.0000') + "<font>";
    		}
        },
        {
            xtype: 'gridcolumn',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            width: 124,
            text: 'CC_NO',
            dataIndex: 'CC_NO',
            hidden: true
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 124,
        	text: 'CC_SEQ',
        	dataIndex: 'CC_SEQ',
            hidden: true
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 110,
        	text: '입고등록자',
        	dataIndex: 'GR_USR_NM',
//        	hidden: true
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 90,
        	text: '출고유무',
        	dataIndex: 'DN_YN',
        	align: 'center',
        	hidden: true
        },
        {
        	xtype: 'gridcolumn',
        	style: 'font-size: 12px; text-align: center; font-weight: bold;',
        	width: 150,
        	text: '전표번호',
        	dataIndex: 'TEMP_GL_NO',
//        	hidden: true
        },
    ],
    selModel: {
        selType: 'checkboxmodel',
        listeners: {
        	select: function(rowmodel, record, index, eOpts) {
    			record.set('V_TYPE', 'V');
            },
            deselect: function(rowmodel, record, index, eOpts) {
    			record.set('V_TYPE', '');
            }
        }
    },
    plugins: [
        {
            ptype: 'gridexporter'
        },
        {
            ptype: 'cellediting'
        }
    ],
	features : [ {
		ftype: 'summary',
        dock: 'bottom'
	} ],
    viewConfig: {
    	enableTextSelection: true,
    },

});