Ext.define('frame.model.MenuModel', {
    extend: 'Ext.data.Model',

    requires: [
        'Ext.data.field.Field'
    ],

    fields: [
        {
            name: 'id'
        },
        {
            name: 'name'
        },
        {
        	name: 'text'
        },
        {
        	name: 'expanded'
        },
    ]
});