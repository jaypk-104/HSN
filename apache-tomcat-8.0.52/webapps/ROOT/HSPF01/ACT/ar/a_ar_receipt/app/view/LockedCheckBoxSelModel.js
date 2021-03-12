Ext.define('A_AR_RECEIPT.view.LockedCheckBoxSelModel', {
	extend : 'Ext.selection.CheckboxModel',
//	alias : 'widget.lockedcheckboxmodel',
//	alternateClassName : [ 'Ext.selection.LockedCheckBoxSelModel', 'Ext.selection.CheckboxModel' ],
	
	getHeaderConfig: function() {
        var me = this,
            showCheck = me.showHeaderCheckbox !== false,
            htmlEncode = Ext.String.htmlEncode,
            config;
        
        config = {
            xtype: 'checkcolumn',
            headerCheckbox: showCheck,
            isCheckerHd: showCheck, // historically used as a dicriminator property before isCheckColumn 
            ignoreExport: true,
            text: me.headerText,
            width: me.headerWidth,
            sortable: false,
            draggable: false,
            resizable: false,
            hideable: false,
            menuDisabled: true,
            checkOnly: me.checkOnly,
            checkboxAriaRole: 'presentation',
            tdCls: me.tdCls,
            cls: Ext.baseCSSPrefix + 'selmodel-column',
            editRenderer: me.editRenderer || me.renderEmpty,            
            locked: true,
            processEvent: me.processColumnEvent,
 
            // It must not attempt to set anything in the records on toggle. 
            // We handle that in onHeaderClick. 
            toggleAll: Ext.emptyFn,
 
            // The selection model listens to the navigation model to select/deselect 
            setRecordCheck: Ext.emptyFn,
            
            // It uses our isRowSelected to test whether a row is checked 
            isRecordChecked: me.isRowSelected.bind(me)
        };
        
        if (!me.checkOnly) {
            config.tabIndex = undefined;
            config.ariaRole = 'presentation';
            config.focusable = false;
            config.cellFocusable = false;
        }
        else {
            config.useAriaElements = true;
            config.ariaLabel = htmlEncode(me.headerAriaLabel);
            config.headerSelectText = htmlEncode(me.headerSelectText);
            config.headerDeselectText = htmlEncode(me.headerDeselectText);
            config.rowSelectText = htmlEncode(me.rowSelectText);
            config.rowDeselectText = htmlEncode(me.rowDeselectText);
        }
        
        return config;
    },
    
});