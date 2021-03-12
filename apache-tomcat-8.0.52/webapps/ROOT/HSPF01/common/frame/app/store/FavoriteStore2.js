


Ext.define('frame.store.FavoriteStore2', {
    extend: 'Ext.data.TreeStore',

    requires: [
        'frame.model.MenuModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'FavoriteStore2', 
            model: 'frame.model.MenuModel',
            root: {
            	id: 0,
                text: 'root',
                expanded: false,
            },
            autoLoad:false,
            proxy: {
                type: 'ajax',
                url: 'sql/MenuFavoriteList.jsp', 
                reader: {
                    type: 'json',
                    rootProperty: 'children'
                }
            }
        }, cfg)]);
    }
});


