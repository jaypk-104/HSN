Ext.define('M_LOCAL_LC_MGM.store.MyStore1', {
    extend: 'Ext.data.Store',

    requires: [
        'M_LOCAL_LC_MGM.model.MyModel1',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'MyStore1',
            model: 'M_LOCAL_LC_MGM.model.MyModel1',
            proxy: {
                type: 'ajax',
                api: {
                    read: 'sql/m_local_lc_mgm.jsp',
//                    create: 'sql/m_local_lc_mgm.jsp',
//                    destroy: 'sql/m_local_lc_mgm.jsp',
                    update: 'sql/m_local_lc_mgm.jsp'
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