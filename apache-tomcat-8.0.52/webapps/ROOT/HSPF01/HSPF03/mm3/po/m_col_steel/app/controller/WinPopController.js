/*
 * File: app/controller/WinAddRowController.js
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

Ext.define('M_COL_STEEL.controller.WinPopController', {
	extend : 'Ext.app.Controller',
	stores : [ 'PopStore1', 'PopStore2', 'MyStore1', 'MyStore2' ],

	control : {
		"#w_selBtn1" : {
			click : 'w_selBtn1Click'
		},
		"#w_selBtn2" : {
			click : 'w_selBtn2Click'
		},
		'#w_saveBtn1' : {
			click : 'w_saveBtn1Click'
		},
		'#w_saveBtn2' : {
			click : 'w_saveBtn2Click'
		},
//		'#popGrid1' : {
//			celldblclick : 'w_popGrid1DblClick'
//		},
	},

	w_selBtn1Click : function(button, e, eOpts) {
		var popStore1 = Ext.getStore('PopStore1');
		popStore1.load({
			params : {
				V_TYPE : 'T1D1',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_DT_FR : Ext.getCmp('W_DT_FR').getValue(),
				V_DT_TO : Ext.getCmp('W_DT_TO').getValue(),
				V_DEPT_CD : '5128',
				V_BP_CD : Ext.getCmp('V_S_BP_CD').getValue(),
			},
			callback : function(records, operations, success) {
			}
		});
	},
	
	w_selBtn2Click : function(button, e, eOpts) {
		var popStore2 = Ext.getStore('PopStore2');
		popStore2.load({
			params : {
				V_TYPE : 'T1D1',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_DT_FR : Ext.getCmp('W_DT_FR2').getValue(),
				V_DT_TO : Ext.getCmp('W_DT_TO2').getValue(),
				V_DEPT_CD : '5128',
				V_BP_CD : Ext.getCmp('V_S_BP_CD').getValue(),
			},
			callback : function(records, operations, success) {
			}
		});
	},

	w_saveBtn1Click : function(button, e, eOpts) {
		var popStore1 = Ext.getStore('PopStore1');
		var myStore2 = Ext.getStore('MyStore2');
		
		Ext.Msg.confirm('확인', '저장하시겠습니까?', function(btn) {
			if (btn == 'yes') {

				Ext.Ajax.request({
					url : 'sql/A_AR_RECEIPT.jsp',
					method : 'post',
					params : {
						V_TYPE : 'WH_COL',
						V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
						V_CLS_AR_NO : Ext.getCmp('V_CLS_AR_NO').getValue(),
						V_CLS_DT : Ext.getCmp('V_COL_DT').getValue(),
						V_BP_CD : Ext.getCmp('V_S_BP_CD').getValue(),
						V_DEPT_CD : '5128',
						V_CUR : 'KRW',
						V_MAST_DB_NO : Ext.getCmp('V_MAST_DB_NO').getValue(),
					},
					success : function(response) {
						var res = response.responseText;

						// 정상등록
						if (res.match('CR') || res.match('UPDATE')) {
							if (res.match('CR')) {
								Ext.getCmp('V_CLS_AR_NO').setValue(res);
							}
							
							popStore1.each(function(rec, idx) {
								if (rec.isDirty()) {
									rec.set('V_TYPE', 'I');
								}
							});
							
							popStore1.sync({
								params : {
									V_TYPE : 'WD_COL',
									V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
									V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
									V_CLS_AR_NO : Ext.getCmp('V_CLS_AR_NO').getValue(),
									V_CLS_DT : Ext.getCmp('V_COL_DT').getValue(),
									V_CUR : 'KRW',
									V_MAST_DB_NO : Ext.getCmp('V_MAST_DB_NO').getValue(),
								},
								callback : function(records, operation, success) {
									popStore1.removeAll();
									
//									var winPopController = M_COL_STEEL.app.getController("WinPopController");
//									winPopController.w_selBtn1Click();
//									myStore2.reload();
									myStore2.load({
										params: {
											V_TYPE: 'COL_S',
											V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
											V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
											V_CLS_AR_NO : Ext.getCmp('V_CLS_AR_NO').getValue(),
											V_MAST_DB_NO : Ext.getCmp('V_MAST_DB_NO').getValue(),
										},
										callback: function(records){
											
										}
									});
									
									var popWin = button.up().up();
									popWin.destroy();
									
									Ext.toast({
		    							title : ' ',
		    							timeout : 1000,
		    							html : '저장완료',
		    							style : 'text-align: center',
		    							align : 't',
		    							width : 130,
		    						});
									
								}
							});
						} else {
							Ext.Msg.alert('확인', res);
						}
					}
				});
			}
		});
		
	},
	
	w_saveBtn2Click : function(button, e, eOpts) {
//		var view = button;
		var popStore2 = Ext.getStore('PopStore2');
		var myStore1 = Ext.getStore('MyStore1');
		var myStore2 = Ext.getStore('MyStore2');
		var totBcAmt=0, totDocAmt=0, totColAmt = 0;
		
		var records = Ext.getCmp('popGrid2').getSelection();
		Ext.Msg.confirm('확인', records.length + '건 선택하시겠습니까?', function(btn) {
			if(btn == 'yes') {
				myStore2.removeAll();
				for(var i=0; i<records.length; i++){
					var record = records[i];
					if(record.get('COL_AMT') > 0){
						totBcAmt += record.get('COL_AMT');
						var rec = Ext.create('M_COL_STEEL.model.MyModel', {
							V_TYPE : 'I',
							BC_NO : record.get('BC_NO'),
							COL_AMT : record.get('COL_AMT'),
							REMAIN_AMT : record.get('REMAIN_AMT'),
						});
						myStore2.insert(myStore2.getCount()-1, rec);
					}
				}
				
				myStore1.each(function(rec, idx) {
					var DOC_AMT = rec.get('DOC_AMT');
					totDocAmt += DOC_AMT;
				});
				
				myStore1.each(function(rec, idx) {
					var DOC_AMT = rec.get('DOC_AMT');
					var rate = DOC_AMT / totDocAmt;
					var COL_AMT = Math.round(totBcAmt*rate/1000)*1000
					
					rec.set('COL_AMT', COL_AMT);
					totColAmt += COL_AMT;
					
					if(myStore1.data.length == idx+1){
						var diffAmt = totBcAmt-totColAmt;
						rec.set('COL_AMT', rec.get('COL_AMT')+diffAmt);
					}
				});
				
				popStore2.removeAll();

				var popWin = button.up().up();
				popWin.destroy();
			}
		});

	},

//	w_popGrid1DblClick : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
//		Ext.getCmp('V_CLS_AR_NO').setValue(record.get('CLS_AR_NO'));
//
//		var tbController = A_AR_RECEIPT.app.getController("TbButtonController");
//		tbController.selBtnClick();
//
//		var popStore1 = this.getPopStore1Store();
//		popStore1.removeAll();
//
//		var popWin = tableview.up().up();
//		popWin.destroy();
//	},

});