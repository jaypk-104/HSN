Ext.define('M_COL_ACCPT_HSPF.store.MyStore1', {
    extend: 'Ext.data.Store',

    requires: [
        'M_COL_ACCPT_HSPF.model.MyModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'MyStore1',
            model: 'M_COL_ACCPT_HSPF.model.MyModel',
            proxy: {
                type: 'ajax',
                api: {
                    read: 'sql/M_COL_ACCPT_HSPF.jsp',
                    create: 'sql/M_COL_ACCPT_HSPF.jsp',
                    destroy: 'sql/M_COL_ACCPT_HSPF.jsp',
                    update: 'sql/M_COL_ACCPT_HSPF.jsp'
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