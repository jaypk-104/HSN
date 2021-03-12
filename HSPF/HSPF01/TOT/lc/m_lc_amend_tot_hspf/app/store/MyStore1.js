Ext.define('M_LC_AMEND_TOT_HSPF.store.MyStore1', {
    extend: 'Ext.data.Store',

    requires: [
        'M_LC_AMEND_TOT_HSPF.model.MyModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'MyStore1',
            model: 'M_LC_AMEND_TOT_HSPF.model.MyModel',
            proxy: {
                type: 'ajax',
                api: {
                    read: 'sql/M_LC_AMEND_TOT_HSPF.jsp',
                    create: 'sql/M_LC_AMEND_TOT_HSPF.jsp',
                    destroy: 'sql/M_LC_AMEND_TOT_HSPF.jsp',
                    update: 'sql/M_LC_AMEND_TOT_HSPF.jsp'
                },
                reader: {
                    type: 'json',
                    rootProperty: 'resultList'
                },
                writer: {
                    type: 'json',
                    writeAllFields: true,
                    encode: true,
                    rootProperty: 'data'
                }
            }
        }, cfg)]);
    }
});