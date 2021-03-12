Ext.define('SUPP_QUERY_TOT_HSPF.view.MyWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.mywindow',

    requires: [
        'SUPP_QUERY_TOT_HSPF.view.MyWindowViewModel',
        'Ext.container.Container',
        'Ext.form.Label',
        'Ext.form.field.File',
        'Ext.button.Button'
    ],

    viewModel: {
        type: 'mywindow'
    },
    height: 500,
    width: 700,
    title: '■ 첨부파일',
    modal: true,
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    items: [
    	{
    		xtype: 'hiddenfield',
//    		xtype: 'textfield',
    		id : 'W_ASN_NO'
    	},
    	
    	{
            xtype: 'form',
            width: 400,
            bodyPadding: 10,
            items: [
            	{
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
                    		 var V_ASN_NO = Ext.getCmp('W_ASN_NO').getValue();
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_ASN_NO='+V_ASN_NO+'&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                             form.submit({
                                 url: 'sql/SUPP_QUERY_TOT_HSPF_FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                                 
                                 success : function(fp, res) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_ASN_NO : V_ASN_NO,
											V_USR_ID : V_USR_ID,
										},
//										callback : function(records, operations, success) {
//											var filePreview = '';
//						   					for(var i=0; i<records.length; i++) {
//						   						filePreview += records[i].get('FILE_NM') + '<br>';
//						   					}
//						   					
//						   					var qText = '';
//						   					if(filePreview.length == 0) {
//						   						qText = '없음';
//						   					} else {
//						   						qText = filePreview;
//						   					}
//						   					
//						                	Ext.tip.QuickTipManager.register({
//						                          target: 'fileAddBtn', // Target button's ID
//						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
//						                          text  : qText,
//						                          dismissDelay: 10000 // Hide after 10 seconds hover
//						                    });
//						                	
//						                	Ext.getCmp('fileAddBtn').setText('[ ' + records.length + ' ]');
//											
//											Ext.toast({
//												title : ' ',
//												timeout : 1000,
//												html : '파일첨부완료',
//												style : 'text-align: center',
//												align : 't',
//												width : 130,
//											});
//										}
									});
                            		 object.fileInputEl.set({ multiple:'multiple' }); 
                            		 
                            	 },
                            	 failure: function(fp, o) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_ASN_NO : V_ASN_NO,
											V_USR_ID : V_USR_ID,
										},
//										callback : function(records, operations, success) {
//											var filePreview = '';
//						   					for(var i=0; i<records.length; i++) {
//						   						filePreview += records[i].get('FILE_NM') + '<br>';
//						   					}
//						   					
//						   					if(filePreview.length == 0) {
//						   						qText = '없음';
//						   					} else {
//						   						qText = filePreview;
//						   					}
//						   					
//						   					var qText = filePreview;
//						                	Ext.tip.QuickTipManager.register({
//						                          target: 'fileAddBtn', // Target button's ID
//						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
//						                          text  : qText
//						                    });
//						                	
//						                	Ext.getCmp('fileAddBtn').setText('[ ' + records.length + ' ]');
//											
//											Ext.toast({
//												title : ' ',
//												timeout : 1000,
//												html : '파일첨부완료',
//												style : 'text-align: center',
//												align : 'd',
//												width : 130,
//											});
//										}
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
	                    hidden: true
	                },
                    {
                        xtype: 'label',
                        flex: 1,
                        dock: 'bottom',
                        margin: '3 0 0 15',
                        text: '※ 파일명을 더블클릭 하시면 다운로드가 시작됩니다.'
                    }
					],
            
            store: 'FileStore',
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
                    dataIndex: 'FILE_NM',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    text: '파일명',
                    flex: 1
                },
                {
                    xtype: 'gridcolumn',
//                    format: 'Y-m-d H:m:s',
                    dataIndex: 'INSRT_DT',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    text: '업로드일시',
                    width: 160,
                },
                {
                    xtype: 'gridcolumn',
                    dataIndex: 'FILE_IN_SYSTEM_NM',
                    style: 'font-size: 12px; text-align: center; font-weight: bold;',
                    text: '파일명(hidden)',
            	  hidden: true
                },
            ],
            selModel: {
                selType: 'checkboxmodel',
                listeners: {
                	select: function(rowmodel, record, index, eOpts) {
                    	record.set('V_TYPE', 'R');
                    },
                    deselect: function(rowmodel, record, index, eOpts) {
                    	record.set('V_TYPE', '');
                    }
                },
                mode: 'MULTI'
            },
        }
    ]

});