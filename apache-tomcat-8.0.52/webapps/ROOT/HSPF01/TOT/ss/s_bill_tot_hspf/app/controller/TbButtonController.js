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

Ext.define('S_BILL_TOT_HSPF.controller.TbButtonController', {
	extend : 'Ext.app.Controller',
	stores : [ 'MyStore', 'MyStore1' ],
	control : {
		"#selBtn" : {
			click : 'selBtnClick'
		},
		"#saveBtn" : {
			click : 'saveBtnClick'
		},
		"#clrBtn" : {
			click : 'clrBtnClick'
		},
		"#clsBtn" : {
			click : 'clsBtnClick'
		},
		"textfield[name=search_field]" : {
			specialkey : 'tfEnter'
		}
	},

	selBtnClick : function(button, e, eOpts) {
		var store = this.getMyStoreStore();
		var store1 = this.getMyStore1Store();

		store.removeAll();
		store1.removeAll();

		var nows = new Date();

		Ext.getCmp('V_BILL_DT').setValue(nows);
		Ext.getCmp('V_SALE_TYPE').setValue(null);
		Ext.getCmp('V_S_BP_CD2').setValue('');
		Ext.getCmp('V_S_BP_NM2').setValue('');
		Ext.getCmp('V_R_BP_CD').setValue('');
		Ext.getCmp('V_R_BP_NM').setValue('');
		Ext.getCmp('V_DN_ISSUE_DT').setValue(nows);
		Ext.getCmp('V_TAX_CD').setValue('TX1');
		Ext.getCmp('V_CUR').setValue('KRW');
		Ext.getCmp('V_IN_TERMS').setValue(null);
		Ext.getCmp('V_PAY_METH').setValue('CH');
		Ext.getCmp('V_SALE_TYPE').setValue('DSO');

		Ext.getCmp('cfmBtn').setDisabled(false);
		Ext.getCmp('gridDelBtn').setDisabled(false);
		Ext.getCmp('tempGlCfmBtn').setDisabled(true);
		Ext.getCmp('tempGlCancelBtn').setDisabled(true);

		store.load({
			params : {
				V_TYPE : 'SH',
				V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
				V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
				V_DN_DT_FR : Ext.getCmp('V_DN_DT_FR').getValue(),
				V_DN_DT_TO : Ext.getCmp('V_DN_DT_TO').getValue(),
				V_S_BP_NM : Ext.getCmp('V_S_BP_NM').getValue(),
				V_M_BP_NM : Ext.getCmp('V_M_BP_NM').getValue(),
				V_ITEM_CD : Ext.getCmp('V_ITEM_CD').getValue(),
				V_ITEM_NM : Ext.getCmp('V_ITEM_NM').getValue(),
				V_LC_DOC_NO : Ext.getCmp('V_LC_DOC_NO').getValue(),
				V_BL_DOC_NO : Ext.getCmp('V_BL_DOC_NO').getValue(),
				V_IV_TYPE : Ext.getCmp('V_IV_TYPE').getValue(),
			},
			callback : function(records, operations, success) {
				
			}
		});
		
		if (Ext.getCmp('V_BILL_NO').getValue() != '') {

			Ext.Ajax.request({
				url : 'sql/S_BILL_TOT_HSPF.jsp',
				method : 'post',
				params : {
					V_TYPE : 'S',
					V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
					V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
					V_BILL_NO : Ext.getCmp('V_BILL_NO').getValue(),
				},
				success : function(response) {
					var res = Ext.JSON.decode(response.responseText).resultList[0];
					
					Ext.getCmp('V_TAX_BILL_YN').setValue(res.TAX_BILL_YN);
					Ext.getCmp('V_TAX_BILL_SEND_YN').setValue(res.TAX_BILL_SEND_YN);
					Ext.getCmp('V_CR_TYPE').setValue(res.CR_TYPE);

					Ext.getCmp('V_BILL_DT').setValue(res.BILL_DT);
					Ext.getCmp('V_SALE_TYPE').setValue(res.SALE_TYPE);
					Ext.getCmp('V_S_BP_CD2').setValue(res.S_BP_CD);
					Ext.getCmp('V_S_BP_NM2').setValue(res.S_BP_NM);
					Ext.getCmp('V_R_BP_CD').setValue(res.R_BP_CD);
					Ext.getCmp('V_R_BP_NM').setValue(res.R_BP_NM);
					Ext.getCmp('V_DN_ISSUE_DT').setValue(res.DN_ISSUE_DT);
					Ext.getCmp('V_TAX_CD').setValue(res.TAX_CD);
					Ext.getCmp('V_CUR').setValue(res.CUR);
					Ext.getCmp('V_IN_TERMS').setValue(res.IN_TERMS);
					Ext.getCmp('V_PAY_METH').setValue(res.PAY_METH);
					Ext.getCmp('V_TEMP_GL_NO').setValue(res.TEMP_GL_NO);
					Ext.getCmp('V_TO_SALES_GRP').setValue(res.TO_SALES_GRP);
					Ext.getCmp('V_XCH_RATE').setValue(res.XCHG_RT);
					Ext.getCmp('V_VAT_TYPE').setValue(res.VAT_TYPE);
					Ext.getCmp('V_REMARK').setValue(res.REMARK);
					Ext.getCmp('V_COST_CD').setValue(res.COST_CD);
					Ext.getCmp('V_EXPECT_LOC_AMT').setValue(Ext.util.Format.number(res.BILL_LOC_AMT, '0,000'));

					if (!!res.TEMP_GL_NO) {
						Ext.getCmp('cfmBtn').setDisabled(true);
						Ext.getCmp('gridDelBtn').setDisabled(true);
						Ext.getCmp('tempGlCfmBtn').setDisabled(true);
						Ext.getCmp('tempGlCancelBtn').setDisabled(false);
					} else {
						Ext.getCmp('cfmBtn').setDisabled(false);
						Ext.getCmp('gridDelBtn').setDisabled(false);
						Ext.getCmp('tempGlCfmBtn').setDisabled(false);
						Ext.getCmp('tempGlCancelBtn').setDisabled(true);
					}
					//    		    			
					if (res.VAT_INC == 'Y') {
						Ext.getCmp('rb1Y').setValue(true);
					} else {
						Ext.getCmp('rb1N').setValue(true);
					}

					if (res.CFM_YN == 'Y') {
						Ext.getCmp('rb2Y').setValue(true);
					} else {
						Ext.getCmp('rb2N').setValue(true);
					}
					
					if(res.SALE_TYPE == 'LSO'){
						Ext.getCmp('localOfferBtn').setDisabled(false);
					} else {
						Ext.getCmp('localOfferBtn').setDisabled(true);
					}

					store1.load({
						params : {
							V_TYPE : 'SD',
							V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
							V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
							V_BILL_NO : Ext.getCmp('V_BILL_NO').getValue(),
						},
						callback : function(records, operations, success) {
						}
					});
				}
			});

		}

	},

	saveBtnClick : function(button, e, eOpts) {

	},

	clrBtnClick : function(button, e, eOpts) {

		var store = Ext.getStore('MyStore');
		var store1 = Ext.getStore('MyStore1');
		store.removeAll();
		store1.removeAll();
		Ext.getCmp('V_BILL_NO').setValue('');
		var nows = new Date();

		Ext.getCmp('V_BILL_DT').setValue(nows);
		Ext.getCmp('V_SALE_TYPE').setValue(null);
		Ext.getCmp('V_S_BP_CD2').setValue('');
		Ext.getCmp('V_S_BP_NM2').setValue('');
		Ext.getCmp('V_R_BP_CD').setValue('');
		Ext.getCmp('V_R_BP_NM').setValue('');
		Ext.getCmp('V_DN_ISSUE_DT').setValue(nows);
		Ext.getCmp('V_TAX_CD').setValue('TX1');
		Ext.getCmp('V_CUR').setValue('KRW');
		Ext.getCmp('V_IN_TERMS').setValue(null);
		Ext.getCmp('V_PAY_METH').setValue('CH');
		Ext.getCmp('V_SALE_TYPE').setValue('DSO');
		Ext.getCmp('V_TEMP_GL_NO').setValue('');
		Ext.getCmp('V_TO_SALES_GRP').setValue('');
		Ext.getCmp('V_XCH_RATE').setValue('1');
		Ext.getCmp('V_VAT_TYPE').setValue(null);
		Ext.getCmp('V_REMARK').setValue('');
		Ext.getCmp('V_TAX_BILL_SEND_YN').setValue('');
		Ext.getCmp('V_TAX_BILL_YN').setValue('');
		Ext.getCmp('V_CR_TYPE').setValue('');
		Ext.getCmp('V_EXPECT_LOC_AMT').setValue(0);

		Ext.getCmp('tempGlCfmBtn').setDisabled(true);
		Ext.getCmp('tempGlCancelBtn').setDisabled(true);

	},

	clsBtnClick : function(button, e, eOpts) {
		var tab = parent.Ext.getCmp('myTab');
		var activeTab = tab.getActiveTab();
		var tabIndex = tab.items.indexOf(activeTab);
		tab.remove(tabIndex, true);
	},

	tfEnter : function(field, e, eOpts) {
		if (e.getKey() == e.ENTER) {
			this.selBtnClick();
		}
	},
	onLaunch : function(application) {
//		Ext.define('S_BILL_TOT_HSPF.override.form.field.Number', {
//			override : 'Ext.form.field.Number',
//
//			useThousandSeparator : true,
//
//			/**
//			 * @inheritdoc
//			 */
//			toRawNumber : function(value) {
//				return String(value).replace(this.decimalSeparator, '.').replace(new RegExp(Ext.util.Format.thousandSeparator, "g"), '');
//			},
//
//			/**
//			 * @inheritdoc
//			 */
//			getErrors : function(value) {
//				if (!this.useThousandSeparator)
//					return this.callParent(arguments);
//				var me = this, errors = Ext.form.field.Text.prototype.getErrors.apply(me, arguments), format = Ext.String.format, num;
//
//				value = Ext.isDefined(value) ? value : this.processRawValue(this.getRawValue());
//
//				if (value.length < 1) { // if it's blank and textfield didn't
//										// flag it then it's valid
//					return errors;
//				}
//
//				value = me.toRawNumber(value);
//
//				if (isNaN(value.replace(Ext.util.Format.thousandSeparator, ''))) {
//					errors.push(format(me.nanText, value));
//				}
//
//				num = me.parseValue(value);
//
//				if (me.minValue === 0 && num < 0) {
//					errors.push(this.negativeText);
//				} else if (num < me.minValue) {
//					errors.push(format(me.minText, me.minValue));
//				}
//
//				if (num > me.maxValue) {
//					errors.push(format(me.maxText, me.maxValue));
//				}
//
//				return errors;
//			},
//
//			/**
//			 * @inheritdoc
//			 */
////			valueToRaw : function(value) {
////				if (!this.useThousandSeparator)
////					return this.callParent(arguments);
////				var me = this;
////
////				var format = "0,000.##";
////				/*
////				 * 소수점 나타내는 부분인듯. for (var i = 0; i < me.decimalPrecision; i++) {
////				 * if (i == 0) format += "."; format += "0"; }
////				 */
////				value = me.parseValue(Ext.util.Format.number(value, format));
////				value = me.fixPrecision(value);
////				value = Ext.isNumber(value) ? value : parseFloat(me.toRawNumber(value));
////				value = isNaN(value) ? '' : String(Ext.util.Format.number(value, format)).replace('.', me.decimalSeparator);
////				return value;
////			},
//
//			/**
//			 * @inheritdoc
//			 */
//			getSubmitValue : function() {
//				if (!this.useThousandSeparator)
//					return this.callParent(arguments);
//				var me = this, value = me.callParent();
//
//				if (!me.submitLocaleSeparator) {
//					value = me.toRawNumber(value);
//				}
//				return value;
//			},
//
//			/**
//			 * @inheritdoc
//			 */
//			setMinValue : function(value) {
//				if (!this.useThousandSeparator)
//					return this.callParent(arguments);
//				var me = this, allowed;
//
//				me.minValue = Ext.Number.from(value, Number.NEGATIVE_INFINITY);
//				me.toggleSpinners();
//
//				// Build regexes for masking and stripping based on the
//				// configured options
//				if (me.disableKeyFilter !== true) {
//					allowed = me.baseChars + '';
//
//					if (me.allowExponential) {
//						allowed += me.decimalSeparator + 'e+-';
//					} else {
//						allowed += Ext.util.Format.thousandSeparator;
//						if (me.allowDecimals) {
//							allowed += me.decimalSeparator;
//						}
//						if (me.minValue < 0) {
//							allowed += '-';
//						}
//					}
//
//					allowed = Ext.String.escapeRegex(allowed);
//					me.maskRe = new RegExp('[' + allowed + ']');
//					if (me.autoStripChars) {
//						me.stripCharsRe = new RegExp('[^' + allowed + ']', 'gi');
//					}
//				}
//			},
//
//			/**
//			 * @private
//			 */
//			parseValue : function(value) {
//				if (!this.useThousandSeparator)
//					return this.callParent(arguments);
//				value = parseFloat(this.toRawNumber(value));
//				return isNaN(value) ? null : value;
//			}
//
//		});
	}

});