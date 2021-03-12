Ext.define('M_B_CON_SELECT_DISTB.view.FileWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.filewindow',

    requires: [
        'M_B_CON_SELECT_DISTB.view.FileWindowViewModel',
        'Ext.form.field.File'
    ],

    viewModel: {
        type: 'filewindow'
    },
    height: 150,
    width: 400,
    layout: 'center',
    title: '첨부파일',
    modal: true,
    id: 'fileWindow',

    items: [
    	{
    		
    	xtype: 'form',
        width: 400,
        bodyPadding: 10,
        items: [
        	{
                xtype: 'filefield',
                width: 300,
                listeners:{
                    afterrender:function(object){
                        //input type="file" 태그 속성중  multiple이라는 속성 추가
                        object.fileInputEl.set({multiple:'multiple'});
                    },
                    change : function(object, value, eOpts ){
                    	var form = this.up('form').getForm();
                    	var record = Ext.getCmp('myGrid1').getSelectionModel().getSelection();
                    	console.log('시작');
                    	 if(form.isValid()){
                    		 var V_BL_NO = record[0].data['BL_NO'];
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                             form.submit({
                                 url: 'sql/FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                                 
                                 success : function(fp, res) {
                            		 var jResult = Ext.JSON.decode(res.response.responseText);
                            		 record[0].set('FILE_NM', jResult.resultList[0].V_FILE_NM);
                            		 record[0].set('FILE_NM_PC', jResult.resultList[0].V_FILE_IN_SYSTEM_NM);
                            		 record[0].set('CON_YN', 'Y');
                            		 
                            		 Ext.getCmp('fileWindow').destroy();
                                	 
                            	 },
                            	 failure: function(fp, res) {
                            		 var jResult = Ext.JSON.decode(res.response.responseText);
                            		 record[0].set('FILE_NM', jResult.resultList[0].V_FILE_NM);
                            		 record[0].set('FILE_NM_PC', jResult.resultList[0].V_FILE_IN_SYSTEM_NM);
                            		 record[0].set('CON_YN', 'Y');
                            		 
                            		 Ext.getCmp('fileWindow').destroy();
                            	 }

                             });
                         }
                    }
                }
            }
        ]
        	
    	},
    	
        
    ]

});