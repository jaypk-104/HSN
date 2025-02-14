/*
 * File: app/view/MyViewport.js
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

Ext.define('M_PROD_PLAN_MNTH_HSPF.view.MyViewport', {
    extend: 'Ext.container.Viewport',
    alias: 'widget.myviewport',

    requires: [
        'M_PROD_PLAN_MNTH_HSPF.view.MyViewportViewModel',
        'M_PROD_PLAN_MNTH_HSPF.view.TbButton',
        'M_PROD_PLAN_MNTH_HSPF.view.MySearchForm',
        'M_PROD_PLAN_MNTH_HSPF.view.MyGrid',
        'Ext.toolbar.Toolbar',
        'Ext.form.Panel',
        'Ext.form.FieldSet',
        'Ext.grid.Panel'
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
            layout: 'fit',
            items: [
                {
                    xtype: 'fieldset',
                    flex: 1,
                    style: 'background-color: white;',
                    layout: 'fit',
                    title: 'Result',
                    items: [
                        {
                            xtype: 'myGrid',
                            tbar: [
                                {
                                    xtype: 'datefield',
                                    fieldLabel: '발주요청일',
                                    id: 'poReqDt',
                                    margin: '0 3 0 0',
                                    format: 'YYYY-mm-dd',
                                    style: 'font-size: 12px'
                                },
                                {
                                    id: 'poReqBtn',
                                    xtype: 'button',
                                    text: '발주요청생성',
                                    margin: '0 3 0 0'
                                },
                                {
                                    id: 'poCancelBtn',
                                    xtype: 'button',
                                    text: '발주요청취소',
                                    margin: '0 3 0 0'
                                },
                                {
                                    xtype: 'container',
                                    flex: 1
                                },
                                {
                                    id: 'planIfBtn',
                                    xtype: 'button',
                                    text: '생산계획I/F',
                                    margin: '0 3 0 0'
                                },
                                {
                                    xtype: 'button',
                                    text: 'Export',
                                    menu: {
                                        defaults: {
                                            handler: 'gridExportBtn'
                                        },
                                        items: [
                                            {
                                                id: 'xlsxDown',
                                                text: 'Excel xlsx',
                                                cfg: {
                                                    type: 'excel07',
                                                    ext: 'xlsx'
                                                }
                                            },
                                            {
                                                id: 'xmlDown',
                                                text: 'Excel xml',
                                                cfg: {
                                                    type: 'excel03',
                                                    ext: 'xml'
                                                }
                                            },
                                            {
                                                id: 'pdfDown',
                                                text: 'PDF',
                                                cfg: {
                                                    type: 'pdf'
                                                }
                                            }
                                        ]
                                    }
                                }
                            ],
                            flex: 1,
                            margin: '-15 -15 0 -15',
                            style: 'padding: 10px;'
                        }
                    ]
                }
            ]
        }
    ]

});