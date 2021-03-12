/*
 * File: app/controller/MyGridController.js
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

Ext.define('S_SCM_TO_DN_TOT_HSPF.controller.MyGridController1', {
	extend : 'Ext.app.Controller',

	control : {
//		"#gridAddBtn" : {
//			click : 'gridAddBtnClick'
//		},
//		"#gridDelBtn" : {
//			click : 'gridDelBtnClick'
//		},
//		"#gridSaveBtn" : {
//			click : 'gridSaveBtnClick'
//		},
		"#gridGrCancelBtn" : {
			click : 'gridGrCancelBtnClick'
		},
		"#xlsxDown1" : {
			click : 'xlsxDown1Click'
		},
	},

//	gridAddBtnClick : function(button, e, eOpts) {
//		var popup = Ext.create("S_SCM_TO_DN_TOT_HSPF.view.WinAddRow");
//		popup.show();
//		Ext.getCmp('rowCount').setValue(1);
//	},
//
//	gridDelBtnClick : function(button, e, eOpts) {},
//
//	gridSaveBtnClick : function(button, e, eOpts) {},
	
	gridGrCancelBtnClick : function(button, e, eOpts) {
		var store1 = Ext.getStore('MyStore1');
		var gridRecord = Ext.getCmp('myGrid1').getSelectionModel().getSelection();
		
		for (var i = 0; i < gridRecord.length; i++) {
			gridRecord[i].set('V_TYPE', 'RD');
		}

//		store1.each(function(record, idx) {
//			if(record.get('CHK_YN') === 'Y') {
//				record.set('V_TYPE', 'RD');
//			}
//		})
		
		Ext.Msg.confirm('확인', '출고취소 하시겠습니까?', function(button) {
			if (button == 'yes') {
				store1.sync({
					params : {
						V_TYPE : 'SYNC',
						V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
						V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
					},
					callback : function(records, operation, success) {
						var tbController = S_SCM_TO_DN_TOT_HSPF.app.getController("TbButtonController");
						tbController.selBtnClick();
					},
					success : function(response) {
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
			}
		});
	},
	
	xlsxDown1Click : function(button, e, eOpts) {
		var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
		var grid = Ext.getCmp('myGrid1');
		grid.saveDocumentAs({
			type : 'xlsx',
			title : '출고마감(취소)', // 엑셀내타이틀
			fileName : currentDate + '.xlsx' // 엑셀파일이름
		});
	},

});