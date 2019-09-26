<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title></title>
    <!-- 1、Jquery组件引用 -->
    <script src="/js/jquery-3.3.1.min.js"></script>

	<!-- 2、bootstrap组件引用 -->
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- 3、bootstrap table组件以及中文包的引用 -->
    <script src="/js/bootstrap-table.js"></script>
    <link href="/css/bootstrap-table.css" rel="stylesheet" />
    <script src="/js/bootstrap-table-zh-CN.js"></script>
    <!-- 4、导出excle插件 -->
    <script src="/js/tableExport.js"></script>
    <script src="/js/bootstrap-table-export.js"></script>
    <script src="/js/jquery.base64.js"></script>
    
    <!-- 5、页面Js文件的引用 -->
    <script src="/js/edit/stuavgScore.js"></script>
    <!-- 6、弹出框 -->
    <script src="/js/layer/layer.js"></script>
    
    <!-- 7、日历时间组件 -->
    <link href="/css/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap-datetimepicker.js"></script>
    <script src="/js/bootstrap-datetimepicker.zh-CN.js"></script>
    
<!-- 设置表格隔行变色 -->
<style type="text/css">
	#tb_departments tr:nth-child(even){
	background: #fafafa;
	}
</style>
</head>
<body>


    <div class="panel-body" style="padding-bottom:0px;">
        <div class="panel panel-default">
            <div class="panel-heading">学生工作记录搜索</div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                 	<div class="form-group" style="margin-top:15px">
	                 	<div class="row"><!-- =========================第一行开始================================ -->
	                 		<label  class="control-label col-sm-2" for="beginTime">开始日期：</label>
                       		<div class="col-sm-3">
	                            <div class='input-group date' id='datetimepicker1'>
									<input type='text' class="form-control" id="beginTime" readonly="readonly"/> 
									<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
	                       	</div>
	                        
	                        <label  class="control-label col-sm-2" for="stuname">学生:</label>
	                        <div class="col-sm-3">
	                            <input id="stuname" type="text" class="form-control" value="${user.trueName }" readonly="readonly"/>
	                        </div>
	                    </div><br><!-- ================================第一行结束================================ -->
                      
                 		<div class="row"><!-- =========================第二行开始================================ -->
                 			<label  class="control-label col-sm-2" for="endTime">结束日期：</label>
	                   		<div class="col-sm-3">
	                           <div class='input-group date' id='datetimepicker2'>
									<input type='text' class="form-control" id="endTime" readonly="readonly"/> 
									<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
	                       	</div>
                 			
                 			<label  class="control-label col-sm-2" for="sno">学号:</label>
	                    	<div class="col-sm-3">
	                            <input id="sno" type="text" class="form-control" value="${user.sno }" readonly="readonly"/>
	                        </div>
                        	<input type="hidden" id="ifmark" name="ifmark" value="已评分"/>
                   	 	</div><br><!-- ====================================第二行结束================================ -->
                    
                    
                    	<div class="row"><!-- =============================第三行开始================================ -->
                    	
                        
		                    <div class="col-sm-10" style="text-align:right">
			                    <button type="button" style="margin-left:50px" id="clean_condition" class="btn btn-primary pull-right">清空查询条件</button>
		                        <button type="button" style="margin-left:50px" id="select" class="btn btn-primary pull-right">查询</button>
		                    </div>
                    	</div><!-- ========================================第三行结束================================ -->
					</div>
				</form>
			</div>
		</div>       

        <table id="tb_departments"></table>
    </div>
</body>

<script type="text/javascript">

setTimeout(function(){
	layer.alter("未评分的学生的平均分查不到")
}, 300);

</script>

</html>