


Ext.define('frame.store.SearchMenuStore', {
    extend: 'Ext.data.Store',

    requires: [
        'frame.model.MenuModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'SearchMenuStore',
            model: 'frame.model.MenuModel',
            proxy: {
                type: 'ajax',
                url: 'sql/MenuSearch.jsp',
                reader: {
                    type: 'json',
                    rootProperty: 'resultList'
                }
            }
        }, cfg)]);
    }
});


