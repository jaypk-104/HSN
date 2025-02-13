/*
 * File: app/controller/TbButtonController.js
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

Ext.define('Packhsna.controller.TbButtonController', {
    extend: 'Ext.app.Controller',

    stores: [
        'InvoiceReg',
        'PalletReg',
        'PackHsnaStore'
    ],

    control: {
        "#selBtn": {
            click: 'selBtnClick'
        },
        "#saveBtn": {
            click: 'saveBtnClick'
        },
        "#delBtn": {
            click: 'delBtnClick'
        },
        "#CfmBtn": {
            click: 'CfmBtnClick'
        },
        "#invoicePrintBtn": {
            click: 'invoicePrintBtnClick'
        },
        "#CfmCancelBtn": {
            click: 'CfmCancelBtnClick'
        },
        "#grid1": {
            itemclick: 'gridClick'
        },
        "#grid2": {
            itemclick: 'grid2Click'
        },
        "#regBtn": {
            click: 'regBtnClick'
        },
        "#cancelBtn": {
            click: 'cancelBtnClick'
        },
        "mysearchform textfield[name=search_field]": {
            specialkey: 'tfEnter'
        }
    },

    selBtnClick: function(button, e, eOpts) {
        var store=this.getPackHsnaStoreStore();
            	var storePal = this.getPalletRegStore();

                store.load({
                	params: {
                		u_lading_from_dt: Ext.getCmp('u_lading_from_dt').getValue(),
                		u_lading_to_dt: Ext.getCmp('u_lading_to_dt').getValue()
                	},
                    callback: function (records, operation, success){
                    	var store_cnt = store.getCount();
                    	for(var i=0; i<store_cnt; i++) {
                    		var records = store.getAt(i);
                    		var check = records.get('CFM_YN');
                    		var checkbox = Ext.getCmp('CFM_YN');
                    		if(check == 'Y') {
                    			checkbox.checked= true;
                    		} else {
                    			checkbox.checked= false;
                    		}
                    	}
                   },
                   scope: this
                });

                storePal.load({
                	params: {
                		u_cont_no: Ext.getCmp('u_cont_no').getValue()
                	},
                	callback: function (records, operation, success){
                	},
                	scope: this
                });

    },

    saveBtnClick: function(button, e, eOpts) {
        	var store = this.getPackHsnaStoreStore();
                    	var flag = '';
                    	var gridRecord = Ext.getCmp('grid1').getSelectionModel().getSelection();

                    	//store.each(function(record, idx) {
                    	for(var i = 0 ; i <gridRecord.length ; i++){
                    		if(gridRecord[i].data['INV_NO'] == undefined) {
                    			flag = 'N';
                    			msg = '인보이스 번호를 입력하세요.';
                    			break;
                    		}
                    		else if(gridRecord[i].data['VESSEL_NM'] == undefined) {
                    			flag = 'N';
                    			msg = '선박명을 입력하세요.';
                				break;
                    		}
                    		else if(gridRecord[i].data['LOAD_DT'] == undefined) {
                    			flag = 'N';
                    			msg = '선적일을 입력하세요';
                    			break;
                    		}
                    		else {
                    			flag = 'Y';
                    			msg = 'test';
                    		}
                    	};

                    	if(flag == 'Y') {
                    		console.log('guser_id : ' +  parent.Ext.getCmp('GUSER_ID').getValue() );
                    		store.sync({
                    			params: {
                                    V_USR: parent.Ext.getCmp('GUSER_ID').getValue(),
                    			},
                    			callback: function(records, operation, success){
                    				//store.reload();
                    				var tbController = Packhsna.app.getController("TbButtonController");
                    				tbController.selBtnClick();
                    			},
                    			scope: this
                    		});
                    	 } else {
                    		Ext.Msg.alert('확인', msg);
                    	}
    },

    delBtnClick: function(button, e, eOpts) {
        alert('delete');
    },

    CfmBtnClick: function(button, e, eOpts) {
        var store = this.getPackHsnaStoreStore();
            	var gridObj = Ext.getCmp('grid1');
            	var gridRecord = gridObj.getSelectionModel().getSelection();

            	if(gridRecord.length==0) {
            		Ext.Msg.alert('확인', '확정할 행을 선택하세요.');
            	} else {
            		for(var c=0; c<gridRecord.length; c++) {
            			gridRecord[c].set('V_TYPE', 'C');
            		}
        			store.sync({
            			params: {
        	                V_USR: parent.Ext.getCmp('GUSER_ID').getValue(),
            			},
            			callback: function(records, operation, success){
            				store.reload();
            			},
            			scope: this
            		});
            	}
            	if (!store.isLoading()) {
                    store.reload();
                }
    },

    invoicePrintBtnClick: function(button, e, eOpts) {
        	var gridRecord1 = Ext.getCmp('grid1').getSelectionModel().getSelection();
            	var V_INVOICE_NO = gridRecord1[0].data['INV_NO'];

            	var myWin=new Ext.Window(
        				{
        					title : '인보이스출력',
        					html : '<iframe name="xxx" border =0 src="http://123.142.124.170:8080/aireport/SWM/INVOICE.jsp?V_INVOICE_NO='+V_INVOICE_NO+'" width="100%" height="100%"></iframe>',
        					width :1000,
        					height:768
        				});
        		myWin.show();
    },

    CfmCancelBtnClick: function(button, e, eOpts) {
        var store = this.getPackHsnaStoreStore();
            	var gridObj = Ext.getCmp('grid1');
            	var gridRecord = gridObj.getSelectionModel().getSelection();

            	if(gridRecord.length==0) {
            		Ext.Msg.alert('확인', '확정취소할 행을 선택하세요.');
            	} else {
            		for(var c=0; c<gridRecord.length; c++) {
            			gridRecord[c].set('V_TYPE', 'A');
            		}
        			store.sync({
            			params: {
        	                V_USR: parent.Ext.getCmp('GUSER_ID').getValue(),
            			},
            			callback: function(records, operation, success){
            				store.reload();
            			},
            			scope: this
            		});
            	}
            	if (!store.isLoading()) {
                    store.reload();
                }
    },

    gridClick: function(dataview, record, item, index, e, eOpts) {
        var gridObj1 = Ext.getCmp('grid1');
            	var gridObj3 = Ext.getCmp('grid3');
            	var store = this.getPackHsnaStoreStore();
            	var invoiceRegStore=this.getInvoiceRegStore();

            	if(gridObj1 != null) {
            		var gridRecord1 = gridObj1.getSelectionModel().getSelection();
            		for(var i = 0; i < gridRecord1.length; i++){
            			invoiceRegStore.load({
        	            	params: {
        	            		V_INV_MGM_NO : gridRecord1[i].data['INV_MGM_NO']
        	            	},
        	                callback: function (records, operation, success){
        	               },
        	               scope: this
        	             });
            		}
            	}
    },

    grid2Click: function(dataview, record, item, index, e, eOpts) {
        var gridObj1 = Ext.getCmp('grid1');
            	var gridObj2 = Ext.getCmp('grid2');
            	var store = this.getPackHsnaStoreStore();
            	var invoiceRegStore=this.getInvoiceRegStore();

            	if(gridObj2 != null) {
            		var gridRecord1 = gridObj1.getSelectionModel().getSelection();
            		var gridRecord2 = gridObj2.getSelectionModel().getSelection();
            		if(gridRecord1.length==0) {
        	    		Ext.Msg.alert('확인', '왼쪽에서 인보이스를 선택하세요');
            		}
            	}
    },

    regBtnClick: function(button, e, eOpts) {
        var palStore = this.getPalletRegStore();
            	var inStore = this.getInvoiceRegStore();
            	var store = this.getPalletRegStore();
            	var gridObj1 = Ext.getCmp('grid1');
            	var gridObj2 = Ext.getCmp('grid2');
            	var gridRecord1 = gridObj1.getSelectionModel().getSelection();
            	var gridRecord2 = gridObj2.getSelectionModel().getSelection();

            	if(gridRecord1.length==0) {
            		Ext.Msg.alert('확인', '인보이스를 선택하세요');
            	} 
            	else if(gridRecord2.length==0){
            		Ext.Msg.alert('확인', 'PALLET를 선택하세요');
            	}
            	else if (gridRecord1[0].data['CFM_YN'] == 'Y'){
            		Ext.Msg.alert('확인', '확정된 인보이스에 추가 불가능합니다.');
            	}
            	else {
            		palStore.sync({
            			params: {
            				V_INV_MGM_NO: gridRecord1[0].data['INV_MGM_NO'],
            				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue()
            			},
            			callback: function(records, operation, success) {
            				Ext.Msg.alert('확인', '저장되었습니다.');
            				Ext.getCmp('tabpanel1').setActiveTab(1);
            				palStore.reload();
        					inStore.reload();
            			}
            		});
            	}
    },

    cancelBtnClick: function(button, e, eOpts) {
        var palStore = this.getPalletRegStore();
            	var inStore = this.getInvoiceRegStore();
            	var gridObj3 = Ext.getCmp('grid3');
            	var gridRecord3 = gridObj3.getSelectionModel().getSelection();
            	var gridObj = Ext.getCmp('grid1');
            	var gridRecord = gridObj.getSelectionModel().getSelection();

            	if(gridRecord3.length==0) {
            		Ext.Msg.alert('확인', '삭제할 행을 선택하세요');
            	} else if(gridRecord.length==0) {
            		Ext.Msg.alert('확인', '좌측 인보이스 번호를 선택하세요');
            	} else if(gridRecord[0].data['CFM_YN']=='Y') {
            		Ext.Msg.alert('확인', '인보이스 확정된 내역입니다. 취소할 수 없습니다.');
            	} else {
            		inStore.sync({
            			params: {
            				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue()
            			},
            			callback: function(records, operation, success) {
            				Ext.Msg.alert('확인', '취소되었습니다.');
            				Ext.getCmp('tabpanel1').setActiveTab(0);
            				palStore.reload();
        					inStore.reload();
            			}
            		});    	}
    },

    tfEnter: function(field, e, eOpts) {
        	if (e.getKey() == e.ENTER) {
        		this.selBtnClick();
        	}
    }

});
