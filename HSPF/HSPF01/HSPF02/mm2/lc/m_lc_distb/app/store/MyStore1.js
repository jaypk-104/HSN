Ext.define('M_LC_DISTB.store.MyStore1', {
    extend: 'Ext.data.Store',

    requires: [
        'M_LC_DISTB.model.MyModel1',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'MyStore1',
            model: 'M_LC_DISTB.model.MyModel1',
            proxy: {
                type: 'ajax',
                api: {
                    read: 'sql/M_LC_DISTB_D.jsp',
                    create: 'sql/M_LC_DISTB_D.jsp',
                    destroy: 'sql/M_LC_DISTB_D.jsp',
                    update: 'sql/M_LC_DISTB_D.jsp'
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