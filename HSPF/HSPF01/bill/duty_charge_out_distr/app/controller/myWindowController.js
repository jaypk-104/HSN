/*
 * File: app/controller/myWindowController.js
 *
 * This file was generated by Sencha Architect version 4.2.3.
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

Ext.define('M_DUTY_CHARGE_OUT_DISTR.controller.myWindowController', {
    extend: 'Ext.app.Controller',

    control: {
        "#W_selectBtn": {
            click: 'W_selectBtnClick'
        },
        "[cls=W_search]": {
            specialkey: 'W_tfEnter'
        },
        "[cls=BP_search]": {
            specialkey: 'BP_tfEnter1'
        },
        "#windowGrid": {
            celldblclick: 'windowGridCellDblClick'
        },
        "#BPselectBtn": {
            click: 'BPselectBtnClick'
        },
        "#BPgrid": {
            celldblclick: 'BPgridCellDblClick'
        }
    },

    W_selectBtnClick: function(button, e, eOpts) {
        var store = Ext.getCmp('windowGrid').getStore();
        store.load({
            params:{
                V_TYPE : 'WS',
                V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                V_BP_CD : parent.Ext.getCmp('GBP_CD').getValue(),

                V_M_CHARGE_NO : Ext.getCmp('W_M_CHARGE_NO').getValue(),
                V_BL_DOC_NO : Ext.getCmp('W_BL_DOC_NO').getValue(),



                V_TAX_DT : Ext.getCmp('W_TAX_DT').getValue(),


            }
        });
    },

    W_tfEnter: function(field, e, eOpts) {
        if (e.getKey() == e.ENTER) {
            this.W_selectBtnClick();
        }
    },

    BP_tfEnter1: function(field, e, eOpts) {
        if (e.getKey() == e.ENTER) {
            this.BPselectBtnClick();
        }
    },

    windowGridCellDblClick: function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        var controller = this.getController('TbButtonController');

        if(record.data['ERP_YN'] == 'Y'){
            Ext.Msg.alert('확인','승인된 항목은 수정이 불가능합니다.<br>조회는 부대경비정산조회에서 가능합니다.');
        }
        else if(record.data['PAY_YN'] == 'Y' && parent.Ext.getCmp('GBP_CD').getValue() != '00000'){
            Ext.Msg.alert('확인','지급처리된 항목은 수정이 불가능합니다.<br>조회는 부대경비정산조회에서 가능합니다.');
        }
        else{
            Ext.getCmp('V_M_CHARGE_NO').setValue(record.data['M_CHARGE_NO']);
            Ext.getCmp('myWindow').destroy();
            controller.selBtnClick();
        }

    },

    BPselectBtnClick: function(button, e, eOpts) {
        var store = Ext.getCmp('BPgrid').getStore();
        store.load({
            params:{
                V_TYPE : 'BPS',
                V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                V_BP_CD : Ext.getCmp('W_BP_BP_CD').getValue(),
                V_BP_NM : Ext.getCmp('W_BP_BP_NM').getValue()
            }
        });
    },

    BPgridCellDblClick: function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {

        console.log(Ext.getCmp('BPwindow'));


        Ext.getCmp('BPwindow').destroy();
    }

});