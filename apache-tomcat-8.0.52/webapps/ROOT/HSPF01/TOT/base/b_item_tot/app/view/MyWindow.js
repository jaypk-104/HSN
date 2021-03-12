Ext.define('B_ITEM_HSPF.view.MyWindow', {
	extend : 'Ext.window.Window',
	alias : 'widget.mywindow',

	requires: [
        'B_ITEM_HSPF.view.MyWindowViewModel',
        'Ext.container.Container',
        'Ext.form.Label',
        'Ext.form.field.File',
        'Ext.button.Button',
    ],

	viewModel : {
		type : 'mywindow'
	},
	height : 700,
	width : 700,
	title : '품목 이미지',
	modal : true,
	layout : {
		type : 'vbox',
		align : 'stretch'
	},
	items : [ {
		xtype : 'form',
		width : 400,
		bodyPadding : 10,
		items : [ {
			xtype : 'filefield',
			name : 'file',
			id : 'fileName',
			fieldLabel : '이미지파일',
			labelWidth : 100,
			msgTarget : 'side',
			allowBlank : false,
			anchor : '60%',
			buttonText : '이미지첨부',
			listeners : {
				afterrender : function(object) {
					// input type="file" 태그 속성중 multiple이라는 속성 추가
					object.fileInputEl.set({
						multiple : 'multiple'
					});
				},
				change : function(object, value, eOpts) {
					
					var form = this.up('form').getForm();
					if (form.isValid()) {
						var V_ITEM_CD = Ext.getCmp('W_ITEM_CD').getValue();
						var V_COMP_ID = parent.Ext.getCmp('GCOMP_ID').getValue();
						var V_USR_ID = parent.Ext.getCmp('GUSER_ID').getValue();
						var params = 'V_TYPE=I&V_ITEM_CD=' + V_ITEM_CD + '&V_COMP_ID=' + V_COMP_ID + '&V_USR_ID=' + V_USR_ID;

						form.submit({
							url : 'sql/B_ITEM_IMG_TOT.jsp?' + params,
							waitMsg : 'Uploading your file...',

							success : function(fp, res) {
								var imageStore = Ext.getStore('ImageStore');
								imageStore.removeAll();
								imageStore.load({
									params : {
										V_TYPE : 'S',
										V_COMP_ID : V_COMP_ID,
										V_ITEM_CD : V_ITEM_CD,
										V_USR_ID : V_USR_ID,
									},
									callback : function(records, operations, success) {
										Ext.toast({
											title : ' ',
											timeout : 1000,
											html : '이미지첨부완료',
											style : 'text-align: center',
											align : 't',
											width : 130,
										});
									}
								});
								object.fileInputEl.set({
									multiple : 'multiple'
								});

							},
							failure : function(fp, o) {
								var imageStore = Ext.getStore('ImageStore');
								imageStore.removeAll();
								imageStore.load({
									params : {
										V_TYPE : 'S',
										V_COMP_ID : V_COMP_ID,
										V_ITEM_CD : V_ITEM_CD,
										V_USR_ID : V_USR_ID,
									},
									callback : function(records, operations, success) {
										Ext.toast({
											title : ' ',
											timeout : 1000,
											html : '이미지첨부완료',
											style : 'text-align: center',
											align : 't',
											width : 130,
										});
									}
								});
								object.fileInputEl.set({
									multiple : 'multiple'
								});

							}

						});
					}
				}
			}
		}, {
			xtype : 'textfield',
			maxWidth : 230,
			minWidth : 230,
			width : 230,
			fieldLabel : '품목코드',
			labelWidth : 80,
			id : 'W_ITEM_CD',
			hidden : true,
		}, ],
	}, {
		flex : 1,
		xtype : 'gridpanel',
		title : 'My Grid Panel',
		id : 'imageGrid',
		style : 'border: 1px solid lightgray; padding: 5px;',
		tbar : [ {
			id : 'w_delBtn',
			text : '',
			margin : '0 3 0 -3',
			glyph : 'xf056@FontAwesome',
			iconCls : 'grid-del-btn',
		}, {
			xtype : 'container',
			flex : 1
		}, ],

		store : 'ImageStore',
		bodyBorder : false,
		header : false,
		columnLines : true,
		columns : [ {
			xtype : 'rownumberer',
		}, {
			xtype : 'gridcolumn',
			dataIndex : 'V_TYPE',
			style : 'font-size: 12px; text-align: center; font-weight: bold;',
			hidden : true
		}, {
			xtype : 'actioncolumn',
			style : 'font-size: 12px; text-align: center; font-weight: bold;',
			dataIndex : 'IMAGE',
			text : '이미지',
			width : 600,
			renderer : function(value, metaData, record, rowIndex, colIndex, store, view) {
				if (!!!value) {
					//					return '<img src=\'../../../images/NOIMAGES.png\' height=100 width=100>';
				} else {
					return '<img src=\'' + value + '\' height=580 width=580>';
				}
			}
		}, {
			xtype : 'gridcolumn',
			dataIndex : 'ITEM_CD',
			style : 'font-size: 12px; text-align: center; font-weight: bold;',
			text : '품목코드',
			width : 100,
			hidden : true,
		}, {
			xtype : 'gridcolumn',
			dataIndex : 'SEQ',
			style : 'font-size: 12px; text-align: center; font-weight: bold;',
			text : '순번',
			hidden : true,
		}, {
			xtype : 'gridcolumn',
			dataIndex : 'IMG_NM',
			style : 'font-size: 12px; text-align: center; font-weight: bold;',
			text : '파일명',
			hidden : true
		}, ],
		selModel : {
			selType : 'checkboxmodel',
			mode : 'MULTI'
		},
	} ]

});