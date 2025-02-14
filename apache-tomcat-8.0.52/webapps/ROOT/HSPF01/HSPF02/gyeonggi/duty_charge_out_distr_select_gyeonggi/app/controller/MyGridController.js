/*
 * File: app/controller/MyGridController.js
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

Ext.define('DUTY_CHARGE_OUT_DISTR_SELECT_GYEONGGI.controller.MyGridController', {
    extend: 'Ext.app.Controller',

    stores: [
        'MyStore',
        'WindowStore',
        'FileStore'
    ],

    control: {
        "#gridAddBtn": {
            click: 'gridAddBtnClick'
        },
        "#gridDelBtn": {
            click: 'gridDelBtnClick'
        },
        "#xlsxDown": {
            click: 'xlsxDownClick'
        },
        "#xmlDown": {
            click: 'xmlDownClick'
        },
        "#myGrid": {
            celldblclick: 'onGridpanelCellDblClick'
        },
        "#payProcessBtn": {
            click: 'payProcessBtnClick'
        },
        "#ERPSendBtn": {
            click: 'ERPSendBtnClick'
        },
        "#ERPSendCancelBtn": {
            click: 'ERPSendCancelBtnClick'
        },
        "#HSPFSendBtn": {
            click: 'HSPFSendBtnClick'
        },
        "#HSPFSendCancelBtn": {
            click: 'HSPFSendCancelBtnClick'
        }
    },

    gridAddBtnClick: function(button, e, eOpts) {
        //var popup = Ext.create("B_COMP_HSPF.view.WinAddRow");
        //popup.show();
        //Ext.getCmp('rowCount').setValue(1);
    },

    gridDelBtnClick: function(button, e, eOpts) {

    },

    xlsxDownClick: function(button, e, eOpts) {
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
            	var grid = Ext.getCmp('myGrid');
            	grid.saveDocumentAs({
                    type: 'xlsx',
                    title: 'test', //엑셀내타이틀
                    fileName: currentDate+'.xlsx' //엑셀파일이름
        		});
    },

    xmlDownClick: function(button, e, eOpts) {
        var currentDate = Ext.util.Format.date(new Date(), 'Y-m-d His');
            	var grid = Ext.getCmp('myGrid');
            	grid.saveDocumentAs({
                    type: 'xml',
                    title: 'test', //엑셀내타이틀
                    fileName: currentDate+'.xml' //엑셀파일이름
        		});
    },

    onGridpanelCellDblClick: function(tableview, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        var popup = Ext.create('DUTY_CHARGE_OUT_DISTR_SELECT_GYEONGGI.view.MyWindow');

        //윈도우 사이즈
        //꽉채우기
        popup.setWidth(Ext.getBody().getViewSize().width);
        popup.setHeight(Ext.getBody().getViewSize().height);

        if(parent.Ext.getCmp('GBP_CD').getValue() == '00000'){
            Ext.getCmp('W_HSPFSendBtn').show();
        }
        else{
            Ext.getCmp('W_HSPFSendBtn').hide();
        }

        if(record.data['HSPF_YN'] == 'Y'){
            Ext.getCmp('W_HSPFSendBtn').setDisabled(true);
        }
        else{
            Ext.getCmp('W_HSPFSendBtn').setDisabled(false);
        }


        popup.show();

        // 좌측 정보 로드

        Ext.Ajax.request({
        	url:'sql/duty_charge_out_distr_select.jsp',
        	method: 'post',
        	params: {
        		V_TYPE: 'WS', //생성
        		V_M_CHARGE_NO : record.data['M_CHARGE_NO'],
        	},

            success : function(response) {
                var jsonResult = Ext.JSON.decode(response.responseText).resultList[0];

                Ext.getCmp('W_M_CHARGE_NO').setValue(jsonResult.W_M_CHARGE_NO);
                Ext.getCmp('W_VESSEL_NM').setValue(jsonResult.W_VESSEL_NM);
                Ext.getCmp('W_IN_DT').setValue(jsonResult.W_IN_DT);
                Ext.getCmp('W_ITEM_NM').setValue(jsonResult.W_ITEM_NM);
                Ext.getCmp('W_QTY').setValue(jsonResult.W_QTY);
                Ext.getCmp('W_BL_DOC_NO').setValue(jsonResult.W_BL_DOC_NO);
                Ext.getCmp('W_TEMP_SL_NM').setValue(jsonResult.W_TEMP_SL_NM);
                Ext.getCmp('W_IN_NO').setValue(jsonResult.W_IN_NO);
                Ext.getCmp('W_TAX_DT').setValue(jsonResult.W_TAX_DT);
                Ext.getCmp('W_ACCEPT_DT').setValue(jsonResult.W_ACCEPT_DT);
                Ext.getCmp('W_TOTAL_AMT').setValue(Ext.util.Format.number(jsonResult.W_TOTAL_AMT, '0,000'));

                Ext.getCmp('W_LC_NO').setValue(record.data['LC_NO']);
                Ext.getCmp('W_BL_NO').setValue(record.data['BL_NO']);
                Ext.getCmp('W_BL_SEQ').setValue(record.data['BL_SEQ']);



            },
        	scope: this
        });



        // 우측 그리드 정보 로드
        var winStore = this.getWindowStoreStore();
        winStore.load({
            params: {
                V_TYPE : 'W_GRID',
                V_M_CHARGE_NO : record.data['M_CHARGE_NO'],
            },
            callback : function() {

            }
        });



        //첨부파일 로드
        var fileStore = this.getFileStoreStore();
        fileStore.load({
            params:{
                V_TYPE : 'S',
                V_M_CHARGE_NO : record.data['M_CHARGE_NO'],
            }
        });


    },

    payProcessBtnClick: function(button, e, eOpts) {
        var grid = Ext.getCmp('myGrid');
        var record = grid.getSelectionModel().getSelection();
        var store = this.getMyStoreStore();
        var myMask = new Ext.LoadMask(Ext.getCmp('myViewport') , {msg:"처리 중"});
        var flag = 'Y';
        var msg = '';

        if(record.length >= 1){
            for(var i = 0 ; i < record.length ; i ++){
                if(record[i].data['V_TYPE'] == 'V'){
                    record[i].set('V_TYPE', 'PAY');
                }
                if(record[i].data['PAY_YN'] == 'Y'){
                    flag = 'N';
                    msg += '지급 완료된 항목이 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
            }
            if(flag == 'Y'){
                Ext.Msg.confirm('확인','지급 완료처리 하시겠습니까?', function(button){
                    if(button == 'yes') {
                        myMask.show();
                        store.sync({
                            params:{
                                V_TYPE : 'SYNC',
                                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                            },
                            callback: function(batch, options){
                                store.reload();
                                myMask.hide();

                            },
                            success: function(batch, options){

                            },
                            failure: function(batch, options){

                            },
                            scope : this
                        });

                    }
                });
            }
            else{
                Ext.Msg.alert('확인', msg);
            }

        }
        else{
            Ext.Msg.alert('확인', '항목을 선택해주세요.');
        }


    },

    ERPSendBtnClick: function(button, e, eOpts) {
        var grid = Ext.getCmp('myGrid');
        var record = grid.getSelectionModel().getSelection();
        var store = this.getMyStoreStore();
        var myMask = new Ext.LoadMask(Ext.getCmp('myViewport') , {msg:"ERP 전송 중"});
        var flag = 'Y';
        var msg = '';

        if(record.length >= 1){
            for(var i = 0 ; i < record.length ; i ++){
                if(record[i].data['V_TYPE'] == 'V'){
                    record[i].set('V_TYPE', 'ERP');
                }
                if(record[i].data['ERP_YN'] == 'Y'){
                    flag = 'N';
                    msg += 'ERP 전송 완료된 항목이 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
                if(record[i].data['BL_NO'] == null){
                    flag = 'N';
                    msg += 'ERP에 등록되지 않은 BL이 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
            }
            if(flag == 'Y'){
                Ext.Msg.confirm('확인','ERP 전송 하시겠습니까?', function(button){
                    if(button == 'yes') {
                        myMask.show();
                        store.sync({
                            params:{
                                V_TYPE : 'SYNC',
                                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                            },
                            callback: function(batch, options){
                                Ext.getCmp('S_ERP_LC_NO').setValue(record[0].data['LC_NO']);
                                Ext.getCmp('S_ERP_BL_NO').setValue(record[0].data['BL_NO']);
                                Ext.getCmp('S_ERP_BL_SEQ').setValue(record[0].data['BL_SEQ']);
                                store.reload();
                                myMask.hide();

                            },
                            success: function(batch, options){

                            },
                            failure: function(batch, options){

                            },
                            scope : this
                        });

                    }
                });
            }
            else{
                Ext.Msg.alert('확인', msg);
            }

        }
        else{
            Ext.Msg.alert('확인', '항목을 선택해주세요.');
        }
    },

    ERPSendCancelBtnClick: function(button, e, eOpts) {
        var grid = Ext.getCmp('myGrid');
        var record = grid.getSelectionModel().getSelection();
        var store = this.getMyStoreStore();
        var myMask = new Ext.LoadMask(Ext.getCmp('myViewport') , {msg:"ERP 전송 중"});
        var flag = 'Y';
        var msg = '';

        if(record.length >= 1){
            for(var i = 0 ; i < record.length ; i ++){
                if(record[i].data['V_TYPE'] == 'V'){
                    record[i].set('V_TYPE', 'ERPCancel');
                }
                if(record[i].data['ERP_YN'] == 'N'){
                    flag = 'N';
                    msg += 'ERP 전송 안된 항목이 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
            }
            if(flag == 'Y'){
                Ext.Msg.confirm('확인','ERP 전송 하시겠습니까?', function(button){
                    if(button == 'yes') {
                        myMask.show();
                        store.sync({
                            params:{
                                V_TYPE : 'SYNC',
                                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                            },
                            callback: function(batch, options){
                                store.reload();
                                myMask.hide();

                            },
                            success: function(batch, options){

                            },
                            failure: function(batch, options){

                            },
                            scope : this
                        });

                    }
                });
            }
            else{
                Ext.Msg.alert('확인', msg);
            }

        }
        else{
            Ext.Msg.alert('확인', '항목을 선택해주세요.');
        }
    },

    HSPFSendBtnClick: function(button, e, eOpts) {
        var grid = Ext.getCmp('myGrid');
        var record = grid.getSelectionModel().getSelection();
        var store = this.getMyStoreStore();
        var myMask = new Ext.LoadMask(Ext.getCmp('myViewport') , {msg:"취소 중"});
        var flag = 'Y';
        var msg = '';

        if(record.length >= 1){
            for(var i = 0 ; i < record.length ; i ++){
                if(record[i].data['V_TYPE'] == 'V'){
                    record[i].set('V_TYPE', 'SEND');
                }
                if(record[i].data['HSPF_YN'] == 'Y'){
                    flag = 'N';
                    msg += '이미 전송된 데이터가 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
                if(record[i].data['CC_NO'] == '' || record[i].data['CC_NO'] == null){
                    flag = 'N';
                    msg += '통관정보가 존재하지 않습니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
            }
            if(flag == 'Y'){
                Ext.Msg.confirm('확인','전송 하시겠습니까?', function(button){
                    if(button == 'yes') {
                        myMask.show();
                        store.sync({
                            params:{
                                V_TYPE : 'SYNC',
                                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                            },
                            callback: function(batch, options){
                                store.reload();
                                myMask.hide();
                                Ext.Msg.alert('확인', '완료');

                            },
                            success: function(batch, options){

                            },
                            failure: function(batch, options){

                            },
                            scope : this
                        });

                    }
                });
            }
            else{
                Ext.Msg.alert('확인', msg);
            }

        }
        else{
            Ext.Msg.alert('확인', '항목을 선택해주세요.');
        }
    },

    HSPFSendCancelBtnClick: function(button, e, eOpts) {
        var grid = Ext.getCmp('myGrid');
        var record = grid.getSelectionModel().getSelection();
        var store = this.getMyStoreStore();
        var myMask = new Ext.LoadMask(Ext.getCmp('myViewport') , {msg:"ERP 전송 중"});
        var flag = 'Y';
        var msg = '';

        if(record.length >= 1){
            for(var i = 0 ; i < record.length ; i ++){
                if(record[i].data['V_TYPE'] == 'V'){
                    record[i].set('V_TYPE', 'CANCEL');
                }
                if(record[i].data['GL_YN'] == 'Y'){
                    flag = 'N';
                    msg += '이미 전표 생성된 데이터가 존재합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
                if(record[i].data['HSPF_YN'] == 'N'){
                    flag = 'N';
                    msg += '전송된 데이터만 취소 가능합니다.(' + record[i].data['M_CHARGE_NO'] + ')<br>';
                }
            }
            if(flag == 'Y'){
                Ext.Msg.confirm('확인','취소 하시겠습니까?', function(button){
                    if(button == 'yes') {
                        myMask.show();
                        store.sync({
                            params:{
                                V_TYPE : 'SYNC',
                                V_USR_ID : parent.Ext.getCmp('GUSER_ID').getValue(),
                            },
                            callback: function(batch, options){
                                store.reload();
                                myMask.hide();
                                Ext.Msg.alert('확인', '완료');

                            },
                            success: function(batch, options){

                            },
                            failure: function(batch, options){

                            },
                            scope : this
                        });

                    }
                });
            }
            else{
                Ext.Msg.alert('확인', msg);
            }

        }
        else{
            Ext.Msg.alert('확인', '항목을 선택해주세요.');
        }
    }

});
