/*
 * File: app/view/MyTabPanel.js
 *
 * This file was generated by Sencha Architect version 4.2.4.
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

Ext.define('Packhsna.view.MyTabPanel', {
    extend: 'Ext.tab.Panel',
    alias: 'widget.mytabpanel',

    requires: [
        'Packhsna.view.MyTabPanelViewModel',
        'Packhsna.view.MyTabPanelViewController',
        'Ext.tab.Tab',
        'Ext.grid.Panel',
        'Ext.grid.column.Column',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.CellEditing',
        'Ext.view.Table'
    ],

    controller: 'mytabpanel',
    viewModel: {
        type: 'mytabpanel'
    },
    id: 'tabpanel1',
    activeTab: 0,
    defaultListenerScope: true,

    items: [
        {
            xtype: 'panel',
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            layout: 'fit',
            title: 'PALLET 등록대상',
            items: [
                {
                    xtype: 'gridpanel',
                    id: 'grid2',
                    store: 'PalletReg',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            hidden: true,
                            id: 'V_TYPE',
                            dataIndex: 'V_TYPE',
                            text: 'V_TYPE'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'CONT_MGM_NO',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            defaultWidth: 150,
                            dataIndex: 'CONT_NO',
                            text: '컨테이너번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            hidden: true,
                            id: 'CONT_MGM_NO2',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 100,
                            dataIndex: 'CONT_MGM_NO',
                            text: 'CONT_MGM_NO'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'PAL_BC_NO',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            defaultWidth: 180,
                            dataIndex: 'PAL_BC_NO',
                            text: 'PALLET번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'ITEM_CD',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            defaultWidth: 180,
                            dataIndex: 'ITEM_CD',
                            text: '대표품번'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'ITEM_NM',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            defaultWidth: 180,
                            dataIndex: 'ITEM_NM',
                            text: '대표품명'
                        }
                    ],
                    selModel: {
                        selType: 'checkboxmodel',
                        listeners: {
                            select: {
                                fn: 'onCheckboxModelSelect',
                                scope: 'controller'
                            },
                            deselect: {
                                fn: 'onCheckboxModelDeselect',
                                scope: 'controller'
                            }
                        }
                    },
                    plugins: [
                        {
                            ptype: 'cellediting',
                            clicksToEdit: 1,
                            listeners: {
                                edit: 'onCellEditingBeforeEdit11',
                                beforeedit: 'onCellEditingBeforeEdit2'
                            }
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'panel',
            flex: 1,
            style: 'font-size: 12px; text-align: center; font-weight: bold;',
            layout: 'fit',
            title: 'PALLET  등록상세',
            items: [
                {
                    xtype: 'gridpanel',
                    id: 'grid3',
                    store: 'InvoiceReg',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            hidden: true,
                            id: 'V_TYPE2',
                            dataIndex: 'V_TYPE',
                            text: 'V_TYPE'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'CONT_NO1',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 150,
                            defaultWidth: 150,
                            dataIndex: 'CONT_NO',
                            text: '컨테이너번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'PAL_NO1',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            defaultWidth: 180,
                            dataIndex: 'PAL_BC_NO',
                            text: 'PALLET번호'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'ITEM_CD1',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 120,
                            defaultWidth: 120,
                            dataIndex: 'ITEM_CD',
                            text: '대표품번'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'ITEM_NM1',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 120,
                            defaultWidth: 120,
                            dataIndex: 'ITEM_NM',
                            text: '대표품명'
                        },
                        {
                            xtype: 'gridcolumn',
                            id: 'INV_MGM_NO2',
                            style: 'font-size: 12px; text-align: center; font-weight: bold;',
                            width: 180,
                            defaultWidth: 180,
                            dataIndex: 'INV_MGM_NO',
                            text: '인보이스관리번호'
                        }
                    ],
                    selModel: {
                        selType: 'checkboxmodel',
                        listeners: {
                            select: {
                                fn: 'onCheckboxModelSelect1',
                                scope: 'controller'
                            },
                            deselect: {
                                fn: 'onCheckboxModelDeselect1',
                                scope: 'controller'
                            }
                        }
                    },
                    plugins: [
                        {
                            ptype: 'cellediting',
                            listeners: {
                                edit: 'onCellEditingBeforeEdit111',
                                beforeedit: 'onCellEditingBeforeEdit21'
                            }
                        }
                    ]
                }
            ]
        }
    ],

    onCellEditingBeforeEdit11: function(editor, context, eOpts) {
        //?
        if ( context.record.get('crud') != 'C' ){
        	            if (context.record.get('contno') !== ''){
        	                context.record.set('crud','U');
        	            }
        	        }
    },

    onCellEditingBeforeEdit2: function(editor, context, eOpts) {
        //?
        if (context.record.get('balyn') === 'Y'){
        	            return false;
        	        }else{
        	            context.record.set('sel','Y');
        	            if (context.record.get('apply') === 'Y'){	//처리된 건은 수정 불가
        	                Ext.Msg.alert('Warring',' 처리된 자료는 수정되지 않습니다.');
        	                context.record.set('crud','');
        	                context.record.set('sel','');
        	                return false;
        	            } else if (context.record.get('contno') !== ''){//PoNO가 있으면 U로 변경

        	                context.record.set('crud','U');
        	                return true;

        	            }else{
        	                context.record.set('crud','C');
        	                return true;
        	            }

        	        }
    },

    onCellEditingBeforeEdit111: function(editor, context, eOpts) {
        //???
        if ( context.record.get('crud') != 'C' ){
        	            if (context.record.get('contno') !== ''){
        	                context.record.set('crud','U');
        	            }
        	        }
    },

    onCellEditingBeforeEdit21: function(editor, context, eOpts) {
        //?
        if (context.record.get('balyn') === 'Y'){
        	            return false;
        	        }else{
        	            context.record.set('sel','Y');
        	            if (context.record.get('apply') === 'Y'){	//처리된 건은 수정 불가
        	                Ext.Msg.alert('Warring',' 처리된 자료는 수정되지 않습니다.');
        	                context.record.set('crud','');
        	                context.record.set('sel','');
        	                return false;
        	            } else if (context.record.get('contno') !== ''){//PoNO가 있으면 U로 변경

        	                context.record.set('crud','U');
        	                return true;

        	            }else{
        	                context.record.set('crud','C');
        	                return true;
        	            }

        	        }
    }

});