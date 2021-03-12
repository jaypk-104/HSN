


Ext.define('frame.store.GbStore', {
    extend: 'Ext.data.Store',

    requires: [
        'frame.model.GbModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'GbStore',
            model: 'frame.model.GbModel',
            proxy: {
                type: 'ajax',
                url: 'sql/Global.jsp',
                reader: {
                    type: 'json',
                    rootProperty: 'resultList'
                }
            }
        }, cfg)]);
    }
});


