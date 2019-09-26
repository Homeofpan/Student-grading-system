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
    	$("#stuname").val("")
    	$("#sno").val("")
    	$("#endTime").val("")
    });

    
    //增删改对表格刷新
    /*$("#tb_departments").bootstrapTable('refresh', {url:"/user"});*/
    
    
    //查询具体用户的权限
   $("#select").click(function(){
	   $("#tb_departments").bootstrapTable('refresh', {url:"/mark/average_show"});
   });
    
   setTimeout(function(){
		layer.msg("未评分的学生的平均分查不到")
	}, 300);
   
});


var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#tb_departments').bootstrapTable({
            url: '/mark/average_show',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
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
                field: 'stuname',
                title: '学生'
            },{
            	field: 'sno',
            	title: '学号'
            },{
            	field: 'average',
            	title: '平均分',
            	sortable: true,
            }]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            stuname: $("#stuname").val(),
            sno: $("#sno").val(),
            beginTime: $("#beginTime").val(),
            endTime: $("#endTime").val(),
            ifmark: $("#ifmark").val(),
        };
        return temp;
    };
    
    return oTableInit;
};




