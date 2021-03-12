/*
 * File: app/view/MyViewport.js
 *
 * This file was generated by Sencha Architect version 4.2.3.
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

Ext.define('M_PO_NON_DLV_MGM.view.MyViewport', {
    extend: 'Ext.container.Viewport',
    alias: 'widget.myviewport',

    requires: [
        'M_PO_NON_DLV_MGM.view.MyViewportViewModel',
        'M_PO_NON_DLV_MGM.view.TbButton',
        'M_PO_NON_DLV_MGM.view.MySearchForm',
        'M_PO_NON_DLV_MGM.view.MyGrid',
        'M_PO_NON_DLV_MGM.view.MyGrid1',
        'Ext.toolbar.Toolbar',
        'Ext.form.Panel',
        'Ext.grid.Panel',
        'Ext.resizer.Splitter'
    ],

    viewModel: {
        type: 'myviewport'
    },
    height: 250,
    style: 'background-color: white',
    width: 400,

    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    items: [
        {
            xtype: 'toolbarBtn',
            margin: '5 0 0 0'
        },
        {
            xtype: 'mysearchform',
            margin: '-5 0 0 0',
            padding: '',
            bodyPadding: '0 10 0 10',
            margins: ''
        },
        {
            xtype: 'container',
            flex: 1,
            padding: '0 10 0 10',
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'container',
                    flex: 0.6,
                    layout: 'fit',
                    items: [
                        {
                            xtype: 'myGrid',
                            style: 'border: 1px solid lightgray; padding: 5px;'
                        }
                    ]
                },
                {
                    xtype: 'splitter',
                    collapseTarget: 'prev'
                },
                {
                    xtype: 'container',
                    flex: 0.4,
                    layout: 'fit',
                    items: [
                        {
                            xtype: 'mygrid1'
                        }
                    ]
                }
            ]
        }
    ]

});