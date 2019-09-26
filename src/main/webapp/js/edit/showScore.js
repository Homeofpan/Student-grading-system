$(function () {

	//初始化时间选择
    $('#datetimepicker1').datetimepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            todayBtn: true,
            language:'zh-CN',
            pickerPosition:"bottom-left",
            minView: "month"
    });
    
    //初始化时间选择
    $('#datetimepicker2').datetimepicker({
    	format: "yyyy-mm-dd",
    	autoclose: true,
    	todayBtn: true,
    	language:'zh-CN',
    	pickerPosition:"bottom-left",
    	minView: "month"
    });

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();
    
    //-----------------------------------清空查询条件
    $("#clean_condition").click(function(){
    	$("#beginTime").val("")
    	$("#ifmark").val("")
    	$("#stuname").val("")
    	$("#workname").val("")
    	$("#sno").val("")
    	$("#shifts").val("")
    	$("#endTime").val("")
    	$("#tb_departments").bootstrapTable('refresh', {url:"/mark/mark_show"});
    });

    
    //增删改对表格刷新
    /*$("#tb_departments").bootstrapTable('refresh', {url:"/user"});*/
    
    
    //--------------------------------------------修改评分
    /*$("#btn_mark").click(function(){
    	var a= $("#tb_departments").bootstrapTable('getSelections');
    	if(a.length == 1){
    	//弹出修改权限框
        layer.open({
            type: 2,
            title:'修改评分',
            //skin: 'layui-layer-rim', //加上边框
            area: ['500px', '550px'], //宽高
            fix: true,
            content: '/mark/goto_edit?id='+a[0].id,
            end:function(){
            	$("#tb_departments").bootstrapTable('refresh', {url:"/mark/mark_list"});
            } 
        });
    	}else if(a.length == 0){
    		layer.msg("请选择修改的用户");
    	}else{
    		layer.msg("不能修改多个用户");
    	}
    	
    });*/
    
    
    //----------------------------------------评分
    /*$("#do_mark").click(function(){
    	var a= $("#tb_departments").bootstrapTable('getSelections');
    	if(a.length == 1){
    	//弹出修改权限框
        layer.open({
            type: 2,
            title:'评分',
            //skin: 'layui-layer-rim', //加上边框
            area: ['500px', '550px'], //宽高
            fix: true,
            content: '/mark/goto_edit?id='+a[0].id,
            end:function(){
            	$("#tb_departments").bootstrapTable('refresh', {url:"/mark/mark_list"});
            } 
        });
    	}else if(a.length == 0){
    		layer.msg("请选择修改的用户");
    	}else{
    		layer.msg("不能修改多个用户");
    	}
    	
    });*/
    
    //查询具体用户的权限
   $("#select").click(function(){
	   $("#tb_departments").bootstrapTable('refresh', {url:"/mark/mark_show"});
   });
    
});


var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#tb_departments').bootstrapTable({
            url: '/mark/mark_show',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams:oTableInit.queryParams,//传递参数（*）
            sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            showRefresh: true,                  //是否显示刷新按钮   
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            exportDataType:'all',//'basic':当前页的数据, 'all':全部的数据, 'selected':选中的数据
            showExport: true,  //是否显示导出按钮
            buttonsAlign:"right",  //按钮位置
            exportTypes:['excel'],  //导出文件类型，[ 'csv', 'txt', 'sql', 'doc', 'excel', 'xlsx', 'pdf']
            columns: [{
                checkbox: true
            },{
                field: 'id',
                title: 'id',
                visible: false
            },{
                field: 'workId',
                title: 'workId',
                visible: false
            },{
                field: 'shifts',
                title: '班次'
            }, {
                field: 'stuname',
                title: '学生'
            },{
            	field: 'sno',
            	title: '学号'
            } ,{
            	field: 'start',
            	title: '开始时间',
            },{
            	field: 'end',
            	title: '结束时间',
            },{
            	field: 'date',
            	title: '工作日期',
            },{
            	field: 'workname',
            	title: '工作地点',
            	visible: false
            },{
            	field: 'ifmark',
            	title: '评分状态'
            },{
            	field: 'mark',
            	title: '分数'
            },{
            	field: 'tip',
            	title: '备注'
            }]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            stuname: $("#stuname").val(),
            sno: $("#sno").val(),
            shifts: $("#shifts option:selected").val(),
            workname: $("#workname option:selected").val(),
            beginTime: $("#beginTime").val(),
            endTime: $("#endTime").val(),
            ifmark: $("#ifmark").val(),
        };
        return temp;
    };
    
    return oTableInit;
};




