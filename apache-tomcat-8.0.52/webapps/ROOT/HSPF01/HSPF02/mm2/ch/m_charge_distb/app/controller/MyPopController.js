/*
 * File: app/controller/MyController.js
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

Ext.define('M_CHARGE_DISTB.controller.MyPopController', {
    extend: 'Ext.app.Controller',
    stores: ['PopStore', 'MyStore'],
    control: {
    	"#popSelBtn" : {
    		click: 'popSelBtnClick'
    	},
		'#popRegBtn' : {
			click : 'popRegBtnClick'
		},
		'#popGrid': {
			celldblclick: 'popGridDblClick'
		},
		"textfield[name=pop_search]": {
            specialkey: 'tfEnter'
        },
        '#V_CHECK' : {
    		change: 'chkChange'
		},
    },

    chkChange: function(field, newValue, oldValue, eOpts) {
    	this.popSelBtnClick();
    },
    
    popSelBtnClick: function(button, e, eOpts) {
		var popStore = this.getPopStoreStore();
		var V_CHECK = '';

		if(Ext.getCmp('V_PR_STEP').getValue() == 'VL' && Ext.getCmp('W_LC_DOC_NO').getValue() != '') {
			Ext.getCmp('V_CHECK').setValue(true);
		}
		
		if(Ext.getCmp('V_PR_STEP').getValue() == 'VB' && Ext.getCmp('W_BL_DOC_NO').getValue() != '') {
			Ext.getCmp('V_CHECK').setValue(true);
		}

		if(Ext.getCmp('V_PR_STEP').getValue() == 'VC' && ((Ext.getCmp('W_ID_NO').getValue() != '') || (Ext.getCmp('W_BL_DOC_NO').getValue() != '')) ) {
			Ext.getCmp('V_CHECK').setValue(true);
		}
			
		
		popStore.load({
    		params: {
    			V_TYPE: 'SP',
    			V_PR_STEP: Ext.getCmp('V_PR_STEP').getValue(),
    			V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				W_LC_DOC_NO : Ext.getCmp('W_LC_DOC_NO').getValue(),
				W_BL_DOC_NO : Ext.getCmp('W_BL_DOC_NO').getValue(),
				W_ID_NO : Ext.getCmp('W_ID_NO').getValue(),
				W_CC_DOC_NO : Ext.getCmp('W_CC_DOC_NO').getValue(),
				V_DT_FR : Ext.getCmp('V_DT_FR').getValue(),
				V_DT_TO : Ext.getCmp('V_DT_TO').getValue(),
				V_M_BP_NM : Ext.getCmp('V_M_BP_NM').getValue(),
				V_CHECK : Ext.getCmp('V_CHECK').getValue(),
    		},
    		callback: function(records,operations,success){
    		}
    	});
	},
	
	popRegBtnClick: function(button, e, eOpts) {
		var V_PR_STEP = Ext.getCmp('V_PR_STEP').getValue();
		var store = this.getMyStoreStore();
		var V_BAS_NO = '';
		var gridRecord = Ext.getCmp('popGrid').getSelectionModel().getSelection();
		
		//경비번호가 없으면 경비생성 STORE + 1
		if(gridRecord[0].get('CHARGE_YN') == 'N') {
			if(V_PR_STEP == 'VL') {
	    		var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('LC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC01', //신용장개설수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('LC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC26', //AMEND수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('LC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC12', //보험료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('LC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec1);
				store.insert(2, rec2);
				store.insert(3, rec3);
				
				V_BAS_NO = gridRecord[0].get('LC_NO');
			} else if (V_PR_STEP == 'VB') {
				var rec14 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC41', //인수수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
				var rec15 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			CHARGE_CD: 'SPC92', //커미션
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
				var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
					BAS_NO: gridRecord[0].get('BL_NO'),
					BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
					CHARGE_CD: 'SPC18', //취급수수료 1 
					CHARGE_DT: new Date(),
					CUR: 'KRW',
					TAX_BIZ_CD: 'TX3',
					XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
				});
	    		var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC29', //입출항료 2
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC31', //D/F 3
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec4 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC30', //C/C 4, SECURITY CHG 5, 스티커 6
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec5 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC43', //SECURITY CHG
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec6 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			CHARGE_CD: 'SPCA4', //스티커비용
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec7 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC27', //선사 H/C
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec8 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC36', //DEM
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			BANK_CD: '32',
	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec9 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA1', //전기료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			BANK_CD: '32',
	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec10 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC83', //상하차료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec11 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA3', //검색기 운송료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec12 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA2', //운송료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		var rec13 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('BL_NO'),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC28', //THC
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('BL_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(gridRecord[0].get('BL_DOC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec14);
				store.insert(2, rec1);
				store.insert(3, rec2);
				store.insert(4, rec3);
				store.insert(5, rec4);
				store.insert(6, rec5);
				store.insert(7, rec6);
				store.insert(8, rec7);
				store.insert(9, rec8);
				store.insert(10, rec9);
				store.insert(11, rec10);
				store.insert(12, rec11);
				store.insert(13, rec12);
				store.insert(14, rec13);
				store.insert(15, rec15);
				
				V_BAS_NO = gridRecord[0].get('BL_NO');
				
			} else if (V_PR_STEP == 'VC') {
				var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('CC_NO'),
	    			ID_NO: gridRecord[0].get('ID_NO'),
	    			CHARGE_CD: 'SPC23', //관세
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			VAT_TYPE: 'K' ,//매출입계산서,
    				PAY_TYPE: 'Z1'
	    		});
	    		var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('CC_NO'),
	    			ID_NO: gridRecord[0].get('ID_NO'),
	    			CHARGE_CD: 'SPC13', //통관료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			VAT_TYPE: 'B', //매입세액불공제,
	    			PAY_TYPE: 'Z1',
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: gridRecord[0].get('CC_NO'),
	    			ID_NO: gridRecord[0].get('ID_NO'),
	    			CHARGE_CD: 'SPCA4', //스티커비용
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: gridRecord[0].get('BL_DOC_NO'),
	    			LC_DOC_NO: gridRecord[0].get('LC_DOC_NO'),
	    			PAY_TYPE: 'Z1'
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('CC_NO'));
	    		Ext.getCmp('V_ID_NO').setValue(gridRecord[0].get('ID_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(gridRecord[0].get('BL_DOC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec2);
				store.insert(2, rec1);	
				store.insert(3, rec3);
				store.insert(4, rec3);
				
				V_BAS_NO = gridRecord[0].get('CC_NO');
			}
			
			Ext.getCmp('distrBtn').setDisabled(true);
			
			Ext.Ajax.request({
				url:'sql/M_CHARGE_DISTR.jsp',
				method: 'post',
				params: {
					V_TYPE: 'SH', //생성 
					V_BAS_NO: V_BAS_NO,
					V_USR_ID : "NEW",
				},
				callback : function(records,operations,success){
			    },
			    success : function(response) {
			    	var res = response.responseText;
			    	
			    	if(res.match('Exception')) {
						Ext.Msg.alert('확인', res);
					} else {
						Ext.getCmp('V_APPROV_NM').setValue(res);
					}
			    },
				scope: this
			});
			
			
		/* 경비가 존재하면 조회 */
		} else {
			if(V_PR_STEP == 'VL') {
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('LC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
			} else if (V_PR_STEP == 'VB') {
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('BL_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(gridRecord[0].get('BL_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
			} else if (V_PR_STEP == 'VC') {
	    		Ext.getCmp('V_BAS_NO').setValue(gridRecord[0].get('CC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(gridRecord[0].get('LC_DOC_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(gridRecord[0].get('BL_DOC_NO'));
	    		Ext.getCmp('V_ID_NO').setValue(gridRecord[0].get('ID_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(gridRecord[0].get('MAST_CHARGE_NO'));
			}
			
			var tbController = M_CHARGE_DISTB.app.getController("TbButtonController");
    		tbController.selBtnClick();

    		Ext.getCmp('distrBtn').setDisabled(false);
		}
		
		
		var popWin=  Ext.getCmp('WinPop');
		popWin.destroy();
		
//		console.log(Ext.getCmp('V_MAST_CHARGE_NO').getValue());
//		console.log(Ext.getCmp('V_TEMP_GL_NO').getValue());

		Ext.getCmp('tempGlCfmBtn').setDisabled(false);
		Ext.getCmp('tempGlCancelBtn').setDisabled(false);
		
		Ext.getCmp('gridAddBtn').setDisabled(false);
		Ext.getCmp('gridDelBtn').setDisabled(false);
		Ext.getCmp('distrBtn').setDisabled(false);
		
		Ext.getStore('MyStore1').removeAll();
	},
	
	popGridDblClick : function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
		var V_PR_STEP = Ext.getCmp('V_PR_STEP').getValue();
		var store = this.getMyStoreStore();
		var V_BAS_NO = '';
		
		//경비번호가 없으면 경비생성 STORE + 1
		if(record.get('CHARGE_YN') == 'N') {
			if(V_PR_STEP == 'VL') {
	    		var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('LC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC01', //신용장개설수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('LC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC26', //AMEND수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('LC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC12', //보험료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('LC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec1);
				store.insert(2, rec2);
				store.insert(3, rec3);
				
				V_BAS_NO = record.get('LC_NO');
			} else if (V_PR_STEP == 'VB') {
				var rec14 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC41', //인수수수료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date()
	    		});
				var rec15 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			CHARGE_CD: 'SPC92', //커미션
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
				var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
					BAS_NO: record.get('BL_NO'),
					BL_DOC_NO: record.get('BL_DOC_NO'),
//					LC_DOC_NO: record.get('LC_DOC_NO'),
					CHARGE_CD: 'SPC18', //취급수수료 1 
					CHARGE_DT: new Date(),
					CUR: 'KRW',
					TAX_BIZ_CD: 'TX3',
					XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
				});
	    		var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC29', //입출항료 2
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC31', //D/F 3
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec4 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC30', //C/C 4, SECURITY CHG 5, 스티커 6
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec5 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC43', //SECURITY CHG
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec6 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			CHARGE_CD: 'SPCA4', //스티커비용
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec7 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC27', //선사 H/C
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec8 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC36', //DEM
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			BANK_CD: '32',
	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec9 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA1', //전기료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			BANK_CD: '32',
	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec10 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC83', //상하차료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec11 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA3', //검색기 운송료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec12 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPCA2', //운송료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		var rec13 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('BL_NO'),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
//	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			CHARGE_CD: 'SPC28', //THC
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
//	    			BANK_CD: '32',
//	    			BANK_ACCT: '168-01-000130-9',
	    			PAY_DUE_DT: new Date(),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('BL_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(record.get('BL_DOC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec14);
				store.insert(2, rec1);
				store.insert(3, rec2);
				store.insert(4, rec3);
				store.insert(5, rec4);
				store.insert(6, rec5);
				store.insert(7, rec6);
				store.insert(8, rec7);
				store.insert(9, rec8);
				store.insert(10, rec9);
				store.insert(11, rec10);
				store.insert(12, rec11);
				store.insert(13, rec12);
				store.insert(14, rec13);
				store.insert(15, rec15);
				
				V_BAS_NO = record.get('BL_NO');
				
			} else if (V_PR_STEP == 'VC') {
				var rec2 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('CC_NO'),
	    			ID_NO: record.get('ID_NO'),
	    			CHARGE_CD: 'SPC23', //관세
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			VAT_TYPE: 'K' ,//매출입계산서,
    				PAY_TYPE: 'Z1'
	    		});
	    		var rec1 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('CC_NO'),
	    			ID_NO: record.get('ID_NO'),
	    			CHARGE_CD: 'SPC13', //통관료
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			VAT_TYPE: 'B', //매입세액불공제,
	    			PAY_TYPE: 'Z1',
	    		});
	    		var rec3 = Ext.create('M_CHARGE_DISTB.model.MyModel', {
	    			BAS_NO: record.get('CC_NO'),
	    			ID_NO: record.get('ID_NO'),
	    			CHARGE_CD: 'SPCA4', //스티커비용
	    			CHARGE_DT: new Date(),
	    			CUR: 'KRW',
	    			TAX_BIZ_CD: 'TX3',
	    			XCHG_RT: '1',
	    			DISTR_TYPE: 'A2',
	    			PAY_DUE_DT: new Date(),
	    			BL_DOC_NO: record.get('BL_DOC_NO'),
	    			LC_DOC_NO: record.get('LC_DOC_NO'),
	    			PAY_TYPE: 'Z1'
	    		});
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('CC_NO'));
	    		Ext.getCmp('V_ID_NO').setValue(record.get('ID_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(record.get('BL_DOC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
	    		
	    		store.removeAll();
				store.insert(1, rec2);
				store.insert(2, rec1);	
				store.insert(3, rec3);
				store.insert(4, rec3);
				
				V_BAS_NO = record.get('CC_NO');
			}
			
			Ext.getCmp('distrBtn').setDisabled(true);
			
			Ext.Ajax.request({
				url:'sql/M_CHARGE_DISTR.jsp',
				method: 'post',
				params: {
					V_TYPE: 'SH', //생성 
					V_BAS_NO: V_BAS_NO,
					V_USR_ID : "NEW",
				},
				callback : function(records,operations,success){
			    },
			    success : function(response) {
			    	var res = response.responseText;
			    	
			    	if(res.match('Exception')) {
						Ext.Msg.alert('확인', res);
					} else {
						Ext.getCmp('V_APPROV_NM').setValue(res);
						Ext.getCmp('V_TEMP_GL_NO').setValue('');
					}
			    },
				scope: this
			});
			
			
		/* 경비가 존재하면 조회 */
		} else {
			if(V_PR_STEP == 'VL') {
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('LC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
			} else if (V_PR_STEP == 'VB') {
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('BL_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(record.get('BL_DOC_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
			} else if (V_PR_STEP == 'VC') {
	    		Ext.getCmp('V_BAS_NO').setValue(record.get('CC_NO'));
	    		Ext.getCmp('V_LC_DOC_NO').setValue(record.get('LC_DOC_NO'));
	    		Ext.getCmp('V_BL_DOC_NO').setValue(record.get('BL_DOC_NO'));
	    		Ext.getCmp('V_ID_NO').setValue(record.get('ID_NO'));
	    		Ext.getCmp('V_MAST_CHARGE_NO').setValue(record.get('MAST_CHARGE_NO'));
			}
			
			var tbController = M_CHARGE_DISTB.app.getController("TbButtonController");
    		tbController.selBtnClick();

    		Ext.getCmp('distrBtn').setDisabled(false);
		}
		
		
		var popWin=  Ext.getCmp('WinPop');
		popWin.destroy();

		Ext.getCmp('tempGlCfmBtn').setDisabled(false);
		Ext.getCmp('tempGlCancelBtn').setDisabled(false);
		
		Ext.getStore('MyStore1').removeAll();
	},
	
	tfEnter: function(field, e, eOpts) {
    	if (e.getKey() == e.ENTER) {
    		this.popSelBtnClick();
    	}
	}


});
