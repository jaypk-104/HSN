Ext.define('ContHsna.view.FileWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.filewindow',

    requires: [
        'ContHsna.view.FileWindowViewModel',
        'Ext.container.Container',
        'Ext.form.Label',
        'Ext.form.field.File',
        'Ext.button.Button'
    ],

    viewModel: {
        type: 'filewindow'
    },
    height: 500,
    width: 1400,
    title: '■ 첨부파일',
    modal: true,
    layout: {
        type: 'hbox',
        align: 'stretch'
    },
    items: [
    	{
    		xtype: 'container',
    		flex: 1,
    		layout: {
    	        type: 'vbox',
    	        align: 'stretch'
    	    },
    		items:[
    			{
    				xtype:'label',
    				text: '<체크리스트>',
    				style: 'text-align: center; font-size: 15px;',
    			},
    			{
    				xtype: 'hiddenfield',
//    				xtype: 'textfield',
    				id : 'W_CONT_NO',
    			},
    			{
    	            xtype: 'form',
    	            width: 400,
    	            bodyPadding: 10,
    	            items: [{
    	            	xtype: 'filefield',
    	                name: 'file',
    	                id: 'fileName',
    	                fieldLabel: 'File',
    	                labelWidth: 50,
    	                msgTarget: 'side',
    	                allowBlank: false,
    	                anchor: '100%',
    	                buttonText: '파일첨부...',
    	                listeners:{
    	                    afterrender:function(object){
    	                        //input type="file" 태그 속성중  multiple이라는 속성 추가
    	                        object.fileInputEl.set({multiple:'multiple'});
    	                    },
    	                    change : function(object, value, eOpts ){
    	                    	var form = this.up('form').getForm();
    	                    	 if(form.isValid()){
    	                    		 var V_CONT_NO = Ext.getCmp('W_CONT_NO').getValue();
    	                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
    	                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
    	                    		 var params = 'V_TYPE=I&V_FILE_TYPE=L&V_CONT_NO='+V_CONT_NO+'&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
    	                             form.submit({
    	                                 url: 'sql/cont_file.jsp?'+params,
    	                                 waitMsg: 'Uploading your file...',
    	                                 
    	                                 success : function(fp, res) { 
    	                                	 var fileStore = Ext.getStore('FileStore1');
    	                                	 fileStore.removeAll();
    	                                	 fileStore.load({
    											params : {
    												V_TYPE : 'S',
    												V_FILE_TYPE: 'L',
    												V_COMP_ID : V_COMP_ID,
    												V_CONT_NO : V_CONT_NO,
    												V_USR_ID : V_USR_ID,
    											},
    											callback : function(records, operations, success) {
    												var filePreview = '';
    												
    												Ext.toast({
    													title : ' ',
    													timeout : 1000,
    													html : '파일첨부완료',
    													style : 'text-align: center',
    													align : 't',
    													width : 130,
    												});
    											}
    										});
    	                            		 object.fileInputEl.set({ multiple:'multiple' }); 
    	                            		 
    	                            	 },
    	                            	 failure: function(fp, o) { 
    	                                	 var fileStore = Ext.getStore('FileStore1');
    	                                	 fileStore.removeAll();
    	                                	 fileStore.load({
    											params : {
    												V_TYPE : 'S',
    												V_FILE_TYPE: 'L',
    												V_COMP_ID : V_COMP_ID,
    												V_CONT_NO : V_CONT_NO,
    												V_USR_ID : V_USR_ID,
    											},
    											callback : function(records, operations, success) {
    							                	
    												Ext.toast({
    													title : ' ',
    													timeout : 1000,
    													html : '파일첨부완료',
    													style : 'text-align: center',
    													align : 'd',
    													width : 130,
    												});
    											}
    										});
    	                            		 object.fileInputEl.set({ multiple:'multiple' }); 
    	                            		 
    	                            	 }

    	                             });
    	                         }
    	                    }
    	                }
    	        	}, 
    	        	],
    	            
    	        },
    	        {
    	        	flex: 1,
    	            xtype: 'gridpanel',
    	            title: 'My Grid Panel',
    	            id: 'fileGrid',
    	            style: 'border: 1px solid lightgray; padding: 5px;',
    	            tbar : [
    						{
    		                    id: 'fileDelBtn',
    		                    text: '',
    		                    margin: '0 3 0 -3',
    		                    glyph: 'xf056@FontAwesome',
    		                    iconCls: 'grid-del-btn',
    		                },
    	                    {
    	                        xtype: 'label',
    	                        flex: 1,
    	                        dock: 'bottom',
    	                        margin: '3 0 0 15',
    	                        text: '※ 파일명을 더블클릭 하시면 다운로드가 시작됩니다.'
    	                    }
    						],
    	            
    	            store: 'FileStore1',
    	            bodyBorder: false,
    	            header: false,
    	            columnLines: true, 
    	            columns: [
    		              {
    		            	  xtype: 'rownumberer',
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'V_TYPE',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		            	  
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'CONT_NO',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'FILE_TYPE',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		              },
    	                {
    	                    xtype: 'gridcolumn',
    	                    dataIndex: 'FILE_NM',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '파일명',
    	                    flex: 1
    	                },
    	                {
    	                    xtype: 'gridcolumn',
//    	                    format: 'Y-m-d H:m:s',
    	                    dataIndex: 'INSRT_DT',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '업로드일시',
    	                    width: 160,
    	                },
    	                {
    	                    xtype: 'gridcolumn',
    	                    dataIndex: 'FILE_SYS_NM',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '파일명(hidden)',
    	            	  hidden: true
    	                },
    	            ],
    	            selModel: {
    	                selType: 'checkboxmodel',
    	                listeners: {
    	                	select: function(rowmodel, record, index, eOpts) {
    	                    	record.set('V_TYPE', 'D');
    	                    },
    	                    deselect: function(rowmodel, record, index, eOpts) {
    	                    	record.set('V_TYPE', '');
    	                    }
    	                },
    	                mode: 'MULTI'
    	            },
    	        }
    		]
    	},
    	{
            xtype: 'splitter',
            style: 'background-color: gray;'
        },
    	{
    		xtype: 'container',
    		flex: 1,
    		layout: {
    	        type: 'vbox',
    	        align: 'stretch'
    	    },
    		items:[
    			{
    				xtype:'label',
    				text: '<컨테이너작업사진>',
    				style: 'text-align: center; font-size: 15px;',
    			},
    			{
    	            xtype: 'form',
    	            width: 400,
    	            bodyPadding: 10,
    	            items: [{
    	            	xtype: 'filefield',
    	                name: 'file',
    	                id: 'fileName2',
    	                fieldLabel: 'File',
    	                labelWidth: 50,
    	                msgTarget: 'side',
    	                allowBlank: false,
    	                anchor: '100%',
    	                buttonText: '파일첨부...',
    	                listeners:{
    	                    afterrender:function(object){
    	                        //input type="file" 태그 속성중  multiple이라는 속성 추가
    	                        object.fileInputEl.set({multiple:'multiple'});
    	                    },
    	                    change : function(object, value, eOpts ){
    	                    	var form = this.up('form').getForm();
    	                    	 if(form.isValid()){
    	                    		 var V_CONT_NO = Ext.getCmp('W_CONT_NO').getValue();
    	                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
    	                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
    	                    		 var params = 'V_TYPE=I&V_FILE_TYPE=R&V_CONT_NO='+V_CONT_NO+'&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
    	                             form.submit({
    	                                 url: 'sql/cont_file.jsp?'+params,
    	                                 waitMsg: 'Uploading your file...',
    	                                 
    	                                 success : function(fp, res) { 
    	                                	 var fileStore = Ext.getStore('FileStore2');
    	                                	 fileStore.removeAll();
    	                                	 fileStore.load({
    											params : {
    												V_TYPE : 'S',
    												V_FILE_TYPE: 'R',
    												V_COMP_ID : V_COMP_ID,
    												V_CONT_NO : V_CONT_NO,
    												V_USR_ID : V_USR_ID,
    											},
    											callback : function(records, operations, success) {
    												
    												Ext.toast({
    													title : ' ',
    													timeout : 1000,
    													html : '파일첨부완료',
    													style : 'text-align: center',
    													align : 't',
    													width : 130,
    												});
    											}
    										});
    	                            		 object.fileInputEl.set({ multiple:'multiple' }); 
    	                            		 
    	                            	 },
    	                            	 failure: function(fp, o) { 
    	                                	 var fileStore = Ext.getStore('FileStore2');
    	                                	 fileStore.removeAll();
    	                                	 fileStore.load({
    											params : {
    												V_TYPE : 'S',
    												V_FILE_TYPE: 'R',
    												V_COMP_ID : V_COMP_ID,
    												V_CONT_NO : V_CONT_NO,
    												V_USR_ID : V_USR_ID,
    											},
    											callback : function(records, operations, success) {
    												
    												Ext.toast({
    													title : ' ',
    													timeout : 1000,
    													html : '파일첨부완료',
    													style : 'text-align: center',
    													align : 'd',
    													width : 130,
    												});
    											}
    										});
    	                            		 object.fileInputEl.set({ multiple:'multiple' }); 
    	                            		 
    	                            	 }

    	                             });
    	                         }
    	                    }
    	                }
    	        	}, 
    	        	],
    	            
    	        },
    	        {
    	        	flex: 1,
    	            xtype: 'gridpanel',
    	            title: 'My Grid Panel',
    	            id: 'fileGrid2',
    	            style: 'border: 1px solid lightgray; padding: 5px;',
    	            tbar : [
    						{
    		                    id: 'fileDelBtn2',
    		                    text: '',
    		                    margin: '0 3 0 -3',
    		                    glyph: 'xf056@FontAwesome',
    		                    iconCls: 'grid-del-btn',
    		                },
    	                    {
    	                        xtype: 'label',
    	                        flex: 1,
    	                        dock: 'bottom',
    	                        margin: '3 0 0 15',
    	                        text: '※ 파일명을 더블클릭 하시면 다운로드가 시작됩니다.'
    	                    }
    						],
    	            
    	            store: 'FileStore2',
    	            bodyBorder: false,
    	            header: false,
    	            columnLines: true, 
    	            columns: [
    		              {
    		            	  xtype: 'rownumberer',
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'V_TYPE',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		            	  
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'CONT_NO',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		              },
    		              {
    		            	  xtype: 'gridcolumn',
    		            	  dataIndex: 'FILE_TYPE',
    		            	  style: 'font-size: 12px; text-align: center; font-weight: bold;',
    		            	  hidden: true
    		              },
    	                {
    	                    xtype: 'gridcolumn',
    	                    dataIndex: 'FILE_NM',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '파일명',
    	                    flex: 1
    	                },
    	                {
    	                    xtype: 'gridcolumn',
//    	                    format: 'Y-m-d H:m:s',
    	                    dataIndex: 'INSRT_DT',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '업로드일시',
    	                    width: 160,
    	                },
    	                {
    	                    xtype: 'gridcolumn',
    	                    dataIndex: 'FILE_SYS_NM',
    	                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
    	                    text: '파일명(hidden)',
    	            	  hidden: true
    	                },
    	            ],
    	            selModel: {
    	                selType: 'checkboxmodel',
    	                listeners: {
    	                	select: function(rowmodel, record, index, eOpts) {
    	                    	record.set('V_TYPE', 'D');
    	                    },
    	                    deselect: function(rowmodel, record, index, eOpts) {
    	                    	record.set('V_TYPE', '');
    	                    }
    	                },
    	                mode: 'MULTI'
    	            },
    	        }
    		]
    	},
        
    ]

});