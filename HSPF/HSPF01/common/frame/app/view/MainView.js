Ext.define('frame.view.MainView', {
    extend: 'Ext.container.Viewport',
    alias: 'widget.mainview',

    requires: [
        'frame.view.MainViewViewModel',
        'Ext.toolbar.Toolbar',
        'Ext.tree.Panel',
        'Ext.tree.View',
        'Ext.tab.Panel',
        'Ext.tab.Tab',
        'Ext.ux.TabCloseMenu',
        'Ext.ux.TabReorderer',
        'Ext.button.Segmented',
    ],

    viewModel: {
        type: 'mainview'
    },
    itemId: 'mainView',
    layout: {
        type: 'hbox',
        align: 'stretch'
    },
    id: 'mainView',
    items: [
		{
		    xtype: 'container',
		    layout: {
		    	type: 'hbox',
		    	align: 'stretch'
		    },
		    items: [
		        {
		        	xtype: 'container',
		        	layout: {
		        		type: 'vbox',
		        		align: 'stretch'
		        	},
		        	items: [
		        		{
		                    xtype: 'tabpanel',
		                    flex: 1,
		                    activeTab: 0,
		                    items: [
		                        {
		                            xtype: 'panel',
		                            title: '메뉴',
		                            layout: {
		                                type: 'vbox',
		                                align: 'stretch'
		                            },
		                            items: [
		                            	{
		        				            xtype: 'treepanel',
		        				            id: 'mentTree',
		        				            cls: 'mentTree',
		        				            width: 250,
		        				            layout: 'fit',
		        		                    flex: 1,
		        		                    scrollable: true,
		        		                    autoScroll: true,
		        		                    reserveScrollbar: true,
		        				            title: '*',
		        				            rootVisible: false,
		        				            rowLines: true,
		        			            	// useArrows: true, 
		        				            collapsed: false,
		        		                    collapseDirection: 'left',
		        		                    collapsible: true,
		        				            store : Ext.create('Ext.data.TreeStore',{ 
		        				            	storeId: 'MenuStore',
		        				            	root : { 
		        				            		text: '1depth', 
		        				            		expanded: false,
		        				            		id: 0
		        			            		}, 
		        			            		proxy: { 
		        			            			type: 'ajax', 
		        			            			url: 'sql/MenuList.jsp', 
		        			            			reader: { 
		        			            				type: 'json', 
		        			            				rootProperty: 'children' 
		        		        					} 
		        			            		} 
		        			            		} 
		        				            ), 
		        				            dockedItems: [
		        			                      {
		        			                          xtype: 'container',
//		        			                          layout: 'fit',
		        			                          layout: {
		        			                              type: 'vbox',
		        			                              align: 'stretch'
		        			                          },
		        			                          dock: 'bottom',
		        			                          items: [
		        			                        	  {
		        			                                  	xtype: 'button',
		        			                                  	height: 30,
		        			                                  	id: 'searchMenuBtn',
		        			                                  	text: '메뉴찾기',
		        			                                  },
		        			                                  {
		        			                                  	xtype: 'button',
		        			                                  	height: 30,
		        			                                  	id: 'closeTabBtn',
		        			                                  	text: '전체탭닫기',
		        			                                  },
		        			                              ]
		        			                      },
		        		                  ],
		        				            renderTo : Ext.getBody(),
		        				            listeners: {
		        				            	afteritemexpand: function(node, index, item, eOpts) {
		        				            		if(node.lastChild == null) {
		        				            			var redirect = '/HSPF01/common/login/login.jsp';
		        				            			window.location = redirect;
		        				            		}
		        				            	},
		        				            	afteritemcollapse:  function(node, index, item, eOpts) {
		        				            		if(node.lastChild == null) {
		        				            			var redirect = '/HSPF01/common/login/login.jsp';
		        				            			window.location = redirect;
		        				            		} 
		        				            	},
	        	                                itemcontextmenu: function(dataview, record, item, index, e, eOpts) {
	        	                                	e.stopEvent();
	        	                                	
	        	                                	Ext.create('Ext.menu.Menu', {
	        	                                        items : [Ext.create('Ext.Action', {
	        	                                            iconCls : 'star',
	        	                                            text : '즐겨찾기 추가',
	        	                                            handler : function() {
	        	                                                if(record.data.url == '/'){
	        	                                                	Ext.Msg.alert('확인', '상위 메뉴는 즐겨찾기 등록 불가능합니다.');
	        	                                                }
	        	                                                else{
	        	                                                	Ext.Ajax.request({
	        	                                                		url : 'sql/MenuFavoriteRegister.jsp',
	        	                                                		method : 'post',
	        	                                                		params : {
	        	                                                			V_COMP_ID : Ext.getCmp('GCOMP_ID').getValue(),
	        	                                                			V_USR_ID : Ext.getCmp('GUSER_ID').getValue(),
	        	                                                			V_TYPE : 'I',
	        	                                                			V_PGM_ID : record.data.pgm_id,
	        	                                                			V_IDX : record.data.id,
	        	                                                		},
	        	                                                	}).then(function(response) {
        	                                                			var jResult = Ext.JSON.decode(response.responseText);
        	                                                			
        	                                                			if(jResult.success == false){
        	                                                				Ext.Msg.alert('관리자에게 문의', jResult.resultList);
        	                                                			}
        	                                                			else{
        	                                                				Ext.toast({
        	                                        							title : ' ',
        	                                        							timeout : 1000,
        	                                        							html : '등록완료',
        	                                        							style : 'text-align: center',
        	                                        							align : 't',
        	                                        							width : 130,
        	                                        						});
        	                                                				
        	                                                			}
        	                                                			
        	                                                		});
	        	                                                }
	        	                                            }
	        	                                        })]
	        	                                    }).showAt(e.getXY());
	        	                                },
		        				                itemclick: function(s,r) {
		        				                		if (r.data.url != '/')
		        				                			{
		        						                        frame.app.gTabRow=frame.app.gTabRow+1;	
		        						                        var txt_tab_id='tab_txt'+frame.app.gTabRow;
		        						                        var id_txt=r.data.url + frame.app.gTabRow.toString();
		        						                        var prefix = '';
		        						                        
		        						                        if(r.data.url.indexOf('HSPF03') >= 1){
		        						                        	prefix = '철강-';
		        						                        }
		        						                        else if(r.data.url.indexOf('HSPF02') >= 1){
		        						                        	prefix = '일반무역-';
		        						                        }
		        						                        else{
		        						                        	prefix = '';
		        						                        }
		        						                        
		        						                        
		        						                        var dynamicTab={
		        						                                xtype:'panel',
		        						                                title :prefix + r.data.text,
		        						                                autoScroll: true,
		        						                                html : '<iframe name="xxx" border =0 src="'+ r.data.url +'" width="100%" height="100%"></iframe>',
		        						                                id :id_txt,
		        						                                reorderable: true,
		        						                                closable : true,
		        						                                items: [
		        						                                    {
		        						                                        xtype: 'hiddenfield',
		        						                                        id: txt_tab_id , // rec.get('menuNo'),
		        						                                        value:'N'
		        						                                    }
		        						                                ],
		        						                                listeners:
		        						                                {
		        						                                    beforeclose:function(component, eOpts) {
		        						
		        						                                        if(component.closeMe){
		        						                                            component.closeMe=false;
		        						                                            return true;
		        						                                        }
		        						                                        var  sv_check=Ext.getCmp(txt_tab_id).getValue();
		        						                                        if (sv_check==='Y')
		        						                                        {
		        						                                            Ext.Msg.confirm(
		        						                                                "확인","자료가 변경되었습니다. 저장하지 않았습니다. 닫기를 하시겠습니까?",
		        						                                                function(button){
		        						                                                    if(button==="yes")
		        						                                                    {
		        						                                                        component.closeMe=true;
		        						                                                        component.close();
		        						                                                    }
		        						                                                    else
		        						                                                    {
		        						                                                        component.closeMe=false;
		        						                                                    }
		        						                                                }
		        						                                            );
		        						                                        }
		        						                                        else
		        						                                        {
		        						                                            component.closeMe=true;
		        						                                            component.close();
		        						                                        }
		        						                                        return false;
		        						                                    }
		        						                                }
		        						                            }; 
		        						                        var myMask = new Ext.LoadMask( Ext.getCmp('myTab'), {msg:"Please wait..."});
		        						                        myMask.show();
		        						                        setTimeout(function() {
		        						                            Ext.getCmp('myTab').add(dynamicTab).show();
		        						                            myMask.hide();
		        						                        }, 1000);
		        				                			}
		        				                }
		        				         },
		        	        	        }
		                            ]
		                        },
		                        {
		                            xtype: 'panel',
		                            title: '즐겨찾기',
		                            flex: 1,
		                            layout: {
		                                type: 'vbox',
		                                align: 'stretch'
		                            },
		                            listeners: {
		                                activate: function(component, eOpts) {
		                                	var store = Ext.getStore('FavoriteStore2');
                            				store.load({
                            					params:{
//                            						node: '0',
//                            						V_TYPE: '0',
                            						
                            					},
                            					callback : function() {
                            						Ext.getCmp('favoriteTree2').expandAll();
                            					}
                            				});
//		                                	Ext.getCmp('favoriteTree2').getLoader().load(Ext.getCmp('favoriteTree2').root);
//		                                	Ext.getCmp('favoriteTree2').collapseAll();
//                            				Ext.getCmp('favoriteTree2').expandAll();
		                                }
		                            },
		                            items:[
		                            	{
		        				            xtype: 'treepanel',
		        				            id: 'favoriteTree2',
		        				            cls: 'mentTree2',
		        				            width: 250,
		        				            layout: 'fit',
		        		                    flex: 1,
		        		                    scrollable: true,
		        		                    autoScroll: true,
		        		                    reserveScrollbar: true,
		        				            title: '*',
		        				            rootVisible: false,
		        				            rowLines: true,
		        			            	// useArrows: true, 
		        				            collapsed: false,
		        		                    collapseDirection: 'left',
		        		                    collapsible: true,
		        				            store : 'FavoriteStore2',
		        				            	/*
		        				            	Ext.create('Ext.data.TreeStore',{ 
		        				            	storeId: 'FavoriteStore2',
		        				            	root : { 
		        				            		text: '1depth', 
		        				            		expanded: true,
		        				            		id: 0
		        			            		}, 
		        			            		proxy: { 
		        			            			type: 'ajax', 
		        			            			url: 'sql/MenuFavoriteList.jsp', 
		        			            			reader: { 
		        			            				type: 'json', 
		        			            				rootProperty: 'children' 
		        		        					} 
		        			            		} 
		        			            		} 
		        			            		
		        				            ), */
		        				            dockedItems: [
		        			                      {
		        			                          xtype: 'container',
//		        			                          layout: 'fit',
		        			                          layout: {
		        			                              type: 'vbox',
		        			                              align: 'stretch'
		        			                          }, 
		        			                          dock: 'bottom',
		        			                          items: [
		        			                        	  {
		        			                                  	xtype: 'button',
		        			                                  	height: 30,
		        			                                  	id: 'searchMenuBtn2',
		        			                                  	text: '메뉴찾기',
		        			                                  },
		        			                                  {
		        			                                  	xtype: 'button',
		        			                                  	height: 30,
		        			                                  	id: 'closeTabBtn2',
		        			                                  	text: '전체탭닫기',
		        			                                  },
		        			                              ]
		        			                      },
		        		                  ],
		        				            renderTo : Ext.getBody(),
		        				            listeners: {
								/*
		        				            	afteritemexpand: function(node, index, item, eOpts) {
		        				            		if(node.lastChild == null) {
		        				            			var redirect = '/HSPF01/common/login/login.jsp';
		        				            			window.location = redirect;
		        				            		}
		        				            	},
		        				            	afteritemcollapse:  function(node, index, item, eOpts) {
		        				            		if(node.lastChild == null) {
		        				            			var redirect = '/HSPF01/common/login/login.jsp';
		        				            			window.location = redirect;
		        				            		} 
		        				            	},
								*/
	        	                                itemcontextmenu: function(dataview, record, item, index, e, eOpts) {
	        	                                	
	        	                                	e.stopEvent();
	        	                                	
	        	                                	
	        	                                	var R_CLICK_MENU = Ext.create('Ext.menu.Menu', {
	        	                                        items : [
	        	                                        	Ext.create('Ext.Action', {
		        	                                            iconCls : 'star',
		        	                                            text : 'UP',
		        	                                            handler : function() {
	        	                                                	Ext.Ajax.request({
	        	                                                		url : 'sql/MenuFavoriteRegister.jsp',
	        	                                                		method : 'post',
	        	                                                		params : {
	        	                                                			V_COMP_ID : Ext.getCmp('GCOMP_ID').getValue(),
	        	                                                			V_USR_ID : Ext.getCmp('GUSER_ID').getValue(),
	        	                                                			V_TYPE : 'UP',
	        	                                                			V_PGM_ID : record.data.pgm_id,
	        	                                                			V_IDX : record.data.id,
	        	                                                		},
	        	                                                	}).then(function(response, opts) {
        	                                                			var jResult = Ext.JSON.decode(response.responseText);
        	                                                			
        	                                                			if(jResult.success == false){
        	                                                				Ext.Msg.alert('관리자에게 문의', jResult.resultList);
        	                                                			}
        	                                                			else{
        	                                                				var store = Ext.getStore('FavoriteStore2'); 
        	                                                				store.load({
        	                                                					params:{
//        	                                                						node: '0'
        	                                                					},
        	                                                					callback : function() {

    	        	                                                				Ext.getCmp('favoriteTree2').expandAll();
        	                                                    				}
        	                                                					
        	                                                				});
        	                                                				
        	                                                			}
        	                                                			
        	                                                		});
		        	                                            }
		        	                                        }),
		        	                                        Ext.create('Ext.Action', {
		        	                                            iconCls : 'star',
		        	                                            text : 'DOWN',
		        	                                            handler : function() {
	        	                                                	Ext.Ajax.request({
	        	                                                		url : 'sql/MenuFavoriteRegister.jsp',
	        	                                                		method : 'post',
	        	                                                		params : {
	        	                                                			V_COMP_ID : Ext.getCmp('GCOMP_ID').getValue(),
	        	                                                			V_USR_ID : Ext.getCmp('GUSER_ID').getValue(),
	        	                                                			V_TYPE : 'DOWN',
	        	                                                			V_PGM_ID : record.data.pgm_id,
	        	                                                			V_IDX : record.data.id,
	        	                                                		},
	        	                                                	}).then(function(response, opts) {
        	                                                			var jResult = Ext.JSON.decode(response.responseText);
        	                                                			
        	                                                			if(jResult.success == false){
        	                                                				Ext.Msg.alert('관리자에게 문의', jResult.resultList);
        	                                                			}
        	                                                			else{
        	                                                				var store = Ext.getStore('FavoriteStore2');
        	                                                				store.load({
        	                                                					params:{
//        	                                                						node: '0'
        	                                                					},
        	                                                					callback : function() {

    	        	                                                				Ext.getCmp('favoriteTree2').expandAll();
        	                                                    				}
        	                                                					
        	                                                				});
        	                                                			}
        	                                                			
        	                                                		});
		        	                                            }
		        	                                        }),
		        	                                        Ext.create('Ext.Action', {
		        	                                            iconCls : 'star',
		        	                                            text : '폴더추가',
		        	                                            handler : function() {
		        	                                            	Ext.create('frame.view.AddFavoriteFolderWindow').show();
		        	                                            }
		        	                                        }),
	        	                                        	Ext.create('Ext.Action', {
	        	                                            iconCls : 'star',
	        	                                            text : '즐겨찾기 삭제',
	        	                                            handler : function() {
	        	                                                if(record.data.url == '/'){
	        	                                                	Ext.Msg.alert('확인', '상위 메뉴는 즐겨찾기 등록 불가능합니다.');
	        	                                                }
	        	                                                else{
	        	                                                	var V_TYPE = '';
	        	                                                	if(record.data.id < 0){
	        	                                                		V_TYPE = 'D_FOLD';
	        	                                                	}
	        	                                                	else{
	        	                                                		V_TYPE = 'D';
	        	                                                	}
	        	                                                	Ext.Ajax.request({
	        	                                                		url : 'sql/MenuFavoriteRegister.jsp',
	        	                                                		method : 'post',
	        	                                                		params : {
	        	                                                			V_COMP_ID : Ext.getCmp('GCOMP_ID').getValue(),
	        	                                                			V_USR_ID : Ext.getCmp('GUSER_ID').getValue(),
	        	                                                			V_TYPE : V_TYPE,
	        	                                                			V_PGM_ID : record.data.pgm_id,
	        	                                                			V_IDX : record.data.id,
	        	                                                		},
	        	                                                	}).then(function(response, opts) {
        	                                                			var jResult = Ext.JSON.decode(response.responseText);
        	                                                			
        	                                                			if(jResult.success == false){
        	                                                				Ext.Msg.alert('관리자에게 문의', jResult.resultList);
        	                                                			}
        	                                                			else{
        	                                                				Ext.toast({
        	                                        							title : ' ',
        	                                        							timeout : 1000,
        	                                        							html : '즐겨찾기 삭제완료',
        	                                        							style : 'text-align: center',
        	                                        							align : 't',
        	                                        							width : 130,
        	                                        						});
        	                                                				var store = Ext.getStore('FavoriteStore2');
        	                                                				store.load({
        	                                                					params:{
//        	                                                						node: '0'
        	                                                					},
        	                                                					callback : function() {
    	        	                                                				Ext.getCmp('favoriteTree2').expandAll();
        	                                                    				}
        	                                                				});
        	                                                			}
        	                                                		});
	        	                                                }
	        	                                            }
	        	                                        }),
//	        	                                        menu_dtl1
	        	                                        
	        	                                        ]
	        	                                    });
	        	                                	
	        	                                	//즐겨찾기에 추가한 폴더 가져오기
	        	                                	Ext.Ajax.request({
	        	                                		url : 'sql/MenuFavoriteList.jsp',
	        	                                		method : 'post',
	        	                                		params : {
	        	                                			node : '0',
	        	                                		},
	        	                                		success : function(response) {
	        	                                			var jResult = Ext.JSON.decode(response.responseText);
	        	                                			
	        	                                			for(var i = 0 ; i < jResult.children.length ; i ++){
	        	                                				if(jResult.children[i].id < 0){
	        	                                					var new_action = Ext.create('Ext.Action', {
	        	        	                                            iconCls : 'star',
	        	        	                                            text :  jResult.children[i].pgm_id + ' 폴더로 이동',
	        	        	                                            fold_id: jResult.children[i].id,
	        	        	                                            handler : function() {
	        	    	                                                	Ext.Ajax.request({
	        	    	                                                		url : 'sql/MenuFavoriteRegister.jsp',
	        	    	                                                		method : 'post',
	        	    	                                                		params : {
	        	    	                                                			V_COMP_ID : Ext.getCmp('GCOMP_ID').getValue(),
	        	    	                                                			V_USR_ID : Ext.getCmp('GUSER_ID').getValue(),
	        	    	                                                			V_TYPE : 'MOVE_TO_FOLD',
	        	    	                                                			V_PGM_ID : this.fold_id,
	        	    	                                                			V_IDX : record.data.id,
	        	    	                                                		},
	        	    	                                                	}).then( function(response, opts) {
        	    	                                                			var jResult = Ext.JSON.decode(response.responseText);
        	    	                                                			
        	    	                                                			if(jResult.success == false){
        	    	                                                				Ext.Msg.alert('관리자에게 문의', jResult.resultList); 
        	    	                                                			}
        	    	                                                			else{
        	    	                                                				var store = Ext.getStore('FavoriteStore2'); 
        	    	                                                				store.load({
        	    	                                                					params:{
        	//    	                                                						node: '0'
        	    	                                                					},
        	    	                                                					callback : function() {
        	
        		        	                                                				Ext.getCmp('favoriteTree2').expandAll();
        	    	                                                    				}
        	    	                                                					
        	    	                                                				});
        	    	                                                				
        	    	                                                			}
        	    	                                                			
        	    	                                                		});
	        	        	                                            }
	        	        	                                        });
	        	        	                                		R_CLICK_MENU.add(new_action);
	        	                                				}
	        	                                			}
	        	                                			
	        	                                		},
	        	                                		scope : this
	        	                                	});
	        	                                	
	        	                                	//만약 폴더를 클릭했으면 이름바꾸기 메뉴 추가
	        	                                	if(Number(record.data['id']) < 0){
	        	                                		var new_action = Ext.create('Ext.Action', {
	        	                                            iconCls : 'star',
	        	                                            text :  '폴더 이름 변경',
	        	                                            handler : function() {
	        	                                            	var renameWindow = Ext.create('frame.view.RenameFavoriteFolderWindow');
	        	                                            	Ext.getCmp('V_RENAME_FOLD_IDX').setValue(record.data.id);
	        	                                            	renameWindow.show();
	        	                                            }
	        	                                        });
	        	                                		R_CLICK_MENU.add(new_action);
	        	                                	}
	        	                                	
	        	                                	R_CLICK_MENU.showAt(e.getXY());
	        	                                	
	        	                                },
		        				                itemclick: function(s,r) {
		        				                		if (r.data.url != '/')
		        				                			{
		        						                        frame.app.gTabRow=frame.app.gTabRow+1;	
		        						                        var txt_tab_id='tab_txt'+frame.app.gTabRow;
		        						                        var id_txt=r.data.url + frame.app.gTabRow.toString();
		        						                        var prefix = '';
		        						                        
		        						                        if(r.data.id > 0){
		        						                        	var dynamicTab={
			        						                                xtype:'panel',
			        						                                title :prefix + r.data.text,
			        						                                autoScroll: true,
			        						                                html : '<iframe name="xxx" border =0 src="'+ r.data.url +'" width="100%" height="100%"></iframe>',
			        						                                id :id_txt,
			        						                                reorderable: true,
			        						                                closable : true,
			        						                                items: [
			        						                                    {
			        						                                        xtype: 'hiddenfield',
			        						                                        id: txt_tab_id , // rec.get('menuNo'),
			        						                                        value:'N'
			        						                                    }
			        						                                ],
			        						                                listeners:
			        						                                {
			        						                                    beforeclose:function(component, eOpts) {
			        						
			        						                                        if(component.closeMe){
			        						                                            component.closeMe=false;
			        						                                            return true;
			        						                                        }
			        						                                        var  sv_check=Ext.getCmp(txt_tab_id).getValue();
			        						                                        if (sv_check==='Y')
			        						                                        {
			        						                                            Ext.Msg.confirm(
			        						                                                "확인","자료가 변경되었습니다. 저장하지 않았습니다. 닫기를 하시겠습니까?",
			        						                                                function(button){
			        						                                                    if(button==="yes")
			        						                                                    {
			        						                                                        component.closeMe=true;
			        						                                                        component.close();
			        						                                                    }
			        						                                                    else
			        						                                                    {
			        						                                                        component.closeMe=false;
			        						                                                    }
			        						                                                }
			        						                                            );
			        						                                        }
			        						                                        else
			        						                                        {
			        						                                            component.closeMe=true;
			        						                                            component.close();
			        						                                        }
			        						                                        return false;
			        						                                    }
			        						                                }
			        						                            };
		        						                        	var myMask = new Ext.LoadMask( Ext.getCmp('myTab'), {msg:"Please wait..."});
			        						                        myMask.show();
			        						                        setTimeout(function() {
			        						                            Ext.getCmp('myTab').add(dynamicTab).show();
			        						                            myMask.hide();
			        						                        }, 1000);
		        						                        }
		        						                        
		        						                        
		        				                			}
		        				                }
		        				         },
		        	        	        }
		                            ]
		                        }
		                    ]
		                },
	        	        
	        	        ]
	        	        }
        	        ],
		        },
		        {
					xtype: 'container',
		            flex: 1,
		            height: 150,
		            layout: {
		                type: 'vbox',
		                align: 'stretch'
		            },
		            items: [
		                {

		                    xtype: 'toolbar',
		                    region: 'north',
		                    cls: 'sencha-dash-dash-headerbar shadow',
		                    height: 45,
		                    itemId: 'headerBar',
		                    items: [
		                        {
		                        	xtype: 'image',
		                        	src: '/HSPF01/common/img/main_top.png',
		                        	height: 30,
		                        	style: 'opacity: 0.7'
//		                        	flex:1,
		                        },
		                        {
		                        	xtype: 'image',
		                        	src: '/HSPF01/common/img/main_top2.png',
		                        	height: 30,
		                        	flex:1,
		                        	margin: '0 7 0 -20',
		                        	style: 'opacity: 0.7'
		                        },
		                        {
		                            xtype: 'image',
		                            height: 30,
		                            width: 30,
		                            glyph: 'f2bd@FontAwesome',
		                            cls: 'fa-info-hspf',
		                            listeners: {
		                            	el: {
		                            		click: function() {
		                            			 var popup = Ext.create("frame.view.MyWindow1");
		                            			 popup.show();

		                            			 Ext.getCmp('w_usr_id').setValue(Ext.getCmp('GUSER_ID').getValue());
		                            			 Ext.getCmp('w_usr_nm').setValue(Ext.getCmp('GUSER_NM').getValue());
		                            			 Ext.getCmp('w_usr_bp_nm').setValue(Ext.getCmp('GBP_NM').getValue());
		                            			 Ext.getCmp('w_usr_bp_cd').setValue(Ext.getCmp('GBP_CD').getValue());
		                            			 Ext.getCmp('w_usr_dept').setValue(Ext.getCmp('GDEPT_NM').getValue());
		                            			 Ext.getCmp('w_usr_posit').setValue(Ext.getCmp('GPOSIT_NM').getValue());
		                            			 Ext.getCmp('w_usr_tel_no').setValue(Ext.getCmp('GTEL_NO').getValue());
		                            			 Ext.getCmp('w_usr_handtel').setValue(Ext.getCmp('GHAND_TEL').getValue());
		                            			 Ext.getCmp('w_usr_fax').setValue(Ext.getCmp('GFAX_NO').getValue());
		                            			 Ext.getCmp('w_usr_address').setValue(Ext.getCmp('GADDRESS').getValue());
		                            			 Ext.getCmp('w_usr_email').setValue(Ext.getCmp('GEMAIL').getValue());
		                            			 
		                            			 if(Ext.getCmp('GEMAIL_YN').getValue() == 'Y') {
		                            				 Ext.getCmp('w_usr_email_yn').setValue(true);
		                            			 } else {
		                            				 Ext.getCmp('w_usr_email_yn').setValue(false);
		                            			 }
		                            			 
		                            		}
		                            	}
		                            }
		                        },
		                        {
									xtype: 'label',
									id: 'lblUsr',
								},
								{
									xtype: 'label',
									id: 'lblComp',
								},
								{
		                            xtype: 'container',
		                        },
		                        {
		                            xtype: 'button',
		                            glyph: 'f08b@FontAwesome',
		                            id: 'logoutBtn',
		                            cls: 'fa-logout',
		                            style: 'background-color: #ffffff; border-radius: 5px;',
		                            tooltip: '로그아웃'
		                        }
		                    ]
		                },
		                {

		                    xtype: 'panel',
		                    region: 'center',
		                    flex: 1,
		                    itemId: 'contentPanel',
		                    layout: 'card',
		                    items: [
		                        {
		                            xtype: 'tabpanel',
		                            id: 'myTab',
		                            activeTab: 0,
		                            items: [
										 {
										 xtype: 'panel',
										 html: '<img src="/HSPF01/common/img/main.png" alt="panoramic image" width="80%" border="0">',
										 bodyStyle: 'text-align: center',
										 glyph: 'f015@FontAwesome',
										 cls: 'fa-my-home'
 // items: [
//         {
//             xtype: 'image',
//             src: '/HSPF01/common/img/main.png',
//             width: '80%',
//         }
//     ],
										 },											
// {
// xtype: 'panel',
// title: 'Tab 2'
// },
// {
// xtype: 'panel',
// title: 'Tab 3'
// }
		                            ],
		                            plugins: [
		                                {
		                                    ptype: 'tabclosemenu'
		                                },
		                                {
		                                    ptype: 'tabreorderer'
		                                }
		                            ]
		                        }
		                    ]
		                
		                },
		                {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GCOMP_ID',
		                    fieldLabel: 'Label'
		                },
		                {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GCOMP_NM',
		                    fieldLabel: 'Label'
		                },
		                {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GUSER_ID',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GUSER_NM',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GDEPT_CD',
		                    fieldLabel: 'Label'
		                },{
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GDEPT_NM',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GPOSIT_NM',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GBP_CD',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GTEL_NO',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GHAND_TEL',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GFAX_NO',
		                    fieldLabel: 'Label'
		                }, {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GADDRESS',
		                    fieldLabel: 'Label'
		                },
		                {
		                    xtype: 'hiddenfield',
		                    flex: 1,
		                    id: 'GEMAIL',
		                    fieldLabel: 'Label'
		                },
		                {
		                	xtype: 'hiddenfield',
		                	flex: 1,
		                	id: 'GEMAIL_YN',
		                	fieldLabel: 'Label'
		                },
		                {
		                	xtype: 'hiddenfield',
		                	flex: 1,
		                	id: 'GROLE_CD',
		                	fieldLabel: 'Label'
		                },
		                {
		                	xtype: 'hiddenfield',
		                	flex: 1,
		                	id: 'GEMP_NO',
		                	fieldLabel: 'Label'
		                },
		                {
		                	xtype: 'hiddenfield',
		                	flex: 1,
		                	id: 'GBP_NM',
		                	fieldLabel: 'Label'
		                },
		                {
		                	xtype: 'hiddenfield',
		                	flex: 1,
		                	id: 'MAIN_SERVER_YN',
		                	//테스트서버인지 메인서버인지 구분하기위해 사용.
		                	fieldLabel: 'Label'
		                },
		            ]
				
		        }
		    ]
});