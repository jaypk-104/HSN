Ext.define('S_BL_MST_TOT_HSPF.view.MyWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.mywindow',

    requires: [
        'S_BL_MST_TOT_HSPF.view.MyWindowViewModel',
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
            xtype: 'form',
            width: 450,
            bodyPadding: 10,
            items: [{
            	xtype: 'filefield',
                name: 'file',
                id: 'fileName3',
                fieldLabel: 'B/L서류등록',
                labelWidth: 120,
                width: 700,
                msgTarget: 'side',
                allowBlank: false,
//                anchor: '40%',
                buttonText: '파일첨부',
                emptyText: 'B/L서류 첨부파일을 끌어다 놓거나 파일첨부 버튼을 클릭해주세요',
                listeners:{
                    afterrender:function(object){
                        //input type="file" 태그 속성중  multiple이라는 속성 추가
                        object.fileInputEl.set({multiple:'multiple'});
                    },
                    drop: {
                        fn: 'drop',
                        element: 'el'
                    },
                    dragstart: {
                        fn: 'dragstart',
                        element: 'el'
                    },
                    dragenter: {
                        fn: 'dragenter',
                        element: 'el'
                    },
                    dragover: {
                        fn: 'dragover',
                        element: 'el'
                    },
                    dragleave: {
                        fn: 'dragleave',
                        element: 'el'
                    },
                    dragexit: {
                        fn: 'dragexit',
                        element: 'el'
                    },
                    change : function(object, value, eOpts ){
                    	
                    	var form = this.up('form').getForm();
                    	 if(form.isValid()){
                    		 var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=BL&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                       
                    		 form.submit({
                                 url: 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                              
                                 
                                 success : function(fp, res) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					var qText = '';
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText,
						                          dismissDelay: 10000 // Hide after 10 seconds hover
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						   					var qText = filePreview;
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                },
                drop: function(e) {
                	var store = Ext.create('Ext.data.Store', {
                        fields: ['name', 'size', 'file', 'status']
                    });
                	
                	e.stopEvent();

                    Ext.Array.forEach(Ext.Array.from(e.browserEvent.dataTransfer.files), function(file) {
                        store.add({
                            file: file,
                            name: file.name,
                            size: file.size,
                            status: 'Ready'

                        });
                    });
                    for (var i = 0; i < store.data.items.length; i++) {
                    	if (!(store.getData().getAt(i).data.status === "Uploaded")) {
                    		store.getData().getAt(i).data.status = "Uploading";
                            store.getData().getAt(i).commit();
                            
                            var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                   		 	var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                   		 	var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                            
                   		 	var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=BL&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                            
                            var xhr = new XMLHttpRequest();
                            var fd = new FormData();
                            fd.append("serverTimeDiff", 0);
                            xhr.open("POST", 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?' + params, false);
                            fd.append('index', i);
                            fd.append('file', store.getData().getAt(i).data.file);
                            xhr.setRequestHeader("serverTimeDiff", 0);
                            
                            xhr.send(fd);
                    	}
                    }
                    
                    var fileStore = Ext.getStore('FileStore');
	               	 fileStore.removeAll();
	               	 fileStore.load({
							params : {
								V_TYPE : 'S',
								V_COMP_ID : V_COMP_ID,
								V_BL_NO : V_BL_NO,
								V_USR_ID : V_USR_ID,
							},
							callback : function(records, operations, success) {
								var filePreview = '';
			   					for(var i=0; i<records.length; i++) {
			   						filePreview += records[i].get('FILE_NM') + '<br>';
			   					}
			   					
			   					var qText = '';
			   					if(filePreview.length == 0) {
			   						qText = '없음';
			   					} else {
			   						qText = filePreview;
			   					}
			   					
			                	Ext.tip.QuickTipManager.register({
			                          target: 'blDocRegBtn', // Target button's ID
			                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
			                          text  : qText,
			                          dismissDelay: 10000 // Hide after 10 seconds hover
			                    });
			                	
			                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
								
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
                    
                },

                dragstart: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragenter: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragover: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragleave: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },

                dragexit: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },
        	}, 
        	],
        }, 
    	
    	{
            xtype: 'form',
            width: 450,
            bodyPadding: 10,
            items: [{
            	xtype: 'filefield',
                name: 'file',
                id: 'fileName1',
                fieldLabel: '인보이스/패킹등록',
                labelWidth: 120,
                width: 700,
                msgTarget: 'side',
                allowBlank: false,
//                anchor: '40%',
                buttonText: '파일첨부',
                emptyText: '인보이스/패킹 첨부파일을 끌어다 놓거나 파일첨부 버튼을 클릭해주세요',
                listeners:{
                    afterrender:function(object){
                        //input type="file" 태그 속성중  multiple이라는 속성 추가
                        object.fileInputEl.set({multiple:'multiple'});
                    },
                    drop: {
                        fn: 'drop',
                        element: 'el'
                    },
                    dragstart: {
                        fn: 'dragstart',
                        element: 'el'
                    },
                    dragenter: {
                        fn: 'dragenter',
                        element: 'el'
                    },
                    dragover: {
                        fn: 'dragover',
                        element: 'el'
                    },
                    dragleave: {
                        fn: 'dragleave',
                        element: 'el'
                    },
                    dragexit: {
                        fn: 'dragexit',
                        element: 'el'
                    },
                    change : function(object, value, eOpts ){
                    	
                    	var form = this.up('form').getForm();
                    	 if(form.isValid()){
                    		 var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=INV&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                       
                    		 form.submit({
                                 url: 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                              
                                 
                                 success : function(fp, res) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					var qText = '';
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText,
						                          dismissDelay: 10000 // Hide after 10 seconds hover
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						   					var qText = filePreview;
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                },
                drop: function(e) {
                	var store = Ext.create('Ext.data.Store', {
                        fields: ['name', 'size', 'file', 'status']
                    });
                	
                	e.stopEvent();

                    Ext.Array.forEach(Ext.Array.from(e.browserEvent.dataTransfer.files), function(file) {
                        store.add({
                            file: file,
                            name: file.name,
                            size: file.size,
                            status: 'Ready'

                        });
                    });
                    for (var i = 0; i < store.data.items.length; i++) {
                    	if (!(store.getData().getAt(i).data.status === "Uploaded")) {
                    		store.getData().getAt(i).data.status = "Uploading";
                            store.getData().getAt(i).commit();
                            
                            var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                   		 	var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                   		 	var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                            
                   		 	var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=INV&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                            
                            var xhr = new XMLHttpRequest();
                            var fd = new FormData();
                            fd.append("serverTimeDiff", 0);
                            xhr.open("POST", 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?' + params, false);
                            fd.append('index', i);
                            fd.append('file', store.getData().getAt(i).data.file);
                            xhr.setRequestHeader("serverTimeDiff", 0);
                            
                            xhr.send(fd);
                    	}
                    }
                    
                    var fileStore = Ext.getStore('FileStore');
	               	 fileStore.removeAll();
	               	 fileStore.load({
							params : {
								V_TYPE : 'S',
								V_COMP_ID : V_COMP_ID,
								V_BL_NO : V_BL_NO,
								V_USR_ID : V_USR_ID,
							},
							callback : function(records, operations, success) {
								var filePreview = '';
			   					for(var i=0; i<records.length; i++) {
			   						filePreview += records[i].get('FILE_NM') + '<br>';
			   					}
			   					
			   					var qText = '';
			   					if(filePreview.length == 0) {
			   						qText = '없음';
			   					} else {
			   						qText = filePreview;
			   					}
			   					
			                	Ext.tip.QuickTipManager.register({
			                          target: 'blDocRegBtn', // Target button's ID
			                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
			                          text  : qText,
			                          dismissDelay: 10000 // Hide after 10 seconds hover
			                    });
			                	
			                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
								
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
                    
                },

                dragstart: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragenter: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragover: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragleave: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },

                dragexit: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },
        	}, 
        	],
        },
        {
            xtype: 'form',
            width: 450,
            bodyPadding: 10,
            items: [{
            	xtype: 'filefield',
                name: 'file',
                id: 'fileName4',
                fieldLabel: '면장서류등록',
                labelWidth: 120,
                width: 700,
                msgTarget: 'side',
                allowBlank: false,
//                anchor: '40%',
                buttonText: '파일첨부',
                emptyText: '면장서류 첨부파일을 끌어다 놓거나 파일첨부 버튼을 클릭해주세요',
                listeners:{
                    afterrender:function(object){
                        //input type="file" 태그 속성중  multiple이라는 속성 추가
                        object.fileInputEl.set({multiple:'multiple'});
                    },
                    drop: {
                        fn: 'drop',
                        element: 'el'
                    },
                    dragstart: {
                        fn: 'dragstart',
                        element: 'el'
                    },
                    dragenter: {
                        fn: 'dragenter',
                        element: 'el'
                    },
                    dragover: {
                        fn: 'dragover',
                        element: 'el'
                    },
                    dragleave: {
                        fn: 'dragleave',
                        element: 'el'
                    },
                    dragexit: {
                        fn: 'dragexit',
                        element: 'el'
                    },
                    change : function(object, value, eOpts ){
                    	
                    	var form = this.up('form').getForm();
                    	 if(form.isValid()){
                    		 var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=EXP&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                       
                    		 form.submit({
                                 url: 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                              
                                 
                                 success : function(fp, res) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					var qText = '';
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText,
						                          dismissDelay: 10000 // Hide after 10 seconds hover
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						   					var qText = filePreview;
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                },
                drop: function(e) {
                	var store = Ext.create('Ext.data.Store', {
                        fields: ['name', 'size', 'file', 'status']
                    });
                	
                	e.stopEvent();

                    Ext.Array.forEach(Ext.Array.from(e.browserEvent.dataTransfer.files), function(file) {
                        store.add({
                            file: file,
                            name: file.name,
                            size: file.size,
                            status: 'Ready'

                        });
                    });
                    for (var i = 0; i < store.data.items.length; i++) {
                    	if (!(store.getData().getAt(i).data.status === "Uploaded")) {
                    		store.getData().getAt(i).data.status = "Uploading";
                            store.getData().getAt(i).commit();
                            
                            var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                   		 	var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                   		 	var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                            
                            var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=EXP&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                            
                            var xhr = new XMLHttpRequest();
                            var fd = new FormData();
                            fd.append("serverTimeDiff", 0);
                            xhr.open("POST", 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?' + params, false);
                            fd.append('index', i);
                            fd.append('file', store.getData().getAt(i).data.file);
                            xhr.setRequestHeader("serverTimeDiff", 0);
                            
                            xhr.send(fd);
                    	}
                    }
                    
                    var fileStore = Ext.getStore('FileStore');
	               	 fileStore.removeAll();
	               	 fileStore.load({
							params : {
								V_TYPE : 'S',
								V_COMP_ID : V_COMP_ID,
								V_BL_NO : V_BL_NO,
								V_USR_ID : V_USR_ID,
							},
							callback : function(records, operations, success) {
								var filePreview = '';
			   					for(var i=0; i<records.length; i++) {
			   						filePreview += records[i].get('FILE_NM') + '<br>';
			   					}
			   					
			   					var qText = '';
			   					if(filePreview.length == 0) {
			   						qText = '없음';
			   					} else {
			   						qText = filePreview;
			   					}
			   					
			                	Ext.tip.QuickTipManager.register({
			                          target: 'blDocRegBtn', // Target button's ID
			                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
			                          text  : qText,
			                          dismissDelay: 10000 // Hide after 10 seconds hover
			                    });
			                	
			                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
								
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
                    
                },

                dragstart: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragenter: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragover: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragleave: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },

                dragexit: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },
        	}, 
        	],
        },
        {
            xtype: 'form',
            width: 450,
            bodyPadding: 10,
            items: [{
            	xtype: 'filefield',
                name: 'file',
                id: 'fileName2',
                fieldLabel: '보험서류등록',
                labelWidth: 120,
                width: 700,
                msgTarget: 'side',
                allowBlank: false,
//                anchor: '40%',
                buttonText: '파일첨부',
                emptyText: '보험서류 첨부파일을 끌어다 놓거나 파일첨부 버튼을 클릭해주세요',
                listeners:{
                    afterrender:function(object){
                        //input type="file" 태그 속성중  multiple이라는 속성 추가
                        object.fileInputEl.set({multiple:'multiple'});
                    },
                    drop: {
                        fn: 'drop',
                        element: 'el'
                    },
                    dragstart: {
                        fn: 'dragstart',
                        element: 'el'
                    },
                    dragenter: {
                        fn: 'dragenter',
                        element: 'el'
                    },
                    dragover: {
                        fn: 'dragover',
                        element: 'el'
                    },
                    dragleave: {
                        fn: 'dragleave',
                        element: 'el'
                    },
                    dragexit: {
                        fn: 'dragexit',
                        element: 'el'
                    },
                    change : function(object, value, eOpts ){
                    	
                    	var form = this.up('form').getForm();
                    	 if(form.isValid()){
                    		 var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                    		 var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                    		 var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                    		 var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=INS&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                       
                    		 form.submit({
                                 url: 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?'+params,
                                 waitMsg: 'Uploading your file...',
                              
                                 
                                 success : function(fp, res) { 
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					var qText = '';
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText,
						                          dismissDelay: 10000 // Hide after 10 seconds hover
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                                	 var fileStore = Ext.getStore('FileStore');
                                	 fileStore.removeAll();
                                	 fileStore.load({
										params : {
											V_TYPE : 'S',
											V_COMP_ID : V_COMP_ID,
											V_BL_NO : V_BL_NO,
											V_USR_ID : V_USR_ID,
										},
										callback : function(records, operations, success) {
											var filePreview = '';
						   					for(var i=0; i<records.length; i++) {
						   						filePreview += records[i].get('FILE_NM') + '<br>';
						   					}
						   					
						   					if(filePreview.length == 0) {
						   						qText = '없음';
						   					} else {
						   						qText = filePreview;
						   					}
						   					
						   					var qText = filePreview;
						                	Ext.tip.QuickTipManager.register({
						                          target: 'blDocRegBtn', // Target button's ID
						                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
						                          text  : qText
						                    });
						                	
						                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
											
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
                },
                drop: function(e) {
                	var store = Ext.create('Ext.data.Store', {
                        fields: ['name', 'size', 'file', 'status']
                    });
                	
                	e.stopEvent();

                    Ext.Array.forEach(Ext.Array.from(e.browserEvent.dataTransfer.files), function(file) {
                        store.add({
                            file: file,
                            name: file.name,
                            size: file.size,
                            status: 'Ready'

                        });
                    });
                    for (var i = 0; i < store.data.items.length; i++) {
                    	if (!(store.getData().getAt(i).data.status === "Uploaded")) {
                    		store.getData().getAt(i).data.status = "Uploading";
                            store.getData().getAt(i).commit();
                            
                            var V_BL_NO = Ext.getCmp('V_BL_NO').getValue();
                   		 	var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
                   		 	var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
                            
                   		 	var params = 'V_TYPE=I&V_BL_NO='+V_BL_NO+'&V_DOC_TYPE=INS&V_COMP_ID='+V_COMP_ID+'&V_USR_ID='+V_USR_ID;
                            
                            var xhr = new XMLHttpRequest();
                            var fd = new FormData();
                            fd.append("serverTimeDiff", 0);
                            xhr.open("POST", 'sql/S_BL_MST_TOT_HSPF_FILE.jsp?' + params, false);
                            fd.append('index', i);
                            fd.append('file', store.getData().getAt(i).data.file);
                            xhr.setRequestHeader("serverTimeDiff", 0);
                            
                            xhr.send(fd);
                    	}
                    }
                    
                    var fileStore = Ext.getStore('FileStore');
	               	 fileStore.removeAll();
	               	 fileStore.load({
							params : {
								V_TYPE : 'S',
								V_COMP_ID : V_COMP_ID,
								V_BL_NO : V_BL_NO,
								V_USR_ID : V_USR_ID,
							},
							callback : function(records, operations, success) {
								var filePreview = '';
			   					for(var i=0; i<records.length; i++) {
			   						filePreview += records[i].get('FILE_NM') + '<br>';
			   					}
			   					
			   					var qText = '';
			   					if(filePreview.length == 0) {
			   						qText = '없음';
			   					} else {
			   						qText = filePreview;
			   					}
			   					
			                	Ext.tip.QuickTipManager.register({
			                          target: 'blDocRegBtn', // Target button's ID
			                          title : '<span style=\'color:#9CFFFA\'>첨부파일현황</span>',  // QuickTip Header
			                          text  : qText,
			                          dismissDelay: 10000 // Hide after 10 seconds hover
			                    });
			                	
			                	Ext.getCmp('blDocRegBtn').setText('선적서류저장[ ' + records.length + ' ]');
								
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
                    
                },

                dragstart: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragenter: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragover: function(e) {
                    if (!e.browserEvent.dataTransfer || Ext.Array.from(e.browserEvent.dataTransfer.types).indexOf('Files') === -1) {
                        return;
                    }

                    e.stopEvent();

                    this.addCls('drag-over');
                },

                dragleave: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },

                dragexit: function(e) {
                    var el = e.getTarget(),
                        thisEl = this.getEl();

                    e.stopEvent();


                    if (el === thisEl.dom) {
                        this.removeCls('drag-over');
                        return;
                    }

                    while (el !== thisEl.dom && el && el.parentNode) {
                        el = el.parentNode;
                    }

                    if (el !== thisEl.dom) {
                        this.removeCls('drag-over');
                    }
                },
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
	                 dataIndex: 'DOC_TYPE',
	                 style: 'font-size: 12px; text-align: center; font-weight: bold;',
	                 text: '문서타입',
	                 width : 160
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
    ],
    

});