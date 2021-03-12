Ext.define('M_PO_HSPF.model.MyModel1', {
    extend: 'Ext.data.Model',

    requires: [
        'Ext.data.field.Field'
    ],

    fields: [
        {
            name: 'PO_NO'
        },
        {
            name: 'PO_SEQ'
        },
        {
            name: 'ITEM_CD'
        },
        {
            name: 'ITEM_NM'
        },
        {
            name: 'PO_QTY'
        },
        {
            name: 'PO_PRC'
        },
        {
            name: 'PO_AMT'
        },
        {
            name: 'PO_LOC_AMT'
        },
        {
            name: 'VAT_TYPE'
        },
        {
            name: 'VAT_TYPE_NM'
        },
        {
            name: 'V_PO_VAT_AMT'
        },
        {
            name: 'DLVY_HOPE_DT'
        },
        {
            name: 'HOPE_SL_CD'
        },
        {
            name: 'SL_NM'
        },
        {
            name: 'OVER_TOL'
        },
        {
            name: 'UNDER_TOL'
        },
        {
            name: 'PUR_NO'
        },
        {
            name: 'PUR_SEQ'
        },
        {
            name: 'ERP_TRANS_YN'
        }
    ]
});