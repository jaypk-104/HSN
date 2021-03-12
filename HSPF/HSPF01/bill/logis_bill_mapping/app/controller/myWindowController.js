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

Ext.define('M_CHARGE_OUT_DISTR2.controller.myWindowController', {
    extend: 'Ext.app.Controller',

    control: {
        "#W_selectBtn": {
            click: 'W_selectBtnClick'
        },
        "[cls=W_search]": {
            specialkey: 'W_tfEnter'
        },
        "[cls=BL_search]": {
            specialkey: 'BL_tfEnter1'
        },
        "#windowGrid": {
            celldblclick: 'windowGridCellDblClick'
        },
        "#BLselectBtn": {
            click: 'BLselectBtnClick'
        },
        "#BLgrid": {
            celldblclick: 'BLgridCellDblClick'
        }
    },

    W_selectBtnClick: function(button, e, eOpts) {
        var store = Ext.getCmp('windowGrid').getStore();
        store.load({
            params:{
                V_TYPE : 'WS',
                V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                V_CH_MST_NO : Ext.getCmp('W_CH_MST_NO').getValue(),
                V_BL_DOC_NO : Ext.getCmp('W_BL_DOC_NO').getValue(),
                V_ITEM_NM : Ext.getCmp('W_ITEM_NM').getValue(),
                V_A_BP_CD : Ext.getCmp('W_A_BP_CD').getValue(),
                V_VESEL : Ext.getCmp('W_VESEL').getValue(),
                V_VESEL_BP_NM : Ext.getCmp('W_VESEL_BP_NM').getValue(),
                V_ID_DT : Ext.getCmp('W_ID_DT').getValue(),
                V_IN_DT : Ext.getCmp('W_IN_DT').getValue(),
            }
        });
    },

    W_tfEnter: function(field, e, eOpts) {
        if (e.getKey() == e.ENTER) {
            this.W_selectBtnClick();
        }
    },

    BL_tfEnter1: function(field, e, eOpts) {
        if (e.getKey() == e.ENTER) {
            this.BLselectBtnClick();
        }
    },

    windowGridCellDblClick: function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        var controller = this.getController('TbButtonController');

        Ext.getCmp('V_CH_MST_NO').setValue(record.data['CH_MST_NO']);
        Ext.getCmp('myWindow').destroy();
        controller.selBtnClick();
    },

    BLselectBtnClick: function(button, e, eOpts) {
        var store = Ext.getCmp('BLgrid').getStore();
        store.load({
            params:{
                V_TYPE : 'BLS',
                V_COMP_ID : parent.Ext.getCmp('GCOMP_ID').getValue(),
                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                V_BL_DOC_NO : Ext.getCmp('BL_BL_DOC_NO').getValue(),
                V_PO_NO : Ext.getCmp('BL_PO_NO').getValue()
            }
        });
    },

    BLgridCellDblClick: function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        Ext.getCmp('V_BL_DOC_NO').setValue(record.data['BL_DOC_NO']);
        Ext.getCmp('BLwindow').destroy();
    }

});