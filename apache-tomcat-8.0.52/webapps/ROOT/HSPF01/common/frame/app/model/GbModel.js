Ext.define('frame.model.GbModel', {
    extend: 'Ext.data.Model',

    requires: [
        'Ext.data.field.Field'
    ],

    fields: [
        {
            name: 'comp_id'
        },
        {
            name: 'comp_nm'
        },
        {
            name: 'usr_id'
        },
        {
            name: 'usr_nm'
        },
        {
            name: 'dept_nm'
        },
        {
            name: 'posit_nm'
        }
		
    ]
});