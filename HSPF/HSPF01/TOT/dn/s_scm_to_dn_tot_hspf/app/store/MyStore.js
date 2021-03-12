/*
 * File: app/store/MyStore.js
 *
 * This file was generated by Sencha Architect version 4.2.2.
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

Ext.define('S_SCM_TO_DN_TOT_HSPF.store.MyStore', {
    extend: 'Ext.data.Store',

    requires: [
        'S_SCM_TO_DN_TOT_HSPF.model.MyModel',
        'Ext.data.proxy.Ajax',
        'Ext.data.reader.Json',
        'Ext.data.writer.Json'
    ],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([Ext.apply({
            storeId: 'MyStore',
            model: 'S_SCM_TO_DN_TOT_HSPF.model.MyModel',
            proxy: {
                type: 'ajax',
                timeout: 60000, // 프로시져 처리 시간이 길어서 callback이 먼저오는 문제로 인해 timeout 1분 설정
                api: {
                    read: 'sql/S_SCM_TO_DN_TOT_HSPF.jsp',
                    create: 'sql/S_SCM_TO_DN_TOT_HSPF.jsp',
                    destroy: 'sql/S_SCM_TO_DN_TOT_HSPF.jsp',
                    update: 'sql/S_SCM_TO_DN_TOT_HSPF.jsp'
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