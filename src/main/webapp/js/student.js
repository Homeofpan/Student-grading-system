$(function () {

    //1.初始化Table
    var oTable = new TableInit();
    oTable.Init();


    //2.初始化Button的点击事件
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();
    
    //增删改对表格刷新
    /*$("#tb_departments").bootstrapTable('refresh', {url:"/user"});*/
    
    //点击查询按钮事件
 /*   $("#select").click(function(){
    	
    });*/
    
    //删除选中行
    $("#delete").click(function(){
    	var a= $("#tb_departments").bootstrapTable('getSelections');
    	if(a.length == 1 && (a[0].power ==0)){	
/*    		layer.open({
    			type:0,       //0:为信息框
    			title:'提示',
    			area:['200px','150px'], 
    			btn: ['确定','取消'],    //显示的按钮
    			shade: 0.4,
    		});*/
    		layer.confirm('您确定要删除这条数据吗？', {
    			btn: ['确定','取消'], 					//按钮
    			btn1:function(){
    				//点击确认触发的函数
    				$.post("/user-delete",
    						{
    							username:a[0].username,
    						},function(data){
    							if(data.status == 200){
    								layer.alert("删除成功",{
    									btn:['确定'],
    								},function(){
    									location.reload();
    								});
    								/*$("#tb_departments").bootstrapTable('refresh', {url:"/user"});*/
    							}else{
    								layer.alert("删除失败");
    								layer.closeAll('dialog');
    							}
    						});
    			},
    			btn2:function(){
    				//点击取消触发的函数
    				layer.closeAll('dialog');
    			},
    		
    			});

    	}else if(a.length ==0){
    		layer.alert("请选择一条修改的数据");
    	}else if(a.length == 1 && a[0].power ==1){
    		layer.alert("无法删除管理员");
    	}else{
    		layer.alert("不得选择多条数据");
    	}
    });
    
    //修改用户信息
    $("#edit").click(function(){
    	var a= $("#tb_departments").bootstrapTable('getSelections');
    	if(a.length == 1){
    	//弹出修改权限框
        layer.open({
            type: 2,
            title:'修改用户权限',
            skin: 'layui-layer-rim', //加上边框
            area: ['420px', '500px'], //宽高
            content: ['/userList/power-edit?username='+a[0].username+'&power='+a[0].power,
            	'no'],
            end:function(){
            	location.reload();
            } 
        });
    	}else if(a.length == 0){
    		layer.alert("请选择修改的用户");
    	}else{
    		layer.alert("不能修改多个用户");
    	}
    	
    });
    
    //查询具体用户的权限
   $("#select").click(function(){
/*	  $.post("/user",{
	  },function(data){
		  if(data[0] != ""){
			  layer.alert("查询成功");
		  }else {
			  layer.alert("用户不存在");
		  }
	  }) */
	   $("#tb_departments").bootstrapTable('refresh', {url:"/user"});
   });
    
});






var TableInit = function () {
    var oTableInit = new Object();
    //初始化Table
    oTableInit.Init = function () {
        $('#tb_departments').bootstrapTable({
            url: '/stu-list',         //请求后台的URL（*）
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
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            exportDataType:'all',//'basic':当前页的数据, 'all':全部的数据, 'selected':选中的数据
            showExport: true,  //是否显示导出按钮
            buttonsAlign:"right",  //按钮位置
            exportTypes:['excel'],  //导出文件类型，[ 'csv', 'txt', 'sql', 'doc', 'excel', 'xlsx', 'pdf']
            columns: [{
                checkbox: true
            }, {
                field: 'name',
                title: '学生姓名'
            }, {
                field: 'sno',
                title: '学号'
            }, {
            	
            } ,
            ]
        });
    };

    //得到查询的参数
    oTableInit.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            //limit: params.limit,   //页面大小
            //offset: params.offset,  //页码
            username: $("#stuName").val(),
        };
        return temp;
    };
    
    return oTableInit;
};

/*var select={
doSelect=function() {				
	$.post("/login", 
			{
				username:$("#username").val(),
				password:$("#password").val()
			},function(data){
		if (data.status == 200) {
			alert("登陆成功");
			$(location).attr("href","/score/scoreSys");
		} else {
			alert("登录失败 :" + data.msg);						
		}
	});
};*/



var ButtonInit = function () {
    var oInit = new Object();
    var postdata = {};

    oInit.Init = function () {
        //初始化页面上面的按钮事件
    };

    return oInit;
};


